Referencias:
- [Guía UC3M TFG](https://uc3m.libguides.com/en/TFG/writing)
- [ldcas-uc3m/thesis-template](https://github.com/ldcas-uc3m/thesis-template)
- [clean-dhbw](https://github.com/roland-KA/clean-dhbw-typst-template) (y su fork [clean-uc3m](https://github.com/JorgeyGari/clean-uc3m-typst-template))


## Usage

> [!NOTE]
> This is still in beta. The following is a quick and dirty way of setting up your thesis.
> 
> We plan on publishing this to the official repository ([Typst Universe](https://typst.app/universe/)) eventually, to have a cleaner setup process.

1. Make a folder for your report.
2. Clone or download this folder, as a subfolder.
3. Move the files inside `template/` to your proyect folder.
4. Change the following lines in `main.typ`:
   ```diff
   @@ -1,4 +1,4 @@
   -#import "/lib.typ": conf
   +#import "uc3m-thesis-ieee-typst/lib.typ": conf
   @@ -17,7 +17,7 @@
   -  bibliography-file: "/template/references.bib",
   +  bibliography-file: "references.bib",
   ```
5. [Optional, but recommended] Delete the `.git/`, `template/` folders and `typst.toml`, `.gitignore` files.

The resulting structure should be as follows:
```
my-thesis/
├─ main.typ
├─ references.bib
├─ ...
├─ uc3m-thesis-ieee-typst/
│  ├─ img/
|  │  ├─ creativecommons.png
|  │  ├─ ...
│  ├─ lib.typ
│  ├─ ...
```


## Formatter setup

We use [typstyle](https://typstyle-rs.github.io/typstyle/), with a line width of 80.

To format:
```bash
typstyle -i -l 80 .
```

In VS-Code with [Tynimist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist), add the following configuration to your `settings.json`:
```json
{
  "tinymist.formatterMode": "typstyle",
  "tinymist.formatterPrintWidth": 80,
  "tinymist.formatterProseWrap": true
}