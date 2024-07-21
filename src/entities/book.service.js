//src/entities/book.service.js
import pool from '../utils/mysql.service.js';
import removeUndefined from '../utils/remove_undefined.js';

export const getBooks = async (query) => {
	try {
		const {
			q = '',
			genreIds,
			publishedDateFrom,
			publishedDateTo,
			publisherIds,
			resourceTypeIds,
			offset = 0,
			sortType = 'b.Book_title',
			sortDirection = 'DESC',
			userId,
			isFavorite = false,
		} = query;

		let whereQuery = '';
		if (q) {
			// prettier-ignore
			whereQuery += `CONCAT(b.ISBN, ' ',  b.Book_title, ' ', a.Author_name) LIKE ${pool.escape(`%${q}%`)}`;
		}
		if (genreIds) {
			if (whereQuery) whereQuery += ' AND ';
			whereQuery += `bg.Genre_ID IN (${pool.escape(genreIds)})`;
		}
		if (publishedDateFrom) {
			if (whereQuery) whereQuery += ' AND ';
			whereQuery += `b.Publication_date >= ${pool.escape(publishedDateFrom)}`;
		}
		if (publishedDateTo) {
			if (whereQuery) whereQuery += ' AND ';
			whereQuery += `b.Publication_date <= ${pool.escape(publishedDateFrom)}`;
		}
		if (publisherIds) {
			if (whereQuery) whereQuery += ' AND ';
			whereQuery += `b.Publisher_ID IN (${pool.escape(publisherIds)})`;
		}
		if (resourceTypeIds) {
			if (whereQuery) whereQuery += ' AND ';
			whereQuery += `b.Resource_type_ID IN (${pool.escape(resourceTypeIds)})`;
		}
		if (isFavorite) {
			if (whereQuery) whereQuery += ' AND ';
			whereQuery += `bm.Bookmark_ID IS NOT NULL`;
		}

		// prettier-ignore
		const queryString = `
      SELECT b.Book_ID, b.ISBN, b.Book_title, b.Book_description, b.Publication_date,
        b.Publisher_ID, p.Publisher_name, rt.Resource_type_name, ${userId ? 'bm.Bookmark_ID,' : ''}
        GROUP_CONCAT(DISTINCT a.Author_name SEPARATOR ';') AS authors
      FROM Book AS b
        LEFT JOIN Books_Author AS ba ON b.Book_ID = ba.Book_ID
        LEFT JOIN Author AS a ON a.Author_ID = ba.Author_ID
        LEFT JOIN Publisher AS p ON p.Publisher_ID = b.Publisher_ID
        LEFT JOIN Books_Genre AS bg ON b.Book_ID = bg.Book_ID
        LEFT JOIN Resource_type AS rt ON rt.Resource_type_ID = b.Resource_type_ID
				${userId ? `LEFT JOIN Bookmark AS bm ON bm.Book_ID = b.Book_ID AND bm.Reader_ID = ${pool.escape(userId)}` : ''}
      ${whereQuery ? `WHERE ${whereQuery}` : ''}
      GROUP BY b.Book_ID, b.ISBN, b.Book_title, b.Book_description, b.Publication_date,
        b.Publisher_ID, p.Publisher_name, rt.Resource_type_name${userId ? ', bm.Bookmark_ID' : ''}
      ORDER BY ${pool.escapeId(sortType)} ${sortDirection === 'DESC' ? 'DESC' : 'ASC'}
			LIMIT 10 OFFSET ${pool.escape(Number(offset))}
    `;

		// prettier-ignore
		const countQueryString = `
      SELECT COUNT(DISTINCT b.Book_ID) as total
      FROM Book AS b
        LEFT JOIN Books_Author AS ba ON b.Book_ID = ba.Book_ID
        LEFT JOIN Author AS a ON a.Author_ID = ba.Author_ID
        LEFT JOIN Publisher AS p ON p.Publisher_ID = b.Publisher_ID
        LEFT JOIN Books_Genre AS bg ON b.Book_ID = bg.Book_ID
        LEFT JOIN Resource_type AS rt ON rt.Resource_type_ID = b.Resource_type_ID
				${userId ? `LEFT JOIN Bookmark AS bm ON bm.Book_ID = b.Book_ID AND bm.Reader_ID = ${pool.escape(userId)}` : ''}
			${whereQuery ? 'WHERE ' + whereQuery : ''}
		`;
		const queryBooks = pool.query(queryString);
		const countBooks = pool.query(countQueryString);
		const [[books], [count]] = await Promise.all([queryBooks, countBooks]);

		return {
			data: books.map((e) => ({
				id: e.Book_ID,
				isbn: e.ISBN,
				title: e.Book_title,
				description: e.Book_description,
				publishedDate: e.Publication_date,
				publisher: e.Publisher_name || '',
				authors: e.authors ? e.authors.split(';') : [],
				type: e.Resource_type_name,
				bookmarkId: e.Bookmark_ID,
			})),
			totalItems: count[0].total,
		};
	} catch (err) {
		console.error('Failed to get Book List:', err);
		return { data: null, totalItems: null };
	}
};

export const getBookFilters = async (query) => {
	const { q = '' } = query;

	// prettier-ignore
	const queryString = `
		SELECT CAST(CONCAT('[', GROUP_CONCAT(DISTINCT JSON_OBJECT('id', g.Genre_ID, 'name', g.Genre_name)), ']') AS JSON) AS genres,
			CAST(CONCAT('[', GROUP_CONCAT(DISTINCT JSON_OBJECT('id', p.Publisher_ID, 'name', p.Publisher_name)), ']') AS JSON) AS publishers,
			CAST(CONCAT('[', GROUP_CONCAT(DISTINCT JSON_OBJECT('id', rt.Resource_type_ID, 'name', rt.Resource_type_name)), ']') AS JSON) AS resourceTypes
		FROM Book AS b
			LEFT JOIN Books_Author AS ba ON b.Book_ID = ba.Book_ID
			LEFT JOIN Author AS a ON a.Author_ID = ba.Author_ID
			LEFT JOIN Publisher AS p ON p.Publisher_ID = b.Publisher_ID
			LEFT JOIN Books_Genre AS bg ON b.Book_ID = bg.Book_ID
			LEFT JOIN Genre AS g ON g.Genre_ID = bg.Genre_ID
			LEFT JOIN Resource_type AS rt ON rt.Resource_type_ID = b.Resource_type_ID
		${q ? `WHERE (CONCAT(b.ISBN, ' ', b.Book_title, ' ', a.Author_name) LIKE ${pool.escape(`%${q}%`)})` : ''}
	`;

	try {
		const [results] = await pool.query(queryString);
		return {
			genres: results[0].genres,
			publishers: results[0].publishers,
			resourceTypes: results[0].resourceTypes,
		};
	} catch (err) {
		console.error('Failed to get Book Filters:', err);
		return null;
	}
};

export const getBookById = async (id, userId) => {
	// prettier-ignore
	const queryString = `
    SELECT b.Book_ID, b.ISBN, b.Book_title, b.Book_description, b.Publication_date, b.Publisher_ID, 
			p.Publisher_name, p.Publisher_address, p.Contact_details, rt.Resource_type_ID, rt.Resource_type_name, ${userId ? 'bm.Bookmark_ID,' : ''}
			CAST(CONCAT('[', GROUP_CONCAT(DISTINCT CASE WHEN g.Genre_ID IS NULL THEN NULL ELSE JSON_OBJECT('id', g.Genre_ID, 'name', g.Genre_name) END), ']') AS JSON) AS genres,
			CAST(CONCAT('[', GROUP_CONCAT(
				DISTINCT CASE WHEN a.Author_ID IS NULL THEN NULL ELSE JSON_OBJECT('id', a.Author_ID, 'name', a.Author_name, 'dateOfBirth', a.Date_of_birth, 'nationality', a.Nationality) END
			), ']') AS JSON) AS authors
		FROM Book AS b
      LEFT JOIN Books_Author AS ba ON b.Book_ID = ba.Book_ID
      LEFT JOIN Author AS a ON a.Author_ID = ba.Author_ID
      LEFT JOIN Publisher AS p ON p.Publisher_ID = b.Publisher_ID
      LEFT JOIN Books_Genre AS bg ON b.Book_ID = bg.Book_ID
      LEFT JOIN Genre AS g ON g.Genre_ID = bg.Genre_ID
      LEFT JOIN Resource_type AS rt ON rt.Resource_type_ID = b.Resource_type_ID
			${userId ? `LEFT JOIN Bookmark AS bm ON bm.Book_ID = b.Book_ID AND bm.Reader_ID = ${pool.escape(userId)}` : ''}
    WHERE b.Book_ID = ?
		GROUP BY b.Book_ID, b.ISBN, b.Book_title, b.Book_description, b.Publication_date, b.Publisher_ID,
			p.Publisher_name, p.Publisher_address, p.Contact_details, rt.Resource_type_name${userId ? ', bm.Bookmark_ID' : ''}
  `;

	const [results] = await pool.query(queryString, [id]);

	return results.length > 0
		? {
				id: results[0].Book_ID,
				isbn: results[0].ISBN,
				title: results[0].Book_title,
				description: results[0].Book_description,
				publishedDate: results[0].Publication_date,
				publisher: {
					id: results[0].Publisher_ID,
					name: results[0].Publisher_name || '',
					address: results[0].Publisher_address || '',
					contact: results[0].Contact_details || '',
				},
				authors: results[0].authors || [],
				genres: results[0].genres || [],
				type: {
					id: results[0].Resource_type_ID,
					name: results[0].Resource_type_name,
				},
				bookmarkId: results[0].Bookmark_ID,
		  }
		: null;
};

export const createBook = async (book, connection) => {
	const db = connection || pool;
	const { isbn, title, description, publisherId, publishedDate, resourceTypeId } = book;
	try {
		const queryString2 = `
            INSERT INTO Book(ISBN, Book_title, Book_description, Publisher_ID, Publication_date, Resource_type_ID) 
            VALUES (?, ?, ?, ?, ?, ?)
        `;

		const [results] = await db.query(queryString2, [
			isbn,
			title,
			description,
			publisherId,
			publishedDate,
			resourceTypeId,
		]);
		return results.insertId;
	} catch (err) {
		console.error('Failed to create Book:', err);
		return null;
	}
};

export const editBookById = async (id, book, connection) => {
	const db = connection || pool;
	const { isbn, title, description, publisherId, publishedDate, resourceTypeId } = book;
	try {
		const queryString3 = `UPDATE Book SET ? WHERE Book_ID = ?`;

		const [results] = await db.query(queryString3, [
			removeUndefined({
				ISBN: isbn,
				Book_title: title,
				Book_description: description,
				Publisher_ID: publisherId,
				Publication_date: publishedDate,
				Resource_type_ID: resourceTypeId,
			}),
			id,
		]);
		return results.changedRows;
	} catch (err) {
		console.error('Failed to edit book:', err);
		return null;
	}
};

export const deleteBook = async (id) => {
	try {
		const queryString4 = `DELETE FROM Book WHERE Book_ID = ?`;

		const [results] = await pool.query(queryString4, [id]);
		return results.affectedRows;
	} catch (err) {
		console.error('Failed to delete book:', err);
		return null;
	}
};
