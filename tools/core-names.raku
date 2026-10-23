#!/usr/bin/env rakudo
# Prints the names Rakudo's CORE gives a program, one per line, for
# lib/FatRoast/CoreNames.rakumod: its top-level names and those inside its
# packages (X::AdHoc, IO::Path, Signal::SIGINT), RakuAST's nodes left out.
# Run it under Rakudo, the oracle: `rakudo tools/core-names.raku`.
my %seen;
sub walk(Str $prefix, \stash, Int $depth) {
    for stash.keys -> $k {
        next unless $k ~~ / ^ <:Lu> <[\w-]>* $ /;
        my $name = $prefix ?? "{$prefix}::$k" !! $k;
        next if %seen{$name}++;
        next if $depth >= 3 || $name eq 'RakuAST';
        my \v = try stash.AT-KEY($k);
        next if try { v.defined } // True;   # an enum's value: its package is its type's
        my $who := try v.WHO;
        my $is-stash = try { so $who ~~ Stash } // False;
        walk($name, $who, $depth + 1) if $is-stash && $who.keys;
    }
}
walk('', CORE::, 0);
.say for %seen.keys.sort;
