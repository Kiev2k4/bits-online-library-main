import * as reader from '../../../entities/reader.service.js';
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';

export const registerReader = async (req, res) => {
	try {
		const { password, email, fullname } = req.body;

		// Check if username already exists
		const existingUser = await reader.getReaderByUsername(email);
		if (existingUser) {
			return res
				.status(400)
				.json({ message: 'Email is already registered. Please choose a different email.' });
		}

		// If username doesn't exist, create new user
		const readerBody = { password, email, fullname };
		const readerId = await reader.createReader(readerBody);

		if (readerId) {
			return res.status(201).json({ message: 'User registered successfully.', readerId });
		} else {
			return res.status(500).json({ message: 'An error occurred while registering the user.' });
		}
	} catch (err) {
		console.error('Failed to register user:', err);
		return res.status(500).json({ message: 'An error occurred while registering the user.' });
	}
};

export const loginReader = async (req, res) => {
	try {
		const { email, password } = req.body;

		// Check if user exists
		const existingUser = await reader.getReaderByUsername(email);
		if (!existingUser) {
			return res.status(400).json({ message: 'User not found. Please register first.' });
		}

		// Check if password is correct
		const isPasswordCorrect = await bcrypt.compare(password, existingUser.password);
		if (!isPasswordCorrect) {
			return res.status(400).json({ message: 'Invalid credentials. Please try again.' });
		}

		// If email and password are correct, create a JWT
		const token = jwt.sign({ id: existingUser.id }, process.env.JWT_SECRET, { expiresIn: '1h' });

		// Attach the JWT to a cookie
		res.cookie('token', token, { httpOnly: true });

		return res.status(200).json({ message: 'User logged in successfully.' });
	} catch (err) {
		console.error('Failed to log in user:', err);
		return res.status(500).json({ message: 'An error occurred while logging in the user.' });
	}
};

export const validateReader = async (req, res, next) => {
	try {
		const { token } = req.cookies;
		if (!token) {
			if (req.originalUrl.startsWith('/favourites')) return res.redirect('/signin');
			return next();
		}

		const decoded = jwt.verify(token, process.env.JWT_SECRET);

		// Get user by ID
		let user = await reader.getReaderById(decoded.id);
		if (!user) {
			res.clearCookie('token', { httpOnly: true });
			if (req.originalUrl.startsWith('/favourites')) return res.redirect('/signin');
			return next();
		}

		delete user.password;
		req.user = user;
		return next();
	} catch (err) {
		console.error('Failed to validate user:', err);
		res.clearCookie('token', { httpOnly: true });

		if (req.originalUrl.startsWith('/favourites')) return res.redirect('/signin');
		return next();
	}
};

export function signout(req, res) {
	res.clearCookie('token', { httpOnly: true });
	res.status(200).json({ status: 'success' });
}

export const getReader = async (req, res) => {
	try {
		const user = req.user;
		return res.status(200).json(user);
	} catch (err) {
		console.error('Failed to get user:', err);
		return res.status(500).json({ message: 'An error occurred while getting the user.' });
	}
};

export const updateReader = async (req, res) => {
	try {
		const user = req.user;
		const updatedUser = await reader.editReaderById(user.id, req.body);
		return res.status(200).json(updatedUser);
	} catch (err) {
		console.error('Failed to update user:', err);
		return res.status(500).json({ message: 'An error occurred while updating the user.' });
	}
};

export const deleteReader = async (req, res) => {
	try {
		const user = req.user;
		await reader.deleteReader(user.id);
		return res.status(200).json({ message: 'User deleted successfully.' });
	} catch (err) {
		console.error('Failed to delete user:', err);
		return res.status(500).json({ message: 'An error occurred while deleting the user.' });
	}
};
