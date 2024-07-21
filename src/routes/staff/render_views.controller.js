export function signinPage(req, res) {
	return res.render('staff/staff-signin.ejs');
}

export function bookManagementPage(req, res) {
	const { books, pagination } = req;
	return res.render('staff/librarianBookSearch.ejs', { books, ...pagination });
}

export function bookDetailPage(req, res) {
	const { book } = req;
	return res.render('staff/editBookDetail.ejs', { book });
}

export function genreManagementPage(req, res) {
	const { genres, pagination } = req;
	return res.render('staff/categoriesManagement.ejs', { genres, ...pagination });
}

export function authorManagementPage(req, res) {
	const { authors, pagination } = req;
	return res.render('staff/authorsManagement.ejs', { authors, ...pagination });
}

export function publisherManagementPage(req, res) {
	const { publishers, pagination } = req;
	return res.render('staff/publishersManagement.ejs', { publishers, ...pagination });
}

export function resourceTypeManagementPage(req, res) {
	const { resourceTypes, pagination } = req;
	return res.render('staff/resourceTypesManagement.ejs', { resourceTypes, ...pagination });
}
