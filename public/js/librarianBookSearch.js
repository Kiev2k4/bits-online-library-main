/* Code to pre-populate the edit modal input field with record value */
const deleteBookButtons = document.querySelectorAll('.deleteButton');

const url = new URL(window.location);
const params = new URLSearchParams(url.search);

const deleteBookForm = document.getElementById('deleteBookForm');

//Load book id to delete book form
deleteBookButtons.forEach((button) => {
	button.addEventListener('click', () => {
		const bookId = button.dataset.bookId;
		deleteBookForm.dataset.bookId = bookId;
	});
});

//Implement delete button
deleteBookForm.addEventListener('submit', async (e) => {
	e.preventDefault();
	try {
		const response = await fetch(`/api/staff/book/${deleteBookForm.dataset.bookId}`, {
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
