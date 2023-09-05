import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("connected");
        const messages = document.getElementById("messages");
        messages.addEventListener("DOMNodeInserted", () => this.resetScroll(messages)); // Pass messages as an argument
        this.resetScroll(messages);
    }

    disconnect() {
        console.log("disconnected");
    }

    resetScroll(messages) { // Accept messages as an argument
        messages.scrollTop = messages.scrollHeight - messages.clientHeight;
    }
}
