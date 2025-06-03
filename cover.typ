#import "utils.typ": *


#let cover(
  degree,
  subject,
  project,
  title,
  year,
  logo,
  group: none,
  author: (),
  professor: none,
  team: none,
  language: "en",
) = [
  #set align(center)
  #set text(azuluc3m)
  #set text(size: 17pt)
  #set page(header: [], footer: [])

  // logo
  #if logo == "new" [
    #image("img/new_uc3m_logo.svg", width: 100%)
    #v(1em)
  ] else [
    #image("img/old_uc3m_logo.svg", width: 45%)
    #v(1em)
  ]

  #emph(degree)

  #subject #year.at(0)/#year.at(1)\
  Grupo #group

  #v(2em)

  #emph(project)\
  #text(25pt, ["#title"])

  #line(length: 70%, stroke: azuluc3m)

  // author
  #{
    set text(20pt)
    author
  }

  #if team != none [
    Team #team
  ]

  #v(3em)

  #if professor != none [
    #if language == "es" [
      _Profesor_\
    ] else [
      _Professor_\
    ]
    #professor
  ]

  #pagebreak()
  #counter(page).update(1)
]
