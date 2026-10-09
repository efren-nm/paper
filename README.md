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

## Figures with captions and cross-references

In `main.typ` (after `#import "style.typ": *` and `#show: paper-style`):

```typst
#paper-figure(
  image("figures/example.png", width: 100%),
  title: [A descriptive figure title.],
  caption: [Details of the measurement, conditions, and plotted data.],
) <fig:example>

See @fig:example for the measurement.
```

Figures are numbered automatically, including when inserted or reordered. The
caption renders as **Figure 1 | A descriptive figure title.** Details...; the
name and number come from Typst's native `figure`, so `@fig:example` is an
automatic cross-reference. No manual numbering is needed.

When using `paper-columns`, figures are column-width by default. For full-page
width figures, place the figure outside the two-column content block (or
restructure the relevant portion of the document into separate column blocks).
