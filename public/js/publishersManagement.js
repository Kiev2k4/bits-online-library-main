const url = new URL(window.location);
const params = new URLSearchParams(url.search);

const editPublisherButtons = document.querySelectorAll('.editButton');
const deletePublisherButtons = document.querySelectorAll('.deleteButton');

const editPublisherForm = document.getElementById('editPublisherForm');
const editPublisherName = document.getElementById('editPublisherName');
const editPublisherAddress = document.getElementById('editPublisherAddress');
const editPublisherContact = document.getElementById('editPublisherContact');


const addPublisherForm = document.getElementById('addPublisherForm');
const addPublisherName = document.getElementById('inputPublisherName');
const addPublisherAddress = document.getElementById('inputPublisherAddress');
const addPublisherContact = document.getElementById('inputPublisherContact');

const deletePublisherForm = document.getElementById('deletePublisherForm');
/* Code to pre-populate the edit modal input field with record value */
editPublisherButtons.forEach((button) => {
	button.addEventListener('click', () => {
		const publisherName = button.dataset.publisherName;
		const publisherAddress = button.dataset.publisherAddress;
		const publisherContact = button.dataset.publisherContact;

		editPublisherName.value = publisherName;
		editPublisherAddress.value = publisherAddress;
		editPublisherContact.value = publisherContact;

		const publisherId = button.dataset.publisherId;
		editPublisherForm.dataset.publisherId = publisherId;
	});
});

/* Load id for delete form */
deletePublisherButtons.forEach((button) => {
	button.addEventListener('click', () => {
		const publisherId = button.dataset.publisherId;
		deletePublisherForm.dataset.publisherId = publisherId;
	});
});

//Implement edit button
editPublisherForm.addEventListener('submit', async (e) => {
	e.preventDefault();
	try {
		const response = await fetch(`/api/staff/publisher/${editPublisherForm.dataset.publisherId}`, {
			method: 'PUT',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ name: editPublisherName.value, address: editPublisherAddress.value, contact: editPublisherContact.value }),
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
addPublisherForm.addEventListener('submit', async (e) => {
	e.preventDefault();
	try {
		const response = await fetch(`/api/staff/publisher/`, {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ name: addPublisherName.value, address: addPublisherAddress.value, contact: addPublisherContact.value }),
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
deletePublisherForm.addEventListener('submit', async (e) => {
	e.preventDefault();
	try {
		const response = await fetch(
			`/api/staff/publisher/${deletePublisherForm.dataset.publisherId}`,
			{ method: 'DELETE' }
		);

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
