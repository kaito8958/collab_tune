// app/javascript/audio_player.js

export function togglePlay(postId) {
  const audio = document.getElementById(`audio-${postId}`);
  const btn = document.querySelector(`#btn-${postId}`);
  const progress = document.getElementById(`progress-${postId}`);
  const timeDisplay = document.getElementById(`time-${postId}`);

  if (!audio || !btn) return;

  // 他のaudioをすべて停止
  document.querySelectorAll("audio").forEach(a => {
    if (a !== audio) {
      a.pause();
      a.currentTime = 0;
      const otherId = a.id.split("-")[1];
      const otherBtn = document.querySelector(`#btn-${otherId}`);
      const otherProgress = document.getElementById(`progress-${otherId}`);
      if (otherBtn) {
        otherBtn.innerHTML =
          '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 fill-white" viewBox="0 0 24 24"><polygon points="5 3 19 12 5 21 5 3"/></svg>';
      }
      if (otherProgress) {
        otherProgress.style.width = "0%";
      }
      highlightCard(otherId, false); // 他のカードの光を消す
    }
  });

  // 再生／一時停止のトグル
  if (audio.paused) {
    audio.play();
    btn.innerHTML =
      '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 fill-white" viewBox="0 0 24 24"><rect x="6" y="4" width="4" height="16"/><rect x="14" y="4" width="4" height="16"/></svg>';
    highlightCard(postId, true); // 再生中→光る
  } else {
    audio.pause();
    btn.innerHTML =
      '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 fill-white" viewBox="0 0 24 24"><polygon points="5 3 19 12 5 21 5 3"/></svg>';
    highlightCard(postId, false); // 停止→光消える
  }

  // 再生中バーの進行
  audio.ontimeupdate = () => {
    if (progress && audio.duration > 0) {
      const percent = (audio.currentTime / audio.duration) * 100;
      progress.style.width = percent + "%";

      const current = formatTime(audio.currentTime);
      const total = formatTime(audio.duration);
      if (timeDisplay) timeDisplay.textContent = `${current} / ${total}`;
    }
  };

  // 再生終了時リセット
  audio.onended = () => {
    btn.innerHTML =
      '<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 fill-white" viewBox="0 0 24 24"><polygon points="5 3 19 12 5 21 5 3"/></svg>';
    if (progress) progress.style.width = "0%";
    highlightCard(postId, false); // 再生終了→光消える
  };
}

// ⏱️ 時間表示フォーマット
function formatTime(seconds) {
  if (isNaN(seconds)) return "0:00";
  const minutes = Math.floor(seconds / 60);
  const secs = Math.floor(seconds % 60);
  return `${minutes}:${secs < 10 ? "0" + secs : secs}`;
}

// 💡 再生中カードを光らせる関数
function highlightCard(postId, isPlaying) {
  const card = document.getElementById(`post-card-${postId}`);
  if (!card) return;

  if (isPlaying) {
    card.classList.add("glow-effect");
  } else {
    card.classList.remove("glow-effect");
  }
}

// ✅ グローバル公開
window.togglePlay = togglePlay;
