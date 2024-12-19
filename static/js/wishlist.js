// Function to add a new wishlist item
function addItem() {
    const itemText = document.getElementById("new-item-input").value.trim();
  
    if (itemText) {
      // Create a new list item with a checkbox and delete button
      const item = document.createElement("li");
      item.className = "wishlist-item";
  
      const label = document.createElement("label");
      const checkbox = document.createElement("input");
      checkbox.type = "checkbox";
      label.appendChild(checkbox);
      label.appendChild(document.createTextNode(" " + itemText));
  
      const deleteBtn = document.createElement("button");
      deleteBtn.className = "delete-btn";
      deleteBtn.textContent = "Remove";
      deleteBtn.onclick = function() {
        item.remove();
      };
  
      item.appendChild(label);
      item.appendChild(deleteBtn);
  
      document.getElementById("wishlist").appendChild(item);
      document.getElementById("new-item-input").value = ""; // Clear input
    }
  }
  
  // Add event listener to the Add button
  document.getElementById("add-item-btn").addEventListener("click", addItem);
  
  // Allow pressing Enter to add item
  document.getElementById("new-item-input").addEventListener("keypress", function(event) {
    if (event.key === "Enter") {
      addItem();
    }
  });