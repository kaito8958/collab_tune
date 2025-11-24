document.addEventListener("turbo:load", () => {
    // ▼▼ ユーザーメニュー ▼▼
    const button = document.getElementById("user-menu-button");
    const menu = document.getElementById("user-dropdown");

    if (button && menu) {
      button.addEventListener("click", (e) => {
        e.stopPropagation();
        menu.classList.toggle("hidden");
      });

      document.addEventListener("click", (e) => {
        if (!menu.classList.contains("hidden") && !button.contains(e.target)) {
          menu.classList.add("hidden");
        }
      });
    }

    // ▼▼ 検索フォームの開閉 ▼▼
    const searchToggle = document.getElementById("search-toggle");
    const searchBox = document.getElementById("header-search");

    if (searchToggle && searchBox) {
      searchToggle.addEventListener("click", (e) => {
        e.stopPropagation();
        searchBox.classList.toggle("hidden");
      });

      // 検索フォーム外クリックで閉じる
      document.addEventListener("click", (e) => {
        if (!searchBox.classList.contains("hidden") &&
            !searchBox.contains(e.target) &&
            e.target !== searchToggle) {
          searchBox.classList.add("hidden");
        }
      });
    }
});
