document.addEventListener("turbo:load", () => {
  const form = document.getElementById("message_form");
  const messagesDiv = document.getElementById("messages");

  if (!form || !messagesDiv) return;

  const chatRoomId = messagesDiv.dataset.chatRoomId;       
  let lastMessageId = Number(messagesDiv.dataset.lastMessageId || 0);

  const csrfToken = document
    .querySelector('meta[name="csrf-token"]')
    ?.getAttribute("content");

  // =====================
  // ① メッセージ送信（Ajax）
  // =====================
  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const formData = new FormData(form);

    try {
      const res = await fetch(form.action + ".json", {
        method: "POST",
        headers: {
          Accept: "application/json",
          "X-CSRF-Token": csrfToken || "",
        },
        body: formData,
      });

      const text = await res.text(); // ← 生レスポンスを受け取る
      let data;
      try {
        data = JSON.parse(text);
      } catch (err) {
        console.error("JSONとしてパースできませんでした。生レスポンス:", text);
        return;
      }

      // 正常にHTMLを返された場合
      if (res.ok && data.html) {
        messagesDiv.insertAdjacentHTML("beforeend", data.html);
        form.reset();
        messagesDiv.scrollTop = messagesDiv.scrollHeight;

        lastMessageId = data.message_id || lastMessageId; // 新しいIDを更新
      } 
      // エラーの場合
      else if (data.error) {
        console.warn("サーバーエラー:", data.error);
        alert(data.error);
      }
    } catch (err) {
      console.error("通信エラー:", err);
    }
  });

  // =====================
  // ② 相手メッセージ受信（ポーリング）＋既読処理
  // =====================
  async function pollMessages() {
    try {
      const res = await fetch(
        `/chat_rooms/${chatRoomId}/messages/poll?last_id=${lastMessageId}`,
        { headers: { Accept: "application/json" } }
      );

      const data = await res.json();

      // 追加メッセージなし
      if (!data.html || data.html.length === 0) return;

      // ---- 1. HTMLを実際に追加 ----
      messagesDiv.insertAdjacentHTML("beforeend", data.html);

      // ---- 2. 新しく追加されたメッセージをDOMから取得 ----
      const temp = document.createElement("div");
      temp.innerHTML = data.html;

      const newMessageEls = temp.querySelectorAll("[data-message-id]");

      newMessageEls.forEach((el) => {
        const senderId = Number(el.dataset.senderId);
        const messageId = Number(el.dataset.messageId);

        // 自分のメッセージは既読処理しない
        if (senderId === Number(document.body.dataset.currentUserId)) return;

        // ---- 3. 既読APIを叩く ----
        fetch(`/messages/${messageId}/mark_as_read`, {
          method: "PATCH",
          headers: {
            "X-CSRF-Token": csrfToken || "",
            Accept: "application/json",
          },
        });
      });

      // ---- 4. lastMessageId 更新 ----
      lastMessageId = data.last_id || lastMessageId;

      // ---- 5. 自動スクロール ----
      messagesDiv.scrollTop = messagesDiv.scrollHeight;

    } catch (err) {
      console.error("ポーリング中にエラー:", err);
    }
  }


  // 3秒ごとに新着メッセージを取りに行く
  setInterval(pollMessages, 3000);
});
