//src/entities/books_genre.service.js
import pool from '../utils/mysql.service.js';

export const createBooksGenre = async (bookId, genreId, connection) => {
	const db = connection || pool;
	try {
		const queryString = `INSERT INTO Books_Genre(Book_ID, Genre_ID) VALUES (?, ?)`;

		const [results] = await db.query(queryString, [bookId, genreId]);
		return results.insertId;
	} catch (err) {
		console.error('Failed to create books-genre:', err);
		return null;
	}
};

export const deleteBooksGenreByBookId = async (bookId, connection) => {
	const db = connection || pool;
	try {
		const queryString2 = `DELETE FROM Books_Genre WHERE Book_ID = ?`;

		const [results] = await db.query(queryString2, [bookId]);
		return results.affectedRows;
	} catch (err) {
		console.error('Failed to delete books-genre:', err);
		return null;
	}
};
