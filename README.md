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
>    git clone https://github.com/guluc3m/uc3m-thesis-ieee-typst.git --depth=1 && mv uc3m-thesis-ieee-typst/template/* . && rm -rf uc3m-thesis-ieee-typst/.git* uc3m-thesis-ieee-typst/template && sed -i 's%"@preview/uc3m-thesis-ieee:0.4.0"%"uc3m-thesis-ieee-typst/lib.typ"%' report.typ
>    ```
> - MacOS:
>    ```bash
>    git clone https://github.com/guluc3m/uc3m-thesis-ieee-typst.git --depth=1 && mv uc3m-thesis-ieee-typst/template/* . && rm -rf uc3m-thesis-ieee-typst/.git* uc3m-thesis-ieee-typst/template && sed -i '' 's%"@preview/uc3m-thesis-ieee:0.4.0"%"uc3m-thesis-ieee-typst/lib.typ"%' report.typ
>    ```

1. Make a folder for your report.
2. Clone or download this repository as a subfolder.
3. Move the files inside `template/` to your project folder.
4. Change the following line in `report.typ`:
   ```diff
   @@ -1,4 +1,4 @@
   -#import "@preview/uc3m-thesis-ieee:0.4.0": conf
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
