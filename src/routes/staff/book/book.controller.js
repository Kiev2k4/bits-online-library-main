// src/routes/staff/book/book.controller.js
import * as bookService from '../../../entities/book.service.js';
import * as booksAuthorService from '../../../entities/books_author.service.js';
import * as booksGenreService from '../../../entities/books_genre.service.js';
import pool from '../../../utils/mysql.service.js';

export const addBook = async (req, res) => {
	const connection = await pool.getConnection();
	try {
		await connection.beginTransaction();

		// Add a new book to the library
		const {
			isbn,
			name: title,
			description,
			pid: publisherId,
			pdate: publishedDate,
			rtypeid: resourceTypeId,
			authorIds,
			genreIds,
		} = req.body;
		const book = { isbn, title, description, publisherId, publishedDate, resourceTypeId }; // Create a book object
		const bookId = await bookService.createBook(book, connection); // Pass the book object to createBook

		// Split authorIds and genreIds from req.body
		const authorIdList = authorIds.split(',');
		const genreIdList = genreIds.split(',');

		// Create BooksAuthor and BooksGenre for each authorId and genreId
		for (const authorId of authorIdList) {
			await booksAuthorService.createBooksAuthor(bookId, authorId, connection);
		}
		for (const genreId of genreIdList) {
			await booksGenreService.createBooksGenre(bookId, genreId, connection);
		}

		await connection.commit();
		res.status(201).json({ message: 'Book added successfully', bookId: bookId });
	} catch (err) {
		await connection.rollback();
		res.status(500).json({ message: 'Failed to add book', error: err.message });
	} finally {
		connection.release();
	}
};

export const updateBook = async (req, res) => {
	const connection = await pool.getConnection();
	try {
		await connection.beginTransaction();

		const {
			isbn,
			name: title,
			description,
			pid: publisherId,
			pdate: publishedDate,
			rtypeid: resourceTypeId,
			authorIds,
			genreIds,
		} = req.body;
		const { id } = req.params;

		// Check if book exists
		const existingBook = await bookService.getBookById(id);
		if (!existingBook) {
			return res.status(404).json({ message: 'Book not found.' });
		}

		// Update the book information
		const bookDetails = { isbn, title, description, publisherId, publishedDate, resourceTypeId };
		await bookService.editBookById(id, bookDetails, connection);

		// Check if authorIds is provided
		if (authorIds) {
			// Delete old authors and add new ones
			const deleteRes = await booksAuthorService.deleteBooksAuthorByBookId(id, connection);
			if (deleteRes === null) {
				await connection.rollback();
				return res.status(500).json({ message: 'Failed to update book' });
			}

			const authorIdList = authorIds.split(',');
			for (const authorId of authorIdList) {
				const addRes = await booksAuthorService.createBooksAuthor(id, authorId, connection);
				if (addRes === null) {
					await connection.rollback();
					return res.status(500).json({ message: 'Failed to update book' });
				}
			}
		}

		// Check if genreIds is provided
		if (genreIds) {
			// Delete old genres and add new ones
			const deleteRes = await booksGenreService.deleteBooksGenreByBookId(id, connection);
			if (deleteRes === null) {
				await connection.rollback();
				return res.status(500).json({ message: 'Failed to update book' });
			}

			const genreIdList = genreIds.split(',');
			for (const genreId of genreIdList) {
				const addRes = await booksGenreService.createBooksGenre(id, genreId, connection);
				if (addRes === null) {
					await connection.rollback();
					return res.status(500).json({ message: 'Failed to update book' });
				}
			}
		}

		await connection.commit();
		res.status(200).json({ message: 'Book updated successfully' });
	} catch (err) {
		await connection.rollback();
		res.status(500).json({ message: 'Failed to update book', error: err.message });
	} finally {
		connection.release();
	}
};

export const deleteBook = async (req, res) => {
	try {
		const { id } = req.params;

		// Check if book exists
		const existingBook = await bookService.getBookById(id);
		if (!existingBook) {
			return res.status(404).json({ message: 'Book not found.' });
		}

		await bookService.deleteBook(id);

		res.status(200).json({ message: 'Book deleted successfully' });
	} catch (err) {
		res.status(500).json({ message: 'Failed to delete book', error: err.message });
	}
};

export const getBookById = async (req, res, next) => {
	try {
		const { id } = req.params;
		const book = await bookService.getBookById(id);
		req.book = book;
		next();
	} catch (err) {
		res.status(500).json({ message: 'Failed to get book', error: err.message });
	}
};

export const getBooks = async (req, res, next) => {
	try {
		req.query.offset = (Number(req.query.page) - 1) * 10 || 0;
		switch (Number(req.query.sort)) {
			case 1:
				req.query.sortType = 'b.Publication_date';
				req.query.sortDirection = 'DESC';
				break;
			case 2:
				req.query.sortType = 'b.Publication_date';
				req.query.sortDirection = 'ASC';
				break;
			default:
				req.query.sortType = 'b.Book_title';
				req.query.sortDirection = 'ASC';
				break;
		}
		const { data, totalItems } = await bookService.getBooks(req.query);
		req.books = data || [];
		req.pagination = {
			totalItems,
			currentPage: Number(req.query.page) || 1,
			totalPages: Math.ceil(totalItems / 10),
		};
		next();
	} catch (err) {
		res.status(500).json({ message: 'Failed to get books', error: err.message });
	}
};
