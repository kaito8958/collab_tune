# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "channels/message_channel"
pin "channels/notification_channel"
# pin "channels/consumer", to: "channels/consumer.js"
# pin_all_from "app/javascript/channels", under: "channels"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin "header", to: "header.js"
pin "audio_player", to: "audio_player.js"