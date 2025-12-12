# Pagy configuration
# https://ddnexus.github.io/pagy/docs/api/pagy

require "pagy/extras/overflow"

Pagy::DEFAULT[:items] = 25
Pagy::DEFAULT[:overflow] = :last_page
