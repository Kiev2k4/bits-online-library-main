const url = new URL(window.location);
const params = new URLSearchParams(url.search);
const filterSubjects = params.get('subjects')?.split(',') || [];
const filterPublishers = params.get('publishers')?.split(',') || [];
const filterResourceTypes = params.get('types')?.split(',') || [];

const filterSubjectCheckboxes = document.querySelectorAll('input[type="checkbox"].filter-subject');
filterSubjectCheckboxes.forEach((checkbox) => {
	checkbox.checked = filterSubjects.includes(checkbox.value);

	checkbox.addEventListener('change', function () {
		if (this.checked) {
			filterSubjects.push(this.value);
			params.set('subjects', filterSubjects.join(','));
		} else {
			filterSubjects.splice(filterSubjects.indexOf(this.value), 1);
			if (filterSubjects.length) params.set('subjects', filterSubjects.join(','));
			else params.delete('subjects');
		}
	});
});

const filterPublisherCheckboxes = document.querySelectorAll(
	'input[type="checkbox"].filter-publisher'
);
filterPublisherCheckboxes.forEach((checkbox) => {
	checkbox.checked = filterPublishers.includes(checkbox.value);

	checkbox.addEventListener('change', function () {
		if (this.checked) {
			filterPublishers.push(this.value);
			params.set('publishers', filterPublishers.join(','));
		} else {
			filterPublishers.splice(filterPublishers.indexOf(this.value), 1);
			if (filterPublishers.length) params.set('publishers', filterPublishers.join(','));
			else params.delete('publishers');
		}
	});
});

const filterResourceTypeCheckboxes = document.querySelectorAll(
	'input[type="checkbox"].filter-resourceType'
);
filterResourceTypeCheckboxes.forEach((checkbox) => {
	checkbox.checked = filterResourceTypes.includes(checkbox.value);

	checkbox.addEventListener('change', function () {
		if (this.checked) {
			filterResourceTypes.push(this.value);
			params.set('types', filterResourceTypes.join(','));
		} else {
			filterResourceTypes.splice(filterResourceTypes.indexOf(this.value), 1);
			if (filterResourceTypes.length) params.set('types', filterResourceTypes.join(','));
			else params.delete('types');
		}
	});
});

const filterPublishedDateFrom = document.querySelector('input#floatingFromDate');
const publishedDateFrom = params.get('publishedDateFrom');
if (publishedDateFrom) filterPublishedDateFrom.value = publishedDateFrom;
filterPublishedDateFrom.addEventListener('change', function () {
	if (this.value) params.set('publishedDateFrom', this.value);
	else params.delete('publishedDateFrom');
});

const filterPublishedDateTo = document.querySelector('input#floatingToDate');
const publishedDateTo = params.get('publishedDateTo');
if (publishedDateTo) filterPublishedDateTo.value = publishedDateTo;
filterPublishedDateTo.addEventListener('change', function () {
	if (this.value) params.set('publishedDateTo', this.value);
	else params.delete('publishedDateTo');
});

const clearFilterBtn = document.querySelector('button#clear-filter');
clearFilterBtn.addEventListener('click', function () {
	params.delete('subjects');
	params.delete('publishers');
	params.delete('types');
	params.delete('page');
	window.location.assign(`${url.origin}${url.pathname}?${params.toString()}`);
});

const applyFilterBtn = document.querySelector('button#apply-filter');
applyFilterBtn.addEventListener('click', function () {
	params.delete('page');
	window.location.assign(`${url.origin}${url.pathname}?${params.toString()}`);
});

const searchForm = document.querySelector('form#search-form');
const searchInput = document.querySelector('input#search-input');
const searchingQuery = document.querySelector('#searching-query');

const searchQuery = params.get('q') || '';

searchingQuery.innerText = `“${searchQuery}”`;
searchInput.value = searchQuery;
searchForm.addEventListener('submit', function (e) {
	e.preventDefault();
	params.delete('page');
	params.set('q', searchInput.value);
	window.location.assign(`${url.origin}${url.pathname}?${params.toString()}`);
});

const sortSelect = document.querySelector('select#sort-select');
const sort = params.get('sort') || '0';
sortSelect.value = sort;
sortSelect.addEventListener('change', function () {
	params.delete('page');
	params.set('sort', sortSelect.value);
	window.location.assign(`${url.origin}${url.pathname}?${params.toString()}`);
});

const favortiteButtons = document.querySelectorAll('button.favorite-button');
favortiteButtons.forEach((button) => {
	button.addEventListener('click', async function (e) {
		e.stopPropagation();
		e.preventDefault();
		const isFavorite = this.classList.contains('favorite');

		try {
			if (isFavorite) {
				const bookmarkId = this.dataset.bookmarkId;
				await fetch(`/api/reader/bookmark/${bookmarkId}`, { method: 'DELETE' });
				this.dataset.bookmarkId = '';
				this.classList.remove('favorite');
			} else {
				const result = await fetch(`/api/reader/bookmark`, {
					method: 'POST',
					headers: { 'Content-Type': 'application/json' },
					body: JSON.stringify({ bookId: this.dataset.bookId }),
				}).then((res) => res.json());
				this.dataset.bookmarkId = result.bookmarkId;
				this.classList.add('favorite');
			}
		} catch (err) {
			console.error('Failed to update favorite:', err);
		}
	});
});
