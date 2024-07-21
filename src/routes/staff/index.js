//src/routes/staff/index.js
import express from 'express';
import authRoutes from './auth/auth.routes.js';
import bookRoutes from './book/book.routes.js';
import authorRoutes from './author/author.routes.js';
import genreRoutes from './genre/genre.routes.js';
import publisherRoutes from './publisher/publisher.routes.js';
import resourceTypeRoutes from './resource_type/resource_type.routes.js';

const router = express.Router();

router.use('/auth', authRoutes);
router.use('/book', bookRoutes);
router.use('/author', authorRoutes);
router.use('/genre', genreRoutes);
router.use('/publisher', publisherRoutes);
router.use('/resource-type', resourceTypeRoutes);

export default router;
