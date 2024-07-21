//src/routes/staff/resource_type/resource_type.routes.js
import express from 'express';
import * as resourceTypeController from './resource_type.controller.js';

const router = express.Router();

router.get(
	'/',
	(req, res, next) => {
		req.isDirectRequest = true;
		return next();
	},
	resourceTypeController.getResourceTypes
);
router.post('/', resourceTypeController.addResourceType);
router.put('/:id', resourceTypeController.updateResourceType);
router.delete('/:id', resourceTypeController.deleteResourceType);

export default router;
