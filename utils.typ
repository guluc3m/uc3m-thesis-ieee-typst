#let azuluc3m = rgb("#000e78")

#let make-frontmatter-header(title, size: none) = box(
  stroke: (top: azuluc3m),
  width: 100%,
  height: 2em,
  inset: (top: 0.6em),
  [
    #set align(center)
    #set text(azuluc3m)
    #{
      if size == none { title } else { text(title, size: size) }
    }
  ]
)

#let keywords(title, ..items) = {

  let result = [*#title:* #items.pos().at(0)]
  for item in items.pos().slice(1) {
    result = [#result • #item]
  }

  return [
    #set align(bottom + left)
    #set par(first-line-indent: 0em, justify: false)
    #result
  ]
}
