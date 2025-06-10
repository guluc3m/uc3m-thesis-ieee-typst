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
  presentation_place: none,
  presentation_date: none,
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


  // Título y grado
  #text(25pt, ["*#title*"])\

  // #line(length: 70%, stroke: azuluc3m)

  // TFG pero en inglés o español xd
  #text(COVER_TYPE.at(language))

  #emph(degree)

  #{
    set text(12pt)
    place(
      bottom + center,
      grid(
        columns: (auto, auto),
        row-gutter: 1em,
        column-gutter: 1em,
        align: (right, left),

        // submission date
        text(weight: "bold", COVER_DATE.at(language)),
        text(str(year.at(0)) + "/" + str(year.at(1))),

        // autor
        align(text(weight: "bold", COVER_AUTHOR.at(language)), top),
        text(author),

        // university supervisor
        text(weight: "bold", COVER_TUTOR.at(language)),
        text(professor),

        // lugar
        if presentation_place != none [
          #text(weight: "bold", COVER_PLACE.at(language))
        ],
        if presentation_place != none [
          #text(presentation_place)
        ],

        // Fecha de presentación
        if presentation_date != none [
          #text(weight: "bold", COVER_PRESENTATION_DATE.at(language))
        ],
        if presentation_date != none [
          #text(presentation_date)
        ],



      ),
    )
  }

  #pagebreak()
  #counter(page).update(1)
]
