//src/entities/resource_type.service.js
import pool from '../utils/mysql.service.js';

export const getResourceTypes = async (query) => {
	const { q, offset = 0, sortType, sortDirection } = query;
	try {
		let queryString = `
			SELECT Resource_type_ID, Resource_type_name FROM Resource_type
			${q ? `WHERE Resource_type_name LIKE ${pool.escape(`%${q}%`)}` : ''}
			ORDER BY ${pool.escapeId(sortType)} ${sortDirection === 'DESC' ? 'DESC' : 'ASC'}
			LIMIT 10 OFFSET ?
		`;

		const countString = `
			SELECT COUNT(*) AS count FROM Resource_type
			${q ? `WHERE Resource_type_name LIKE ${pool.escape(`%${q}%`)}` : ''}
		`;

		const resultPromise = pool.query(queryString, [offset]);
		const countPromise = pool.query(countString);

		const [[results], [count]] = await Promise.all([resultPromise, countPromise]);

		return {
			data: results.map((e) => ({ id: e.Resource_type_ID, name: e.Resource_type_name })),
			totalItems: count[0].count,
		};
	} catch (err) {
		console.error('Failed to get Resource type list:', err);
		return { data: null, totalItems: null };
	}
};

export const createResourceType = async (name) => {
	try {
		const queryString2 = `INSERT INTO Resource_type(Resource_type_name) VALUES (?)`;

		const [results] = await pool.query(queryString2, [name]);
		return results.insertId;
	} catch (err) {
		console.error('Failed to create Resource type:', err);
		return null;
	}
};

export const editResourceTypeById = async (id, name) => {
	try {
		const queryString3 = `UPDATE Resource_type SET Resource_type_name = ? WHERE Resource_type_ID = ?`;

		const [results] = await pool.query(queryString3, [name, id]);
		return results.changedRows;
	} catch (err) {
		console.error('Failed to edit resource type:', err);
		return null;
	}
};

export const deleteResourceType = async (id) => {
	try {
		const queryString4 = `DELETE FROM Resource_type  WHERE Resource_type_ID = ?`;

		const [results] = await pool.query(queryString4, [id]);
		return results.affectedRows;
	} catch (err) {
		console.error('Failed to delete resource type:', err);
		return null;
	}
};
