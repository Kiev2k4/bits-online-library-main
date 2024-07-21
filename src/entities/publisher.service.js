//src/entities/publisher.service.js
import pool from '../utils/mysql.service.js';

export const getPublishers = async (query) => {
	const { q, offset = 0, sortType, sortDirection } = query;
	try {
		// prettier-ignore
		let queryString = `
			SELECT * FROM Publisher
			${q ? `WHERE CONCAT(Publisher_name, ' ', Publisher_address, ' ', Contact_details) LIKE ${pool.escape(`%${q}%`)}` : ''}
			ORDER BY ${pool.escapeId(sortType)} ${sortDirection === 'DESC' ? 'DESC' : 'ASC'}
			LIMIT 10 OFFSET ?
		`;
		// prettier-ignore
		const countString = `
			SELECT COUNT(*) AS count FROM Publisher
			${q ? `WHERE CONCAT(Publisher_name, ' ', Publisher_address, ' ', Contact_details) LIKE ${pool.escape(`%${q}%`)}` : ''}
		`;

		const resultPromise = pool.query(queryString, [offset]);
		const countPromise = pool.query(countString);

		const [[results], [count]] = await Promise.all([resultPromise, countPromise]);

		return {
			data: results.map((e) => ({
				id: e.Publisher_ID,
				name: e.Publisher_name,
				address: e.Publisher_address,
				contact: e.Contact_details,
			})),
			totalItems: count[0].count,
		};
	} catch (err) {
		console.error('Failed to get Publishers list:', err);
		return { data: null, totalItems: null };
	}
};

export const createPublisher = async (publisher) => {
	try {
		const queryString = `INSERT INTO Publisher SET ?`;

		const [results] = await pool.query(queryString, [
			{
				Publisher_name: publisher.name,
				Publisher_address: publisher.address,
				Contact_details: publisher.contact,
			},
		]);
		return results.insertId;
	} catch (err) {
		console.error('Failed to create Publisher:', err);
		return null;
	}
};

export const editPublisherById = async (id, publisher) => {
	try {
		const queryString = `UPDATE Publisher SET ? WHERE Publisher_ID = ?`;

		const [results] = await pool.query(queryString, [
			{
				Publisher_name: publisher.name,
				Publisher_address: publisher.address,
				Contact_details: publisher.contact,
			},
			id,
		]);
		return results.changedRows;
	} catch (err) {
		console.error('Failed to edit publisher:', err);
		return null;
	}
};

export const deletePublisher = async (id) => {
	try {
		const queryString = `DELETE FROM Publisher WHERE Publisher_ID = ?`;

		const [results] = await pool.query(queryString, [id]);
		return results.affectedRows;
	} catch (err) {
		console.error('Failed to delete publisher:', err);
		return null;
	}
};
