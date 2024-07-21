//src/routes/staff/auth/auth.controller.js
import * as staff from '../../../entities/staff.service.js';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';

export const registerStaff = async (req, res) => {
	try {
		const { password, email, fullname, mobile } = req.body;

		// Check if username already exists
		const existingUser = await staff.getStaffByUsername(email);
		if (existingUser) {
			return res
				.status(400)
				.json({ message: 'Email is already registered. Please choose a different email.' });
		}

		// If username doesn't exist, create new user
		const staffBody = { password, email, fullname, mobile };
		const staffId = await staff.createStaff(staffBody);

		if (staffId) {
			return res.status(201).json({ message: 'Staff registered successfully.', staffId });
		} else {
			return res.status(500).json({ message: 'An error occurred while registering the staff.' });
		}
	} catch (err) {
		console.error('Failed to register staff:', err);
		return res.status(500).json({ message: 'An error occurred while registering the staff.' });
	}
};

export const loginStaff = async (req, res) => {
	try {
		const { username, password } = req.body;

		// Check if user exists
		const existingUser = await staff.getStaffByUsername(username);
		if (!existingUser) {
			return res.status(400).json({ message: 'Staff not found. Please register first.' });
		}

		// Check if password is correct
		const isPasswordCorrect = await bcrypt.compare(password, existingUser.password);
		if (!isPasswordCorrect) {
			return res.status(400).json({ message: 'Invalid credentials. Please try again.' });
		}

		// If email and password are correct, create a JWT
		const token = jwt.sign({ id: existingUser.id }, process.env.JWT_SECRET, { expiresIn: '1h' });

		// Remove password from user object
		delete existingUser.password;

		// Attach the JWT to a cookie
		res.cookie('staff-token', token, { httpOnly: true });

		return res.status(200).json({ message: 'Staff logged in successfully.' });
	} catch (err) {
		console.error('Failed to log in staff:', err);
		return res.status(500).json({ message: 'An error occurred while logging in the staff.' });
	}
};

export const validateStaff = async (req, res, next) => {
	try {
		const token = req.cookies['staff-token'];
		if (!token) {
			return res.redirect('/admin/signin');
		}

		const decoded = jwt.verify(token, process.env.JWT_SECRET);

		let user = await staff.getStaffById(decoded.id);
		if (!user) {
			res.clearCookie('staff-token', { httpOnly: true });
			return res.redirect('/admin/signin');
		}

		// Remove password from user object
		delete user.password;

		req.user = user;
		next();
	} catch (err) {
		console.error('Failed to validate staff:', err);
		res.clearCookie('staff-token', { httpOnly: true });
		return res.redirect('/admin/signin');
	}
};

export const getStaff = async (req, res) => {
	try {
		const user = req.user;
		return res.status(200).json(user);
	} catch (err) {
		console.error('Failed to get staff:', err);
		return res.status(500).json({ message: 'An error occurred while getting the staff.' });
	}
};

export const logoutStaff = (req, res) => {
	res.clearCookie('staff-token');
	return res.status(200).json({ message: 'Staff logged out successfully.' });
};
