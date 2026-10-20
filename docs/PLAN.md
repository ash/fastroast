# FatRoast plan

## Why

Raku++ passes all 220,845 tests declared in the 1,425 files of Roast's
`spectest.data`, and 11 of the 30 files the list leaves out as well (1,436 of
the checkout's 1,455). It still had twenty divergences on a
single to-do list in October 2026, each found by writing new code: `.minmax`
over Rats, `.indices` inside a CR LF, `~~ Map` for a Set, `&infix:<->(10)`
beside a user multi. Every one was a feature crossed with an input its tests
had no reason to use. A specification test pins a feature down with one
clear example, and asserts mostly by truth or string (95,408 `ok` and 29,025
`is` against 7,544 `is-deeply`). Rakumap's matrix domains enumerate such
products from scratch; FatRoast gets them from the tests that already exist,
keeping the expectations Roast's authors worked out.

## Invariants

1. The oracle runs every program the candidate runs, from the same text.
2. A file is edited only through the tokens of a parse-aware tokenizer that
   reassembles it exactly; anything else is skipped, not guessed.
3. A transform is named and versioned; changing its rules makes a new version.
4. `fat` means the engines agree on the seed. A divergence present without
   the fat is `base` and is not counted as the transform's.
5. Minimizing keeps the signature (the first disagreeing test and how), never
   just "still differs".
6. A same-verdicts transform the oracle breaks is debt, recorded beside the
   finding, not hidden.

## Done

- `strings-v1`, `names-v1`, `ops-v1`.
- Palettes, the second axis of a letter-mapping transform: `latin1`,
  `cyrillic`, `cjk`, `hangul`, `astral`, `marks` and their rotation `mixed`
  (the default), named in a spec as `strings-v1:cjk`.
- Campaign: seeds, the four-run classification, delta-debugging over edit
  groups, per-finding dossiers, a per-chapter report, parallel files.
- A rename is complete or not made: `names-v1` keeps any name with a spelling
  its tokens cannot reach, and the campaign puts back a name the oracle's
  errors report after the rename.

## What the tokenizer owes

Every edit is placed by the highlighter's spans, so a span the highlighter
cuts wrongly is an edit in the wrong place: a "string" that runs on for
forty lines gets its code fattened. The first Cyrillic sample found three
such cuts in Raku++ (ASCII-only names, a `-`/`'` joining a name before a
digit or a quote, a negated quote adverb `qq:!c/…/`), fixed there with a
regression test. Fattened files are exactly the input that finds these, so a
finding whose oracle error points at code the transform should not have
touched is checked against the spans first.

## Next

- `regex-v1`: regex literals together with the strings they match (S05),
  through the same palettes, leaving metasyntax (`\w`, `<alpha>`,
  `<[a..z]>`, adverbs) alone.
- `emoji-v1`: emoji, ZWJ sequences and skin-tone modifiers inside string
  literals (S15, S32-str), where grapheme boundaries move further than one
  combining mark moves them (the `marks` palette).
- `numbers-v1`: Int literals as BigInts of the same residue, and Rats as
  FatRats (S02, S32-num).
- `whitespace-v1`: CR LF line endings and a BOM for the whole file, a
  same-verdicts transform.
- A relation check for the oracle-mode transforms on demand: the oracle with
  itself, seed against fat, to tell a transform that broke a test from one
  that only changed its data.
- Graduating findings: a `fat` finding that is a candidate defect becomes a
  regression test in the candidate's suite; one that is an oracle defect is
  reported upstream.
