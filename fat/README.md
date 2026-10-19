# The fattened Roast

Every file in Roast's `spectest.data`, as FastRoast rewrites it, at the
file's own path in Roast. Each directory is a tree laid out like Roast, one
subdirectory per chapter:

| directory | what is in it | files |
|---|---|---:|
| [`seed/`](seed/) | the Roast file fudged for Rakudo, its `#?` directive lines dropped | 1,424 |
| [`strings-v1.mixed/`](strings-v1.mixed/) | the seed with the letters in its string literals mapped through the `mixed` palette | 1,413 |
| [`names-v1.mixed/`](names-v1.mixed/) | the seed with its declared variables, subs, classes, roles and grammars renamed through the `mixed` palette | 1,173 |
| [`ops-v1/`](ops-v1/) | the seed with Texas operators in their Unicode spellings | 445 |

A transform's tree holds the files it changed; the others had nothing it
rewrites. [`coverage.tsv`](coverage.tsv) has one line per Roast file: whether
it seeds, and how many edit groups each transform made of it. One file,
`S15-unicode-information/uniprop.t`, does not seed: the tokens it is edited
through do not reassemble it exactly, so it is skipped rather than edited at
a guessed offset.

To see just the fat, compare a tree with the seeds:

```sh
diff -r fat/seed fat/strings-v1.mixed
diff fat/seed/S32-str/uc.t fat/names-v1.mixed/S32-str/uc.t
```

A file runs from a Roast checkout, as a campaign runs it:

```sh
cd /path/to/roast
RAKULIB=packages/Test-Helpers rakudo /path/to/fastroast/fat/strings-v1.mixed/S32-str/uc.t
```

A fattened test may fail on every implementation: a sort over strings in the
`mixed` palette, say, is no longer sorted. FastRoast's question is whether
two implementations give the same verdicts, not whether either passes; see
the [README](../README.md).

## Provenance

- Roast `da425eb92` (2026-10-07).
- FastRoast commit `5d0b9e6`, with
  `rakupp bin/fastroast fatten --roast=/path/to/roast --out=fat`.
- Tokens from the highlighter of Raku++ 5.4.1-136-g9550aecc, with the
  2026-10-19 fixes for non-ASCII names and negated quote adverbs; seeds from
  Roast's own `fudge rakudo`.

The command above regenerates the trees exactly; they are generated files,
and a change to a transform is a new version of it, not an edit here.

## License

These files are derived from [Roast](https://github.com/Raku/roast) and,
like it and like FastRoast, are under the [Artistic License 2.0](../LICENSE).
The tests and their expectations are Roast's authors' work.
