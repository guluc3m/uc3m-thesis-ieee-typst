# UC3M IEEE Thesis Template

A [Typst](https://typst.app/) template for bachelor/master theses at [Universidad Carlos III de Madrid](https://uc3m.es), following [university guidelines](https://uc3m.libguides.com/en/TFG/writing)[^1].

The template is based on [ldcas-uc3m/thesis-template](https://github.com/ldcas-uc3m/thesis-template) and [clean-uc3m](https://github.com/JorgeyGari/clean-uc3m-typst-template) (a fork of [clean-dhbw](https://github.com/roland-KA/clean-dhbw-typst-template)).

[^1]: We consider some of the guidelines to be... plain ol' ugly, so we took some liberties in the formatting of headings, headers, footers, captions, colors, etc. If you still want to strictly adhere to the guidelines, set `style` to `"strict"`.


## Features

- **Three visual styles**: `fancy` (default), `clean`, and `strict` (university-compliant)
- **Bilingual**: Spanish (`es`) and English (`en`)
- **Automatic front matter**: title page, abstract, acknowledgements, table of contents, list of figures/tables/listings, and abbreviations
- **Back matter**: bibliography, glossary, appendixes, and the mandatory generative AI declaration
- **IEEE-style citations and figure/table captions** (or clean-style captions)
- **Glossary and acronym support** via [`glossarium`](https://typst.app/universe/package/glossarium/)
- **Chapter-level numbering** for figures, tables, and equations
- **Double-sided layout** support
- **PDF/A** compatible output



## Usage

### Installation

#### Via Typst Universe (recommended)

You can initialize a new project from the template with:

```shell
typst init @preview/uc3m-thesis-ieee my-final-thesis
```

This creates a `my-final-thesis/` directory with all the files needed to get started.

#### Manual installation

> [!TIP]
> One-liner for lazy people:
> - Linux:
>    ```bash
>    git clone https://github.com/guluc3m/uc3m-thesis-ieee-typst.git --depth=1 && mv uc3m-thesis-ieee-typst/template/* . && rm -rf uc3m-thesis-ieee-typst/.git* uc3m-thesis-ieee-typst/template && sed -i 's%"/lib.typ"%"uc3m-thesis-ieee-typst/lib.typ"%' report.typ
>    ```
> - MacOS:
>    ```bash
>    git clone https://github.com/guluc3m/uc3m-thesis-ieee-typst.git --depth=1 && mv uc3m-thesis-ieee-typst/template/* . && rm -rf uc3m-thesis-ieee-typst/.git* uc3m-thesis-ieee-typst/template && sed -i '' 's%"/lib.typ"%"uc3m-thesis-ieee-typst/lib.typ"%' report.typ
>    ```

1. Make a folder for your report.
2. Clone or download this repository as a subfolder.
3. Move the files inside `template/` to your project folder.
4. Change the following line in `report.typ`:
   ```diff
   @@ -1,4 +1,4 @@
   -#import "/lib.typ": conf
   +#import "uc3m-thesis-ieee-typst/lib.typ": conf
   ```
5. [Optional, but recommended] Delete the `.git/`, `template/` folders and `typst.toml`, `.gitignore` files.

The resulting structure should be:

```
my-thesis/
├─ report.typ
├─ references.bib
├─ config/
│  ├─ bibliography.typ
│  ├─ gen-ai.typ
│  └─ glossary.typ
├─ parts/
│  ├─ introduction.typ
│  └─ ...
├─ img/
   └─ ...
└─ uc3m-thesis-ieee-typst/   ← only for manual install
   ├─ img/
   ├─ lib.typ
   └─ ...
```

### Compilation

Install [Typst](https://github.com/typst/typst?tab=readme-ov-file#installation) and run:
```bash
typst compile report.typ
```

To comply with the recommended PDF/A ISO standard:

```bash
typst compile report.typ --pdf-standard=a-4
```

> [!TIP]
> For [VS Code](https://code.visualstudio.com/) users, it is recommended to use the [Tinymist Typst](https://marketplace.visualstudio.com/items/?itemName=myriad-dreamin.tinymist) extension, which works without needing to install the compiler and provides live preview, autocompletion, and formatting.

> [!TIP]
> For [Neovim](https://neovim.io/) users, it is recommended to use the [typst-preview.nvim](https://github.com/chomosuke/typst-preview.nvim) plugin.



## Configuration

The template exports a single `conf` function, which you apply to your document with `#show: conf.with(...)`.

### Minimal example

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

### All parameters

The following table lists every parameter accepted by `conf`. Required parameters are marked with *.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title`* | `str` | - | Title of the thesis. |
| `author`* | `str` | - | Author's full name. |
| `degree`* | `str` | - | Degree name (e.g. `"Computer Science and Engineering"`). |
| `advisors`* | `array` of `str` | - | List of advisor names (at least one). |
| `location`* | `str` | - | Presentation location (e.g. `"Leganés, Madrid"`). |
| `thesis-type`* | `str` | - | `"TFG"` (Bachelor) or `"TFM"` (Master). |
| `date`* | `datetime` | - | Presentation date. |
| `abstract`* | `dictionary` | - | Abstract content and keywords. See [Abstract](#abstract). |
| `language`* | `str` | - | `"en"` or `"es"`. |
| `genai-declaration`* | `dictionary` or `content` | - | Generative AI usage declaration. See [Generative AI Declaration](#generative-ai-declaration). |
| `bibliography-content` | `content` | `none` | Bibliography contents, typically the result of calling `bibliography(...)`. |
| `style` | `str` | `"fancy"` | Visual style: `"fancy"`, `"clean"`, or `"strict"`. See [Styles](#styles). |
| `titlepage-style` | `str` or `auto` | `auto` | Style for the title page. If `auto`, uses the main `style`. |
| `table-style` | `str` or `auto` | `auto` | Caption style for tables: `"ieee"` or `"clean"`. If `auto`, uses `"clean"` for the style and `"ieee"` for the others. |
| `figure-style` | `str` or `auto` | `auto` | Caption style for figures: `"ieee"` or `"clean"`. Defaults the same as `table-style`. |
| `figure-spacing` | `length` or `none` | `0.75em` | Extra vertical spacing around figures and tables. Set to `none` to disable. |
| `double-sided` | `bool` | `false` | Whether to use double-sided page layout. Not allowed with `"strict"` style. |
| `logo` | `str` | `"new"` | UC3M logo variant: `"new"` (horizontal color logo) or `"old"` (shield logo). |
| `short-title` | `str` or `content` | `none` | Shorter version of the title for the page header. Only applies when `double-sided` is `true`. |
| `date-format` | `str` or `auto` | `auto` | Date format using [Typst's format syntax](https://typst.app/docs/reference/foundations/datetime/#format). Defaults to the locale's format. |
| `license` | `bool` | `true` | Whether to include the CC BY-NC-ND 4.0 license notice on the title page. |
| `flyleaf` | `bool` | `true` | Whether to include a blank page after the cover. |
| `epigraph` | `dictionary` or `none` | `none` | An opening quote. See [Epigraph](#epigraph). |
| `english-abstract` | `dictionary` or `none` | `none` | English translation of the abstract. Required for Spanish works, invalid for English ones. |
| `acknowledgements` | `content` or `none` | `none` | Acknowledgements text. |
| `outlines` | `dictionary` or `none` | `none` | Extra outlines to include (figures, tables, listings, custom). See [Outlines](#outlines). |
| `abbreviations` | `dictionary` of `str`, `content`, or `none` | `none` | Abbreviations and acronyms list. See [Abbreviations](#abbreviations). |
| `appendixes` | `content` or `none` | `none` | Appendix content. A generative AI declaration appendix is always appended automatically. |
| `glossary` | `array`, `content`, or `none` | `none` | Glossary entries for `glossarium`, or custom `content`. See [Glossary](#glossary). |


---

### Abstract

The `abstract` parameter takes a dictionary with the following keys:

| Key | Type | Description |
|-----|------|-------------|
| `body`* | `content` | The abstract text. |
| `keywords`* | `array` of `str` | Between 2 and 5 keywords. See [IEEE Taxonomy](https://www.ieee.org/content/dam/ieee-org/ieee/web/org/pubs/ieee-taxonomy.pdf). |

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

---

### Epigraph

An optional opening quote placed before the abstract. Provide a dictionary with:

| Key | Type | Description |
|-----|------|-------------|
| `quote`* | `content` | The quote text. |
| `author`* | `str` | The author of the quote. |
| `source` | `str` | (Optional) The source where the quote was found. |

```typ
epigraph: (
  quote: [The purpose of abstracting is not to be vague, but to create a new semantic level in which one can be absolutely precise.],
  author: "Edsger W. Dijkstra",
  source: "The Humble Programmer, 1972",
),
```

---

### Outlines

The `outlines` parameter accepts an optional dictionary with the following boolean keys. All keys are optional (default `false`):

| Key | Type | Description |
|-----|------|-------------|
| `figures` | `bool` | Include a list of figures. |
| `tables` | `bool` | Include a list of tables. |
| `listings` | `bool` | Include a list of code listings. |
| `custom` | `array` of `content` | Additional custom outlines (e.g. algorithms). |

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

---

### Abbreviations

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

---

### Glossary

The template integrates with [`glossarium`](https://typst.app/universe/package/glossarium/) for automatic glossary and acronym management.

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

---

### Generative AI Declaration

The `genai-declaration` parameter is **required** by the university. You can either:

#### Option A: Use the built-in template (recommended)

**If you did not use generative AI** (`usage: false`):

```typ
genai-declaration: (usage: false),
```

**If you did use generative AI** (`usage: true`), provide the full declaration:

Pass a dictionary with the following keys:

| Key | Type | Required | Description |
|-----|------|----------|-------------|
| `usage`* | `bool` | Always | Whether you used generative AI in the thesis. |
| `data-usage` | `dictionary` | If `usage` is `true` | Data usage declaration. See below. |
| `technical-usage` | `dictionary` | If `usage` is `true` | Technical usage declaration. See below. |
| `usage-reflection` | `content` | If `usage` is `true` | Personal reflection on AI usage. |

**`data-usage` keys** — all are `bool` (`true` = YES, `false` = NO):

| Key | Description |
|-----|-------------|
| `confidential` | Did you submit confidential data (trade secrets, proprietary info)? |
| `copyright` | Did you submit copyrighted materials? |
| `personal` | Did you submit personal data? |
| `tos` | Did your usage respect the tool's terms of use? |

**`technical-usage` keys** — include only those that apply, with a brief description of the prompt and interaction. Items are automatically grouped into two sections matching the official form:

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

#### Option B: Provide custom content

If you need full control, pass any `content` directly:

```typ
genai-declaration: [
  // Your custom AI declaration content here.
],
```

---

### Bibliography

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

---

## Styles

The template offers three visual styles, controlled by the `style` parameter.

### `"fancy"` (default)

An opinionated style inspired by the original [LaTeX template](https://github.com/ldcas-uc3m/thesis-template), with:
- Decorative chapter title pages with a horizontal rule and chapter number/name centered
- Serif headers showing the current chapter name and page number
- IEEE-style figure captions and table captions
- **Libertinus Serif** body font

### `"clean"`

A clean, minimal style inspired by [clean-dhbw](https://github.com/roland-KA/clean-dhbw-typst-template), with:
- Large chapter number in the background on chapter pages
- Simple running header showing the chapter name
- Clean-style figure and table captions
- **Libertinus Serif** body font

### `"strict"`

Strictly follows the [UC3M library guidelines](https://uc3m.libguides.com/en/TFG/writing):
- Times New Roman font, 12pt
- Centered uppercase chapter headings
- Page numbers in the footer (Roman numerals in front matter, Arabic in body)
- No decorative elements
- Double-sided layout is **not** permitted with this style

> [!NOTE]
> You can mix styles for the title page and body independently using `titlepage-style`. For example, to use a `fancy` title page with a `strict` body: `style: "strict", titlepage-style: "fancy"`.

---

## Packages Used

This template depends on the following Typst packages (automatically resolved via Typst Universe):

| Package | Purpose |
|---------|---------|
| [`hydra`](https://typst.app/universe/package/hydra/) | Displays the current chapter heading in the page header. |
| [`glossarium`](https://typst.app/universe/package/glossarium/) | Glossary and acronym support. |


---

## More information

### Typst resources
- [Typst documentation](https://typst.app/docs)
  - [Guide for LaTeX users](https://typst.app/docs/guides/guide-for-latex-users/)
- [Typst forum](https://forum.typst.app/)
- [tex2typst](https://qwinsi.github.io/tex2typst-webapp) - converts LaTeX math formulas to/from Typst
  - [LaTeX-to-Typst Cheat Sheet](https://qwinsi.github.io/tex2typst-webapp/cheat-sheet.html)
- [Typst table generator](https://www.latex-tables.com/?format=typst&force)
- [Typst Examples Book](https://sitandr.github.io/typst-examples-book/book/)
- [Typerino](https://typerino.com/) - Online Typst equation editor
- [L. Casais - Memorias de p**** madre: Introducción a Typst](https://github.com/rajayonin/typst-intro)

### Examples

Here are some theses written using this template:
- [J. A. Verde - Procesamiento de señales de encefalograma para la detección de ataques epilépticos](https://github.com/joseaverde/TFG/tree/master/report)
- [L. D. Casais - Implementing Interrupts, Timers, and Memory-Mapped I/O in CREATOR](https://github.com/ldcas-uc3m/TFM)

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on commits, formatting, and pull requests.

If you find a bug or have a feature request, please [open an issue](https://github.com/guluc3m/uc3m-thesis-ieee-typst/issues).
