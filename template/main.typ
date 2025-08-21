#import "/lib.typ": conf

#show: conf.with(
  degree: "Ingeniería Typstática",
  title: "La mejor memoria de la historia",
  // short-title: "",
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
  bibliography-file: "/template/references.bib",
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
  // glossary: []
  // abbreviations: (TFG: "Trabajo de Fin de Grado"),
)



= Introduction
#lorem(50)

== In the beninging
#lorem(400)

=== Some cool stuff
#lorem(50)

==== But not _that_ cool
#lorem(40)


== Motivation
#lorem(140)

== Problem Statement
#lorem(50)

= Related Work
#lorem(200)

#figure(
  image("/img/old_uc3m_logo.svg", width: 70%),
  caption: [El mejor logo de la UC3M, con diferencia],
) <logo>


= Tables

#let check = [$checkmark$]
#let uncheck = []
#figure(
  caption: "Feature comparison of current assembly simulators",
  {
    set text(9.4pt)
    block(
      stroke: (y: 0.7pt),
      table(
        columns: (34%, auto, auto, auto, auto, auto),
        row-gutter: -0.2em,
        stroke: (_, y) => if y == 0 { (bottom: 0.2pt) },
        table.header(
          [*Simulator*], [Kite], [ARMLite], [Sail], [CREATOR], [Proposal]
        ),
        align: (left, horizon, horizon, horizon, horizon, horizon),

        [*Language*], [C/C++], [JavaScript], [OCaml], [JavaScript], [ISO C++20],

        [*License*],
        [BSD-3-Clause],
        [None],
        [BSD-2-Clause],
        [LGPLv2.1],
        [GPLv3],

        [*CLI*], check, uncheck, uncheck, check, check,
        [*I/O*], uncheck, check, uncheck, check, check,
        [*Step-by-step execution*], uncheck, uncheck, uncheck, check, check,
        [*Simple architecture definition*],
        uncheck,
        uncheck,
        uncheck,
        check,
        check,

        [*Native execution*], check, uncheck, check, uncheck, check,
        [*In-browser*], uncheck, check, uncheck, check, [$checkmark^*$],
        [*Error checking*], uncheck, check, uncheck, check, check,
        [*Architecture validation support*],
        uncheck,
        uncheck,
        uncheck,
        uncheck,
        check,
      ),
    )
    set align(left)
    [#super("*") Future work]
  },
)
