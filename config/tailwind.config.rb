Tailwind.configure do |config|
  # Tailwind の入力となる CSS ファイル
  config.input = "app/assets/tailwind/application.css"

  # ビルドされた Tailwind CSS の出力先
  config.output = "app/assets/builds/tailwind.css"

  # HTML / JS からクラスを抽出する対象
  config.content = [
    "app/views/**/*.erb",
    "app/helpers/**/*.rb",
    "app/javascript/**/*.js",
    "app/javascript/**/*.jsx",
    "app/javascript/**/*.ts",
    "app/javascript/**/*.tsx"
  ]
end
