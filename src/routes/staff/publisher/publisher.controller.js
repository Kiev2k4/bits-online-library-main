//src/routes/staff/publisher/publisher.controller.js
import * as publisher from '../../../entities/publisher.service.js';

export const getPublishers = async (req, res, next) => {
	req.query.offset = (Number(req.query.page) - 1) * 10 || 0;
	switch (Number(req.query.sort)) {
		case 1:
			req.query.sortType = 'Publisher_ID';
			req.query.sortDirection = 'DESC';
			break;
		case 2:
			req.query.sortType = 'Publisher_ID';
			req.query.sortDirection = 'ASC';
			break;
		default:
			req.query.sortType = 'Publisher_name';
			req.query.sortDirection = 'ASC';
			break;
	}

	const { data, totalItems } = await publisher.getPublishers(req.query);

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
		req.publishers = data;
		req.pagination = {
			totalItems,
			totalPages: Math.ceil(totalItems / 10),
			currentPage: Number(req.query.page) || 1,
		};
		next();
	}
};

export const addPublisher = async (req, res) => {
	try {
		const newPublisherId = await publisher.createPublisher(req.body);
		if (!newPublisherId) {
			return res.status(500).json({ error: 'Failed to create publisher' });
		}
		res.json({ id: newPublisherId });
	} catch (err) {
		res.status(500).json({ error: err.toString() });
	}
};

export const updatePublisher = async (req, res) => {
	try {
		const updatedRows = await publisher.editPublisherById(req.params.id, req.body);
		if (!updatedRows) {
			return res.status(404).json({ error: 'Publisher not found' });
		}
		res.json({ updatedRows });
	} catch (err) {
		res.status(500).json({ error: err.toString() });
	}
};

export const deletePublisher = async (req, res) => {
	try {
		const deletedRows = await publisher.deletePublisher(req.params.id);
		if (!deletedRows) {
			return res.status(404).json({ error: 'Publisher not found' });
		}
		res.json({ deletedRows });
	} catch (err) {
		res.status(500).json({ error: err.toString() });
	}
};
