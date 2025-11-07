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
        // 自分のメッセージなら無視
        const currentUserId = document.body.dataset.currentUserId;
        if (String(data.user_id) === currentUserId) return;

        // メッセージを追加表示
        const messagesDiv = document.getElementById("messages");
        if (messagesDiv && data.message_html) {
          messagesDiv.insertAdjacentHTML("beforeend", data.message_html);
        }

        // ✅ チャットルームを開いている場合は即既読APIを叩く
        const currentRoomId = document.body.dataset.currentRoomId;
        if (currentRoomId && data.message_id) {
          fetch(`/messages/${data.message_id}/mark_as_read`, {
            method: "PATCH",
            headers: { "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content }
          });
        }
      },

      disconnected() {
        console.log("❌ Disconnected from MessageChannel");
        subscription = null;
      }
    }
  );
};
