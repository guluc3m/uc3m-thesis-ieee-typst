//! Auxiliar functions and definitions.

#import "arguments.typ": format-value


#let azuluc3m = rgb("#000e78")


/// Prints a flyleaf, an empty (double sided) page.
///
/// -> content
#let make-flyleaf() = {
  set page(header: none, footer: none)
  pagebreak()
  pagebreak()
}

/// Checks whether the current page is a chapter start page.
///
/// -> bool
#let is-chapter-start() = {
  // https://forum.typst.app/t/how-to-determine-if-the-current-page-has-a-heading-of-level-1/4185/2
  query(heading.where(level: 1)).any(it => (
    it.location().page() == here().page()
  ))
}


/// Checks whether the current page is the last page.
///
/// -> bool
#let is-last-page() = {
  counter(page).final().first() == counter(page).get().first()
}
