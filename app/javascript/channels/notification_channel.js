// app/javascript/channels/notification_channel.js
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
    const badge = document.getElementById("notification-badge");
    if (badge) {
      badge.textContent = data.unread_count > 0 ? `未読 ${data.unread_count}` : "";
    }
  },
});
