Referencias:
- [Guía UC3M TFG](https://uc3m.libguides.com/en/TFG/writing)
- [ldcas-uc3m/thesis-template](https://github.com/ldcas-uc3m/thesis-template)
- [clean-dhbw](https://github.com/roland-KA/clean-dhbw-typst-template) (y su fork [clean-uc3m](https://github.com/JorgeyGari/clean-uc3m-typst-template))


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