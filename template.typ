// --- Callout Boxes ---
// Reusable admonitions for the body. Usage: #pitfall[...], #note[...], #tip[...]
#let callout(kind, accent, bg, title: none, body) = block(
  fill: bg,
  stroke: (left: 3pt + accent),
  inset: (x: 12pt, y: 10pt),
  radius: 2pt,
  width: 100%,
  breakable: false,
  [
    #text(size: 9pt, weight: "bold", fill: accent)[#upper(if title != none { title } else { kind })]
    #v(-4pt)
    #body
  ]
)

#let warn(title: none, body) = callout("Warning", rgb("#b23b2e"), rgb("#f9e9e7"), title: title, body)
#let note(title: none, body) = callout("Note", rgb("#0b4c8c"), rgb("#e7f0f9"), title: title, body)
#let tip(title: none, body)  = callout("Tip", rgb("#2e7d32"), rgb("#e8f3e9"), title: title, body)

#let init(title, subtitle, font: none, author: "", date: "", logo: "", body) = {

  // --- 1. Basic Document Settings ---
  set text(size: 11pt, ..if font != none { (font: font) })
  set page(margin: 1in)

  // --- 2. Juicy Inline Code ---
  show raw.where(block: false): box.with(
    fill: luma(200),
    inset: (x: 3pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // --- 3. Professional Code Blocks ---
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
                upper(code.lang)
              )
            )
          )
          #v(12pt)
        ]
        #code
      ]
    )
  }

  // --- 4. Tech Pill Links ---
  show link: it => box(
    fill: rgb("#d1e6f9"),
    inset: (x: 4pt),
    outset: (y: 3pt),
    radius: 3pt,
    [
      #set text(fill: rgb("#0b4c8c"))
      #it
    ]
  )

  // --- Header ---
  // Each of logo, author, and date is optional. The header row is laid out in
  // normal flow (not with `place`), so whatever is present gets its own space
  // and the title below never overlaps it. If nothing is present, no header
  // row is emitted at all. The logo cell is built lazily inside the branches
  // that use it, so an empty `logo` is never handed to `image`.
  let has-logo = logo != ""
  let has-meta = author != "" or date != ""

  let logo-cell() = box(width: 2.5in, height: 1in)[
    #image(logo, width: 100%, height: 100%, fit: "contain")
  ]

  let meta-cell = align(right)[
    #text(size: 10pt, fill: luma(80))[
      #if author != "" [#author]
      #if author != "" and date != "" [\ ]
      #if date != "" [#date]
    ]
  ]

  if has-logo and has-meta {
    // Logo left, author/date right, vertically centered against each other.
    grid(
      columns: (auto, 1fr),
      align: (left + horizon, right + horizon),
      logo-cell(),
      meta-cell,
    )
  } else if has-logo {
    // Logo only, on the left.
    align(left)[#logo-cell()]
  } else if has-meta {
    // Author/date only, on the right.
    meta-cell
  }

  if has-logo or has-meta {
    v(0.5em)
  }

  // --- Title ---
  align(center)[
    #text(size: 18pt, weight: "bold")[#title]
    #v(0.5em)
    #text(size: 12pt, style: "italic")[#subtitle]
  ]

  line(length: 100%, stroke: 1pt + gray)
  v(1em)

  // --- Render the Document Body ---
  body
}
