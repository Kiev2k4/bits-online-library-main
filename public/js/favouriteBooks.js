const buttons = document.querySelectorAll('button.favorite-button');
buttons.forEach((button) => {
	button.addEventListener('click', () => {
		const bookmarkId = button.dataset.bookmarkId;
		fetch(`/api/reader/bookmark/${bookmarkId}`, { method: 'DELETE' })
			.then((response) => {
				if (!response.ok) {
					throw new Error('Network response was not ok');
				}
				return response.json();
			})
			.then((data) => location.reload())
			.catch((error) => console.error('Error delete bookmark:', error));
	});
});

const url = new URL(window.location);
const params = new URLSearchParams(url.search);

const searchForm = document.querySelector('form#search-form');
const searchInput = document.querySelector('input#search-input');
searchForm.addEventListener('submit', function (e) {
	e.preventDefault();
	params.delete('page');
	params.set('q', searchInput.value);
	window.location.assign(`${url.origin}${url.pathname}?${params.toString()}`);
});
