// routes/readerRoutes.js
import express from 'express';
import * as bookmarkController from './bookmark.controller.js';
import { validateReader } from '../auth/auth.controller.js';

const router = express.Router();

// router.get('/', bookmarkController.getBookmarks);
router.post('/', validateReader, bookmarkController.addBookmark);
router.delete('/:id', validateReader, bookmarkController.removeBookmark);

export default router;
