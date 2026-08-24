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

#let init(title, subtitle,font: none, author: "", date: "", logo: "", body) = {

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
      
  // --- Logo Placement ---
  if logo != "" {
    place(top + left, dy: -0.25in)[
      #box(width: 2.5in, height: 1in)[
        #image(logo, width: 100%, height: 100%, fit: "contain")
      ]
    ]
  }

  // --- Author & Date Placement ---
  place(top + right, dy: -0.25in)[
    #align(right)[
      #text(size: 10pt, fill: luma(80))[
        #author\
        #date
      ]
    ]
  ]

    
  // --- 5. Title ---
  align(center)[
    #text(size: 18pt, weight: "bold")[#title]
    #v(0.5em)
    #text(size: 12pt, style: "italic")[#subtitle]
  ]

  line(length: 100%, stroke: 1pt + gray)
  v(1em)

  // --- 6. Render the Document Body ---
  body
}
