const url = new URL(window.location);
const params = new URLSearchParams(url.search);

const editResourceTypeButtons = document.querySelectorAll('.editButton');
const deleteResourceTypeButtons = document.querySelectorAll('.deleteButton');

const editResourceTypeForm = document.getElementById('editResourceTypeForm');
const editResourceTypeName = document.getElementById('editResourceTypeName');

const addResourceTypeForm = document.getElementById('addResourceTypeForm');
const addResourceTypeName = document.getElementById('inputResourceTypeName');

const deleteResourceTypeForm = document.getElementById('deleteResourceTypeForm');

/* Code to pre-populate the edit modal input field with record value */
editResourceTypeButtons.forEach(button => {
  button.addEventListener('click', () => {
    const resourceTypeName = button.dataset.resourceTypesName;
    editResourceTypeName.value = resourceTypeName;

    const resourceTypeId = button.dataset.resourceTypeId;
    editResourceTypeForm.dataset.resourceTypeId = resourceTypeId;    
  });
});

/* Load id for delete form */
deleteResourceTypeButtons.forEach(button => {
  button.addEventListener('click', () => {
    const resourceTypeId = button.dataset.resourceTypeId;
    deleteResourceTypeForm.dataset.resourceTypeId = resourceTypeId;
  });
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

//Implement edit button
editResourceTypeForm.addEventListener('submit', async (e) => {
  e.preventDefault();
  try {
    const response = await fetch(`https://library.nnhnam.io.vn/api/staff/resource-type/${editResourceTypeForm.dataset.resourceTypeId}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name: editResourceTypeName.value, id: editResourceTypeForm.dataset.resourceTypeId }),
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
})

//Implement add button
addResourceTypeForm.addEventListener('submit', async (e) => {
  e.preventDefault();
  try {
    const response = await fetch(`https://library.nnhnam.io.vn/api/staff/resource-type/`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name: addResourceTypeName.value }),
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
})

//Implement delete button
deleteResourceTypeForm.addEventListener('submit', async (e) => {
  e.preventDefault();
  try {
    const response = await fetch(`https://library.nnhnam.io.vn/api/staff/resource-type/${deleteResourceTypeForm.dataset.resourceTypeId}`, {
      method: 'DELETE',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ id: deleteResourceTypeForm.dataset.resourceTypeId }),
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
})