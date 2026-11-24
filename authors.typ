#let affiliations = (
  (
    id: 1,
    text: [Instituto	de	Ciencia	Molecular,	Universitat	de	València,	Calle	Catedrático	José	Beltrán	Martínez	2,	46980,	Paterna,	Spain.],
  ),
  (
    id: 2,
    text: [Departamento de Física Aplicada,	Facultad de Física, Universitat	de	València,	Calle	Catedrático	José	Beltrán	Martínez	2,	46980,	Paterna,	Spain.],
  ),
)

#let authors = (
  (
    name: "Ana Torres-Suay",
    order: 1,
    affiliations: (1,),
    corresponding: false,
    email: "",
    shared: true,
  ),
  (
    name: "Ivona Košić",
    order: 2,
    affiliations: (1,),
    corresponding: false,
    email: "",
    shared: true,
  ),
  (
    name: "Filippo Mione",
    order: 3,
    affiliations: (1,),
    corresponding: false,
    email: "",
  ),
  (
    name: "Khagesh Tanwar",
    order: 4,
    affiliations: (1,),
    corresponding: false,
    email: "",
  ),
  (
    name: "Vicente Muñoz Sanjosé",
    order: 5,
    affiliations: (2,),
    corresponding: false,
    email: "",
  ),
  (
    name: "Andrés Cantarero",
    order: 6,
    affiliations: (1,),
    corresponding: false,
    email: "",
  ),
  (
    name: "Marta Galbiati",
    order: 7,
    affiliations: (1,),
    corresponding: true,
    email: "marta.galbiati@uv.es",
  ),
    (
    name: "Efrén Navarro-Moratalla",
    order: 8,
    affiliations: (1,),
    corresponding: true,
    email: "efren.navarro@uv.es",
  ),
)

#let author-list(authors, affiliations) = {
  let ordered = authors.sorted(key: a => a.order)

  let corresponding-authors = ordered
    .filter(a => a.at("corresponding", default: false))
    .map(a => a.name + " (" + a.email + ")")
    .join("; ")

  // Determine the order in which NEW footnotes
  // will appear, and assign their symbols.
  let sequence = ()
  let registered = ()

  for a in ordered {
    if a.at("corresponding", default: false) and not ("corresponding" in registered) {
      sequence.push("*")
      registered.push("corresponding")
    }

    if a.at("shared", default: false) and not ("shared" in registered) {
      sequence.push("†")
      registered.push("shared")
    }

    for id in a.affiliations {
      let key = "aff-" + str(id)
      if not (key in registered) {
        sequence.push(str(id))
        registered.push(key)
      }
    }
  }

  // Automatic numbering based on actual appearance
  set footnote(
    numbering: n => sequence.at(
      n - 1,
      default: str(n),
    )
  )

  let seen = ()
  let shared-seen = false
  let corresponding-seen = false
  let entries = ()

  for a in ordered {
    let marks = ()

    // Corresponding authors
    if a.at("corresponding", default: false) {
      if corresponding-seen {
        marks.push(footnote(<corresponding-authors>))
      } else {
        marks.push([
          #footnote[
            Correspondence to:
            #corresponding-authors
          ]<corresponding-authors>
        ])
        corresponding-seen = true
      }
    }

    // Equal contributions
    if a.at("shared", default: false) {
      if shared-seen {
        marks.push(footnote(<equal-contribution>))
      } else {
        marks.push([
          #footnote[
            These authors contributed equally
            to this work.
          ]<equal-contribution>
        ])
        shared-seen = true
      }
    }

    // Affiliations
    for id in a.affiliations {
      let aff-label = label("aff-" + str(id))

      if id in seen {
        marks.push(footnote(aff-label))
      } else {
        let aff = affiliations.find(x => x.id == id)

        marks.push([
          #footnote(aff.text)
          #label("aff-" + str(id))
        ])

        seen.push(id)
      }
    }

    entries.push(text(a.name) + marks.join())
  }

  entries.join([, ])
}

