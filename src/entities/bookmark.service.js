import pool from '../utils/mysql.service.js';

export const createBookmark = async (bid, rid) => {
	try {
		const queryString = `INSERT INTO Bookmark (Book_ID, Reader_ID, Created_date) VALUES (?, ?, ?)`;

		const [results] = await pool.query(queryString, [bid, rid, new Date()]);
		return results.insertId;
	} catch (err) {
		console.error('Failed to create bookmark:', err);
		return null;
	}
};

export const deleteBookmarkById = async (id) => {
	try {
		const queryString = `DELETE FROM Bookmark WHERE Bookmark_ID = ?`;

		const [results] = await pool.query(queryString, [id]);
		return results.affectedRows;
	} catch (err) {
		console.error('Failed to delete publisher:', err);
		return null;
	}
};
