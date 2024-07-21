import { createBookmark, deleteBookmarkById } from '../../../entities/bookmark.service.js';
import { getBooks } from '../../../entities/book.service.js';

export const addBookmark = async (req, res) => {
	const readerId = req.user?.id;
	if (!readerId) {
		return res.status(401).json({ message: 'Unauthorized' });
	}

	const { bookId } = req.body;
	const bookmarkId = await createBookmark(bookId, readerId);

	if (!bookmarkId) return res.status(500).json({ message: 'Failed to add bookmark' });

	res.status(201).json({ message: 'Bookmark added successfully', bookmarkId });
};

export const removeBookmark = async (req, res) => {
	try {
		const { id } = req.params;
		const affectedRows = await deleteBookmarkById(id);
		if (affectedRows > 0) {
			res.status(200).json({ message: 'Bookmark deleted successfully' });
		} else {
			res.status(404).json({ message: 'Bookmark not found' });
		}
	} catch (err) {
		res.status(500).json({ message: 'Failed to delete bookmark', error: err.message });
	}
};

export const getBookmarks = async (req, res, next) => {
	const readerId = req.user.id;
	const { data, totalItems } = await getBooks({
		userId: readerId,
		isFavorite: true,
		q: req.query.q,
		offset: req.query.page && Number(req.query.page) ? (Number(req.query.page) - 1) * 10 : 0,
		sortType: 'bm.Created_date',
		sortDirection: 'DESC',
	});

	req.books = !data ? [] : data;
	req.pagination = {
		totalItems: !totalItems ? 0 : totalItems,
		totalPages: !totalItems ? 0 : Math.ceil(totalItems / 10),
		currentPage: Number(req.query.page) || 1,
	};
	next();
};
