// =====================================================================
// --- Palettes ---
// Each palette defines the header/link colors and the callout colors.
// Pick one with: #show: init.with(palette: "slate")
// or pass your own dictionary with the same keys.
// =====================================================================
#let palettes = (
  // Navy headers, violet notes (original blue look)
  default: (
    title:      rgb("#0b3a6b"),
    accent:     rgb("#0b4c8c"),
    heading-bg: rgb("#eef2f7"),
    link-fg:    rgb("#0b4c8c"),
    link-bg:    rgb("#d1e6f9"),
    note: (accent: rgb("#6a3d9a"), bg: rgb("#f1eaf8")),
    tip:  (accent: rgb("#2e7d32"), bg: rgb("#e8f3e9")),
    warn: (accent: rgb("#b23b2e"), bg: rgb("#f9e9e7")),
  ),

  // Charcoal/slate headers, blue notes (neutral, print-friendly)
  slate: (
    title:      rgb("#2f3e46"),
    accent:     rgb("#52616b"),
    heading-bg: rgb("#eceff1"),
    link-fg:    rgb("#2f3e46"),
    link-bg:    rgb("#dde3e7"),
    note: (accent: rgb("#0b4c8c"), bg: rgb("#e7f0f9")),
    tip:  (accent: rgb("#2e7d32"), bg: rgb("#e8f3e9")),
    warn: (accent: rgb("#b23b2e"), bg: rgb("#f9e9e7")),
  ),

  // Deep teal headers, violet notes
  ink: (
    title:      rgb("#0f4c5c"),
    accent:     rgb("#1a6b7c"),
    heading-bg: rgb("#e6f1f3"),
    link-fg:    rgb("#0f4c5c"),
    link-bg:    rgb("#cfe6eb"),
    note: (accent: rgb("#6a3d9a"), bg: rgb("#f1eaf8")),
    tip:  (accent: rgb("#2e7d32"), bg: rgb("#e8f3e9")),
    warn: (accent: rgb("#b23b2e"), bg: rgb("#f9e9e7")),
  ),

  // Plum headers, blue notes
  plum: (
    title:      rgb("#3d2352"),
    accent:     rgb("#5b3a7a"),
    heading-bg: rgb("#f0ebf5"),
    link-fg:    rgb("#3d2352"),
    link-bg:    rgb("#e2d7ee"),
    note: (accent: rgb("#0b4c8c"), bg: rgb("#e7f0f9")),
    tip:  (accent: rgb("#2e7d32"), bg: rgb("#e8f3e9")),
    warn: (accent: rgb("#b23b2e"), bg: rgb("#f9e9e7")),
  ),
)

// Holds the active palette so functions outside init can read it.
#let palette-state = state("palette", palettes.default)

// --- Title Page ---
// A dedicated cover page. Pass `logo` as a path to a PNG/SVG (e.g. "logo.svg")
// to display it above the title; `logo-height` controls its size.
#let title_page(title, subtitle: none, logo: none, logo-height: 2in) = context {
  let p = palette-state.get()
  align(center + horizon)[
    #if logo != none [
      #block(image(logo, height: logo-height))
      #v(1em)
    ]
    #block(text(size: 36pt, weight: "bold", fill: p.title, title))

    #if subtitle != none {
      v(1.5em)
      block(text(size: 18pt, fill: luma(100), subtitle))
    }
  ]
}

// --- Title Header ---
// A title block for the top of the first content page (in normal flow, not
// a repeating page header). Pass `logo` as a path to a PNG/SVG to display it
// above the title; `logo-height` controls its size.
#let title_header(title, subtitle: none, logo: none, logo-height: 1in) = context {
  let p = palette-state.get()
  align(center)[
    #if logo != none [
      #block(image(logo, height: logo-height))
      #v(1em)
    ]
    #block(text(size: 36pt, weight: "bold", fill: p.title, title))

    #if subtitle != none {
      v(1.5em)
      block(text(size: 18pt, fill: luma(100), subtitle))
    }
  ]
}

// --- Table of Contents ---
#let toc = {
  outline(
    title: "Table of Contents",
    indent: auto,
  )
}

// --- Callout Boxes ---
// Reusable note boxes for the body.
// Usage: #warn[...], #note[...], #tip[...]
#let callout(kind, label, title: none, body) = context {
  let c = palette-state.get().at(kind)
  block(
    fill: c.bg,
    stroke: (left: 3pt + c.accent),
    inset: (x: 12pt, y: 10pt),
    radius: 2pt,
    width: 100%,
    breakable: false,
    [
      #text(size: 9pt, weight: "bold", fill: c.accent)[#upper(if title != none { title } else { label })]
      #v(-4pt)
      #body
    ],
  )
}

#let warn(title: none, body) = callout("warn", "Warning", title: title, body)
#let note(title: none, body) = callout("note", "Note", title: title, body)
#let tip(title: none, body)  = callout("tip", "Tip", title: title, body)

// --- Set the style of the document ---
// palette: a palette name (e.g. "slate") or a dictionary with the same keys.
#let init(palette: "default", body) = {
  let p = if type(palette) == str { palettes.at(palette) } else { palette }

  set text(size: 11pt)
  set page(margin: 1cm, paper: "a4")

  // --- Headings ---
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    // `weak: true` skips the break when we're already at the top of a page
    // (e.g. the very first heading in the document, or right after a
    // title_page), so it doesn't leave a blank page behind.
    pagebreak(weak: true)
    block(
      fill: p.heading-bg,
      stroke: (left: 4pt + p.accent),
      inset: (x: 12pt, y: 10pt),
      radius: 2pt,
      width: 100%,
      breakable: false,
      text(size: 16pt, weight: "bold", fill: p.title)[
        #if it.numbering != none [
          #counter(heading).display("1.")#h(6pt)
        ]
        #it.body
      ],
    )
    v(0.4em)
  }

  show heading.where(level: 2): it => {
    v(0.3em)
    block(
      fill: p.heading-bg,
      stroke: (left: 3pt + p.accent),
      inset: (x: 12pt, y: 6pt),
      radius: 2pt,
      width: auto,
      breakable: false,
      text(size: 15pt, weight: "bold", fill: p.title)[
        #if it.numbering != none [
          #counter(heading).display("1.1")#h(6pt)
        ]
        #it.body
      ],
    )
    v(0.2em)
  }

  show heading.where(level: 3): it => {
    v(0.2em)
    underline(
      stroke: 1.5pt + p.accent,
      offset: 4pt,
      text(size: 14pt, weight: "bold", fill: p.title)[#it.body],
    )
    v(0.2em)
  }

  // --- Juicy Inline Code ---
  show raw.where(block: false): box.with(
    fill: luma(200),
    inset: (x: 3pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // --- Professional Code Blocks ---
  show raw.where(block: true): code => {
    block(
      fill: luma(220),
      stroke: luma(100),
      inset: 14pt,
      radius: 4pt,
      width: 100%,
      breakable: false,
      [
        #if code.lang != none [
          #place(
            top + left,
            dx: -14pt,
            dy: -14pt,
            block(
              fill: luma(100),
              inset: (x: 8pt, y: 4pt),
              radius: (top-left: 3pt, bottom-right: 3pt),
              text(
                size: 9pt,
                weight: "bold",
                fill: luma(220),
                upper(code.lang),
              ),
            ),
          )
          #v(12pt)
        ]
        #code
      ],
    )
  }

  // --- Tech Pill Links ---
  show link: it => box(
    fill: p.link-bg,
    inset: (x: 4pt),
    outset: (y: 3pt),
    radius: 3pt,
    [
      #set text(fill: p.link-fg)
      #it
    ],
  )

  // --- Make the palette available to callouts and title functions ---
  palette-state.update(p)

  // --- Render the document body ---
  body
}
