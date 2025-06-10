#import "utils.typ": *


#let cover(
  degree,
  title,
  year,
  logo,
  author: (),
  professor: none,
  language: "en",
  presentation_place: none,
  presentation_date: none,
  license: false,
) = [
  #set align(center)
  #set text(azuluc3m)
  #set text(size: 17pt)
  #set page(header: [], footer: [])

  // logo
  #if logo == "new" [
    #image("img/new_uc3m_logo.svg", width: 100%)
  ] else [
    #image("img/old_uc3m_logo.svg", width: 45%)
  ]
  #v(1em)


  // Título
  #text(25pt, ["*#title*"])\

  // "TFG" o "Bachelor Thesis"
  #text(COVER_TYPE.at(language))

  // Grado
  #emph(degree)

  #{
    set text(12pt)
    place(
      bottom + center,
      grid(
        columns: (auto, auto),
        row-gutter: 1em,
        column-gutter: 0.5em,
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

        // Espacio para la licencia
        if license {
          v(7em)
        },
      ),
    )
  }

  // Licencia
  #{
    set text(fill: luma(0), size: 12pt)
    place(
      bottom + left,
      if license [
        #image("img/by-nc-nd.svg", width: 25%)
        #v(-0.5em)
        #text(COVER_LICENSE.at(language))
      ],
    )
  }

  #pagebreak()
  #counter(page).update(1)
]
