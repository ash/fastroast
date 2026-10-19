# FastRoast

Roast with the fat added.

[Roast](https://github.com/Raku/roast) tests each feature at the input its
authors thought of first, and that is mostly ASCII text, Latin names and the
Texas spelling of every operator. An implementation can pass all of it and
still be wrong for the next input over: a string with a combining mark, an
identifier in another script, `≤` instead of `<=`. FastRoast takes the Roast
files as they are and **adds fat**: named, versioned transforms rewrite each
file, both engines run the rewritten file, and their results are compared
test by test.

It is a sibling of [Rakumap](https://github.com/ash/rakumap) (differential
exploration from generated programs), [Rakugrid](https://github.com/ash/rakugrid)
and [Rakuglaze](https://github.com/ash/rakuglaze). Rakumap starts from nothing
and generates; FastRoast starts from the 1,425 files Roast's `spectest.data`
lists (the set `make spectest` runs) and mutates them. It keeps no copy of
Roast: each file is fattened when it runs, and every result is keyed by the
file's path in Roast.

## How it decides

For each Roast file and each transform:

1. **The seed** is the file fudged for Rakudo by Roast's own `fudge`, with its
   `#?` directive lines dropped (an engine that honours them natively, as
   Raku++ does, would apply them a second time).
2. **The transform** turns the seed into edit groups; all of them applied is
   the fattened file.
3. **Both engines run the fattened file.** The same TAP verdict for every test,
   and the same exit status, is `agree`.
4. Otherwise **both run the seed as well.** If they disagree there too, the
   divergence is `base`: it exists without the fat and belongs to the
   engine's ordinary conformance work. If they agree there, it is `fat`.
5. **A fat finding is minimized** by delta debugging over the edit groups,
   keeping a subset while the same first test still disagrees the same way.
   The dossier names the strings, names or operators the divergence needs.

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

The tokens come from Raku++'s parse-aware highlighter (`rakupp --highlight
--html`); a file whose tokens do not reassemble it exactly is skipped rather
than edited at a guessed offset. A transform that changes is a new version,
so a finding stays reproducible.

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
`--palette=all` runs every palette, and `rakupp bin/fastroast palettes`
prints them.

## Running it

FastRoast is written in Raku and runs under Raku++ (its tokens come from
Raku++'s highlighter). It needs a Roast checkout, Rakudo as the oracle, and
`perl` for Roast's `fudge`. Use a Raku++ built after 2026-10-19: before
then the highlighter read only ASCII names and misread a few quote forms
(`qq:!c/…/`, `1&'a'`), which put edits in the wrong places.

```sh
rakupp bin/fastroast transforms
rakupp bin/fastroast palettes
rakupp bin/fastroast coverage --roast=/path/to/roast
rakupp bin/fastroast run --roast=/path/to/roast --transform=all --per=5 \
    --oracle=rakudo --candidate=/path/to/rakupp --jobs=2
rakupp bin/fastroast run --roast=/path/to/roast --transform=strings-v1 \
    --palette=cjk,marks --chapters=S05,S32-str --candidate=/path/to/rakupp
rakupp bin/fastroast run --roast=/path/to/roast --transform=names-v1:hangul,ops-v1
rakupp bin/fastroast fatten /path/to/roast/S32-str/uc.t --transform=strings-v1:astral
```

Each file in flight runs one engine at a time: two runs per file and
transform when the engines agree, four when they do not, and more while a
finding is minimized. `--jobs` is the number of files in flight.

`--per=N` takes N files per chapter (chosen by `--seed`); without it every
file of the chosen chapters runs. Results land under `--out` (default
`out/latest`):

```text
report.md                  per transform: a chapter table and the findings
results.tsv                one line per file and transform
findings/TRANSFORM.PALETTE/FILE/
  finding.md               signature, the groups needed, the names kept, the differing tests
  seed.t  fat.t  min.t     the seed, the fully fattened file, the minimum
  oracle.stdout/.stderr    both engines on min.t
  candidate.stdout/.stderr
```

Run the tests with `for t in t/*.rakutest; do rakupp $t; done`.
`fixtures/engines/` holds two engine doubles with planted defects (one fails
only on fattened files, one always), which is how the campaign test knows a
`fat` from a `base`.

## Status

See [docs/PLAN.md](docs/PLAN.md) for what is next.
