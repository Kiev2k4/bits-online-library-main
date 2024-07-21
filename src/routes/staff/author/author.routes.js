//src/routes/staff/author
import express from 'express';
import * as authorController from './author.controller.js';

const router = express.Router();

router.get(
	'/',
	(req, res, next) => {
		req.isDirectRequest = true;
		return next();
	},
	authorController.getAuthors
);
router.post('/', authorController.addAuthor);
router.put('/:id', authorController.updateAuthor);
router.delete('/:id', authorController.deleteAuthor);

export default router;
