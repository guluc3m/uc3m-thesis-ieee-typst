#import "@preview/lilaq:0.5.0" as lq

#let x = lq.linspace(0, 20)


#grid(
  columns: (1fr, 1fr),
  gutter: 2cm,
  align: center,
  lq.diagram(
    lq.plot(x, x => calc.sin(x + 0.541)),
    width: 7cm,
    height: 4cm,
  ),
  lq.diagram(
    lq.plot(
      (3, 6, 10, 16),
      (5, 3, 4, 2),
      mark: "o",
      color: red,
    ),
  ),
)


#lq.diagram(
  xaxis: (
    ticks: ("Apples", "Bananas", "Kiwis", "Mangos", "Papayas")
      .map(rotate.with(-45deg, reflow: true))
      .map(align.with(right))
      .enumerate(),
    subticks: none,
  ),
  lq.bar(
    range(5),
    (5, 3, 4, 2, 1),
  ),
),

