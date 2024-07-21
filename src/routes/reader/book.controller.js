// controllers/bookController.js

import * as book from '../../entities/book.service.js';

export const getBooks = async (req, res, next) => {
	try {
		req.query.genreIds = req.query.subjects
			? req.query.subjects.split(',').map((id) => Number(id))
			: undefined;
		req.query.resourceTypeIds = req.query.types
			? req.query.types.split(',').map((id) => Number(id))
			: undefined;
		req.query.publisherIds = req.query.publishers
			? req.query.publishers.split(',').map((id) => Number(id))
			: undefined;
		req.query.publishedDateFrom = req.query.publishedDateFrom
			? new Date(req.query.publishedDateFrom)
			: undefined;
		req.query.publishedDateTo = req.query.publishedDateTo
			? new Date(req.query.publishedDateTo)
			: undefined;
		req.query.offset = (Number(req.query.page) - 1) * 10 || 0;
		req.query.userId = req.user ? req.user.id : undefined;

		switch (Number(req.query.sort)) {
			case 1:
				req.query.sortType = 'b.Publication_date';
				req.query.sortDirection = 'DESC';
				break;
			case 2:
				req.query.sortType = 'b.Publication_date';
				req.query.sortDirection = 'ASC';
				break;
			default:
				req.query.sortType = 'b.Book_title';
				req.query.sortDirection = 'ASC';
				break;
		}
	} catch (err) {
		console.error(err);
		req.books = [];
		return next();
	}

	try {
		const { data, totalItems } = await book.getBooks(req.query);
		req.books = !data ? [] : data;
		req.pagination = {
			totalItems: !totalItems ? 0 : totalItems,
			totalPages: !totalItems ? 0 : Math.ceil(totalItems / 10),
			currentPage: Number(req.query.page) || 1,
		};
		return next();
	} catch (err) {
		console.error(err);
		req.books = [];
		req.pagination = {
			totalItems: 0,
			totalPages: 0,
			currentPage: 0,
		};
		return next();
	}
};

export const getBookById = async (req, res, next) => {
	try {
		const userId = req.user ? req.user.id : undefined;
		const bookDetail = await book.getBookById(req.params.id, userId);
		if (!bookDetail) return res.render('404.ejs');

		req.book = bookDetail;
		next();
	} catch (err) {
		console.error(err);
		return res.render('404.ejs');
	}
};

export const getBookFilters = async (req, res, next) => {
	try {
		const result = await book.getBookFilters(req.query);
		req.genres = !result.genres ? [] : result.genres;
		req.publishers = !result.publishers ? [] : result.publishers;
		req.resourceTypes = !result.resourceTypes ? [] : result.resourceTypes;
		return next();
	} catch (err) {
		console.error(err);

		req.genres = [];
		req.publishers = [];
		req.resourceTypes = [];
		return next();
	}
};
