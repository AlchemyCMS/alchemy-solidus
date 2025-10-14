Alchemy.importmap.pin "alchemy_solidus", to: "alchemy_solidus.js", preload: true
Alchemy.importmap.pin_all_from Alchemy::Solidus::Engine.root.join("app/javascript/alchemy_solidus"),
  under: "alchemy_solidus", preload: true
Alchemy.importmap.pin "spree", to: "spree.js", preload: true
