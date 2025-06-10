#import "../lib.typ": conf

#show: conf.with(
  degree: "Grado en...",
  subject: "Asignatura",
  year: (24, 25),
  project: "Práctica 0",
  title: "La mejor memoria de la historia",
  group: 89,
  author: "Luis Daniel Casais Mezquida",
  professor: "Perico de los Palotes",
  toc: true,
  logo: "old",
  language: "en",
  presentation_place: "Leganés, Madrid, España",
  presentation_date: "Junio, 2025"
)



= Introduction
#lorem(90)


== Motivation
#lorem(140)

== Problem Statement
#lorem(50)

= Related Work
#lorem(200)

#figure(
  image("../img/old_uc3m_logo.svg", width: 70%),
  caption: [El mejor logo de la UC3M, con diferencia],
) <logo>
