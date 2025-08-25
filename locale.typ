//! Localization information.


#let AUTHOR = (
  es: "Autor",
  en: "Author",
)

#let ADVISOR = (
  es: "Tutor",
  en: "Advisor",
)

#let ADVISORS = (
  es: "Tutores",
  en: "Advisors",
)

#let CC-LICENSE = (
  es: [
    Esta obra se encuentra sujeta a la licencia #link("https://creativecommons.org/licenses/by-nc-nd/4.0/")[Creative Commons\ *Reconocimiento -- No Comercial -- Sin Derivadas* 4.0
      International]
  ],
  en: [
    This work is licensed under #link("https://creativecommons.org/licenses/by-nc-nd/4.0/")[Creative Commons\ *Attribution -- Non Commercial -- No Derivatives* 4.0
      International]
  ],
)

#let DATE-FMT = (
  es: "[month repr:long] [year]",
  en: "[month repr:long] [year]",
)

#let MONTHS = (
  es: (
    "enero",
    "febrero",
    "marzo",
    "abril",
    "mayo",
    "junio",
    "julio",
    "agosto",
    "septiembre",
    "octubre",
    "noviembre",
    "diciembre",
  ),
)

#let ACKNOWLEDGEMENTS = (
  es: "Agradecimientos",
  en: "Acknowledgements",
)

#let ABSTRACT = (
  es: "Resumen",
  en: "Abstract",
)

#let KEYWORDS = (
  es: "Palabras clave",
  en: "Keywords",
)

#let OUTLINE = (
  "contents": (
    es: "Tabla de contenidos",
    en: "Table of contents",
  ),
  "figures": (
    es: "Índice de figuras",
    en: "List of figures",
  ),
  "tables": (
    es: "Índice de tablas",
    en: "List of tables",
  ),
  "listings": (
    es: "Índice de listados",
    en: "List of listings",
  ),
)

#let THESIS-TYPE = (
  TFG: (
    es: "Trabajo de Fin de Grado",
    en: "Bachelor Thesis",
  ),
  TFM: (
    es: "Trabajo de Fin de Máster",
    en: "Master Thesis",
  ),
)

#let DEGREE-TYPE = (
  TFG: (
    es: "Grado en ",
    en: "Bachelor's Degree in ",
  ),
  TFM: (
    es: "Máster en ",
    en: "Master's Degree in ",
  ),
)

#let CHAPTER = (
  es: "Capítulo",
  en: "Chapter",
)

#let APPENDIX = (
  es: "Apéndice",
  en: "Appendix",
)

#let GLOSSARY = (
  es: "Glosario",
  en: "Glossary",
)

#let ABBREVIATIONS = (
  es: "Listado de abreviaciones",
  en: "List of abbreviations",
)


#let AFFIRMATION = (
  es: "SI",
  en: "YES",
)

#let NEGATION = (
  es: "NO",
  en: "NO",
)

#let AI-USAGE = (
  title: (
    es: "Declaración de uso de IA generativa",
    en: "Declaration of Use of Generative AI",
  ),
  affirmation: (
    es: "He utilizado IA generativa en este trabajo:",
    en: "I have used Generative AI in this work:",
  ),
  negation: (
    es: [El autor de esta tésis *no* ha usado ningún tipo de inteligencia
      artificial generativa durante el desarrollo del proyecto ni durante la
      redacción de este documento.],
    en: [The author of this thesis *has not* used any type of generative
      artificial intelligence during the development of the project or during
      the writing of this document.],
  ),
)


#let QUESTION = (
  es: "Pregunta",
  en: "Question",
)


#let PART = (
  es: "Parte",
  en: "Part",
)

#let AI-DATA-USAGE = (
  title: (
    es: "Reflexión sobre comportamiento ético y responsable",
    en: "Reflection on ethical and responsible behaviour",
  ),
  questions: (
    sensitive: (
      prompt: (
        es: [En mi interacción con herramientas de IA Generativa he remitido
          *datos de carácter sensible* con la debida autorización de los
          interesados.],
        en: [In my interaction with Generative AI tools, I have submitted
          *sensitive data* with the consent of the data subjects.],
      ),
      answers: (
        with-authorization: (
          es: [SÍ, he usado estos datos con autorización],
          en: [YES, I have used this data with permission],
        ),
        without-authorization: (
          es: [NO, he usado estos datos sin autorización],
          en: [NO, I have used this data without authorisation],
        ),
        not-used: (
          es: [NO, no he usado datos de carácter sensible],
          en: [NO, I have not used sensitive data],
        ),
      ),
    ),
    copyright: (
      prompt: (
        es: [
          En mi interacción con herramientas de IA Generativa he remitido
          #strong[materiales protegidos por derechos de autor] con la debida
          autorización de los interesados.
        ],
        en: [In my interaction with Generative AI tools, I have submitted
          #strong[copyrighted materials] with the permission of those
          concerned.],
      ),
      answers: (
        with-authorization: (
          es: [SÍ, he usado estos materiales con autorización],
          en: [YES, I have used these materials with permission.],
        ),
        without-authorization: (
          es: [NO, he usado estos materiales sin autorización],
          en: [NO, I have used these materials without permission.],
        ),
        not-used: (
          es: [NO, no he usado materiales protegidos],
          en: [NO, I have not used protected materials.],
        ),
      ),
    ),
    personal: (
      prompt: (
        es: [En mi interacción con herramientas de IA Generativa he remitido
          #strong[datos de carácter personal] con la debida autorización de los
          interesados.],
        en: [In my interaction with Generative AI tools, I have submitted
          #strong[personal data] with the consent of the data subjects.],
      ),
      answers: (
        with-authorization: (
          es: [SÍ, he usado estos materiales con autorización],
          en: [YES, I have used these materials with permission.],
        ),
        without-authorization: (
          es: [NO, he usado estos materiales sin autorización],
          en: [NO, I have used these materials without permission.],
        ),
        not-used: (
          es: [NO, no he usado datos de carácter personal],
          en: [NO, I have not used personal data.],
        ),
      ),
    ),
  ),
  followed-terms: (
    es: [Mi utilización de la herramienta de IA Generativa ha *respetado sus
        términos de uso*, así como los principios éticos esenciales, no
      orientándola de manera maliciosa a obtener un resultado inapropiado para
      el trabajo presentado, es decir, que produzca una impresión o conocimiento
      contrario a la realidad de los resultados obtenidos, que suplante mi
      propio trabajo o que pueda resultar en un perjuicio para las personas.],
    en: [My use of the Generative AI tool has *respected its terms of use*, as
      well as the essential ethical principles, not being maliciously oriented
      to obtain an result for the work presented, that is to say, one that an
      impression or knowledge contrary to the reality of the obtained, that
      supplants my own work or that could harm people.],
  ),
)

#let AI-TECHNICAL-USAGE = (
  title: (
    es: "Declaración de uso técnico",
    en: "Declaration of technical use",
  ),
  questions: (
    documentation: (
      es: "Documentación y redacción",
      en: "Documentation and drafting",
    ),
    review: (
      es: "Revisión o reescritura de párrafos redactados previamente",
      en: "Revision or rewriting of previously drafted paragraphs",
    ),
    research: (
      es: "Búsqueda de información o respuesta a preguntas concretas",
      en: "Search for information or answers to specific questions",
    ),
    references: (
      es: "Búsqueda de bibliografía",
      en: "Bibliography search",
    ),
    summary: (
      es: "Resumen de bibliografía consultada",
      en: "Summary of bibliography consulted",
    ),
    translation: (
      es: "Traducción de texto consultados ",
      en: "Translation of texts consulted ",
    ),
    assistance-coding: (
      es: "Asistencia en el desarrollo de líneas de código (programación)",
      en: "Assistance in the development of lines of code (programming)",
    ),
    generating-content: (
      es: "Generación de esquemas, imágenes, audios o vídeos",
      en: "Generation of diagrams, images, audios or videos",
    ),
    optimization: (
      es: "Procesos de optimización",
      en: "Optimisation processes",
    ),
    data-processing: (
      es: "Tratamiento de datos: recogida, análisis, cruce de datos…",
      en: "Data processing: collection, analysis, cross-checking of data...",
    ),
    idea-inspiration: (
      es: "Inspiración de ideas en el proceso creativo",
      en: "Inspiration of ideas in the creative process",
    ),
    other: (
      es: "Otros usos vinculados a la generación de puntos concretos del desarrollo específico del trabajo",
      en: "Other uses linked to the generation of specific points of the specific development of the work",
    ),
  ),
)

#let AI-USAGE-REFLECTION = (
  title: (
    es: "Reflexión sobre utilidad",
    en: "Reflection on utility",
  ),
)
