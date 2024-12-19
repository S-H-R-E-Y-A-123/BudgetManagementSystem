// Get the elements
const incomeSlider = document.getElementById("incomeSlider");
const incomeValue = document.getElementById("incomeValue");
const finalizeIncomeBtn = document.getElementById("finalizeIncomeBtn");
const finalIncomeDisplay = document.getElementById("finalIncomeDisplay");
const finalIncome = document.getElementById("finalIncome");

// Update income value as the slider is moved
incomeSlider.addEventListener("input", function() {
  const value = incomeSlider.value;
  incomeValue.textContent = `₹${(value / 1000)}K`; // Display income in thousands
});

// Finalize the income when button is clicked
finalizeIncomeBtn.addEventListener("click", function() {
  finalIncome.textContent = `₹${(incomeSlider.value / 1000)}K`;
  finalIncomeDisplay.classList.remove("hidden");
});