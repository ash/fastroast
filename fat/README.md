# The fattened Roast

Every file in Roast's `spectest.data`, as FatRoast rewrites it, at the
file's own path in Roast: the very same test suite with mangled characters.
A file here is the Roast file as it is, `#?` fudge directives included, with
only one transform's edits applied; no transform touches a comment, so the
directives read exactly as Roast's do. Each directory is a tree laid out like
Roast, one subdirectory per chapter:

| directory | what is in it | files |
|---|---|---:|
| [`strings-v1.mixed/`](strings-v1.mixed/) | the letters in its string literals mapped through the `mixed` palette | 1,413 |
| [`names-v1.mixed/`](names-v1.mixed/) | its declared variables, subs, classes, roles and grammars renamed through the `mixed` palette | 1,181 |
| [`ops-v1/`](ops-v1/) | Texas operators in their Unicode spellings | 446 |
| [`strings-v2.mixed/`](strings-v2.mixed/) | as `strings-v1.mixed`, without the edits that broke the test on every engine: a heredoc's terminator, an escape's digits, what a `"…"` interpolates, a number in a word list, a name the program knows, a range's endpoints, and the code, commands and names a program keeps in strings | 1,414 |
| [`names-v2.mixed/`](names-v2.mixed/) | as `names-v1.mixed`, never renaming an operator's category, renaming in every interpolating string, keeping a name that code in a string uses | 1,166 |
| [`ops-v2/`](ops-v2/) | as `ops-v1`, where the alias is the core operator: spaced, after a term, a whole constant, not one the file declares | 422 |

A transform's tree holds the files it changed; the others had nothing it
rewrites. The v2 trees are the v1 rules without what Roast showed them
breaking on Raku++ and Rakudo alike (see the README's table of transforms);
the v1 trees are kept as they were, so what was measured on them can be
measured again. [`coverage.tsv`](coverage.tsv) has one line per Roast file: whether
its tokens reassemble it, and how many edit groups each transform made of it.
One file, `S15-unicode-information/uniprop.t`, does not: the tokens it is
edited through do not reassemble it exactly, so it is skipped rather than
edited at a guessed offset.

To see just the fat, compare a file with Roast's:

```sh
diff /path/to/roast/S32-str/uc.t fat/strings-v1.mixed/S32-str/uc.t
```

A tree runs the way Roast runs, its directives applied by the same rules:
Raku++ applies them itself, and Rakudo's harness runs Roast's `fudge` over a
file first. Raku++'s `tools/run-fatroast.raku` runs every tree from an
overlay of the Roast checkout (the tree laid over a copy of it, so a file's
helpers and fixtures are where it expects them) through its Roast harness,
with plain Roast beside it as the baseline.

A fattened test may fail on every implementation: a sort over strings in the
`mixed` palette, say, is no longer sorted. FatRoast's question is whether
two implementations give the same verdicts, not whether either passes; see
the [README](../README.md).

## Provenance

- Roast `da425eb92` (2026-10-07).
- The v1 trees: FatRoast `43f3282` (their rules have not changed since) with
  `rakupp bin/fatroast fatten --roast=/path/to/roast
  --transform=strings-v1,names-v1,ops-v1 --out=fat`, tokens from the
  highlighter of Raku++ 5.4.1-143-g333bb080.
- The v2 trees: FatRoast at the commit that carries this README, with
  `--transform=strings-v2,names-v2,ops-v2`, tokens from the highlighter of
  Raku++ 5.5.0-14-g8e2175a7, which also reads the Unicode quotes, a word list
  after a listop, reductions, shifts, word hyper operators and `:sym<…>`
  token names the earlier one misread. Their columns were added to
  `coverage.tsv`.

Those commands regenerate the trees exactly; they are generated files,
and a change to a transform is a new version of it, not an edit here.

## License

These files are derived from [Roast](https://github.com/Raku/roast) and,
like it and like FatRoast, are under the [Artistic License 2.0](../LICENSE).
The tests and their expectations are Roast's authors' work.
