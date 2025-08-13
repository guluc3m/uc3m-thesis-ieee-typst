#import "locale.typ": *
#import "utils.typ": azuluc3m

#let titlepage(
  author,
  date,
  title-font,
  language,
  title,
  type-of-thesis,
  date-format,
  page-grid,
  degree: none,
  advisors: none,
  location: none,
  logo-type: "new",
  accent-color: azuluc3m,
  license: true,
) = {
  // general configuration
  set page(
    margin: (top: 4cm, bottom: 3cm, left: 4cm, right: 3cm),
  )

  set text(size: page-grid, fill: accent-color)
  if title-font != auto {
    set text(font: title-font)
  }
  set align(center)

  // logo
  place(
    top + center,
    dy: -2.5 * page-grid,
    {
      box(image("img/" + logo-type + "_uc3m_logo.svg"), width: 100%, height: 11 * page-grid)
    },
  )

  if logo-type == "old" {
    v(9.4 * page-grid)
  } else {
    v(8.4 * page-grid)
  }

  // degree
  if degree != none {
    text(size: 1.2 * page-grid, weight: "regular", degree)
    linebreak()
  }

  // type-of-thesis
  if type-of-thesis != none {
    text(size: 1.2 * page-grid, style: "italic", type-of-thesis)
    v(0.6 * page-grid)
  }

  // title
  text(size: 2 * page-grid, weight: "bold", "\"" + title + "\"")
  v(0.3 * page-grid)

  line(length: 70%, stroke: (paint: accent-color, thickness: 0.5pt))
  v(0.3 * page-grid)

  // author
  text(size: 1.2 * page-grid, style: "italic", TITLEPAGE_AUTHOR.at(language))
  linebreak()
  text(size: 1.5 * page-grid, weight: "bold", author)
  v(0.3 * page-grid)

  // advisors
  if advisors != none and advisors.len() > 0 {
    text(size: 1.2 * page-grid, style: "italic", TITLEPAGE_ADVISOR.at(language))
    linebreak()

    for tutor in advisors {
      text(size: 1.2 * page-grid, tutor)
      linebreak()
    }

    v(0.3 * page-grid)
  }

  // location
  if location != none {
    text(size: 1.2 * page-grid, location)
    linebreak()
  }

  // date
  text(size: 1.2 * page-grid, {
    set text(lang: language)

    let get-spanish-month(month-num) = {
      let spanish-months = (
        "enero",
        "febrero",
        "marzo",
        "abril",
        "mayo",
        "junio",
        "julio",
        "agosto",
        "septiembre",
        "octubre",
        "noviembre",
        "diciembre",
      )
      spanish-months.at(month-num - 1)
    }

    if (type(date) == datetime) {
      if (language == "es" and date-format.contains("[month repr:long]")) {
        // currently, Typst doesn't support localization for the format syntax
        str(date.day()) + " de " + get-spanish-month(date.month()) + " de " + str(date.year())
      } else {
        date.display(date-format)
      }
    } else {
      date.at(0).display(date-format) + [ -- ] + date.at(1).display(date-format)
    }
  })

  // license
  if license {
    place(
      bottom + left,
      dy: -0.01 * page-grid,
      {
        set text(fill: black, size: 0.5 * page-grid)
        set align(left)
        box(width: 60%, {
          image("img/creativecommons.png", width: 3.5cm)
          v(0.05 * page-grid)
          set par(justify: false)
          text(CC_LICENSE_TEXT.at(language))
        })
      },
    )
  }


  pagebreak(to: "odd")
}
