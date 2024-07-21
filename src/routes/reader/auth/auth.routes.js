import express from 'express';
import * as authController from './auth.controller.js';

const router = express.Router();

router.post('/register', authController.registerReader);
router.post('/login', authController.loginReader);
router.get('/', authController.validateReader, authController.getReader);
router.put('/', authController.validateReader, authController.updateReader);
router.delete('/', authController.validateReader, authController.deleteReader);
router.post('/signout', authController.signout);

export default router;
