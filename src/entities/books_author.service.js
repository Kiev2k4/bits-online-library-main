//src/entities/books_author.service.js
import pool from '../utils/mysql.service.js';

export const createBooksAuthor = async (bookId, authorId, connection) => {
	const db = connection || pool;
	try {
		const queryString = `INSERT INTO Books_Author(Book_ID, Author_ID) VALUES (?, ?)`;

		const [results] = await db.query(queryString, [bookId, authorId]);
		return results.insertId;
	} catch (err) {
		console.error('Failed to create books-author:', err);
		return null;
	}
};

export const deleteBooksAuthorByBookId = async (bookId, connection) => {
	const db = connection || pool;
	try {
		const queryString2 = `DELETE FROM Books_Author WHERE Book_ID = ?`;

		const [results] = await db.query(queryString2, [bookId]);
		return results.affectedRows;
	} catch (err) {
		console.error('Failed to delete books-author:', err);
		return null;
	}
};
