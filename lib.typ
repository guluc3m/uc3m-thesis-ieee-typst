#import "@preview/hydra:0.6.1": hydra

#import "titlepage.typ": titlepage
#import "locale.typ" as locale
#import "utils.typ": *
#import "arguments.typ": validate-argument


/// Main configuration function.
///
/// Recommended to use with `#show: conf.with(...)`.
///
/// - title (str): Title of the thesis.
/// - author (str): Author name.
/// - degree (str): Degree name (e.g. `"Computer Science and Engineering"`).
/// - advisors (array): List of advisor names.
/// - location (str): Presentation location.
/// - thesis-type (str): Type of thesis (`"TFG"` or `"TFM"`).
/// - date (datetime): Presentation date.
/// - bibliography-file (str): Path to bibliography file.
/// - language (str): `"en"` or `"es"`.
/// - logo (str): Type of logo (`"old"` or `"new"`).
/// - short-title (str): Shorter version of the title, to be displayed in the headers.
/// - date-format (str, auto): Date format. Use `auto` or specify the format using the [Typst format syntax](https://typst.app/docs/reference/foundations/datetime/#format).
/// - license (bool): Whether to include the CC BY-NC-ND 4.0 license.
/// - epigraph (dictionary, none): A short quote that guided you through the writting of the thesis, your degree, or your life. Consists of `quote` (of type `content`), the body or text itself, `author` (of type `str`), the author of the quote and, optionally, `source` (of type `str`), where the quote was found.
/// - abstract (dictionary): A short and precise representation of the thesis content. Consists of `body` (of type `content`), the main text, and `keywords`, an array of key terms (of type `str`) (see [IEEE Taxonomy](https://www.ieee.org/content/dam/ieee-org/ieee/web/org/pubs/ieee-taxonomy.pdf)).
/// - acknowledgements (content, none): Text where you give thanks to everyone that helped you.
/// - doc (content): Thesis contents.
///
/// -> content
#let conf(
  title: none,
  author: none,
  degree: none,
  advisors: none,
  location: none,
  thesis-type: none,
  date: none,
  bibliography-file: none,
  language: none,
  logo: "new",
  short-title: none,
  date-format: auto,
  license: true,
  epigraph: none,
  abstract: (contents: [], keywords: ()),
  acknowledgements: none,
  doc,
) = {
  // ========================= ARGUMENT VALIDATION ========================== //

  validate-argument("title", title, target-type: str)

  validate-argument("author", author, target-type: str)

  validate-argument("degree", degree, target-type: str)

  validate-argument(
    "advisors",
    advisors,
    target-type: ((array, str),),
    min-len: 1,
  )

  validate-argument("location", location, target-type: str)

  validate-argument(
    "thesis-type",
    thesis-type,
    target-type: str,
    possible-values: ("TFG", "TFM"),
  )

  validate-argument("date", date, target-type: datetime)

  validate-argument(bibliography-file, "bibliography-file", target-type: str)

  validate-argument(
    "language",
    language,
    target-type: str,
    possible-values: ("es", "en"),
  )

  validate-argument(
    "logo",
    logo,
    target-type: str,
    possible-values: ("new", "old"),
  )

  validate-argument(
    "short-title",
    short-title,
    optional: true,
    target-type: (str, content),
  )

  validate-argument("license", license, target-type: bool)

  validate-argument(
    "epigraph",
    epigraph,
    optional: true,
    target-type: dictionary,
    schema: (
      quote: (target-type: content),
      author: (target-type: str),
      source: (target-type: str, optional: true),
    ),
  )

  validate-argument(
    "abstract",
    abstract,
    target-type: dictionary,
    schema: (
      body: (target-type: content),
      keywords: (target-type: ((array, str),), min-len: 2, max-len: 5),
    ),
  )

  validate-argument(
    "acknowledgements",
    acknowledgements,
    optional: true,
    target-type: content,
  )


  // ============================== PAGE SETUP ============================== //

  let in-frontmatter = state("in-frontmatter", false) // to control page number format in frontmatter
  let in-endmatter = state("in-endmatter", false) // to control page number format in endmatter
  let in-body = state("in-body", false) // to control heading formatting in/outside of body
  let in-appendix = state("in-appendix", false) // to control heading formatting in the appendixes


  /* TEXT */

  set text(size: 12pt, lang: language)

  set par(
    leading: 0.65em,
    spacing: 1em,
    first-line-indent: 1.8em,
    justify: true,
  )


  /* HEADINGS */

  set heading(numbering: "1.")
  show heading: set text(azuluc3m)
  show heading: set block(above: 1.4em, below: 1em)

  // fancy headings for chapters
  show heading.where(level: 1): it => {
    // reset figure counters so they are counted per chapter
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)

    // chapter on new page
    pagebreak(weak: true, to: "odd")

    if in-frontmatter.get() or in-endmatter.get() {
      set align(center)
      box(
        stroke: (top: azuluc3m + 1.8pt),
        width: 100%,
        height: 2em,
        inset: (top: 1.5em),
        { text(size: 24pt, upper(it)) },
      )
      v(3em)
    } else {
      box(
        width: 100%,
        inset: (top: 5.5em, bottom: 5em),
        [
          // chapter number
          #box(
            width: 100%,
            stroke: (top: azuluc3m + 1.8pt, bottom: azuluc3m + 1.8pt),
            inset: (top: 1.5em, bottom: 1.5em),
            [
              #set align(center)
              #text(
                [
                  #upper(if in-body.get() {
                    locale.CHAPTER.at(language)
                  } else if in-appendix.get() {
                    locale.APPENDIX.at(language)
                  })
                  #(counter(heading).get().first())
                ],
                size: 24pt,
              )
            ],
          )
          // chapter name
          #box(
            width: 100%,
            inset: (top: 0.2em),
            [
              #set align(center)
              #set text(azuluc3m)
              #set par(justify: false)
              #text(upper(it.body), size: 24pt, weight: "semibold")],
          )
        ],
      )
    }
  }

  // allow to set headings with selector `<nonumber>` to prevent numbering
  show selector(<nonumber>): set heading(numbering: none)


  /* FIGURES */

  // figure captions w/ blue
  show figure.caption: it => {
    [
      #set text(azuluc3m, weight: "semibold")
      #it.supplement #context it.counter.display(it.numbering):
    ]
    it.body
  }

  // show chapter on numbering
  set figure(numbering: (..num) => numbering(
    if in-appendix.get() { "A.1" } else { "1.1" },
    counter(heading).get().first(),
    num.pos().first(),
  ))


  // more space around figures
  // https://github.com/typst/typst/issues/6095#issuecomment-2755785839
  show figure: it => {
    let figure_spacing = 0.75em

    if it.placement == none {
      block(it, inset: (y: figure_spacing))
    } else if it.placement == top {
      place(it.placement, float: true, block(
        width: 100%,
        inset: (bottom: figure_spacing),
        align(center, it),
      ))
    } else if it.placement == bottom {
      place(it.placement, float: true, block(
        width: 100%,
        inset: (top: figure_spacing),
        align(center, it),
      ))
    }
  }


  /* IMAGES */

  show figure.where(kind: image): set figure.caption(position: bottom)


  /* TABLES */

  show figure.where(kind: table): set figure.caption(position: top)

  show table: block.with(stroke: (y: 0.7pt))
  set table(
    row-gutter: -0.1em, // Row separation
    stroke: (_, y) => if y == 0 { (bottom: 0.2pt) },
  )


  /* REFERENCES & LINKS */

  show ref: set text(azuluc3m)
  show link: set text(azuluc3m)


  /* FOOTNOTES */

  // change line color
  set footnote.entry(separator: line(
    length: 30% + 0pt,
    stroke: 0.5pt + azuluc3m,
  ))

  // change footnote number color
  show footnote: set text(azuluc3m) // in text
  show footnote.entry: it => {
    // in footnote
    h(1em) // indent
    {
      set text(azuluc3m)
      super(str(counter(footnote).at(it.note.location()).at(0))) // number
    }
    h(.05em) // mini-space in between number and body (same as default)
    it.note.body
  }


  /* PAGE LAYOUT */

  set page(
    paper: "a4",
    margin: (
      y: 2.5cm,
      x: 3cm,
    ),

    // header
    header: context {
      if in-body.get() and not is-chapter-start() {
        set text(azuluc3m)
        if calc.odd(here().page()) {
          counter(page).display()
          h(1fr)
          smallcaps({ if short-title != none { short-title } else { title } })
        } else {
          smallcaps([#locale.CHAPTER.at(language) #hydra(1)]) // chapter title
          h(1fr)
          counter(page).display("1") // arabic page numbers for the rest of the document
        }

        v(-0.7em)
        line(length: 100%, stroke: 0.4pt + azuluc3m)
      }
    },

    // footer
    footer: context {
      set align(center)
      set text(azuluc3m)

      if in-frontmatter.get() {
        counter(page).display("i") // roman page numbers for the frontmatter
      } else if (
        (in-endmatter.get() or is-chapter-start()) and not in-appendix.get()
      ) {
        counter(page).display("1") // arabic page numbers for chapter start and endmatter
      }
    },
  )


  // ============================== TITLEPAGE =============================== //

  titlepage(
    author,
    date,
    language,
    title,
    locale.THESIS-TYPE.at(thesis-type).at(language),
    if date-format == auto {
      locale.DATE-FMT.at(language, default: locale.DATE-FMT.at("es"))
    } else {
      date-format
    },
    locale.DEGREE-TYPE.at(thesis-type).at(language) + degree,
    location,
    advisors,
    logo-type: logo,
    accent-color: azuluc3m,
    license: license,
  )

  flyleaf()


  // ============================= FRONTMATTER ============================== //

  in-frontmatter.update(true)

  /* EPIGRAPH */

  if epigraph != none {
    set quote(block: true)
    set page(header: none, footer: none) // clean page

    grid(
      columns: (1fr, 1fr),
      rows: (1fr, 1fr, 1fr),
      // first (empty) row
      [], [],
      [],
      quote(attribution: {
        strong({
          epigraph.author
          if epigraph.keys().contains("source") [, #emph(epigraph.source)]
        })
      })[#emph(epigraph.quote)],
    )

    pagebreak(to: "odd")
  }

  /* ABSTRACT */

  heading(locale.ABSTRACT.at(language), numbering: none)
  abstract.body

  v(1fr)
  [*#locale.KEYWORDS.at(language):* #abstract.keywords.join(" • ")]


  /* ACKNOWLEDGEMENTS */

  if acknowledgements != none {
    heading(locale.ACKNOWLEDGEMENTS.at(language), numbering: none)
    acknowledgements
  }


  /* TOC */

  outline(title: locale.TOC.at(language))

  pagebreak(to: "odd")


  in-frontmatter.update(false)


  // ============================ DOCUMENT BODY ============================= //

  in-body.update(true)
  counter(page).update(1) // first chapter starts at page 1

  doc

  // pagebreak(to: "odd")
  in-body.update(false)


  // =============================== APPENDIX =============================== //

  in-appendix.update(true)

  set heading(numbering: "A.1")
  counter(heading).update(0)

  in-appendix.update(false)


  // ============================== ENDMATTER =============================== //

  pagebreak(to: "odd")
  in-endmatter.update(true)


  /* BIBLIOGRAPHY */

  bibliography(bibliography-file, style: "ieee")

  /* GLOSSARY */


  // in-endmatter.update(false)
}
