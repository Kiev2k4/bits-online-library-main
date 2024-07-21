const url = new URL(window.location);
const params = new URLSearchParams(url.search);

const editCategoryButtons = document.querySelectorAll('.editButton');
const deleteCategoryButtons = document.querySelectorAll('.deleteButton');

const editCategoryForm = document.getElementById('editCategoryForm');
const editCategoryName = document.getElementById('editCategoryName');

const addCategoryForm = document.getElementById('addCategoryForm');
const addCategoryName = document.getElementById('inputCategoryName');

const deleteCategoryForm = document.getElementById('deleteCategoryForm');

/* Code to pre-populate the edit modal input field with record value */
editCategoryButtons.forEach((button) => {
	button.addEventListener('click', () => {
		const categoryName = button.dataset.categoryName;
		editCategoryName.value = categoryName;

		const categoryId = button.dataset.categoryId;
		editCategoryForm.dataset.categoryId = categoryId;
	});
});

/* Load id for delete form */
deleteCategoryButtons.forEach((button) => {
	button.addEventListener('click', () => {
		const categoryId = button.dataset.categoryId;
		deleteCategoryForm.dataset.categoryId = categoryId;
	});
});

//Implement edit button
editCategoryForm.addEventListener('submit', async (e) => {
	e.preventDefault();
	try {
		const response = await fetch(`/api/staff/genre/${editCategoryForm.dataset.categoryId}`, {
			method: 'PUT',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ name: editCategoryName.value }),
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

//Implement add button
addCategoryForm.addEventListener('submit', async (e) => {
	e.preventDefault();
	try {
		const response = await fetch(`/api/staff/genre/`, {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ name: addCategoryName.value }),
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

//Implement delete button
deleteCategoryForm.addEventListener('submit', async (e) => {
	e.preventDefault();
	try {
		const response = await fetch(`/api/staff/genre/${deleteCategoryForm.dataset.categoryId}`, {
			method: 'DELETE',
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

//Searchbar
const searchForm = document.querySelector('form#searchForm');
const searchInput = document.querySelector('input#searchInput');

const searchQuery = params.get('q');
searchInput.value = searchQuery;
searchForm.addEventListener('submit', function (e) {
	e.preventDefault();
	params.delete('page');
	params.set('q', searchInput.value);
	window.location.assign(`${url.origin}${url.pathname}?${params.toString()}`);
});

//Sort select
const sortSelect = document.querySelector('select#sort-select');
const sort = params.get('sort') || '0';
sortSelect.value = sort;
sortSelect.addEventListener('change', function () {
	params.delete('page');
	params.set('sort', sortSelect.value);
	window.location.assign(`${url.origin}${url.pathname}?${params.toString()}`);
});
