//src/entities/genre.service.js
import pool from '../utils/mysql.service.js';

export async function getGenres(query) {
	const { q, offset = 0, sortType = 'Genre_name', sortDirection = 'ASC' } = query;
	try {
		const queryString = `
			SELECT * FROM Genre
			${q ? `WHERE Genre_name LIKE ${pool.escape(`%${q}%`)}` : ''}
			ORDER BY ${pool.escapeId(sortType)} ${sortDirection === 'DESC' ? 'DESC' : 'ASC'}
			LIMIT 10 OFFSET ?
		`;
		const countString = `
			SELECT COUNT(*) AS count FROM Genre
			${q ? `WHERE Genre_name LIKE ${pool.escape(`%${q}%`)}` : ''}
		`;

		const resultPromise = pool.query(queryString, [offset]);
		const countPromise = pool.query(countString);
		const [[results], [count]] = await Promise.all([resultPromise, countPromise]);

		return {
			data: results.map((e) => ({ id: e.Genre_ID, name: e.Genre_name })),
			totalItems: count[0].count,
		};
	} catch (err) {
		console.error('Failed to get genre list:', err);
		return { data: null, totalItems: null };
	}
}

export async function createGenre(genre) {
	try {
		const query = 'INSERT INTO Genre SET ?';
		const [results] = await pool.query(query, [{ Genre_name: genre.name }]);
		return results.insertId;
	} catch (err) {
		console.error('Failed to create genre:', err);
		return null;
	}
}

export async function editGenre(genreId, updatedGenre) {
	try {
		const query = 'UPDATE Genre SET ? WHERE Genre_ID = ?';
		const [results] = await pool.query(query, [{ Genre_name: updatedGenre.name }, genreId]);
		return results.changedRows;
	} catch (err) {
		console.error('Failed to edit genre:', err);
		return null;
	}
}

export async function deleteGenre(genreId) {
	try {
		const query = 'DELETE FROM Genre WHERE Genre_ID = ?';

		const [results] = await pool.query(query, [genreId]);
		return results.affectedRows;
	} catch (err) {
		console.error('Failed to delete genre:', err);
		return null;
	}
}
