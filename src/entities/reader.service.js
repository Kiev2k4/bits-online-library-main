import bcrypt from 'bcrypt';
import pool from '../utils/mysql.service.js';

export const getReaderByUsername = async (username) => {
	try {
		const queryString = 'SELECT * FROM Reader WHERE Reader.Reader_username = ?';
		const [results] = await pool.query(queryString, [username]);

		return results.length > 0
			? {
					id: results[0].Reader_ID,
					fullname: results[0].Reader_fullname,
					username: results[0].Reader_username,
					email: results[0].Reader_email,
					password: results[0].Reader_password
			  }
			: null;
	} catch (err) {
		console.error('Failed to get Reader by Username:', err);
		return null;
	}
};

export const getReaderById = async (id) => {
	try {
		const queryString = 'SELECT * FROM Reader WHERE Reader.Reader_id = ?';
		const [results] = await pool.query(queryString, [id]);

		return results.length > 0
			? {
					id: results[0].Reader_ID,
					fullname: results[0].Reader_fullname,
					username: results[0].Reader_username,
					email: results[0].Reader_email,
			  }
			: null;
	} catch (err) {
		console.error('Failed to get Reader by Username:', err);
		return null;
	}
};

export const createReader = async (reader) => {
	try {
		const { password, email, fullname } = reader;
		const hashPassword = await bcrypt.hash(password, 10);

		const [results] = await pool.query('INSERT INTO Reader SET ?', [
			{
				Reader_fullname: fullname,
				Reader_email: email,
				Reader_username: email,
				Reader_password: hashPassword
			},
		]);

		return results.insertId;
	} catch (err) {
		console.error('Failed to add Reader:', err);
		return null;
	}
};

export const editReaderById = (id, reader) => {};

export const deleteReader = async (id) => {
	try {
		const queryString = `DELETE FROM Reader  WHERE Reader_ID = ?`;

		const [results] = await pool.query(queryString, [id]);
		return results.affectedRows;
	} catch (err) {
		console.error('Failed to delete reader:', err);
		return null;
	}
};

