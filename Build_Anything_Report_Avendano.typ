#set document(title: "My Doc")
#set page(
  paper: "us-letter",
  margin: 1in,
  header: context {
    let h1-hits = query(heading.where(level: 1).before(here()))
    let h2-hits = query(heading.where(level: 2).before(here()))
    let h1 = if h1-hits.len() > 0 { h1-hits.last().body } else { none }
    let h2 = if h2-hits.len() > 0 { h2-hits.last().body } else { none }
    grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      if h1 != none { text(size: 9pt, smallcaps(lower(h1))) },
      if h2 != none {
        text(size: 9pt, style: "italic", h2)
        h(1em)
        text(size: 9pt, counter(page).display())
      } else {
        text(size: 9pt, counter(page).display())
      },
    )
  },
)
#set text(font: "Palatino", size: 11pt, fill: rgb("#111111"))
#set par(leading: 0.75em, spacing: 1.5em, justify: true)

#show heading.where(level: 1): it => {
  v(2em, weak: true)
  align(center, text(size: 15pt, weight: "bold", it.body))
  v(0.8em, weak: true)
}
#show heading.where(level: 2): it => {
  v(1.5em, weak: true)
  text(size: 13pt, weight: "bold", it.body)
  v(0.5em, weak: true)
}
#show heading.where(level: 3): it => {
  v(1em, weak: true)
  text(size: 11pt, weight: "bold", smallcaps(it.body))
  v(0.3em, weak: true)
}

// NotesTeX-style callout boxes
#let _box(label, border-color, bg-color, content) = block(
  width: 100%,
  fill: bg-color,
  stroke: (left: 2pt + border-color),
  inset: (left: 10pt, top: 6pt, bottom: 6pt, right: 8pt),
  radius: (right: 2pt),
  spacing: 1.2em,
  [#text(weight: "bold", size: 9pt, font: "Helvetica", upper(label)) \ #content],
)

#let theorem(content)   = _box("Theorem",    rgb("#F0A500"), rgb("#FFFBF0"), content)
#let definition(content) = _box("Definition", rgb("#2196F3"), rgb("#EEF6FF"), content)
#let lemma(content)     = _box("Lemma",      rgb("#D32F2F"), white,         content)
#let example(content)   = _box("Example",    rgb("#111111"), white,         content)
#let proof(content)     = _box("Proof",      rgb("#1565C0"), white,         content)


= Using protein language models to design the next cold vaccine

  #align(center)[
    Carlos Avendaño \
    University of Washington · MCB · #datetime.today().display("[month repr:long] [year]")
  ]

== Background and significance

Although 
test @makhsousWithinHostRhinovirusEvolution2024

== Innovation

== Approach

== Summary

#bibliography("MCB_Build_Anything.bib", title: "References", style: "ieee")