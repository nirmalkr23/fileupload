// app/assets/javascripts/chat.js
document.addEventListener("DOMContentLoaded", function () {
    const chatBox = document.getElementById("chat-box");
    const messagesContainer = document.getElementById("messages");
    const messageInput = document.getElementById("message-input");
  
    function scrollToBottom() {
      messagesContainer.scrollTop = messagesContainer.scrollHeight;
    }
  
    function fetchMessages() {
      fetch("/chat/messages") // Replace with your route
        .then((response) => response.json())
        .then((data) => {
          messagesContainer.innerHTML = "";
          data.messages.forEach((message) => {
            const messageElement = document.createElement("div");
            messageElement.textContent = message.content;
            messagesContainer.appendChild(messageElement);
          });
          scrollToBottom();
        });
    }
  
    function createMessage(content) {
      fetch("/chat/messages", {
        method: "POST",
        body: JSON.stringify({ content }),
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        },
      });
    }
  
    chatBox.addEventListener("submit", function (event) {
      event.preventDefault();
      const content = messageInput.value.trim();
      if (content) {
        createMessage(content);
        messageInput.value = "";
      }
    });
  
    setInterval(fetchMessages, 3000); // Fetch messages every 3 seconds (adjust as needed)
    fetchMessages();
  });
  