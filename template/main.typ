#import "../lib.typ": conf, gls, glspl
#import "config/glossary.typ": glossary-entries
#import "config/gen-ai.typ": genai-declaration
#import "config/acknowledgements.typ": acknowledgements
#import "config/bibliography.typ": bibliography


#show: conf.with(
  degree: "Ingeniería Typstática",
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
  bibliography: bibliography,
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
  acknowledgements: acknowledgements,
  outlines: (
    // contents is compulsory
    figures: true,
    tables: true,
    listings: false,
    // custom: []
  ),
  // appendixes: [],
  glossary: glossary-entries, // uncomment this line if you want a glossary
  // abbreviations: (TFG: "Trabajo de Fin de Grado"),
  genai-declaration: genai-declaration,
)


#include "parts/introduction.typ"
#include "parts/state_of_the_art.typ"
#include "parts/analysis.typ"
#include "parts/design.typ"
#include "parts/implementation.typ"
#include "parts/verification.typ"
#include "parts/project_plan.typ"
#include "parts/conclusions.typ"


#figure(
  image("img/logo_gul_uc3m.svg", width: 70%),
  caption: [El mejor logo de la UC3M, con diferencia],
) <logo>

#include "/parts/graph_example.typ"

// Referencing an acronym or the glossary is very important, ie. if you don't know
// what an #gls("API") is, you should look it up.
