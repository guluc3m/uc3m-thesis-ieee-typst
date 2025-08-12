#import "utils.typ": *


#let cover(
  degree,
  subject,
  project,
  title,
  logo,
  year: (69, 420),
  author: (),
  advisors: (),
  team: none,
  language: "en",
) = [
  #set align(center)
  #set text(azuluc3m)
  #set text(size: 17pt)
  #set page(header: [], footer: [])
  #set par(justify: false)

  // logo
  #if logo == "new" [
    #image("img/new_uc3m_logo.svg", width: 120%)
    #v(1em)
  ] else [
    #image("img/old_uc3m_logo.svg", width: 45%)
    #v(1em)
  ]

  #emph(degree)

  #subject #year.at(0) -- #year.at(1)\

  #v(1em)

  _Trabajo fin de grado_ \
  #emph(project)\
  #text(25pt, ["#title"])

  #line(length: 70%, stroke: azuluc3m)

  // author
  #{
    set text(18pt)
    [_Autor_\ ]
    set text(20pt)
    author
  }

  #if team != none [
    Team #team
  ]

  #v(1em)

  #{
    set text(18pt)
    [_Tutor_\ ]
    set text(20pt)
    advisors.at(0)
  }

  #v(1em)
  Leganés, a 8 de septiembre de 2025

  #set align(left)

  // #if professor != none [
  //   #if language == "es" [
  //     _Profesor_\
  //   ] else [
  //     _Professor_\
  //   ]
  //   #professor
  // ]

  #v(1em)
  #image("img/creativecommons.png", height: 2em)
  #set text(black, size: 10pt)

  Esta obra se encuentra sujeta a la licencia Creative Commons \
  *Reconocimiento -- No Comercial -- Sin Obra Derivada*
]
