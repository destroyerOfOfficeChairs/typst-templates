#let project(doc) = {
  // --- 1. Juicy Inline Code ---
  // Apply the "box" style to all inline code (single backticks)
  show raw.where(block: false): box.with(
    fill: luma(200),
    inset: (x: 3pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // --- 2. Professional Code Blocks ---
  // Apply the "block" style to all code blocks (triple backticks)
  show raw.where(block: true): it => {
    block(
      fill: luma(220),
      stroke: luma(100),
      inset: (x: 10pt, y: 10pt),
      radius: 4pt,
      width: 100%,
      [
        // Place the language label in the top left, small and gray
        #place(top + left, text(fill: luma(80), size: 8pt, it.lang)) \
        #it
      ]
    )
  }

  // --- 3. Tech Pill Links ---
  // Apply the "pill" style to all links
  show link: it => box(
    fill: rgb("#eef6fc"),
    inset: (x: 3pt),
    outset: (y: 3pt), // Keeps line-height stable
    radius: 2pt,
    [
      #set text(fill: rgb("#1b6acb"))
      #it
    ]
  )

  // --- 4. Basic Document Settings ---
  set text(font: "Libertinus Serif", size: 11pt)
  set page(margin: 1.5in)
  
  // Render the actual document content
  doc
}
