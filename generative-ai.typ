
#import "locale.typ" as locale
#import "utils.typ": newpage
#import "arguments.typ": validate-argument



// Set the declaration of use of AI in the project

/// Prints the declaration of use of AI in the project
///
/// - language (str): The language of the project (e.g. "en", "es").
/// - usage (bool): Whether AI is used in the project.
/// - ai_data_usage (dictionary): AI data usage declaration. // todo add more info here
/// todo: refactor this to 3 dicts
/// - sensible_data_usage (str): sensible data usage (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - copyright_data_usage (str): copyright data usage (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - personal_data_usage (str): personal data usage (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - followed_terms (str): followed terms (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - followed_terms (bool, str): Whether the followed terms are accepted
/// - technical_usage_documentation (array): array of the dictionary format: tool (str), for (array) str, example (str).

#let genai(
  language,
  usage,
  ai_data_usage,
  // technical_usage_documentation,
  // technical_usage_review,
  // technical_usage_information_search,
  // technical_usage_references,
  // technical_usage_summary_references,
  // technical_usage_translation,
  // technical_usage_assistance_coding,
  // technical_usage_generating_schemas,
  // technical_usage_optimization,
  // technical_usage_data_processing,
  // technical_usage_idea_inspiration,
  // technical_usage_other_generations,
  // usage_reflection,
) = {
  validate-argument(
    "language",
    language,
    possible-values: ("es", "en"),
  )

  validate-argument("usage", usage, target-type: bool)


  [= #locale.AI_USAGE_TITLE.at(language)]

  strong[#locale.AFFIRMATION_AI_USAGE.at(language)]

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
        "sensible_data_usage": 2,
        "copyright_data_usage": 4,
        "personal_data_usage": 6,
      )

      // Check data usage fields
      for (field, row) in data_type_rows.pairs() {
        let value = ai_data_usage.at(field)
        let target_column = value_to_column.at(value)
        if (x, y) == (target_column, row) {
          return gray
        }
      }

      // Check followed_terms field (row 8)
      if y == 8 {
        if (x == 0 and ai_data_usage.at("followed_terms")) {
          return gray
        }
        if (x == 2 and not ai_data_usage.at("followed_terms")) {
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
          + In my interaction with Generative AI tools, I have submitted
            #strong[sensitive data] with the consent of the data subjects.

        ],
        [#quote(block: true)[
            YES, I have used this data with permission
          ]

        ],
        table.cell(colspan: 2)[#quote(block: true)[
            NO, I have used this data without authorisation
          ]

        ],
        [#quote(block: true)[
            NO, I have not used sensitive data
          ]

        ],
        table.cell(
          colspan: 4,
        )[#block[
            #set enum(numbering: "1.", start: 2)
            + In my interaction with Generative AI tools, I have submitted
              #strong[copyrighted materials] with the permission of those
              concerned.
          ]

        ],
        [#quote(block: true)[
            YES, I have used these materials with permission
          ]

        ],
        table.cell(colspan: 2)[#quote(block: true)[
            NO, I have used these materials without permission
          ]

        ],
        [#quote(block: true)[
            NO, I have not used protected materials
          ]

        ],
        table.cell(
          colspan: 4,
        )[#block[
            #set enum(numbering: "1.", start: 3)
            + In my interaction with Generative AI tools, I have submitted
              #strong[personal data] with the consent of the data subjects.
          ]

        ],
        [#quote(block: true)[
            YES, I have used this data with permission
          ]

        ],
        table.cell(colspan: 2)[#quote(block: true)[
            NO, I have used this data without authorisation
          ]

        ],
        [#quote(block: true)[
            NO, I have not used personal data
          ]

        ],
        table.cell(
          align: left,
          colspan: 4,
        )[#block[
            #set enum(numbering: "1.", start: 4)
            + My use of the Generative AI tool has #strong[respected its terms
                of use];, as well as the essential ethical principles, not being
              maliciously oriented to obtain an inappropriate result for the
              work presented, that is to say, one that produces an impression or
              knowledge contrary to the reality of the results obtained, that
              supplants my own work or that could harm people.
          ]

        ],
        table.cell(align: left, colspan: 2)[#quote(block: true)[
            YES
          ]

        ],
        table.cell(align: left, colspan: 2)[#quote(block: true)[
            NO
          ]

        ],
      )],
      kind: table,
    )

    if ai_data_usage.at("sensible_data_usage").contains("yes") or ai_data_usage.at("copyright_data_usage").contains("yes") or ai_data_usage.at("personal_data_usage").contains("yes") [
      #ai_data_usage.data_usage_explication
    ]



    [== #locale.AI_P2_TITLE.at(language)]

    [== #locale.AI_P3_TITLE.at(language)]
  } else {
    // No se ha utilizado IA
    [#locale.NEGATION_AI_USAGE.at(language)]

    // If there is an extra comment, add it here
  }
}
