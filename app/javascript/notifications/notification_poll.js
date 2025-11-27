// app/javascript/notifications/notification_poll.js

document.addEventListener("turbo:load", () => {
  const badge = document.getElementById("notification-badge");
  if (!badge) return;

  async function pollNotifications() {
    try {
      const currentRoomId = document.body.dataset.currentRoomId;

      // ★ 通知API自体は呼ぶ（未読数は正しく取得する）
      const res = await fetch("/notifications/poll", {
        headers: {
          Accept: "application/json"
        }
      });

      const data = await res.json();
      const count = data.unread_count || 0;

      // ★ チャットルーム内なら「UIだけ更新しない」
      if (currentRoomId && currentRoomId.length > 0) {
        return; // ← UI更新しないだけ。fetchは動いてる。
      }

      // ★ 通知バッジの更新
      if (count > 0) {
        badge.textContent = count;
        badge.style.display = "inline-block";
      } else {
        badge.textContent = "";
        badge.style.display = "none";
      }
    } catch (err) {
      console.error("通知ポーリング中にエラー:", err);
    }
  }

  // 初回実行 & 3秒おき
  pollNotifications();
  setInterval(pollNotifications, 3000);
});
