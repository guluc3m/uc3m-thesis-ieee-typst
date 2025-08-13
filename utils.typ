//! Auxiliar functions and definitions.

#import "arguments.typ": format-value


#let azuluc3m = rgb("#000e78")


/// Prints a flyleaf, an empty (double sided) page.
///
/// -> content
#let flyleaf() = {
  set page(header: none, footer: none)
  pagebreak()
  pagebreak()
}
