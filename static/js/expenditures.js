// Get the form and table elements
const expenseForm = document.getElementById('expense-form');
const expenseNameInput = document.getElementById('expense-name');
const expenseAmountInput = document.getElementById('expense-amount');
const expenseCategorySelect = document.getElementById('expense-category');
const expensesTable = document.getElementById('expenses-table').getElementsByTagName('tbody')[0];

// Add event listener to the form submission
expenseForm.addEventListener('submit', function(e) {
    e.preventDefault();

    // Get input values
    const expenseName = expenseNameInput.value;
    const expenseAmount = expenseAmountInput.value;
    const expenseCategory = expenseCategorySelect.value;

    if (expenseName && expenseAmount && expenseCategory) {
        // Add the expense to the table
        addExpenseToTable(expenseName, expenseAmount, expenseCategory);

        // Clear the form inputs
        expenseNameInput.value = '';
        expenseAmountInput.value = '';
        expenseCategorySelect.value = '';
    }
});

// Function to add expense to the table
function addExpenseToTable(name, amount, category) {
    // Create a new table row
    const newRow = expensesTable.insertRow();

    // Insert cells for each column
    const nameCell = newRow.insertCell(0);
    const amountCell = newRow.insertCell(1);
    const categoryCell = newRow.insertCell(2);
    const actionCell = newRow.insertCell(3);

    // Set cell content
    nameCell.textContent = name;
    amountCell.textContent = amount;
    categoryCell.textContent = category;

    // Create a delete button
    const deleteButton = document.createElement('button');
    deleteButton.textContent = 'Delete';
    deleteButton.onclick = function() {
        // Remove the row when the delete button is clicked
        expensesTable.deleteRow(newRow.rowIndex);
    };
    actionCell.appendChild(deleteButton);
}