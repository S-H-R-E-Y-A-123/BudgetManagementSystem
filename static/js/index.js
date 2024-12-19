// Sample data for user categories, income, and savings
const mockUserData = {
  userId: 1,
  username: "admin",
  categories: ["Groceries", "Utilities", "Entertainment"],
  income: 5000,
  savings: 1500
};

// Add event listener for the login form submission
document.getElementById("login-form").addEventListener("submit", function(event) {
  event.preventDefault();

  // Get values from the form
  const username = document.getElementById("username").value;
  const password = document.getElementById("password").value;

  // Mock login validation
  if (username === mockUserData.username && password === "password123") {
    alert("Login successful!");

    // Hide the login form and show the user data section
    document.querySelector('.login-container').style.display = 'none';
    document.getElementById('user-data').style.display = 'block';
    document.getElementById('user-name').textContent = username;

    // Display user-specific data
    displayUserData(mockUserData);
  } else {
    alert("Invalid username or password.");
  }
});

// Function to display user data
function displayUserData(userData) {
  // Populate categories
  const categoryList = document.getElementById('category-list');
  categoryList.innerHTML = userData.categories.map(category => `<li>${category}</li>`).join('');

  // Display income and savings
  document.getElementById('income-amount').textContent = `$${userData.income}`;
  document.getElementById('savings-amount').textContent = `$${userData.savings}`;
}

// Toggle Login and Signup forms
function toggleForm(formType) {
  if (formType === 'login') {
    document.getElementById('login-form').style.display = 'block';
    document.getElementById('signup-form').style.display = 'none';
  } else {
    document.getElementById('login-form').style.display = 'none';
    document.getElementById('signup-form').style.display = 'block';
  }
}

