#import "/lib.typ": conf
#import "config/glossary.typ": glossary-entries
#import "config/gen-ai.typ": genai-declaration
#import "config/bibliography.typ": bibliography


#show: conf.with(
  degree: "Grado en Ingeniería Typstática",
  title: "Análisis, diseño, e implementación del mejor Trabajo de Fin de Grado de la historia",
  short-title: "La mejor Memoria de la Historia",
  author: "Nombre Extremadamente Largo e Incómodo de Escribir",
  advisors: ("Profesor Cuyos Padres Tenían Visión de Futuro",),
  location: "Leganés, Madrid",
  thesis-type: "TFG",
  date: datetime(year: 2025, month: 4, day: 20),
  language: "es",
  style: "fancy",
  license: true,
  double-sided: true,
  flyleaf: true,
  bibliography-content: bibliography,
  epigraph: (
    quote: [Cacaaaaaaaaaaaa.],
    author: "Uno que se cagaba",
    // source: "",
  ),
  abstract: (
    body: [Ta wapo.],
    keywords: ("Caca", "Culo", "Pedo", "Pis"), // see https://www.ieee.org/content/dam/ieee-org/ieee/web/org/pubs/ieee-taxonomy.pdf
  ),
  english-abstract: (
    body: ['tis cool.],
    keywords: ("Poop", "Butt", "Fart", "Pee"),
  ),
  acknowledgements: [Mi churri.],
  outlines: (
    // contents is compulsory
    figures: true,
    tables: true,
    listings: false,
    // custom: []
  ),
  // appendixes: [],
  glossary: glossary-entries, // comment this line if you don't want a glossary
  // abbreviations: (TFG: "Trabajo de Fin de Grado"),
  genai-declaration: genai-declaration,
)


/* Custom set/show rules */

// prevent floating elements from spilling into the next section
#show heading.where(level: 2): it => {
  place.flush()
  it
}

// "booktab" table style
#show table: block.with(stroke: (y: 0.7pt))
#set table(column-gutter: .2em, stroke: none)
#set table.hline(stroke: 0.4pt)



/* Thesis */

#include "parts/introduction.typ"
#include "parts/state_of_the_art.typ"
#include "parts/analysis.typ"
#include "parts/design.typ"
#include "parts/implementation.typ"
#include "parts/verification.typ"
#include "parts/project_plan.typ"
#include "parts/conclusions.typ"


/* Examples */

#include "parts/graph_example.typ"

#figure(
  image("img/logo_gul_uc3m.svg", width: 70%),
  caption: [El mejor logo de la UC3M, con diferencia],
) <fig:logo>

@fig:logo.

#let yes = sym.checkmark
#figure(
  table(
    columns: 7,
    table.header(
      [*OS*],
      [*Silksong*],
      [*Ads*],
      [*Spyware*],
      [*Unix*],
      [*FOSS*],
      [*Penguins*],
    ),
    table.hline(),
    [Linux], [#yes], [], [], [#yes], [#yes], [#yes],
    [MacOS], [#yes], [], [#yes], [#yes], [], [],
    [Windows], [#yes], [#yes], [#yes], [], [], [],
  ),
  caption: [Comparison of desktop Operating Systems],
) <tab:os>

@tab:os.

@sdg-un // bibliography reference

// glossary
#import "@preview/glossarium:0.5.9": gls, glspl
#gls("API")

