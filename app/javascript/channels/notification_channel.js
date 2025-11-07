import consumer from "./consumer";

console.log("📡 notification_channel.js loaded");

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    console.log("✅ Connected to NotificationChannel");
  },

  disconnected() {
    console.log("❌ Disconnected from NotificationChannel");
  },

  received(data) {
    console.log("📩 Notification received:", data);

    // ✅ 今チャットルームを開いている場合は未読更新をスキップ
    const currentRoomId = document.body.dataset.currentRoomId;
    if (currentRoomId && currentRoomId !== "") {
      console.log("💬 In chat room, skipping unread update");
      return;
    }

    const badge = document.getElementById("notification-badge");
    if (badge) {
      badge.textContent = data.unread_count > 0 ? `未読 ${data.unread_count}` : "";
    }
  },
});
