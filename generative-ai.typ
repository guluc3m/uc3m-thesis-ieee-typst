
#import "locale.typ" as locale
#import "utils.typ": newpage
#import "arguments.typ": validate-argument



// Set the declaration of use of AI in the project

/// Prints the declaration of use of AI in the project
///
/// - language (str): The language of the project (e.g. "en", "es").
/// - usage (bool): Whether AI is used in the project.
/// - data-usage (dictionary): AI data usage declaration. // todo add more info here
/// todo: refactor this to 3 dicts
/// - sensible (str): sensible data usage (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - copyright (str): copyright data usage (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - personal (str): personal data usage (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - followed-terms (str): followed terms (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - followed-terms (bool, str): Whether the followed terms are accepted
/// - technical_usage_documentation (array): array of the dictionary format: tool (str), for (array) str, example (str).

#let genai(
  language,
  genai-usage,
) = {
  [= #locale.AI_USAGE_TITLE.at(language)]

  strong[#locale.AFFIRMATION_AI_USAGE.at(language)]

  let usage = genai-usage.at("usage")

  let data-usage = genai-usage.at("data-usage")
  let technical-usage = genai-usage.at("technical-usage")
  let usage-reflection = genai-usage.at("usage-reflection")


  let usage = genai-usage.at("usage")

  let data-usage = genai-usage.at("data-usage")
  let technical-usage = genai-usage.at("technical-usage")
  let usage-reflection = genai-usage.at("usage-reflection")

  show figure: set block(breakable: true)
  figure(
    align(
      center,
    )[#table(
      fill: (x, y) => if x == 0 and usage { gray } else if x == 1
        and not usage {
        gray
      } else { white },
      columns: (1fr, 1fr),
      align: (auto, auto),
      [#strong[#locale.AFFIRMATION.at(language)];],
      [#strong[#locale.NEGATION.at(language)];],
    )],
    kind: table,
  )

  if usage {
    [== #locale.AI_P1_TITLE.at(language)]

    // Helper function to determine table fill color
    let get_table_fill(x, y) = {
      // Define the mapping of data usage values to column positions
      let value_to_column = (
        "yes_with_auth": 0,
        "no_without_auth": 1,
        "no_not_used": 3,
      )

      // Define the mapping of data types to row positions
      let data_type_rows = (
        "sensible": 2,
        "copyright": 4,
        "personal": 6,
      )

      // Check data usage fields
      for (field, row) in data_type_rows.pairs() {
        let value = data-usage.at(field)
        let target_column = value_to_column.at(value)
        if (x, y) == (target_column, row) {
          return gray
        }
      }

      // Check followed-terms field (row 8)
      if y == 8 {
        if (x == 0 and data-usage.at("followed-terms")) {
          return gray
        }
        if (x == 2 and not data-usage.at("followed-terms")) {
          return gray
        }
      }

      return white
    }

    set table(fill: get_table_fill)

    figure(
      align(
        center,
      )[#table(
        columns: (33.33%, 16.5%, 14.33%, 35.83%),
        align: (auto, auto, auto, auto),
        table.cell(colspan: 4)[#strong[Question];],
        table.cell(
          colspan: 4,
        )[
          + #locale.AI_REFLECTION.at("q1").at(language)

        ],
        [#quote(block: true)[
            #locale.AI_REFLECTION.at("a1-1").at(language)
          ]

        ],
        table.cell(colspan: 2)[#quote(block: true)[
            #locale.AI_REFLECTION.at("a1-2").at(language)
          ]

        ],
        [#quote(block: true)[
            #locale.AI_REFLECTION.at("a1-3").at(language)
          ]

        ],
        table.cell(
          colspan: 4,
        )[#block[
            #set enum(numbering: "1.", start: 2)
            + #locale.AI_REFLECTION.at("q2").at(language)
          ]

        ],
        [#quote(block: true)[
            #locale.AI_REFLECTION.at("a2-1").at(language)
          ]

        ],
        table.cell(colspan: 2)[#quote(block: true)[
            #locale.AI_REFLECTION.at("a2-2").at(language)
          ]

        ],
        [#quote(block: true)[
            #locale.AI_REFLECTION.at("a2-3").at(language)
          ]

        ],
        table.cell(
          colspan: 4,
        )[#block[
            #set enum(numbering: "1.", start: 3)
            + #locale.AI_REFLECTION.at("q3").at(language)
          ]

        ],
        [#quote(block: true)[
            #locale.AI_REFLECTION.at("a3-1").at(language)
          ]

        ],
        table.cell(colspan: 2)[#quote(block: true)[
            #locale.AI_REFLECTION.at("a3-2").at(language)
          ]

        ],
        [#quote(block: true)[
            #locale.AI_REFLECTION.at("a3-3").at(language)
          ]

        ],
        table.cell(
          align: left,
          colspan: 4,
        )[#block[
            #set enum(numbering: "1.", start: 4)
            + #locale.AI_REFLECTION.at("q4").at(language)
          ]

        ],
        table.cell(align: left, colspan: 2)[#quote(block: true)[
            #locale.AFFIRMATION.at(language)
          ]

        ],
        table.cell(align: left, colspan: 2)[#quote(block: true)[
            #locale.NEGATION.at(language)
          ]

        ],
      )],
      kind: table,
    )

    if (
      data-usage.at("sensible").contains("yes")
        or data-usage.at("copyright").contains("yes")
        or data-usage.at("personal").contains("yes")
    ) [
      #data-usage.data-usage-explication
    ]


    [== #locale.AI_P2_TITLE.at(language)]


    for (key_interaction, interactions) in technical-usage {
      set enum(numbering: "1.", start: 1)
      [=== #locale.AI_INTERACTION.at(key_interaction).at(language)]
      [#interactions]
    }


    [== #locale.AI_P3_TITLE.at(language)]

    usage-reflection
  } else {
    // No se ha utilizado IA
    [#locale.NEGATION_AI_USAGE.at(language)]

    // If there is an extra comment, add it here
  }
}
