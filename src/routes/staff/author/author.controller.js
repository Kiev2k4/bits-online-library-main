//src/routes/staff/author/author.controller.js
import * as authorService from '../../../entities/author.service.js';

export const addAuthor = async (req, res) => {
	try {
		const { name, birth, nationality } = req.body;
		const authorId = await authorService.createAuthor({ name, birth, nationality });
		res.status(201).json({ message: 'Author added successfully', authorId: authorId });
	} catch (err) {
		res.status(500).json({ message: 'Failed to add author', error: err.message });
	}
};

export const updateAuthor = async (req, res) => {
	try {
		const { id } = req.params;
		const { name, birth, nationality } = req.body;
		const changedRows = await authorService.editAuthorById(id, { name, birth, nationality });
		if (changedRows > 0) {
			res.status(200).json({ message: 'Author updated successfully' });
		} else {
			res.status(404).json({ message: 'Author not found' });
		}
	} catch (err) {
		res.status(500).json({ message: 'Failed to update author', error: err.message });
	}
};

export const deleteAuthor = async (req, res) => {
	try {
		const { id } = req.params;
		const affectedRows = await authorService.deleteAuthor(id);
		if (affectedRows > 0) {
			res.status(200).json({ message: 'Author deleted successfully' });
		} else {
			res.status(404).json({ message: 'Author not found' });
		}
	} catch (err) {
		res.status(500).json({ message: 'Failed to delete author', error: err.message });
	}
};

export const getAuthors = async (req, res, next) => {
	req.query.offset = (Number(req.query.page) - 1) * 10 || 0;
	switch (Number(req.query.sort)) {
		case 1:
			req.query.sortType = 'Author_ID';
			req.query.sortDirection = 'DESC';
			break;
		case 2:
			req.query.sortType = 'Author_ID';
			req.query.sortDirection = 'ASC';
			break;
		default:
			req.query.sortType = 'Author_name';
			req.query.sortDirection = 'ASC';
			break;
	}

	const { data, totalItems } = await authorService.getAuthors(req.query);

	if (req.isDirectRequest) {
		res.json({
			data,
			pagination: {
				totalItems,
				totalPages: Math.ceil(totalItems / 10),
				currentPage: Number(req.query.page) || 1,
			},
		}); // Send response to the client
	} else {
		req.authors = data || [];
		req.pagination = {
			totalItems,
			totalPages: Math.ceil(totalItems / 10),
			currentPage: Number(req.query.page) || 1,
		};
		next();
	}
};
