import consumer from "./consumer";

let subscription = null;

export const subscribeToMessages = (chatRoomId) => {
  if (subscription) return;

  subscription = consumer.subscriptions.create(
    { channel: "MessageChannel", chat_room_id: chatRoomId },
    {
      connected() {
        console.log("✅ Connected to MessageChannel");
      },

received(data) {
  console.log("💌 data received:", data);

  const messagesDiv = document.getElementById("messages");
  const currentUserId = document.body.dataset.currentUserId;

  if (messagesDiv && data.message_html) {
    const tempDiv = document.createElement("div");
    tempDiv.innerHTML = data.message_html.trim();
    const messageElement = tempDiv.firstElementChild;

    const senderId = data.sender_id;
    console.log("🧭 senderId:", senderId, "currentUserId:", currentUserId);

    if (String(senderId) === String(currentUserId)) {
      console.log("➡️ adding self class");
      messageElement.classList.add("self");
    } else {
      console.log("⬅️ adding other class");
      messageElement.classList.add("other");
    }

    console.log("✅ final element:", messageElement.outerHTML);
    messagesDiv.appendChild(messageElement);
    messagesDiv.scrollTop = messagesDiv.scrollHeight;
  }
},


      disconnected() {
        console.log("❌ Disconnected from MessageChannel");
        subscription = null;
      }
    }
  );
};
