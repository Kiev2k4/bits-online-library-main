const url = new URL(window.location);
const params = new URLSearchParams(url.search);

const editAuthorButtons = document.querySelectorAll('.editButton');
const deleteAuthorButtons = document.querySelectorAll('.deleteButton');

const editAuthorName = document.getElementById('editAuthorName');
const editAuthorNationality = document.getElementById('editAuthorNationality');
const editAuthorDOB = document.getElementById('editAuthorDOB');

const addAuthorName = document.getElementById('inputAuthorName');
const addAuthorNationality = document.getElementById('inputAuthorNationality');
const addAuthorDOB = document.getElementById('inputAuthorDOB');

const editAuthorForm = document.getElementById('editAuthorForm');
const addAuthorForm = document.getElementById('addAuthorForm');
const deleteAuthorForm = document.getElementById('deleteAuthorForm');

/* Code to pre-populate the edit modal input field with record value */
editAuthorButtons.forEach((button) => {
	button.addEventListener('click', () => {
		const authorName = button.dataset.authorName;
		const authorNationality = button.dataset.authorNationality;
		const authorDOB = button.dataset.authorDob;
		const authorId = button.dataset.authorId;

		editAuthorName.value = authorName;
		editAuthorNationality.value = authorNationality;
		editAuthorDOB.value = authorDOB;
		editAuthorForm.dataset.authorId = authorId;
	});
});

deleteAuthorButtons.forEach((button) => {
	button.addEventListener('click', () => {
		const authorId = button.dataset.authorId;

		deleteAuthorForm.dataset.authorId = authorId;
	});
});

//Implement edit button
editAuthorForm.addEventListener('submit', async (e) => {
	e.preventDefault();
	try {
		const response = await fetch(`/api/staff/author/${editAuthorForm.dataset.authorId}`, {
			method: 'PUT',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				name: editAuthorName.value,
				birth: editAuthorDOB.value,
				nationality: editAuthorNationality.value,
			}),
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
addAuthorForm.addEventListener('submit', async (e) => {
	e.preventDefault();
	try {
		const response = await fetch(`/api/staff/author/`, {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				name: addAuthorName.value,
				birth: addAuthorDOB.value,
				nationality: addAuthorNationality.value,
			}),
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
deleteAuthorForm.addEventListener('submit', async (e) => {
	e.preventDefault();
	try {
		const response = await fetch(`/api/staff/author/${deleteAuthorForm.dataset.authorId}`, {
			method: 'DELETE',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ id: deleteAuthorForm.dataset.authorId }),
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
