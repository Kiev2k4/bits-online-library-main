export function signinPage(req, res) {
	return res.render('customer/signin_page.ejs', { user: req.user });
}

export function homepage(req, res) {
	const books = req.books.slice(0, 6);
	return res.render('customer/homepage.ejs', { books, user: req.user });
}

export function searchBookPage(req, res) {
	const { books, genres, publishers, resourceTypes, pagination, user } = req;
	return res.render('customer/search_book_page.ejs', {
		user,
		books,
		genres,
		publishers,
		resourceTypes,
		...pagination,
	});
}

export function bookDetailPage(req, res) {
	return res.render('customer/book_detail_page.ejs', {
		book: req.book,
		user: req.user,
		newBooks: req.books.slice(0, 4),
	});
}

export function favouritePage(req, res) {
	return res.render('customer/favourite_page.ejs', {
		books: req.books,
		user: req.user,
		...req.pagination,
	});
}
