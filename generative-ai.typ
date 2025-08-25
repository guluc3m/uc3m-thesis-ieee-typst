//! Declaration of use of AI in the project

#import "locale.typ" as locale
#import "utils.typ": newpage
#import "arguments.typ": validate-argument


/// Prints the declaration of use of AI in the project.
///
/// - language (str): The language of the project (e.g. "en", "es").
/// - usage (bool): Whether AI is used in the project.
/// - data-usage (dictionary): AI data usage declaration.
/// - technical-usage (dictionary): Technical usage of AI.
/// -> content
#let genai(
  language,
  usage,
  data-usage,
  technical-usage,
  usage-reflection,
) = {
  /* SETUP */
  // for headings of level 2, show "Part N"
  set heading(
    numbering: (..n) => {
      if n.pos().len() == 1 { numbering("A.1", ..n) } else {
        numbering("1.", ..n.pos().slice(1)) // remove the first one
      }
    },
    supplement: [#locale.PART.at(language)], // this doesn't work for some reason...
    outlined: false, // not in outline
  )

  // this also doesn't work
  show heading.where(level: 1): set heading(
    supplement: [#locale.APPENDIX.at(language)],
  )


  [= #locale.AI-USAGE.title.at(language)]


  /* USAGE */

  strong[#locale.AI-USAGE.affirmation.at(language)]

  table(
    fill: (x, y) => if x == 0 and usage { gray } else if x == 1 and not usage {
      gray
    } else { white },
    columns: 2,
    align: (auto, auto),
    [#strong[#locale.AFFIRMATION.at(language)];],
    [#strong[#locale.NEGATION.at(language)];],
  )


  if not usage {
    // No se ha utilizado IA
    return [#locale.AI-USAGE.negation.at(language)]
  }


  /* DATA USAGE */

  [== #locale.AI-DATA-USAGE.title.at(language)]

  table(
    columns: (2fr, 1fr, 1fr, 2fr),
    align: center,
    inset: 0.8em,
    table.cell(colspan: 4)[#strong[Question];],
    ..for (index, (question-key, question-data)) in locale
      .AI-DATA-USAGE
      .questions
      .pairs()
      .enumerate() {
      // we use spreading, creating an array within the loop
      // see https://forum.typst.app/t/how-come-this-does-not-generate-a-grid-as-expected/1660/2
      (
        // prompt spanning all columns
        table.cell(colspan: 4)[
          #set enum(start: index + 1) // correctly set enum number
          + #question-data.prompt.at(language)
        ],
        // Answer layout: Answer1 (2fr), Answer2 (1fr+1fr with colspan), Answer3 (2fr)
        ..for (i, (answer-key, answer-text)) in question-data
          .answers
          .pairs()
          .enumerate() {
          (
            table.cell(
              colspan: if i == 1 { 2 } else { 1 }, // middle answer spans 2 columns
              fill: if data-usage.at(question-key) == answer-key { gray },
            )[#set par(justify: false)
              #answer-text.at(language)],
          )
        },
      )
    },

    // terms of use
    table.cell(
      colspan: 4,
    )[
      #set enum(start: locale.AI-DATA-USAGE.questions.len() + 1)
      + #locale.AI-DATA-USAGE.followed-terms.at(language)
    ],

    table.cell(
      colspan: 2,
      fill: if data-usage.followed-terms { gray },
      inset: 5pt,
    )[
      #locale.AFFIRMATION.at(language)
    ],
    table.cell(
      colspan: 2,
      fill: if not data-usage.followed-terms { gray },
      inset: 5pt,
    )[
      #locale.NEGATION.at(language)
    ],
  )

  if (
    data-usage.at("sensitive") == "without-authorization"
      or data-usage.at("copyright") == "without-authorization"
      or data-usage.at("personal") == "without-authorization"
  ) {
    assert(
      data-usage.at("explanation", default: none) != none,
      message: "Missing key 'explanation' in 'genai-declaration'. If any of the data usage was done without authorization, you must provide an explanation.",
    )
    data-usage.explanation
  }


  /* TECHNICAL USAGE */

  [== #locale.AI-TECHNICAL-USAGE.title.at(language)]

  show heading.where(level: 3): set heading(numbering: none) // remove numbering

  for (key_interaction, interactions) in technical-usage {
    assert(
      locale.AI-TECHNICAL-USAGE.questions.keys().contains(key_interaction),
      message: "Unknown technical-usage '" + key_interaction + "'",
    )

    [=== #locale.AI-TECHNICAL-USAGE.questions.at(key_interaction).at(language)
      #interactions]
  }


  /* REFLECTION */

  [== #locale.AI-USAGE-REFLECTION.title.at(language)]

  usage-reflection
}
