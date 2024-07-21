//src/routes/index.js
import { Router } from 'express';

import readerRouter from './reader/index.js';
import staffRouter from './staff/index.js';
import viewRouter from './render_view.routes.js';

const router = Router();

router.use('/api/reader', readerRouter);
router.use('/api/staff', staffRouter);

router.use('/api/*', (req, res) => {
	res.status(404).json({
		status: 'fail',
		message: 'API not found!',
	});
});

router.use('/', viewRouter);

export default router;
