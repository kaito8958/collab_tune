Tailwind.configure do |config|
  config.input = "app/assets/tailwind/application.css"
  config.output = "app/assets/builds/tailwind.css"

  config.content = [
    "app/views/**/*.erb",
    "app/helpers/**/*.rb",
    "app/javascript/**/*.js",
    "app/javascript/**/*.jsx",
    "app/javascript/**/*.ts",
    "app/javascript/**/*.tsx"
  ]

  # 🔥 purge（削除）されて困るクラスを safelist で強制的に残す
  config.safelist = [
    "left-1/2",
    "-translate-x-1/2",
    "top-14",
    "top-16",
    "absolute",
    "fixed",
    "transform",
    "w-full",
    "max-w-md"
  ]
end