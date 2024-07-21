$(document).ready(function () {
	// Submit form
	// Implement add button
	const addBookForm = document.getElementById('add-book-form');
	addBookForm?.addEventListener('submit', async (e) => {
		e.preventDefault();

		const formData = new FormData(e.target);
		const jsonData = Object.fromEntries(formData);

		const authorIds = $('#author-multi-select')
			.select2('data')
			.map((author) => author.id)
			.join(',');
		const genreIds = $('#genre-multi-select')
			.select2('data')
			.map((genre) => genre.id)
			.join(',');

		jsonData.authorIds = authorIds;
		jsonData.genreIds = genreIds;

		try {
			const response = await fetch(`/api/staff/book`, {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify(jsonData),
			});

			if (!response.ok) {
				const errorData = await response.json();
				console.error('Error:', errorData.message);
				return;
			}
			window.location.assign('/admin/books');
		} catch (error) {
			console.error('Error:', error);
		}
	});

	// Implement edit button
	const editBookForm = document.getElementById('edit-book-form');
	editBookForm?.addEventListener('submit', async (e) => {
		e.preventDefault();
		const url = window.location.pathname;
		const id = url.match(/\/admin\/books\/(\w+)/)[1];

		const formData = new FormData(e.target);
		const jsonData = Object.fromEntries(formData);

		const authorIds = $('#author-multi-select')
			.select2('data')
			.map((author) => author.id)
			.join(',');
		const genreIds = $('#genre-multi-select')
			.select2('data')
			.map((genre) => genre.id)
			.join(',');

		jsonData.authorIds = authorIds;
		jsonData.genreIds = genreIds;

		try {
			const response = await fetch(`/api/staff/book/${id}`, {
				method: 'PUT',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify(jsonData),
			});
			if (!response.ok) {
				const errorData = await response.json();
				console.error('Error:', errorData.message);
				return;
			}
			window.location.reload();
		} catch (error) {
			console.error('Error:', error);
		}
	});

	// Author multiselect
	$('#author-multi-select').select2({
		selectionCssClass: 'input-field',
		ajax: {
			url: '/api/staff/author',
			processResults: function (data) {
				return {
					results: data.data.map((type) => ({ id: type.id, text: type.name })),
					pagination: { more: data.pagination.currentPage < data.pagination.totalPages },
				};
			},
		},
	});

	// Genre multiselect
	$('#genre-multi-select').select2({
		selectionCssClass: 'input-field',
		ajax: {
			url: '/api/staff/genre',
			processResults: function (data) {
				return {
					results: data.data.map((type) => ({ id: type.id, text: type.name })),
					pagination: { more: data.pagination.currentPage < data.pagination.totalPages },
				};
			},
		},
	});

	// Resource type select
	$('#resource-type-select').select2({
		selectionCssClass: 'input-field',
		ajax: {
			url: '/api/staff/resource-type',
			processResults: function (data) {
				return {
					results: data.data.map((type) => ({ id: type.id, text: type.name })),
					pagination: { more: data.pagination.currentPage < data.pagination.totalPages },
				};
			},
		},
	});

	// Publisher select
	$('#publisher-select').select2({
		selectionCssClass: 'input-field',
		ajax: {
			url: '/api/staff/publisher',
			processResults: function (data) {
				return {
					results: data.data.map((type) => ({ id: type.id, text: type.name })),
					pagination: { more: data.pagination.currentPage < data.pagination.totalPages },
				};
			},
		},
	});
});
