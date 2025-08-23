
#import "locale.typ" as locale
#import "utils.typ": newpage
#import "arguments.typ": validate-argument


// Set the declaration of use of AI in the project

/// Prints the declaration of use of AI in the project
///
/// - language (str): The language of the project (e.g. "en", "es").
/// - usage (bool): Whether AI is used in the project.
/// - sensible_data_usage (str): sensible data usage (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - copyright_data_usage (str): copyright data usage (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - personal_data_usage (str): personal data usage (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - followed_terms (str): followed terms (`yes_with_auth`, `no_without_auth`, `no_not_used`)
/// - followed_terms (bool, str): Whether the followed terms are accepted
/// - technical_usage_documentation (array): array of the dictionary format: tool (str), for (array) str, example (str).

#let genai(
  language,
  usage,
  // sensible_data_usage,
  // copyright_data_usage,
  // personal_data_usage,
  // followed_terms,
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


  if not usage {
    // No se ha utilizado IA
    if language == "es" {
      [= Declaración de uso de IA generativa]

      [*Declaración de uso de IA generativa en el Trabajo de Fin de Grado*]

      [El autor de esta tésis *no* ha usado ningún tipo de inteligencia
        artificial generativa durante el desarrollo del proyecto ni durante la
        redacción de este documento.]
    } else {
      [= Declaration of the use of generative AI]

      [*Declaration of the use of generative AI in the final degree project*]

      [The author of this thesis *has not* used any type of generative
        artificial intelligence during the development of the project or during
        the writing of this document.]
    }
  }
}
