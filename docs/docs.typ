#import "@preview/tidy:0.4.3"
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

#set document(
  title: "uc3m-thesis-ieee — Documentation",
  author: "GUL UC3M",
)


#let toml = read("../typst.toml")
#let matches = toml.match(regex("version\\s*=\\s*\"([^\"]+)\""))
#let package_version = if matches != none { matches.captures.at(0) } else {
  "unknown"
}

#set page(
  paper: "a4",
  margin: (x: 3cm, y: 2.5cm),
  numbering: "1",
  header: context {
    if counter(page).get().first() > 1 {
      set text(size: 9pt, fill: luma(120))
      [*uc3m-thesis-ieee* v#package_version]
      h(1fr)
      counter(page).display()
      v(-0.5em)
      line(length: 100%, stroke: 0.4pt)
    }
  },
)

#set heading(numbering: "1.")
#set text(font: "Libertinus Serif", size: 11pt)
#set par(leading: 8pt, justify: true, first-line-indent: 0pt)

#let images_example(style) = {
  let images = ("cover", "chapter").map(section =>
    image("report_" + style + "_" + section + ".png", width: 92%)
  )

  figure(
    grid(
      columns: 2,
      gutter: 0cm,
      ..images,
    ),
    caption: [Example of the *#style* style.],
  )
}


#align(center)[
  #text(size: 26pt, weight: "bold")[uc3m-thesis-ieee]
  \
  #text(size: 13pt, fill: luma(80))[Package Documentation — v#package_version]
  #v(0.4em)
  #text(
    size: 10pt,
  )[Universidad Carlos III de Madrid thesis template, IEEE style]
]

#v(1.5em)
#line(length: 100%, stroke: 0.5pt)
#v(1em)

#let doc-table = table.with(
  fill: (_, y) => if y == 0 { luma(240) } else { none },
  stroke: (x: none, y: 0.5pt),
  inset: (x: 8pt, y: 5pt),
)



= Configuration

The template exports a single `conf` function, which you apply to your document with `#show: conf.with(...)`.

== Minimal example

#codly
```typ
#import "@preview/uc3m-thesis-ieee:0.4.0": conf

#show: conf.with(
  title: "My Bachelor Thesis",
  author: "GUL UC3M",
  degree: "Computer Science and Engineering",
  advisors: ("Prof. L",),
  location: "Leganés, Madrid",
  thesis-type: "TFG",
  date: datetime(year: 2025, month: 6, day: 15),
  language: "en",
  abstract: (
    body: [A short description of my thesis.],
    keywords: ("Keyword 1", "Keyword 2", "Keyword 3"),
  ),
  genai-declaration: (usage: false),
)

= Introduction

My thesis starts here.
```


== Abstract
<sec:abstract>

The `abstract` parameter takes a dictionary with the following keys:

#doc-table(
  columns: (auto, auto, 1fr),
  table.header(
    [*Key*],
    [*Type*],
    [*Description*],
  ),
  [`body`\*],
  [`content`],
  [The abstract text.],
  [`keywords`\*],
  [`array` of `str`],
  [Between 2 and 5 keywords. See #link("https://www.ieee.org/content/dam/ieee-org/ieee/web/org/pubs/ieee-taxonomy.pdf")[IEEE Taxonomy].],
)

```typ
  abstract: (
  body: [
    This thesis presents an implementation of interrupts and timers
    in the CREATOR simulator.
  ],
  keywords: ("Operating Systems", "Interrupts", "RISC-V", "Simulation"),
),
```

For Spanish documents, it is required to provide an `english-abstract` with the same structure:

```typ
language: "es",
abstract: (
  body: [Una breve descripción de mi tesis.],
  keywords: ("Sistemas Operativos", "Interrupciones", "RISC-V"),
),
english-abstract: (
  body: [A brief description of my thesis.],
  keywords: ("Operating Systems", "Interrupts", "RISC-V"),
),
```

== Epigraph
<sec:epigraph>

An optional opening quote placed before the abstract. Provide a dictionary with:

#doc-table(
  columns: (auto, auto, 1fr),
  table.header(
    [*Key*],
    [*Type*],
    [*Description*],
  ),
  [`quote`\*],
  [`content`],
  [The quote text.],
  [`author`\*],
  [`str`],
  [The author of the quote.],
  [`source`],
  [`str`],
  [(Optional) The source where the quote was found.],
)

```typ
epigraph: (
  quote: [The purpose of abstracting is not to be vague, but to create a new semantic level in which one can be absolutely precise.],
  author: "Edsger W. Dijkstra",
  source: "The Humble Programmer, 1972",
),
```

== Outlines
<sec:outlines>

The `outlines` parameter accepts an optional dictionary with the following boolean keys. All keys are optional (default `false`):

#doc-table(
  columns: (auto, auto, 1fr),
  table.header(
    [*Key*],
    [*Type*],
    [*Description*],
  ),
  [`figures`],
  [`bool`],
  [Include a list of figures.],
  [`tables`],
  [`bool`],
  [Include a list of tables.],
  [`listings`],
  [`bool`],
  [Include a list of code listings.],
  [`custom`],
  [`array` of `content`],
  [Additional custom outlines (e.g. algorithms).],
)

```typ
outlines: (
  figures: true,
  tables: true,
  listings: false,
  // custom: (
  //   outline(
  //     title: [List of Algorithms],
  //     target: figure.where(kind: "algorithm"),
  //   ),
  // ),
),
```

== Abbreviations
<sec:abbreviations>
You can pass abbreviations as a dictionary mapping abbreviations to their expansions (automatically sorted alphabetically):

```typ
abbreviations: (
  API: "Application Programming Interface",
  CPU: "Central Processing Unit",
  ML: "Machine Learning",
  TFG: "Trabajo de Fin de Grado",
),
```

Or as custom `content` if you need full control over the layout:

```typ
abbreviations: [
  #table(
    columns: (auto, 1fr),
    [*API*], [Application Programming Interface],
    [*ML*],  [Machine Learning],
  )
],
```

== Glossary
<sec:glossary>
The template integrates with #link("https://typst.app/universe/package/glossarium/")[`glossarium`] for automatic glossary and acronym management.

Define your entries in a separate file (e.g. `config/glossary.typ`):

```typ
#let glossary-entries = (
  (
    key: "API",
    short: "API",
    long: "Application Programming Interface",
    description: "A set of protocols and tools for building software.",
  ),
  (
    key: "ML",
    short: "ML",
    long: "Machine Learning",
    description: "A subset of AI that enables computers to learn from data.",
  ),
)
```

Then import it in your main file and pass it to `conf`:

```typ
#import "config/glossary.typ": glossary-entries

#show: conf.with(
  // ...
  glossary: glossary-entries,
)
```

To reference a glossary term in the body text, use `#gls("key")` (singular) or `#glspl("key")` (plural). These are re-exported from `glossarium` and available after the `#show: conf.with(...)` call:

```typ
#import "@preview/uc3m-thesis-ieee:0.4.0": conf
#import "@preview/glossarium:0.5.9": gls, glspl

// In the body:
The #gls("API") exposes several endpoints.
Multiple #glspl("ML") models were evaluated.
```

Alternatively, you can pass fully custom `content` to `glossary` if you don't want to use `glossarium`.

== Generative AI Declaration
<sec:genai-declaration>

The `genai-declaration` parameter is *required* by the university. You can either:

=== Option A: Use the built-in template (recommended)

*If you did not use generative AI* (`usage: false`):

```typ
genai-declaration: (usage: false),
```

*If you did use generative AI* (`usage: true`), it is required to provide the full declaration:

Pass a dictionary with the following keys:

#doc-table(
  columns: (auto, auto, auto, 1fr),
  table.header(
    [*Key*],
    [*Type*],
    [*Required*],
    [*Description*],
  ),
  [`usage`\*],
  [`bool`],
  [Always],
  [Whether you used generative AI in the thesis.],
  [`data-usage`],
  [`dictionary`],
  [If `usage` is `true`],
  [Data usage declaration. See below.],
  [`technical-usage`],
  [`dictionary`],
  [If `usage` is `true`],
  [Technical usage declaration. See below.],
  [`usage-reflection`],
  [`content`],
  [If `usage` is `true`],
  [Personal reflection on AI usage.],
)

*`data-usage` keys* — all are `bool` (`true` = YES, `false` = NO):

#doc-table(
  columns: (auto, 1fr),
  table.header(
    [*Key*],
    [*Description*],
  ),
  [`confidential`],
  [Did you submit confidential data (trade secrets, proprietary info)?],
  [`copyright`],
  [Did you submit copyrighted materials?],
  [`personal`],
  [Did you submit personal data?],
  [`tos`],
  [Did your usage respect the tool's terms of use?],
)

*`technical-usage` keys* — include only those that apply, with a brief description of the prompt and interaction. Items are automatically grouped into two sections matching the official form:

*Documentation and drafting:* `reflection`, `review`, `research`, `references`, `summary`, `translation`

*Develop specific content:* `assistance-coding`, `generating-content`, `optimization`, `data-processing`, `idea-inspiration`, `other`

An optional `tool` key (`str`) declares the AI system name and version (e.g. `"ChatGPT 4o"`).

```typ
genai-declaration: (
  usage: true,
  data-usage: (
    // true = YES / used with authorization; false = NO / not used
    confidential: false,
    copyright: false,
    personal: false,
    tos: true,
  ),
  technical-usage: (
    // Name of the AI system and version (optional):
    // tool: "ChatGPT 4o",

    // ── Documentation and drafting ─────────────────────────────────────
    reflection: [I asked for a list of alternatives to address the
      problem stated at the beginning of the paper.],
    // review: [...],
    // research: [...],
    // references: [...],
    // summary: [...],
    // translation: [...],

    // ── Develop specific content ────────────────────────────────────────
    assistance-coding: [I asked for explanations about a Python code
      snippet and for help correcting an error.],
    // generating-content: [...],
    // optimization: [...],
    // data-processing: [...],
    // idea-inspiration: [...],
    // other: [...],
  ),
  usage-reflection: [
    Overall, I found generative AI useful for boilerplate tasks and
    quick explanations, but it required careful verification of all
    generated content. It did not replace critical thinking or
    domain-specific knowledge.
  ],
),
```

=== Option B: Provide custom content

If you need full control, pass any `content` directly:

```typ
genai-declaration: [
  // Your custom AI declaration content here.
],
```

== Bibliography

Pass the result of Typst's built-in `bibliography()` call:

```typ
// config/bibliography.typ
#let bibliography-file = "../references.bib"
#let bibliography-style = "ieee"
#let bibliography = bibliography(bibliography-file, style: bibliography-style)
```

```typ
// report.typ
#import "config/bibliography.typ": bibliography

#show: conf.with(
  // ...
  bibliography-content: bibliography,
)
```

#line(length: 100%, stroke: 0.5pt)

= Styles
<sec:styles>

The template offers three visual styles, controlled by the `style` parameter.

== `"fancy"` (default)

An opinionated style inspired by the original #link("https://github.com/ldcas-uc3m/thesis-template")[LaTeX template], with:
- Decorative chapter title pages with a horizontal rule and chapter number/name centered
- Serif headers showing the current chapter name and page number
- IEEE-style figure captions and table captions
- *Libertinus Serif* body font

// Insert a screenshot of the fancy style here
#images_example("fancy")

== `"clean"`

A clean, minimal style inspired by #link("https://github.com/roland-KA/clean-dhbw-typst-template")[clean-dhbw], with:
- Large chapter number in the background on chapter pages
- Simple running header showing the chapter name
- Clean-style figure and table captions
- *Libertinus Serif* body font

// Insert a screenshot of the clean style here
#images_example("clean")

== `"strict"`

Strictly follows the #link("https://uc3m.libguides.com/en/TFG/writing")[UC3M library guidelines]:
- Times New Roman font, 12pt
- Centered uppercase chapter headings
- Page numbers in the footer (Roman numerals in front matter, Arabic in body)
- No decorative elements
- Double-sided layout is *not* permitted with this style

// Insert a screenshot of the strict style here
#images_example("strict")

> [!NOTE]
> You can mix styles for the title page and body independently using `titlepage-style`. For example, to use a `fancy` title page with a `strict` body: `style: "strict", titlepage-style: "fancy"`.

#line(length: 100%, stroke: 0.5pt)

== All parameters (API Reference)

#[
  #set heading(numbering: none)
  #for file in ("lib", "generative-ai"){ //,, "titlepage") {
    let docs = tidy.parse-module(read("../" + file + ".typ"), name: file, old-syntax: true)
    tidy.show-module(docs)
  }
]