# HTH VBQPPL — prototype

Public site: https://linhmy2001.github.io/hth-vbqppl/

## Edit workflow (Cursor / local)

1. Edit source: `_extracted_template.html`
2. Rebuild:
   ```powershell
   .\rebuild.ps1
   ```
   Or also refresh Pages file:
   ```powershell
   .\rebuild.ps1 -Pages
   ```
3. Open `HTH_VBQPPL.html` in browser to preview.
4. Publish to GitHub Pages:
   ```powershell
   .\rebuild.ps1 -Pages
   git add docs/index.html _extracted_template.html HTH_VBQPPL.html
   git commit -m "Update HTH prototype"
   git push
   ```

## Important files

| File | Role |
|------|------|
| `_extracted_template.html` | **Source** — edit this |
| `HTH_VBQPPL.html` | Built app (open in browser) |
| `docs/index.html` | GitHub Pages publish file |
| `rebuild.ps1` | Rebuild script |
