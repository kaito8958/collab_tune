document.addEventListener("turbo:load", () => {
    const button = document.getElementById("user-menu-button");
    const menu = document.getElementById("user-dropdown");

    if (button && menu) {
      button.addEventListener("click", (e) => {
        e.stopPropagation();
        menu.classList.toggle("hidden");
      });

      // メニュー外をクリックしたら閉じる
      document.addEventListener("click", (e) => {
        if (!menu.classList.contains("hidden") && !button.contains(e.target)) {
          menu.classList.add("hidden");
        }
      });
    }
});
