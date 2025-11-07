import consumer from "./consumer"

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
        // 自分のメッセージなら無視
        const currentUserId = document.body.dataset.currentUserId;
        if (String(data.user_id) === currentUserId) return;

        const messagesDiv = document.getElementById("messages");
        if (messagesDiv && data.message_html) {
          messagesDiv.insertAdjacentHTML("beforeend", data.message_html);
        }
      },
      disconnected() {
        console.log("❌ Disconnected from MessageChannel");
        subscription = null;
      }
    }
  );
};
