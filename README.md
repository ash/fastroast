# FatRoast

Roast with the fat added.

[Roast](https://github.com/Raku/roast) specifies each feature with clear,
focused examples, and most of them are written in ASCII text, with Latin
names and the Texas spelling of operators. That keeps every test about the
one thing it checks, and Unicode has chapters of its own. Still, an
implementation can pass a test and go wrong when the same feature meets
other input: a string with a combining mark, an identifier in another
script, `≤` instead of `<=`. FatRoast takes the Roast files as they are and
**adds fat**: named, versioned transforms rewrite each file, both engines
run the rewritten file, and their results are compared test by test. Every
expectation it checks is one Roast's authors wrote.

It is a sibling of [Rakumap](https://github.com/ash/rakumap) (differential
exploration from generated programs), [Rakugrid](https://github.com/ash/rakugrid)
and [Rakuglaze](https://github.com/ash/rakuglaze). Rakumap starts from nothing
and generates; FatRoast starts from the 1,425 files Roast's `spectest.data`
lists, the tests Roast expects an implementation to pass, and mutates them.
Everything it writes keeps the file's path in Roast (`S32-str/uc.t`), and the
fattened files for one Roast revision are in this repository, under
[fat/](fat/).

## Two ways to use it

- **`fatroast run`** is a campaign. It fattens each file as it goes, runs
  Rakudo (the oracle) and a candidate on it, compares their TAP test by test,
  and shrinks a divergence the fat caused to the few edits it needs.
- **`fatroast fatten`** writes the fattened suite as trees laid out as Roast
  is, which [fat/](fat/) holds. Raku++'s `tools/run-fatroast.raku` runs those
  trees the way it runs Roast and compares the outcomes file by file.

| | `fatroast run` | `fat/` + `run-fatroast.raku` |
|---|---|---|
| what runs | a seed: the file fudged for Rakudo, `#?` lines dropped | the Roast file as it is, `#?` directives kept |
| compared | every test's verdict, and the exit status | each file's outcome |
| engines | an oracle and a candidate | one or several; the first is the reference |
| a divergence | shrunk to `min.t`, with a dossier | listed |

## How it edits

Every edit is placed by tokens from Raku++'s parse-aware highlighter
(`rakupp --highlight --html`): each span gives a class (`s` a string literal,
`n` a name, `nv` a variable, `k` a keyword, `c1` a comment) with its text and
its offset in the file. A file whose tokens do not reassemble it exactly is
skipped rather than edited at a guessed offset; of Roast's 1,425 files, one
is (`S15-unicode-information/uniprop.t`).

A transform turns a file into **edit groups**, the units that must change
together: one string literal, every occurrence of one renamed name, one
operator. All of them applied is the fattened file; a subset is what the
minimizer probes. Edits never overlap, and no transform touches a comment. A
transform that changes is a new version, so a finding stays reproducible.

## How a campaign decides

For each Roast file and each transform:

1. **The seed** is the file fudged for Rakudo by Roast's own `fudge`, invoked
   as Rakudo's spectest invokes it (`--keep-exit-code --version=v6.d
   rakudo.moar`), with its `#?` directive lines dropped (an engine that
   honours them natively, as Raku++ does, would apply them a second time).
2. **The transform** turns the seed into edit groups; all of them applied is
   the fattened file.
3. **Both engines run the fattened file**, from the Roast checkout's root
   with its `packages/Test-Helpers` on `RAKULIB`. The same TAP verdict for
   every test (keyed by subtest depth and test number; descriptions are left
   out), and the same exit status, is `agree`. Under `names-v1`, a name the
   oracle's errors report as undeclared after the rename is put back and both
   engines run the file again, four runs at most: that rename was incomplete,
   a spelling the tokens did not show.
4. Otherwise **both run the seed as well.** If they disagree there too, the
   divergence is `base`: it exists without the fat and belongs to the
   engine's ordinary conformance work. If they agree there, it is `fat`.
5. **A fat finding is minimized** by delta debugging over the edit groups
   (24 probes by default, `--shrink-budget`), keeping a subset while the same
   first test still disagrees the same way. The dossier names the strings,
   names or operators the divergence needs.

The oracle is Rakudo. A fattened test that now fails is fine if it fails on
both: the transform does not have to keep the file passing, only valid. A
transform that does promise the same verdicts (`ops-v1`) also records `debt`
when the oracle's own verdicts changed, since then the promise is what broke.

A divergence is a lead, not a verdict on either engine.

## Transforms

| name | relation | what it rewrites |
|---|---|---|
| `strings-v1` | oracle | the letters inside string literals, through a palette. Escapes, interpolations, heredocs and the strings of `use`/`no`/`need`/`require` statements are kept |
| `names-v1` | oracle | the variables a file declares with `my`/`our`/`state`/`constant`, and its subs, classes, roles and grammars, renamed through a palette everywhere they occur (interpolations included). A variable also used as a named argument keeps its name, as do parameters, methods and the core class an `augment` names. So does any name with a spelling the tokens cannot reach (inside a regex, in a string that is EVALed), or that the oracle's errors name after the rename, so a rename never leaves the program referring to what it no longer declares |
| `ops-v1` | same verdicts | Texas operator spellings to their Unicode aliases: `∈ ∋ ∪ ∩ ∖ ⊖ ⊆ ⊇ ⊂ ⊃ ≡ ⊎ ⊍`, `≤ ≥ ≠ ≅`, `× ÷ −` between terms, `…`, `».`, `∞ π τ`. Strings, regexes and comments are protected; an infix is rewritten only after a term, so a Whatever `*` stays |

## Palettes

A transform that maps letters runs through a **palette**, the second axis of
a campaign: `strings-v1:cjk` is the string rule in CJK ideographs. Each maps
a–z and A–Z one to one:

| palette | a–z | per letter |
|---|---|---|
| `latin1` | àáâãäåæçèé… | 2 bytes in UTF-8, cased, precomposed letters with marks |
| `cyrillic` | абвгдежзий… | 2 bytes, cased |
| `cjk` | 业丛东丝丞丟… | 3 bytes, no case |
| `hangul` | 갚갛개객갞갟… | 3 bytes, no case; NFD splits each syllable into jamo |
| `astral` | 𝐚𝐛𝐜𝐝𝐞𝐟… (bold) | 4 bytes, outside the BMP, no case mapping |
| `marks` | a̲b̲c̲d̲e̲f̲… | one grapheme of two codepoints (letter + U+0332), cased; NFC keeps both |
| `mixed` | à丛개𝐝e̲е… | each letter from the palette its position picks, in turn: every width and both kinds of grapheme in one string |

The single-script palettes keep the letters in order (A–Z before a–z, each
run ascending), so a sort over fattened strings is still a sort, and the cased
ones keep case, so `.uc` and `.lc` still pass where they passed. `mixed`
keeps neither, which an oracle-relation transform allows: a test of sort
order may now fail, on both engines alike. `mixed` is the default;
`--palette=all` runs every palette, and `rakupp bin/fatroast palettes`
prints them. A spec with a palette is a directory with a dot:
`strings-v1:cjk` writes to `strings-v1.cjk/`.

## Running it

FatRoast is written in Raku and runs under Raku++ (its tokens come from
Raku++'s highlighter). It needs a Roast checkout, Rakudo as the oracle, and
`perl` for Roast's `fudge`. Use a Raku++ built after 2026-10-19: before
then the highlighter read only ASCII names and misread a few quote forms
(`qq:!c/…/`, `1&'a'`), which put edits in the wrong places.

```sh
rakupp bin/fatroast transforms
rakupp bin/fatroast palettes
rakupp bin/fatroast coverage --roast=/path/to/roast
rakupp bin/fatroast run --roast=/path/to/roast --transform=all --per=5 \
    --oracle=rakudo --candidate=/path/to/rakupp --jobs=2
rakupp bin/fatroast run --roast=/path/to/roast --transform=strings-v1 \
    --palette=cjk,marks --chapters=S05,S32-str --candidate=/path/to/rakupp
rakupp bin/fatroast run --roast=/path/to/roast --transform=names-v1:hangul,ops-v1
rakupp bin/fatroast fatten /path/to/roast/S32-str/uc.t --transform=strings-v1:astral
```

Each file in flight runs one engine at a time: two runs per file and
transform when the engines agree, four when they do not, and more while a
finding is minimized. `--jobs` is the number of files in flight. Each run is
bounded by `--timeout` (90 s by default), and the engine runs in its own
process group, so a timeout also stops whatever the test spawned.

`--per=N` takes N files per chapter (chosen by `--seed`); without it every
file of the chosen chapters runs. Results land under `--out` (default
`out/latest`):

```text
report.md                  per transform: a chapter table and the findings
results.tsv                one line per file and transform
findings/TRANSFORM.PALETTE/S32-str/uc.t/
  finding.md               signature, the groups needed, the names kept, the differing tests
  seed.t  fat.t  min.t     the seed, the fully fattened file, the minimum
  oracle.stdout/.stderr    both engines on min.t
  candidate.stdout/.stderr
```

A campaign keeps the files of its findings only. The full trees for Roast
`da425eb92` are in this repository, under [fat/](fat/), browsable chapter by
chapter. They are not seeds: a tree's file is the Roast file as it is, `#?`
directives included, with only the transform's edits applied (no transform
touches a comment), so it is the same test suite with mangled characters and
runs wherever and however Roast runs. `fatten` without a file writes them (it
runs no engine), laid out as Roast is:

```sh
rakupp bin/fatroast fatten --roast=/path/to/roast --out=out/fat
rakupp bin/fatroast fatten --roast=/path/to/roast --chapters=S05,S32-str \
    --transform=strings-v1 --palette=all --out=out/fat
```

```text
out/fat/
  coverage.tsv                 one line per Roast file: tokenized or not, edit groups per spec
  strings-v1.mixed/S32-str/uc.t
  names-v1.mixed/S32-str/uc.t
  ops-v1/S32-str/uc.t          (a spec's tree holds the files it changed)
```

`diff /path/to/roast/S32-str/uc.t out/fat/strings-v1.mixed/S32-str/uc.t`
shows the fat and nothing else.

### The trees under Raku++'s Roast harness

Raku++'s `tools/run-fatroast.raku` runs fat/'s trees through its Roast
harness, `tools/run-roast.raku`, as **parts**: first `roast`, the baseline
(plain Roast, cut to the files the trees change), then one part per tree.
`--parts=strings-v1` names every palette's tree of a transform,
`--parts=strings-v1.mixed` one tree, and `--help` lists them with their file
counts.

A tree cannot be a Roast by itself. It holds only the `.t` files its
transform changed; about 300 files find `packages/Test-Helpers` through their
own location (`$*PROGRAM.parent(2)`), and others read fixtures that sit
beside them. So each part runs from an **overlay**: the Roast checkout copied
without `.git`, the tree laid over it, and a `spectest.data` cut down to the
part's own lines, markers included, so only files Roast lists run and
`--skip-marker` keeps out what it keeps out of Roast. The overlay is restored
with rsync before every engine's run, so what one run's tests wrote beside
themselves is gone before the next. The directives are left to run-roast's
rules: Raku++ applies them itself, and a foreign engine gets Roast's `fudge`
first.

From a Raku++ checkout:

```sh
nice build/rakupp tools/run-fatroast.raku -j2
nice build/rakupp tools/run-fatroast.raku -j2 --engine=build/rakupp,rakudo
build/rakupp tools/run-fatroast.raku --parts=roast,ops-v1 S03-operators
build/rakupp tools/run-fatroast.raku --parts=strings-v1 S32-str
```

It finds FatRoast at `$FATROAST` (default `$HOME/fatroast`), Roast at
`$ROAST` (default `$HOME/roast`) and puts the overlays at `$FATROAST_OVERLAY`
(default `$HOME/roast-fat`). It warns when the Roast checkout is not the
revision fat/README.md names, since the overlay pairs the trees with that
checkout's helpers and fixtures. Each file's outcome (`PASS`, `part 13/19`,
`TIME`, `noTAP`, `LOST`) is read from run-roast's lists, and the results go
to `OVERLAY/lists/`:

```text
PART.ENGINE.log            run-roast's output for that run
PART.ENGINE.list           its fully passing files (+ .meta)
PART.ENGINE.lost           files that fully pass in Roast but not in PART
PART.A-vs-B.diff           with two engines, the files whose outcome differs:
                           fat when the engines agree on the plain Roast file,
                           base when they disagree there too
```

A fattened test can fail on every engine (a sort over `mixed`-palette strings
is no longer sorted), so a part's pass count says little alone; the `.lost`
and `.diff` files are what to read. For test-by-test verdicts and a shrunk
reproducer, use `fatroast run`.

### Tests

Run the tests with `for t in t/*.rakutest; do rakupp $t; done`.
`fixtures/engines/` holds two engine doubles with planted defects (one fails
only on fattened files, one always), which is how the campaign test knows a
`fat` from a `base`.

## Layout

```text
bin/fatroast               the command: run, fatten, coverage, transforms, palettes
lib/FatRoast/
  Tokens.rakumod           the highlighter's spans as tokens; none for a file they do not reassemble
  Transform.rakumod        the palettes, the transforms, edit groups and render
  Roast.rakumod            spectest.data's files; a file's seed (fudged for Rakudo, #? lines dropped)
  Runner.rakumod           one engine on one file, in its own process group, with a timeout
  Tap.rakumod              TAP as keys (depth:number:verdict), their diff, a divergence's signature
  Campaign.rakumod         one file judged, delta debugging, the dossiers, report.md and results.tsv
fat/                       the fattened trees for one Roast revision (see fat/README.md)
  coverage.tsv             per Roast file: tokenized or not, edit groups per transform
  strings-v1.mixed/  names-v1.mixed/  ops-v1/
t/                         the tests
fixtures/roast-mini/       a Roast-shaped tree for the campaign and fatten tests
fixtures/engines/          two engine doubles with planted defects
docs/PLAN.md               the invariants, and what is next
docs/RESULTS.md            results so far
out/                       campaign output (not committed)
```

## Status

Results so far are in [docs/RESULTS.md](docs/RESULTS.md); [docs/PLAN.md](docs/PLAN.md)
says what is next.
