import consumer from "./consumer";

console.log("📡 notification_channel.js loaded");

let subscription;

function subscribeNotificationChannel() {
  if (subscription) subscription.unsubscribe(); // 二重登録防止

  subscription = consumer.subscriptions.create("NotificationChannel", {
    connected() {
      console.log("✅ Connected to NotificationChannel");
    },

    disconnected() {
      console.log("❌ Disconnected from NotificationChannel");
    },

    received(data) {
      console.log("📩 Notification received:", data);

      // ✅ チャット中なら未読更新をスキップ
      const currentRoomId = document.body.dataset.currentRoomId;
      if (currentRoomId && currentRoomId !== "") {
        console.log("💬 In chat room, skipping unread update");
        return;
      }

      // ✅ 要素がまだ描画されていない場合に備えて再試行
      const updateBadge = () => {
        const badge = document.getElementById("notification-badge");
        if (badge) {
          if (data.unread_count > 0) {
            badge.textContent = data.unread_count;
            badge.classList.remove("hidden");
          } else {
            badge.classList.add("hidden");
          }
        } else {
          console.warn("⚠️ notification-badge not found, retrying...");
          setTimeout(updateBadge, 500); // 0.5秒後に再試行
        }
      };
      updateBadge();
    },
  });
}

document.addEventListener("turbo:load", subscribeNotificationChannel);
document.addEventListener("DOMContentLoaded", subscribeNotificationChannel);
