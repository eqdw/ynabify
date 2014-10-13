ynabify
=======

Library to help convert bank-specific csv sheets to YNAB's expected format


----

The ultimate goal of this project is to have a system that does three
things:

1. It takes a CSV file (say from a bank account transaction export), and
   converts the schema to another format (say, with the columns that
   YNAB expects)

2. It following some simple rules, intelligently changes the data in a
   given cell based on the data of other cells in that row (in short,
   this is "always rename X as Y and categorize as Z")

3. It provides a mechanism to easily edit the rules implemented in (2).
   I imagine both a dedicated "edit rules" mode, and an "interactive
   convert" mode that converts a file, and prompts the user for input on
   every row that does not already have a rule associated with it.


----

Project Roadmap:

- [ ] CLI interface
  - [X] Framework for programming subcommands
  - [X] Help framework
  - [ ] Subcommand argument validation
  - [ ]  Spin out CLI interface framework to separate gem (optional)
- [ ] Convert subcommand
  - [ ] Ingest, parse, change schema, output csv
  - [ ] Method of specifying input -> output schema mapping
  - [ ] Row-level rewrite rules
  - [ ] Interactive mode
- [ ] Edit subcommand
  - [ ] Implement rules framework
  - [ ] Seed with basic example rules
  - [ ] Allow editing of rules programmatically
  - [ ] Expose rule editing via UI
- [ ] Configuration
  - [ ] Allow easy portability of rules (If I use a sqlite db that
        should be as easy as copypasting a file)
- [ ] Business
  - [ ] Make tons of money providing this as a cloud service
  - [ ] Get sued for leaking peoples' financial data
  - [ ] Get fined by regulators for working with peoples' financial data

----

Contributing:

Right now I would prefer to work on this solo. If you'd like to help
out, please get in touch with me directly so we can better organize.
Thanks :D
