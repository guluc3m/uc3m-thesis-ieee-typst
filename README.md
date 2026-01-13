# UC3M IEEE thesis template
This is a [Typst](https://typst.app/) template for bachelor/master thesis on [Universidad Carlos III de Madrid](https://uc3m.es), following [university guidelines](https://uc3m.libguides.com/en/TFG/writing)[^1].

The template is based on [ldcas-uc3m/thesis-template](https://github.com/ldcas-uc3m/thesis-template) and [clean-uc3m](https://github.com/JorgeyGari/clean-uc3m-typst-template) (a fork of [clean-dhbw](https://github.com/roland-KA/clean-dhbw-typst-template)).


[^1]: We consider some of the guidelines to be... plain ol' ugly, so we took some liberties in the formatting of headings, headers, footers, captions, colors... If you still want to strictly adhere to the guidelines, set `style` to `"strict"`.



## Usage

### Installation

> [!NOTE]
> This is still in beta. The following is a quick and dirty way of setting up your thesis.
> 
> We plan on publishing this to the official repository ([Typst Universe](https://typst.app/universe/)) eventually, to have a cleaner setup process.

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
2. Clone or download this folder, as a subfolder.
3. Move the files inside `template/` to your project folder.
4. Change the following line in `report.typ`:
   ```diff
   @@ -1,4 +1,4 @@
   -#import "/lib.typ": conf
   +#import "uc3m-thesis-ieee-typst/lib.typ": conf
   ```
5. [Optional, but recommended] Delete the `.git/`, `template/` folders and `typst.toml`, `.gitignore` files.

The resulting structure should be as follows:
```
my-thesis/
├─ report.typ
├─ references.bib
├─ parts/
│  ├─ ...
├─ ...
├─ uc3m-thesis-ieee-typst/
│  ├─ img/
|  │  ├─ ...
│  ├─ lib.typ
│  ├─ ...
```

### Compilation
Install [Typst](https://github.com/typst/typst?tab=readme-ov-file#installation) and run:
```
typst compile report.typ
```

> [!TIP]
> For [VS Code](https://code.visualstudio.com/) users, it is recommended to use the [Tinymist Typst](https://marketplace.visualstudio.com/items/?itemName=myriad-dreamin.tinymist) extension, which works without needing to install the compiler.

> [!TIP]
> For [Neovim](https://neovim.io/) users, it is recommended to use the [typst-preview.nvim](https://github.com/chomosuke/typst-preview.nvim) plugin.



## More information

### Typst resources
- [Typst documentation](https://typst.app/docs)
  - [Guide for LaTeX users](https://typst.app/docs/guides/guide-for-latex-users/)
- [Typst forum](https://forum.typst.app/)
- [tex2typst](https://qwinsi.github.io/tex2typst-webapp), converts LaTeX math formulas from/to Typst
  - [LaTeX-to-typst Cheat Sheet](https://qwinsi.github.io/tex2typst-webapp/cheat-sheet.html)
- [Typst table generator](https://www.latex-tables.com/?format=typst&force)
- [Typst Examples Book](https://sitandr.github.io/typst-examples-book/book/)
- [Typerino](https://typerino.com/): Online typst equation editor
