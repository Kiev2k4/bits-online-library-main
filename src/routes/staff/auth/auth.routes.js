//src/routes/staff/auth/auth.routes.js
import express from 'express';
import * as authController from './auth.controller.js';

const router = express.Router();

router.post('/register', authController.registerStaff);
router.post('/login', authController.loginStaff);
router.get('/', authController.validateStaff, authController.getStaff);
router.post('/logout', authController.logoutStaff);

export default router;
