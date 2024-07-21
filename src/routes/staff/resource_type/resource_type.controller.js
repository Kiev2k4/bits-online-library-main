//src/routes/staff/resource_type/resource_type.controller.js
import * as resourceType from '../../../entities/resource_type.service.js';

export const getResourceTypes = async (req, res, next) => {
	req.query.offset = (Number(req.query.page) - 1) * 10 || 0;
	switch (Number(req.query.sort)) {
		case 1:
			req.query.sortType = 'Resource_type_ID';
			req.query.sortDirection = 'DESC';
			break;
		case 2:
			req.query.sortType = 'Resource_type_ID';
			req.query.sortDirection = 'ASC';
			break;
		default:
			req.query.sortType = 'Resource_type_name';
			req.query.sortDirection = 'ASC';
			break;
	}
	const { data, totalItems } = await resourceType.getResourceTypes(req.query);

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
		req.resourceTypes = data;
		req.pagination = {
			totalItems,
			totalPages: Math.ceil(totalItems / 10),
			currentPage: Number(req.query.page) || 1,
		};
		next();
	}
};

export const addResourceType = async (req, res) => {
	try {
		const newResourceTypeId = await resourceType.createResourceType(req.body.name);
		if (!newResourceTypeId) {
			return res.status(500).json({ error: 'Failed to create resource type' });
		}
		res.json({ id: newResourceTypeId });
	} catch (err) {
		res.status(500).json({ error: err.toString() });
	}
};

export const updateResourceType = async (req, res) => {
	try {
		const updatedRows = await resourceType.editResourceTypeById(req.params.id, req.body.name);
		if (!updatedRows) {
			return res.status(404).json({ error: 'Resource type not found' });
		}
		res.json({ updatedRows });
	} catch (err) {
		res.status(500).json({ error: err.toString() });
	}
};

export const deleteResourceType = async (req, res) => {
	try {
		const deletedRows = await resourceType.deleteResourceType(req.params.id);
		if (!deletedRows) {
			return res.status(404).json({ error: 'Resource type not found' });
		}
		res.json({ deletedRows });
	} catch (err) {
		res.status(500).json({ error: err.toString() });
	}
};
