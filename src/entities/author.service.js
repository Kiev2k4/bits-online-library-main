//src/entities/author.service.js
import pool from '../utils/mysql.service.js';
import removeUndefined from '../utils/remove_undefined.js';

export const getAuthors = async (query) => {
	const { q, offset = 0, sortType, sortDirection } = query;
	try {
		// prettier-ignore
		const queryString = `SELECT * FROM Author 
			${q ? `WHERE Author_name LIKE ${pool.escape(`%${q}%`)}` : ''}
			${sortType && sortDirection ? `ORDER BY ${pool.escapeId(sortType)} ${sortDirection === 'DESC' ? 'DESC' : 'ASC'}` : ''}
			LIMIT 10 OFFSET ?
		`;
		const countString = `SELECT COUNT(*) AS count FROM Author ${
			q ? `WHERE Author_name LIKE ${pool.escape(`%${q}%`)}` : ''
		}`;

		const resultPromise = pool.query(queryString, [offset]);
		const countPromise = pool.query(countString);

		const [[authors], [count]] = await Promise.all([resultPromise, countPromise]);
		return {
			data: authors.map((e) => ({
				id: e.Author_ID,
				name: e.Author_name,
				dateOfBirth: e.Date_of_birth,
				nationality: e.Nationality,
			})),
			totalItems: count[0].count,
		};
	} catch (err) {
		console.error('Failed to get author list:', err);
		return { data: null, totalItems: null };
	}
};

export const createAuthor = async (author) => {
	try {
		const queryString = `INSERT INTO Author SET ?`;

		const [results] = await pool.query(queryString, [
			removeUndefined({
				Author_name: author.name,
				Date_of_birth: author.birth,
				Nationality: author.nationality,
			}),
		]);
		return results.insertId;
	} catch (err) {
		console.error('Failed to create author:', err);
		return null;
	}
};

export const editAuthorById = async (id, author) => {
	try {
		const queryString3 = `UPDATE Author SET ? WHERE Author_ID = ?`;

		const [results] = await pool.query(queryString3, [
			removeUndefined({
				Author_name: author.name,
				Date_of_birth: author.birth,
				Nationality: author.nationality,
			}),
			id,
		]);
		return results.changedRows;
	} catch (err) {
		console.error('Failed to edit author:', err);
		return null;
	}
};

export const deleteAuthor = async (id) => {
	try {
		const queryString4 = `DELETE FROM Author WHERE Author_ID = ?`;

		const [results] = await pool.query(queryString4, [id]);
		return results.affectedRows;
	} catch (err) {
		console.error('Failed to delete author:', err);
		return null;
	}
};
