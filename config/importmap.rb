# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin 'address_api', to: 'apis/radar.js'
pin 'weatherjs', to: 'utils/weather.js'
pin 'addressjs', to: 'utils/address.js'

