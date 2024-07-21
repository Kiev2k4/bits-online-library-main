//src/entities/staff.service.js
import pool from '../utils/mysql.service.js';
import bcrypt from 'bcrypt';

export const getStaffByUsername = async (username) => {
	try {
		const queryString = 'SELECT * FROM Staff WHERE Staff.Staff_username = ?';
		const [results] = await pool.query(queryString, [username]);

		return results.length > 0
			? {
					id: results[0].Staff_ID,
					fullname: results[0].Staff_fullname,
					username: results[0].Staff_username,
					email: results[0].Staff_email,
                    mobile: results[0].Staff_mobile,
					password: results[0].Staff_password  // Add this line
			  }
			: null;
	} catch (err) {
		console.error('Failed to get Staff by Username:', err);
		return null;
	}
};

export const getStaffById = async (id) => {
	try {
		const queryString = 'SELECT * FROM Staff WHERE Staff.Staff_ID = ?';
		const [results] = await pool.query(queryString, [id]);

		return results.length > 0
			? {
					id: results[0].Staff_ID,
					fullname: results[0].Staff_fullname,
					username: results[0].Staff_username,
					email: results[0].Staff_email,
                    mobile: results[0].Staff_mobile
			  }
			: null;
	} catch (err) {
		console.error('Failed to get Staff by ID:', err);
		return null;
	}
};

export const createStaff = async (staff) => {
	try {
		const { password, email, fullname, mobile } = staff;
		const hashPassword = await bcrypt.hash(password, 10);

		const [results] = await pool.query('INSERT INTO Staff SET ?', [
			{
				Staff_fullname: fullname,
				Staff_email: email,
				Staff_username: email,
                Staff_mobile: mobile,
				Staff_password: hashPassword
			},
		]);

		return results.insertId;
	} catch (err) {
		console.error('Failed to add Staff:', err);
		return null;
	}
};