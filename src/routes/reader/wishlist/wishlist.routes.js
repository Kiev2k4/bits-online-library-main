// routes/wishlistRoutes.js
import express from 'express';
import * as wishlistController from './wishlist.controller.js';

const router = express.Router();
router.get('/', wishlistController.getWishlist);
router.post('/', wishlistController.addToWishlist);
router.delete('/:id', wishlistController.removeFromWishlist);

export default router;
