// Populated at compile time via --input. Use `make changelog` to compile.
#let raw     = sys.inputs.at("commits", default: "")
#let version = sys.inputs.at("version", default: "?")

#let commits = if raw == "" { () } else {
  raw.split("|").filter(c => c.len() > 0)
}

#let is-breaking(c) = c.match(regex("^(?:feat|fix)[^:]*!:")) != none
#let is-feat(c)     = c.match(regex("^feat[^!]*:"))           != none
#let is-fix(c)      = c.match(regex("^fix[^!]*:"))            != none

#let breaking = commits.filter(is-breaking)
#let features = commits.filter(c => not is-breaking(c) and is-feat(c))
#let fixes    = commits.filter(c => not is-breaking(c) and is-fix(c))

#let clean(msg) = {
  let m = msg.match(regex("^(?:feat|fix|refactor|chore)(?:\\([^)]+\\))?!?:\\s*(.+)$"))
  if m != none { m.captures.at(0) } else { msg }
}

= Changelog

== v#version


#if features.len() > 0 [
  === New Features
  #list(..features.map(c => [#clean(c)]))
]

#if fixes.len() > 0 [
  === Bug Fixes
  #list(..fixes.map(c => [#clean(c)]))
]

#if breaking.len() > 0 [
  === Other Changes
  #list(..breaking.map(c => [#clean(c)]))
]

#if commits.len() == 0 [
  #text(fill: luma(150))[_Run `make changelog` to populate._]
]
