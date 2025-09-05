#import "@preview/cetz:0.4.1": canvas, draw
#import "@preview/cetz-plot:0.1.2": plot

#let datasets = (
  (
    "Paco",
    (
      data: (
        (1, 973.21),
        (2, 1241.56),
        (4, 1389.44),
        (8, 1512.87),
        (10, 1601.32),
        (14, 1829.05),
      ),
      color: blue,
    ),
  ),
  (
    "Francisco",
    (
      data: (
        (1, 102.34),
        (2, 312.87),
        (4, 421.56),
        (8, 589.43),
        (10, 712.09),
        (14, 923.67),
      ),
      color: green,
    ),
  ),
)

#let y-ticks = (50, 100, 200, 500, 1000, 2000, 5000)

/// Linear regression fit (y = a + b*x)
#let lin-fit(data) = {
  let xs = data.map(d => d.at(0))
  let ys = data.map(d => d.at(1))
  let n = data.len()

  let mean-x = xs.sum() / n
  let mean-y = ys.sum() / n

  let b = (
    (
      range(0, n).map(i => (xs.at(i) - mean-x) * (ys.at(i) - mean-y)).sum()
    )
      / (
        xs.map(x => (x - mean-x) * (x - mean-x)).sum()
      )
  )
  let a = mean-y - b * mean-x

  (a, b, x => a + b * x)
}

#let add-series(name, spec) = {
  // Compute fit from data
  let (a, b, fitfn) = lin-fit(spec.data)

  // Scatter points
  plot.add(
    spec.data,
    style: (stroke: none),
    mark: "o",
    mark-style: (stroke: spec.color, fill: white),
    mark-size: 0.1,
    label: name,
  )

  // Regression line
  plot.add(
    domain: (0, 15),
    fitfn,
    style: (stroke: spec.color, dash: "dashed"),
  )
}

== Graph Example

#figure(
  canvas({
    plot.plot(
      size: (12, 8),
      x-ticks: (1, 2, 4, 8, 10, 14),
      x-tick-step: none,
      y-ticks: y-ticks,
      y-mode: "log",
      x-label: "Horas de sueño",
      y-label: "Felicidad",
      x-grid: "major",
      y-grid: "major",
      y-max: 5000,
      y-min: 20,
      legend: "north-east",
      {
        for (name, spec) in datasets { add-series(name, spec) }
      },
    )

    draw.content(
      (6, 8.75),
      [*Happiness related to sleep hours*],
      anchor: "center",
    )
  }),
  caption: [Happiness related to sleep hours.],
  supplement: [Figure],
)
