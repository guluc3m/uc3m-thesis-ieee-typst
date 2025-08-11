#import "locale.typ": *
#import "utils.typ": azuluc3m

#let titlepage(
  authors,
  date,
  title-font,
  language,
  logo-left,
  title,
  type-of-thesis,
  date-format,
  page-grid,
  degree: none,
  course: none,
  tutors: none,
  location: none,
  accent-color: azuluc3m,
) = {

  set page(     
    margin: (top: 4cm, bottom: 3cm, left: 4cm, right: 3cm),   
  )
  
  set text(size: page-grid, fill: accent-color)
  if title-font != auto {
    set text(font: title-font)
  }
  set align(center)

  place(                                
    top + center,
    dy: -2.5 * page-grid,
    box(if logo-left == none { image("img/new_uc3m_logo.svg") } else { logo-left }, width: 100%, height: 5.5 * page-grid)
  )

  v(4.8 * page-grid)
    
  if degree != none {
    text(size: 1.2 * page-grid, weight: "regular", degree)
    linebreak()
  }
  
  if course != none {
    text(size: 1.2 * page-grid, weight: "regular", course)
    linebreak()
    v(1.2 * page-grid)
  }
  
  if type-of-thesis != none {
    text(size: 1.2 * page-grid, style: "italic", type-of-thesis)
    v(0.6 * page-grid)
  }
  
  text(size: 2 * page-grid, weight: "bold", "\"" + title + "\"")
  v(0.3 * page-grid)

  line(length: 70%, stroke: (paint: accent-color, thickness: 0.5pt))
  v(0.3 * page-grid)

  text(size: 1.2 * page-grid, style: "italic", TITLEPAGE_AUTHOR.at(language))
  linebreak()
  text(size: 1.5 * page-grid, weight: "bold", authors.at(0).name)
  v(0.3 * page-grid)
  
  if tutors != none and tutors.len() > 0 {
    if tutors.len() == 1 {
      text(size: 1.2 * page-grid, style: "italic", TITLEPAGE_TUTOR.at(language))
    } else {
      text(size: 1.2 * page-grid, style: "italic", TITLEPAGE_TUTORS.at(language))
    }
    linebreak()
    for tutor in tutors {
      text(size: 1.2 * page-grid, tutor)
      linebreak()
    }
    v(0.3 * page-grid)
  }
  
  if location != none {
    text(size: 1.2 * page-grid, location)
    linebreak()
  }
  
  text(size: 1.2 * page-grid, {
    set text(lang: language)
    
    let get-spanish-month(month-num) = {
      let spanish-months = (
        "enero", "febrero", "marzo", "abril", "mayo", "junio",
        "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"
      )
      spanish-months.at(month-num - 1)
    }
    
    if (type(date) == datetime) {
      if (language == "es" and date-format.contains("[month repr:long]")) {
        str(date.day()) + " de " + get-spanish-month(date.month()) + " de " + str(date.year())
      } else {
        date.display(date-format)
      }
    } else {
      date.at(0).display(date-format) + [ -- ] + date.at(1).display(date-format)
    }
  })
  
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
    }
  )
}