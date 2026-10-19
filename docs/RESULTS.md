# Results

## 2026-10-19: the first two samples

Oracle Rakudo v2026.09; candidate Raku++ 5.4.1-136-g9550aecc (built from
`main` with uncommitted highlighter fixes). Files are drawn per chapter from
Roast's `spectest.data` with `--seed=1`.

| sample | spec | files | agree | fat | base | skip |
|---|---|---:|---:|---:|---:|---:|
| 5 per chapter | `strings-v1:cyrillic` | 461 | 340 | 78 | 37 | 6 |
| 5 per chapter | `names-v1:cyrillic` | 461 | 268 | 72 | 36 | 85 |
| 5 per chapter | `ops-v1` | 461 | 117 | 5 | 18 | 321 |
| 3 per chapter | `strings-v1:mixed` | 311 | 223 | 62 | 23 | 3 |
| 3 per chapter | `names-v1:mixed` | 311 | 206 | 28 | 21 | 56 |

The Cyrillic `names-v1` row predates the rename-completeness rules. Re-run
with them, its 72 fat findings became 35 agree, 4 skip and 33 fat. Of the
206 files in both samples, 10 agree in Cyrillic and diverge in `mixed`.

A third of the fat findings differ only in exit status (52 of 155 in the
first sample, 31 of 90 in the second). Rakudo's Test exits 255 after dying
with a short plan and with the failure count when tests failed; Raku++ exits
1 or 255.

### Raku++ defects confirmed from these findings

Each one is reproduced outside FastRoast against Rakudo:

| defect | found by |
|---|---|
| `my $y := $ч` copies instead of binding (any non-ASCII scalar name) | `names-v1:cyrillic` |
| `my Еоо $x` drops the type constraint (non-ASCII type name) | `names-v1:cyrillic` |
| `infix:<nosuch>(42)` returns 42 instead of failing as undeclared | `strings-v1:cyrillic` |
| Test's exit status after a die or a short plan | every spec |
| `/$é/` and `/@𝐯/` do not interpolate (non-ASCII variable in a regex) | `names-v1:mixed` |
| `.trans(/ \s+ / => "_")` replaces at the wrong place after a combining mark | `strings-v1:mixed` |

The highlighter FastRoast takes its tokens from had three defects of its own
(ASCII-only names, `-`/`'` joining a name before a digit or a quote, `qq:!c`),
fixed in Raku++ the same day.

### Coverage

`fastroast fatten --roast=…` over all 1,425 files: 1,424 seed (one,
`S15-unicode-information/uniprop.t`, does not reassemble from the
highlighter's tokens). `strings-v1:mixed` changes 1,413 of them (176,929 edit
groups), `names-v1:mixed` 1,173 (8,956), `ops-v1` 445 (5,856).
