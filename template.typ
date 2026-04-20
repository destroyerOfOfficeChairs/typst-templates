#let init(title, subtitle) = {

  // --- 1. Basic Document Settings ---
  set text(font: "Liberation Sans", size: 11pt)
  set page(margin: 1in)

  // --- 2. Juicy Inline Code ---
  // Apply the "box" style to all inline code (single backticks)
  show raw.where(block: false): box.with(
    fill: luma(200),
    inset: (x: 3pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // --- 3. Professional Code Blocks ---
  // Apply the "block" style to all code blocks (triple backticks)
  show raw.where(block: true): code => { 
    block(
      fill: luma(220),
      stroke: luma(100),
      inset: 14pt, // slightly more padding to give the label room
      radius: 4pt,
      width: 100%,
      [
        // Only render if a language is specified
        #if code.lang != none [
          #place(
            top + left,
            dx: -14pt, // Pull it back left to the edge (matches inset)
            dy: -14pt, // Pull it back up to the top (matches inset)
            block(
              fill: luma(100), // A distinct, darker header color
              inset: (x: 8pt, y: 4pt),
              radius: (top-left: 3pt, bottom-right: 3pt), // Stylized corner
              text(
                size: 9pt, 
                weight: "bold", 
                fill: luma(220), 
                upper(code.lang) // Uppercase looks more "official"
              )
            )
          )
          // Add a little empty vertical space so the first line of code
          // doesn't start right underneath the label.
          #v(12pt)
        ]
        
        #code
      ]
    )
  }

  // --- 4. Tech Pill Links ---
  // Apply the "pill" style to all links
  show link: it => box(
    fill: rgb("#d1e6f9"), // Much more visible blue
    inset: (x: 4pt),
    outset: (y: 3pt),     // Keeps the line rhythm
    radius: 3pt,
    [
      // Darken the text slightly to maintain contrast against the darker bg
      #set text(fill: rgb("#0b4c8c")) 
      #it
    ]
  )
    
  // --- 5. Title ---
  align(center)[
    text(size: 18pt, weight: "bold")[#title]
    v(0.5em)
    text(size: 12pt, style: "italic")[#subtitle]
  ]

  line(length: 100%, stroke: 1pt + gray)
  v(1em)
}
#let init(title, subtitle, body) = {

  // --- 1. Basic Document Settings ---
  set text(font: "Liberation Sans", size: 11pt)
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
