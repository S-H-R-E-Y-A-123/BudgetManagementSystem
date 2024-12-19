document.addEventListener("DOMContentLoaded", () => {
    const users = ["John", "Jane", "Bob", "Alice"]; // Sample user list
    const userList = document.getElementById("user-list");
    const chatWindow = document.getElementById("chat-window");
    const messageInput = document.getElementById("message-input");
    const messageForm = document.getElementById("message-form");
    const chatHeader = document.getElementById("chat-header");
  
    // Function to display the list of users
    users.forEach(user => {
      const li = document.createElement("li");
      li.textContent = user;
      li.addEventListener("click", () => startChat(user));
      userList.appendChild(li);
    });
  
    // Function to start a chat with a selected user
    function startChat(user) {
      chatHeader.textContent = `Chatting with ${user}`;
      chatWindow.innerHTML = ""; // Clear previous chat
      messageInput.value = ""; // Clear message input field
      messageForm.addEventListener("submit", (e) => sendMessage(e, user));
    }
  
    // Function to send a message
    function sendMessage(e, user) {
      e.preventDefault();
      const message = messageInput.value.trim();
      if (message) {
        const messageElement = document.createElement("p");
        messageElement.textContent = `You: ${message}`;
        chatWindow.appendChild(messageElement);
        chatWindow.scrollTop = chatWindow.scrollHeight; // Auto scroll to the bottom
        messageInput.value = ""; // Clear input after sending
      }
    }
  });