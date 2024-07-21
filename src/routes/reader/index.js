import express from 'express';
import authRoutes from './auth/auth.routes.js';
import bookmarkRoutes from './bookmark/bookmark.routes.js';
import wishlistRoutes from './wishlist/wishlist.routes.js';

const router = express.Router();

router.use('/auth', authRoutes);
router.use('/bookmark', bookmarkRoutes);
router.use('/wishlist', wishlistRoutes);

export default router;
