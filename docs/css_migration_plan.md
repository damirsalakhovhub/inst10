# CSS Migration Plan (Fizzy-style)

## Goals
- Drop SCSS preprocessing; rely on native CSS + nesting (as in Fizzy).
- Keep styles modular (multiple CSS files, HTTP/2 friendly).
- Ensure dev auto-reload keeps working without `sass --watch`.
- Keep production static assets cacheable with digests.

## Stages
1) **Prepare dev pipeline for plain CSS (this step)**
   - Add LiveReload watch on `app/assets/stylesheets/` so CSS changes reload without sass watcher.
   - Document current SCSS usage (no mixins/functions) and plan safe rename.

2) Rename entrypoint and imports
   - Rename `application.scss` → `application.css`.
   - Replace SCSS `@import` with CSS `@import` (or consolidate) and adjust layout includes.

3) Convert app styles
   - Rename app `.scss` to `.css` (landing, components, layout header).
   - Remove SCSS-only syntax if any (currently none beyond nesting).

4) Convert UI kit styles
   - Rename UI kit `.scss` to `.css`; ensure tokens/base import ordering preserved.
   - Verify CSS nesting works in all files.

5) Remove SCSS toolchain
   - Drop `dartsass-rails` and related config (`Procfile.dev` css process, assets initializer options).
   - Update rules/docs (`ports.mdc`, `x_DEV_MODE_SETUP.md`) to reflect CSS-only pipeline.

6) Clean-up and verify
   - Run assets in dev (Hotwire LiveReload) and confirm page reload.
   - Run test suite; check production build (assets:precompile) produces digested CSS.

