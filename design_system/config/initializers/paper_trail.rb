# PaperTrail configuration
# https://github.com/paper-trail-gem/paper_trail

PaperTrail.config.enabled = true
PaperTrail.config.has_paper_trail_defaults = {
  on: %i[create update destroy]
}
