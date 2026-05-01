#set document(title: "My Doc")
#set page(
  paper: "us-letter",
  margin: 0.5in,
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
#set text(font: "Arial", size: 11pt, fill: rgb("#111111"))
#set par(leading: 0.65em, spacing: 1.6em, justify: true)

#show heading.where(level: 1): it => {
  v(2em, weak: true)
  align(center, text(size: 15pt, weight: "bold", it.body))
  v(0.8em, weak: true)
}
#show heading.where(level: 2): it => {
  v(1.5em, weak: true)
  text(size: 13pt, weight: "bold", it.body)
  v(1em, weak: true)
}
#show heading.where(level: 3): it => {
  v(1em, weak: true)
  text(size: 11pt, weight: "bold", smallcaps(it.body))
  v(0.7em, weak: true)
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
Cold symptoms, while generally mild, still have large-scale economic impacts due to the effect on productivity. @bramleyProductivityLossesRelated2002
For immunocompromised individuals, it can be much more severe. @kraftSeverityHumanRhinovirus2012
There are many viruses responsible for the common cold; rhinoviruses are responsible for at least half of cold illnesses. @turnerCommonCold2012
Despite this, research in the area has been overshadowed by influenza and SARS-CoV-2.
A vaccine or an effective antiviral treatment does not currently exist for rhinoviruses.  @leeClinicalSignificanceRhinoviruses2025

There are three species of rhinoviruses A, B, and C, which are then further subdivided; there exist over 160 serotypes for rhinoviruses. @leeHumanRhinovirusSpecies2012
The variety that exists in rhinoviruses presents a problem in vaccine development: how to create a vaccine that is representative of as many serotypes as possible. 
Like other members of the Picornaviridae family, rhinoviruses are non-enveloped, enclosed in a protein capsid; there are many regions that are conserved. Identifying rhinovirus epitopes and sites that elicit an immune response could be the key to solving this years-long issue. @mcleanVaccineStrategiesInduce2019

The introduction of protein language models (PLMs) has made huge impacts in the field of biology.
Models such as ESM3 are trained on hundreds of millions of proteins with the ability to condense large datasets and discover new patterns in this noise @Simulating500Million.
These models have been used to develop tools for viral forecasting such as CovFit @itoProteinLanguageModel2025a, and to model antibody sequences such as AbLang @olsenAbLangAntibodyLanguage2022. 

In Phage ImmunoPrecipitation (PhiP-Seq), bacteriophage genetic code can be modified to display short peptide fragments derived from any protein on its capsid.
The process is high-throughput, where thousands of custom bacteriophages can be generated, assembled, and tested against human sera to elicit an immune response. @tiuPhageImmunoPrecipitationSequencing2022
Many rhinovirus epitopes are internal and not well studied; PhiP-Seq can display peptide fragments from any protein.
Designing a PLM trained on PhiP-Seq data could identify important new epitopes for a rhinovirus vaccine. 

== Innovation

This project looks to research an understudied virus, rhinovirus, and generate large amounts of phage display data.
Phage display data will be used to train a new protein language model, where both the model and phage display data will be open source, available for public use.
This model will help determine new epitope regions in the rhinovirus capsid and identify the sites to target to develop a novel vaccine.

== Approach

=== Aim 1 Design and implement a phage display library

A sequencing library of predicted rhinovirus epitopes and other capsid proteins will be compiled.
To prevent the library from getting too large, epitopes and capsid proteins will be clustered based on site similarity, choosing proteins that encompass the largest number of serotypes.

A deep mutational scan library would be invaluable for this research but also presents the same issue of inflating the library size.
An alanine scanning library will be built instead, where for a given protein, a new protein will be designed with one alanine placed at each position of the protein, incrementing by one position. This alanine scan will show which specific residues are essential to elicit an immune response.

These steps will ensure that the initial phage display library will be based on proteins that are representative of most serotypes while still being a manageable size for cost and time. The proteins of this new library will be inserted into the capsid protein genome of the phage to be built into part of the capsid by the phage.

Phages will be grown and incubated in a medium with E. coli to ensure that there are multiple copies of each phage. 
Diluted samples from this medium will be tested against human sera, where phages that are bound by IgG will be separated, lysed, and sequenced.

The human sera will be from a highly diverse collection of individuals who have all been infected with rhinovirus.

Alanine significance

=== Aim 2 Train a PLM on phage display data

A masked language model will be built and trained on the capsid proteins of rhinovirus; the dataset will include all serotypes of rhinovirus.
The model will also be trained on metagenomic sequencing data for rhinovirus from SRA to encompass additional mutations. 
To further expand this dataset, other Picornaviridae capsid proteins will be included.

This protein language model will then be fine-tuned on the phage display results to predict and generate proteins that elicit a high immune response. 
The model's sequence embeddings will cluster proteins of similar function together and will be labeled by rhinovirus serotype. 
Novel proteins generated from the model will be screened by checking semantic similarity, or if the proteins are near enough to all proteins from all serotypes in their functional group.

Since PhiP-Seq only tests for linear epitopes, PhiP-Seq proteins will be run through AlphaFold to generate 3D structural information, with the model being further fine-tuned on the structural embeddings.

ESM3 will also be fine-tuned on PhiP-Seq expression data; ESM3 will be used instead of ESM2 as it can be trained on 3D structural information.
This much larger model will be tested against the previously generated model to determine whether a model trained on hundreds of millions of proteins will outperform one trained on a smaller, more specific dataset.

=== Aim 3 Predict epitope sites and produce new phage libraries

Selected novel proteins generated by the model will then be used to generate a new library with alanine scanning performed as well to test which residues are essential to elicit an immune response. 
These new proteins will be tested against the sera samples from the diverse cohort of adults to determine which newly generated proteins elicit the strongest immune response across patients.
Proteins that elicit an immune response in the most patients will be used to further fine-tune the model.
This will further optimize the model to generate proteins that not only elicit a strong immune response, but are also recognized by a majority of the sera from adults who have been infected with different serotypes of rhinovirus.

This iterative process will help identify promising vaccine candidate proteins, where more in-depth testing can be performed on a smaller subset of selected proteins, saving countless hours of testing.

#pagebreak()
#bibliography("MCB_Build_Anything.bib", title: "References", style: "ieee")