import { Router } from 'express';

import * as readerBookController from './reader/book.controller.js';
import * as readerAuthController from './reader/auth/auth.controller.js';
import * as readerViewController from './reader/render_views.controller.js';
import { getBookmarks } from './reader/bookmark/bookmark.controller.js';

import * as staffAuthController from './staff/auth/auth.controller.js';
import * as staffViewController from './staff/render_views.controller.js';
import * as staffBookController from './staff/book/book.controller.js';
import { getGenres as getStaffGenres } from './staff/genre/genre.controller.js';
import { getAuthors as getStaffAuthors } from './staff/author/author.controller.js';
import { getPublishers as getStaffPublishers } from './staff/publisher/publisher.controller.js';
import { getResourceTypes as getStaffResourceTypes } from './staff/resource_type/resource_type.controller.js';

const router = Router();

router.get(
	'',
	readerAuthController.validateReader,
	readerBookController.getBooks,
	readerViewController.homepage
);
router.get(
	'/books',
	readerAuthController.validateReader,
	readerBookController.getBooks,
	readerBookController.getBookFilters,
	readerViewController.searchBookPage
);
router.get(
	'/books/:id',
	readerBookController.getBooks,
	readerAuthController.validateReader,
	readerBookController.getBookById,
	readerViewController.bookDetailPage
);
router.get(
	'/favourites',
	readerAuthController.validateReader,
	getBookmarks,
	readerViewController.favouritePage
);
router.get('/signin', readerViewController.signinPage);

router.get('/admin', staffAuthController.validateStaff, (req, res) => res.redirect('/admin/books'));
router.get('/admin/signin', staffViewController.signinPage);
router.get(
	'/admin/books',
	staffAuthController.validateStaff,
	staffBookController.getBooks,
	staffViewController.bookManagementPage
);
router.get('/admin/books/add', staffViewController.bookDetailPage);
router.get(
	'/admin/books/:id',
	staffAuthController.validateStaff,
	staffBookController.getBookById,
	staffViewController.bookDetailPage
);
router.get(
	'/admin/categories',
	staffAuthController.validateStaff,
	getStaffGenres,
	staffViewController.genreManagementPage
);
router.get(
	'/admin/authors',
	staffAuthController.validateStaff,
	getStaffAuthors,
	staffViewController.authorManagementPage
);
router.get(
	'/admin/publishers',
	staffAuthController.validateStaff,
	getStaffPublishers,
	staffViewController.publisherManagementPage
);
router.get(
	'/admin/resource-types',
	staffAuthController.validateStaff,
	getStaffResourceTypes,
	staffViewController.resourceTypeManagementPage
);

export default router;
