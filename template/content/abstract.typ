#import "@local/ost-template:0.0.1": *

#let abstract(ausgangslage, problem, ziel, methode, ergebnisse, empfehlungen, schluesselwoerter) = {
  v(0.8em)

  grid(
    columns: (auto, 1fr),
    gutter: 1.5em,
    [
      *Ausgangslage*:], [#ausgangslage],
    [
      *Problem*:], [#problem],
    [
      *Ziel*:], [#ziel],
    [
      *Methode / Vorgehen*:], [#methode],
    [
      *Wesentliche Ergebnisse*:], [#ergebnisse],
    [
      *Empfehlungen*:], [#empfehlungen],
    [
      *Schlüsselwörter*:], [#schluesselwoerter],
  )
}


// Example usage:
#abstract(
  [Kurze Beschreibung der Ausgangslage],
  [Beschreibung des Problems],
  [Das Ziel der Arbeit],
  [Methodisches Vorgehen],
  [Die wesentlichen Ergebnisse],
  [Konkrete Empfehlungen],
  [Beispiel, Typst, Abstract],
)
