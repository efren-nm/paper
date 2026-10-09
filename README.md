# InDesign → Typst research article template

The project uses `style.typ` for the layout and `references.yml` for Hayagriva citations. The sample `main.typ` is an **editable demonstration**, not a verbatim 18-page reconstruction.

## Identified design geometry (from the provided PDF and IDML)
- A4 sheet: 595.276 × 841.89 pt.
- Main-page printable width about 525.5 pt, left origin about 36 pt.
- Main article: two columns ~258 pt each, ~9.6 pt gutter.
- Title 26 pt bold, authors 12 pt light, main text 10 pt / 12.5 pt leading, 8.5 pt first-line indent.
- Bold abstract 10 pt / 12.5 pt; figure captions 8 pt / 11 pt.
- Methods 9 pt / 11.5 pt; captions 8 pt; page numbers centered low on the page.
- Supplementary information: single column with 16 pt section and 13 pt subsection titles.
- All type switched to Libertinus Serif and Libertinus Math.

## Use
Run `typst compile main.typ`. Fonts must include Libertinus Serif, Libertinus Math, and ideally Libertinus Mono. Citations can be written as `@novoselov2005graphene`; bibliography is generated from `references.yml`.

## Fidelity limitations
Indesign uses individually positioned text frames and placed artwork. This sample does not reproduce the original article page-for-page, and is not compiled/visually verified in this environment because the Typst binary is unavailable. In particular, precise first-page affiliations, full-page figure placement, and all 18 pages of article content still need a production pass.
