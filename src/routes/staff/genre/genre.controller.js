//src/routes/staff/genre/genre.controller.js
import * as genre from '../../../entities/genre.service.js';

export const addGenre = async (req, res) => {
	try {
		const { name } = req.body;

		// Validate the name
		if (typeof name !== 'string') {
			return res.status(400).json({ message: 'Invalid genre name' });
		}

		const genreObj = { name };
		const genreId = await genre.createGenre(genreObj);

		if (genreId) {
			res.status(201).json({ message: 'Genre added successfully', genreId });
		} else {
			res.status(500).json({ message: 'Failed to add genre' });
		}
	} catch (err) {
		res.status(500).json({ message: 'Failed to add genre', error: err.message });
	}
};

export const deleteGenre = async (req, res) => {
	try {
		const { id } = req.params;
		const affectedRows = await genre.deleteGenre(id);
		if (affectedRows > 0) {
			res.status(200).json({ message: 'Genre deleted successfully' });
		} else {
			res.status(404).json({ message: 'Genre not found' });
		}
	} catch (err) {
		res.status(500).json({ message: 'Failed to delete genre', error: err.message });
	}
};

export const updateGenre = async (req, res) => {
	try {
		const { id } = req.params;
		const { name } = req.body;
		const affectedRows = await genre.editGenre(id, { name });
		if (affectedRows > 0) {
			res.status(200).json({ message: 'Genre updated successfully' });
		} else {
			res.status(404).json({ message: 'Genre not found' });
		}
	} catch (err) {
		res.status(500).json({ message: 'Failed to update genre', error: err.message });
	}
};

export const getGenres = async (req, res, next) => {
	req.query.offset = (Number(req.query.page) - 1) * 10 || 0;
	switch (Number(req.query.sort)) {
		case 1:
			req.query.sortType = 'Genre_ID';
			req.query.sortDirection = 'DESC';
			break;
		case 2:
			req.query.sortType = 'Genre_ID';
			req.query.sortDirection = 'ASC';
			break;
		default:
			req.query.sortType = 'Genre_name';
			req.query.sortDirection = 'ASC';
			break;
	}

	const { data, totalItems } = await genre.getGenres(req.query); // Pass the entire req.query object

	if (req.isDirectRequest) {
		// If it's a direct request, send the response
		res.status(200).json({
			data,
			pagination: {
				totalItems,
				totalPages: Math.ceil(totalItems / 10),
				currentPage: Number(req.query.page) || 1,
			},
		});
	} else {
		// If it's not a direct request, pass the data to the next middleware
		req.genres = data;
		req.pagination = {
			totalItems,
			totalPages: Math.ceil(totalItems / 10),
			currentPage: Number(req.query.page) || 1,
		};
		next();
	}
};
