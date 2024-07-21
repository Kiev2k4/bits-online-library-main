//src/routes/staff/genre/genre.routes.js
import express from 'express';
import * as genreController from './genre.controller.js';

const router = express.Router();

router.get(
	'/',
	(req, res, next) => {
		req.isDirectRequest = true;
		return next();
	},
	genreController.getGenres
);
router.post('/', genreController.addGenre);
router.put('/:id', genreController.updateGenre);
router.delete('/:id', genreController.deleteGenre);

export default router;
