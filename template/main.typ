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
  // titlepage-style: "fancy",
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

// more space around figures
// https://github.com/typst/typst/issues/6095#issuecomment-2755785839
#show figure.where(kind: image).or(figure.where(kind: table)): it => {
  let figure_spacing = 0.75em

  if it.placement == none {
    block(it, inset: (y: figure_spacing))
  } else if it.placement == top {
    place(it.placement, float: true, block(
      width: 100%,
      inset: (bottom: figure_spacing),
      align(center, it),
    ))
  } else if it.placement == bottom {
    place(it.placement, float: true, block(
      width: 100%,
      inset: (top: figure_spacing),
      align(center, it),
    ))
  }
}

// indent lists
#set list(indent: 1em)
#set enum(indent: 1em)



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

Figure @fig:logo.

@sdg-un // bibliography reference

// glossary
#import "@preview/glossarium:0.5.9": gls, glspl
#gls("API")

