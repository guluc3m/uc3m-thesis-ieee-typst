= Changelog

== v0.4.0

=== Breaking Changes

- *`report.typ` rename*: The template entrypoint was renamed from `main.typ` to `report.typ`.
- *Multiple outlines*: The `outlines` parameter now accepts a dictionary instead of a list.
- *Figure and table style*: New `figure-style` and `table-style` parameters control caption style; it is no longer hardcoded.
- *Figure spacing*: New `figure-spacing` parameter controls vertical spacing around figures and tables (default `0.75em`). Previously there was no spacing.
- *Bibliography accent color*: The bibliography now uses the document accent color.
- *Degree customization*: `degree` now accepts a dictionary for more control (e.g. separate label and name).
- *Removed German support*: `"de"` is no longer a valid `language` value.

=== New Features

- Generative AI usage declaration via the `genai-declaration` parameter.
- Equation numbering support.
- Abbreviations list is now sorted alphabetically.
- Cross-references to chapters now use the `"Chapter"` supplement.
- Document metadata can be configured via the `metadata` parameter.
- Floating figures and tables are prevented from spilling into the next section.
- Indented lists are supported in the template body.
- Graph examples now use #link("https://typst.app/universe/package/lilaq")[lilaq].

=== Bug Fixes

- The `date` parameter is now used instead of the automatic compilation date.
- First paragraphs in frontmatter sections no longer have a leading indent.
- The abbreviations list no longer appears in the table of contents.
- A missing page break before the abbreviations list was added.
- Appendix cross-reference supplements are now correct.
- IEEE-style figures now render correctly.
- Spanish month names are now lowercase, per RAE.
- Spacing around figures with `placement: auto` is now correct.
- Headers and footers on the last pages of body and endmatter sections are correct.
- Appendix numbering is correct.
- `genai-declaration` validation errors are more informative; raw `content` is also accepted.
- `tutor` was renamed to `advisor` consistently throughout.
- English author label order on the title page is correct.
- Argument types can now be specified as an array of accepted types.
