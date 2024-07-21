//src/routes/staff/publisher/publisher.routes.js
import express from 'express';
import * as publisherController from './publisher.controller.js';

const router = express.Router();

router.get('/', (req, res, next) => {
	req.isDirectRequest = true;
	next();
}, publisherController.getPublishers);
router.post('/', publisherController.addPublisher);
router.put('/:id', publisherController.updatePublisher);
router.delete('/:id', publisherController.deletePublisher);

export default router;
