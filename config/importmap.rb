# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js" 
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "tailwindcss-stimulus-components" # @6.1.3
pin "local-time" # @3.0.3

pin "viem", to: "https://esm.sh/viem"
pin "viem/chains", to: "https://esm.sh/viem/chains"

