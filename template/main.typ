#import "../lib.typ": conf

#show: conf.with(
  degree: "Grado en...",
  title: "La mejor memoria de la historia",
  authors: ((name: "Nombre Extremadamente Largo e Incómodo de Escribir"),),
  tutors: ("Profesor Cuyos Padres Tenían Visión de Futuro",),
  location: "La casa de tu madre",
  type-of-thesis: "Trabajo de Fin de Grado",
  date: datetime(year: 2025, month: 4, day: 20),
  toc: true,
  logo: "old",
  language: "es",
)



= Introduction
#lorem(900)


== Motivation
#lorem(140)

== Problem Statement
#lorem(50)

= Related Work
#lorem(200)

#figure(image("../img/old_uc3m_logo.svg", width: 70%), caption: [El mejor logo de la UC3M, con diferencia]) <logo>

= Tables

#let check = [$checkmark$]
#let uncheck = []
#figure(
  caption: "Feature comparison of current assembly simulators", {
  set text(9.4pt);
  table(
    columns: (34%, auto, auto, auto, auto, auto),
    row-gutter: -0.4em,
    table.header([*Simulator*], [Kite], [ARMLite], [Sail], [CREATOR], [Proposal]),
    align: (left, horizon, horizon, horizon, horizon, horizon),

    [*Language*], [C/C++], [JavaScript], [OCaml], [JavaScript], [ISO C++20],

    [*License*],  [BSD-3-Clause], [None], [BSD-2-Clause], [LGPLv2.1], [GPLv3],
    [*CLI*],                               check, uncheck, uncheck,   check, check,
    [*I/O*],                             uncheck,   check, uncheck,   check, check,
    [*Step-by-step execution*],          uncheck, uncheck, uncheck,   check, check,
    [*Simple architecture definition*],  uncheck, uncheck, uncheck,   check, check,
    [*Native execution*],                  check, uncheck,   check, uncheck, check,
    [*In-browser*],                      uncheck,   check, uncheck,   check, [$checkmark^*$],
    [*Error checking*],                  uncheck,   check, uncheck,   check, check,
    [*Architecture validation support*], uncheck, uncheck, uncheck, uncheck, check
  )
  set align(left)
  [#super("*") Future work]
}
)
