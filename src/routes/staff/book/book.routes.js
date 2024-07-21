//src/routes/staff/book/book.routes.js
import express from 'express';
import * as bookController from './book.controller.js';

const router = express.Router();

// router.get('/', bookController.getBooks, bookController.sendBooks);
// router.get('/:id', bookController.getBookById, bookController.sendBook);
router.post('/', bookController.addBook);
router.put('/:id', bookController.updateBook);
router.delete('/:id', bookController.deleteBook);

export default router;
