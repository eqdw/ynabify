$:.push File.expand_path("../lib", __FILE__)
require "ynabify/version"

Gem::Specification.new do |s|
  s.name          = "ynabify"
  s.version       = Ynabify::VERSION
  s.authors       = [ "Tim Herd"    ]
  s.email         = [ "rz@eqdw.net" ]
  s.homepage      = "http://github.com/eqdw/ynabify"
  s.summary       = "YNABify Gem"
  s.description   = "A tool to help process CSV bank transaction records into a format that YNAB recognizes"
  s.license       = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = ["ynabify"]
  
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"

  s.add_runtime_dependency     "dm-core"
  s.add_runtime_dependency     "sqlite3"
  s.add_runtime_dependency     "dm-sqlite-adapter"
end
