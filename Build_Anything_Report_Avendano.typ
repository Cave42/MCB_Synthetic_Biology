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

Each year, half the world's population contracts some form of the common cold. @turnerCommonCold2012 
Cold symptoms while generally mild, still have large scale economic impacts due to the effect on productivity. @bramleyProductivityLossesRelated2002
For immunocompromised individuals, it can be much more severe. @kraftSeverityHumanRhinovirus2012
There are many viruses responsible for the common cold; rhinoviruses are responsible at least half of cold illnesses. @turnerCommonCold2012
Despite this, research in the area has been overshadowed by influenza and Sars-CoV-2.
A vaccine or an effective antiviral treatment does not exist currently for rhinoviruses.  @leeClinicalSignificanceRhinoviruses2025

There are three subtypes of rhinoviruses A, B, and C, which are then further subdivided; there exist over 160 serotypes for rhinoviruses. @leeHumanRhinovirusSpecies2012
The variety that exists in rhinoviruses presents a problem in vaccine development: how to create a vaccine that is representative of many serotypes as possible. 
Like other members of the Picornaviridae family, rhinoviruses are enveloped by a capsid and there are many regions that conserved. Identifying rhinoviruses epitopes and sites that illicit immune response could be the key to solving this year's long issue. @mcleanVaccineStrategiesInduce2019

The introduction of protein language models (PLMs) has been made huge impacts in the field biology, with the ability to condense large datasets and discover new patterns in this noise.
These models have been used to develop tools from viral forecasting prediction like in CovFit @itoProteinLanguageModel2025a, to modeling antibody sequences like in AbLang @olsenAbLangAntibodyLanguage2022. 

In Phage ImmunoPrecipitation (PhiP-Seq) bacteriophage genetic code can be modified to display any protein on its capsid. 
The process is high throughput, where thousands of custom bacteriophages can be generated and assembled and tested against human sera to illicit immune response. @tiuPhageImmunoPrecipitationSequencing2022
Many rhinoviruses epitopes are internal and not well studied, PhiP-Seq can display any protein. 
Designing a PLM model trained on PhiP-Seq data could identify new important epitopes for a rhinovirus vaccine. 

== Innovation

This project looks research an understudied virus, rhinovirus and use phage display data train a new large language model.
This model will help determine new epitope regions in the rhinovirus capsid and identify the sites to target to develop a novel vaccine.

== Approach

== Summary

#bibliography("MCB_Build_Anything.bib", title: "References", style: "ieee")