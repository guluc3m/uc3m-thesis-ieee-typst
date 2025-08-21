#import "@preview/hydra:0.6.2": hydra

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
/// - bibliography-style (str): Bibliography citation style. See https://typst.app/docs/reference/model/bibliography/#parameters-style.
/// - language (str): `"en"` or `"es"`.
/// - style (str): Visual style, mainly affecting headings, headers, and footers. The available styles are `strict`, which strictly follow's the university library's guidelines, `clean`, based on clean-dhbw, and `fancy`, based on my original LaTeX version.
/// - double-sided (bool): Whether to use double-sided pages. This is not allowed in the `strict` style.
/// - logo (str): Type of logo (`"old"` or `"new"`).
/// - short-title (str): Shorter version of the title, to be displayed in the headers. Only applies if `double-sided` is set to `true`.
/// - date-format (str, auto): Date format. Use `auto` or specify the format using the [Typst format syntax](https://typst.app/docs/reference/foundations/datetime/#format).
/// - license (bool): Whether to include the CC BY-NC-ND 4.0 license.
/// - flyleaf (bool): Whether to include a blank page after the cover.
/// - epigraph (dictionary, none): A short quote that guided you through the writting of the thesis, your degree, or your life. Consists of `quote` (of type `content`), the body or text itself, `author` (of type `str`), the author of the quote and, optionally, `source` (of type `str`), where the quote was found.
/// - abstract (dictionary): A short and precise representation of the thesis content. Consists of `body` (of type `content`), the main text, and `keywords`, an array of key terms (of type `str`) (see [IEEE Taxonomy](https://www.ieee.org/content/dam/ieee-org/ieee/web/org/pubs/ieee-taxonomy.pdf)).
/// - english-abstract (dictionary): An english translation of the abstract. Compulsory for spanish works, invalid for english ones.
/// - acknowledgements (content, none): Text where you give thanks to everyone that helped you.
/// - outlines (dictionaty, none): Set of extra outlines to include (`figures`, `tables`, `listings`), and extra custom outlines (`custom`, of type `content`).
/// - abbreviations (dict, none): Map of abbreviations, acronyms and initials used throughout the thesis.
/// - appendixes (content, none): Set of appendixes.
/// - glossary (content, none): Glossary.
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
  bibliography-style: "ieee",
  language: none,
  style: "fancy",
  double-sided: false,
  logo: "new",
  short-title: none,
  date-format: auto,
  license: true,
  flyleaf: true,
  epigraph: none,
  abstract: none,
  english-abstract: none,
  acknowledgements: none,
  outlines: none,
  appendixes: none,
  glossary: none,
  abbreviations: none,
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

  validate-argument("bibliography-file", bibliography-file, target-type: str)

  validate-argument("bibliography-style", bibliography-style, target-type: str)

  validate-argument(
    "language",
    language,
    target-type: str,
    possible-values: ("es", "en"),
  )

  validate-argument(
    "style",
    style,
    target-type: str,
    possible-values: ("fancy", "clean", "strict"),
  )

  validate-argument(
    "double-sided",
    double-sided,
    target-type: bool,
  )

  assert(
    not (double-sided and style == "strict"),
    message: "'strict' style doesn't allow for 'double-sided' to be set to `true`.",
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

  validate-argument("flyleaf", flyleaf, target-type: bool)

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
    "english-abstract",
    english-abstract,
    target-type: if language == "es" { dictionary } else { none },
    optional: if language == "es" { false } else { true },
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

  validate-argument(
    "outlines",
    outlines,
    optional: true,
    target-type: dictionary,
    schema: (
      figures: (target-type: bool, optional: true),
      tables: (target-type: bool, optional: true),
      listings: (target-type: bool, optional: true),
      custom: (target-type: content, optional: true),
    ),
  )

  validate-argument(
    "abbreviations",
    abbreviations,
    optional: true,
    target-type: ((dictionary, str),),
  )

  validate-argument(
    "appendixes",
    appendixes,
    optional: true,
    target-type: content,
  )

  validate-argument(
    "glossary",
    glossary,
    optional: true,
    target-type: content,
  )


  // ============================== PAGE SETUP ============================== //

  let in-frontmatter = state("in-frontmatter", false) // to control page number format in frontmatter
  let in-endmatter = state("in-endmatter", false) // to control page number format in endmatter
  let in-body = state("in-body", false) // to control heading formatting in/outside of body
  let in-appendix = state("in-appendix", false) // to control heading formatting in the appendixes

  let accent-color = if style == "strict" { black } else { azuluc3m }


  /* TEXT */

  let font = if style == "strict" {
    "Times New Roman"
  } else { "Libertinus Serif" }

  set text(size: 12pt, lang: language, font: font)

  set par(
    leading: if style == "strict" { 7pt } else { 8pt },
    spacing: 1.15em,
    first-line-indent: 1.8em,
    justify: true,
  )


  /* HEADINGS */

  set heading(numbering: if style == "clean" { "1.1" } else { "1." })
  show heading: set text(
    accent-color,
    font: font,
  )

  show heading: it => {
    if style == "clean" {
      if (it.level >= 4) {
        [
          #v(16pt)
          #smallcaps(
            text(
              size: 11pt,
              weight: "semibold",
              fill: azuluc3m,
              it.body,
            ),
          )
        ]
      } else {
        set par(leading: 4pt, justify: false)
        text(it, top-edge: 0.75em, bottom-edge: -0.25em, fill: azuluc3m)
      }
      v(16pt, weak: true)
    } else if style == "fancy" {
      set block(above: 1.4em, below: 1em)
      it
    } else if style == "strict" {
      set block(above: 1.15em, below: 1.15em)
      text(it, size: 12pt, weight: "bold")
    } else { it }
  }

  // fancy headings for chapters
  show heading.where(level: 1): it => {
    // reset figure counters so they are counted per chapter
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)

    // chapter on new page
    newpage(double-sided)

    if style == "strict" {
      set align(center)
      text(upper(it), size: 14pt, weight: "bold")
      v(1.15em)
      return
    }


    if in-frontmatter.get() or in-endmatter.get() {
      /* frontmatter / endmatter */

      if style == "clean" {
        v(32pt) + text(size: 32pt, fill: azuluc3m, weight: "bold", it)
      } else if style == "fancy" {
        set align(center)
        box(
          stroke: (top: azuluc3m + 1.8pt),
          width: 100%,
          height: 2em,
          inset: (top: 1.5em),
          { text(size: 24pt, upper(it)) },
        )
        v(3em)
      } else { it }
    } else {
      /* document */

      if style == "clean" {
        set par(leading: 0pt, justify: false)
        pagebreak()
        context {
          if in-body.get() {
            v(160pt)
            place(
              // place heading number prominently at the upper right corner
              top + right,
              dx: 9pt, // slight adjustment for optimal alignment with right margin
              text(
                counter(heading).display(),
                top-edge: "bounds",
                size: 160pt,
                weight: 900,
                azuluc3m.lighten(70%),
              ),
            )
            text(
              // heading text on separate line
              it.body,
              size: 40pt,
              fill: azuluc3m,
              weight: "bold",
              top-edge: 0.75em,
              bottom-edge: -0.25em,
            )
          } else {
            v(2 * page-grid)
            text(
              size: 2 * page-grid,
              fill: azul-uc3m,
              weight: "bold",
              counter(heading).display() + h(0.5em) + it.body,
            ) // appendix
          }
        }
      } else if style == "fancy" {
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
  }

  show heading.where(level: 2): it => {
    if style == "clean" { v(16pt) + text(size: 16pt, it) } else { it }
  }
  show heading.where(level: 3): it => {
    if style == "clean" { v(16pt) + text(size: 11pt, it) } else { it }
  }


  /* FIGURES */

  // figure captions
  show figure.caption: it => {
    set text(size: 10pt)
    if style == "strict" { it } else {
      [
        #set text(azuluc3m, weight: "semibold")
        #it.supplement #context it.counter.display(it.numbering):
      ]
      it.body
    }
  }

  set figure.caption(
    separator: if style == "strict" {
      [.]
      h(1em)
    } else { auto },
  )

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

  // caption position
  show figure.where(kind: image): set figure.caption(position: bottom)
  show figure.caption.where(kind: image): set align(if style == "strict" {
    left
  } else { center })

  // change supplement for strict style
  show figure.where(kind: image): set figure(
    supplement: if style == "strict" {
      "Fig."
    } else { auto },
    gap: { 1em },
  )


  /* TABLES */

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption.where(kind: table): it => {
    if style == "strict" [
      #context smallcaps(it.supplement)
      #context smallcaps(it.counter.display(it.numbering)) \
      #set text(weight: "regular")
      #smallcaps(it.body) \
    ] else { it }
  }


  /* REFERENCES & LINKS */

  show ref: set text(accent-color)
  show link: set text(accent-color)


  /* FOOTNOTES */

  // change line color
  set footnote.entry(separator: line(
    length: 30% + 0pt,
    stroke: 0.5pt + accent-color,
  ))

  // change footnote number color
  show footnote: set text(accent-color) // in text
  show footnote.entry: it => {
    // in footnote
    h(1em) // indent
    {
      set text(accent-color)
      super(str(counter(footnote).at(it.note.location()).at(0))) // number
    }
    h(.05em) // mini-space in between number and body (same as default)
    it.note.body
  }


  /* PAGE LAYOUT */

  set page(
    paper: "a4",
    margin: if double-sided {
      (y: 2.5cm, inside: 3cm, outside: 2.5cm)
    } else { (y: 2.5cm, x: 3cm) },

    /* header */
    header: context {
      if style == "strict" {
        // no header
        return
      }

      if (
        (style == "clean" and not in-appendix.get())
          or (style == "fancy" and in-body.get() and not is-chapter-start())
      ) {
        // show header
        set text(accent-color)
        if double-sided and calc.even(here().page()) {
          counter(page).display()
          h(1fr)
          smallcaps({ if short-title != none { short-title } else { title } })
        } else {
          // chapter title
          if style == "clean" {
            // just name
            hydra(
              1,
              display: (_, it) => {
                // hydra should already do this... but alas...
                if not is-chapter-start() {
                  smallcaps(it.body)
                }
              },
              use-last: true,
              skip-starting: true,
              book: double-sided,
            )
          } else if style == "fancy" {
            // name and number
            smallcaps([#locale.CHAPTER.at(language) #hydra(1)])
          }
          h(1fr)
          counter(page).display("1") // arabic page numbers for the rest of the document
        }

        v(-0.6em)
        line(length: 100%, stroke: 0.4pt + azuluc3m)
      }
    },

    /* footer */
    footer: context {
      if style == "strict" {
        set align(right)
        if in-frontmatter.get() {
          counter(page).display("I")
        } else if not in-appendix.get() {
          counter(page).display("1")
        }
      } else if style == "fancy" {
        set align(center)
        set text(azuluc3m)

        if in-frontmatter.get() {
          counter(page).display("i") // roman page numbers for the frontmatter
        } else if (
          (in-endmatter.get() or is-chapter-start()) and not in-appendix.get()
        ) {
          counter(page).display("1") // arabic page numbers for chapter start and endmatter
        }
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
    accent-color,
    double-sided,
    style,
    logo-type: logo,
    license: license,
  )

  if flyleaf { make-flyleaf(double-sided) }


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

    newpage(double-sided)
  }


  /* ABSTRACT */

  let make-abstract(data, language) = {
    heading(locale.ABSTRACT.at(language), numbering: none, outlined: false)
    data.body

    v(1fr)
    [*#locale.KEYWORDS.at(language):* #data.keywords.join(" • ")]
  }

  make-abstract(abstract, language)

  // english abstract
  if english-abstract != none {
    newpage(double-sided)
    make-abstract(english-abstract, "en")
  }


  /* ACKNOWLEDGEMENTS */

  if acknowledgements != none {
    heading(
      locale.ACKNOWLEDGEMENTS.at(language),
      numbering: none,
      outlined: false,
    )
    acknowledgements
  }


  /* OUTLINES */


  // disable footnotes
  show outline: it => {
    set footnote.entry(separator: none)
    show footnote.entry: hide
    show ref: none
    show footnote: none
    it
  }

  // top-level TOC entries in bold without filling
  show outline.entry.where(level: 1): it => {
    // only apply for contents (headings) outline
    if it.element.func() != heading { return it }

    if style == "strict" {
      set block(spacing: 1.5em)
      link(
        it.element.location(), // make entry linkable
        it.indented(
          it.prefix(),
          upper(it.body())
            + "  "
            + box(width: 1fr, repeat([.], gap: 2pt))
            + "  "
            + it.page(),
        ),
      )
    } else if style == "clean" {
      set block(above: 2em)
      set text(weight: "semibold", fill: azuluc3m)
      link(
        it.element.location(), // make entry linkable
        it.indented(it.prefix(), it.body() + box(width: 1fr) + it.page()),
      )
    } else if style == "fancy" {
      set block(above: 1.3em)
      set text(size: 13pt, weight: "semibold", fill: azuluc3m)

      // wrap it in a block to prevent justification
      block(
        link(
          it.element.location(), // make entry linkable
          [
            #if it.prefix() != none {
              locale.CHAPTER.at(language) + " " + it.prefix()
            } else {
              none
            } #it.body() #box(width: 1fr) #it.page()
          ],
        ),
      )
    }
  }

  // other TOC entries in regular with adapted filling
  show outline.entry.where(level: 2).or(outline.entry.where(level: 3)): it => {
    set block(above: if style == "strict" { auto } else { 0.8em })

    show link: set text(black) // reset link color

    link(
      it.element.location(), // make entry linkable
      it.indented(
        it.prefix(),
        it.body()
          + "  "
          + box(width: 1fr, repeat([.], gap: 2pt))
          + "  "
          + it.page(),
      ),
    )
  }

  // contents
  outline(title: locale.OUTLINE.at("contents").at(language), depth: 3)
  newpage(double-sided)

  if outlines != none {
    // figures
    if outlines.at("figures", default: false) {
      outline(
        title: locale.OUTLINE.at("figures").at(language),
        target: figure.where(kind: image),
      )
      newpage(double-sided)
    }

    // tables
    if outlines.at("tables", default: false) {
      outline(
        title: locale.OUTLINE.at("tables").at(language),
        target: figure.where(kind: table),
      )
      newpage(double-sided)
    }

    // listings
    if outlines.at("listings", default: false) {
      outline(
        title: locale.OUTLINE.at("listings").at(language),
        target: figure.where(kind: raw),
      )
      newpage(double-sided)
    }

    // custom
    if outlines.at("custom", default: false) {
      custom
      newpage(double-sided)
    }
  }


  /* ABBREVIATIONS */

  if abbreviations != none {
    heading(
      locale.ABBREVIATIONS.at(language),
      numbering: none,
    )

    set align(center)

    box(
      width: 80%,
      table(
        columns: (1fr, 2fr), // ful width
        stroke: none,
        align: left,
        ..abbreviations.pairs().flatten()
      ),
    )
  }


  in-frontmatter.update(false)


  // ============================ DOCUMENT BODY ============================= //

  in-body.update(true)
  counter(page).update(1) // first chapter starts at page 1

  doc

  // newpage(double-sided)
  in-body.update(false)


  // ============================== ENDMATTER =============================== //

  newpage(double-sided, weak: false)
  in-endmatter.update(true)


  /* BIBLIOGRAPHY */

  bibliography(bibliography-file, style: bibliography-style)


  /* GLOSSARY */

  if glossary != none {
    heading(
      locale.GLOSSARY.at(language),
      numbering: none,
    )

    glossary
  }

  in-endmatter.update(false)


  // =============================== APPENDIX =============================== //

  if appendixes != none {
    in-appendix.update(true)

    newpage(double-sided)

    set heading(numbering: "A.1")
    counter(heading).update(0)

    appendixes

    // in-appendix.update(false)
  }
}
