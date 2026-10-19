use Test;

plan 4;


# L<S06/The C<&?ROUTINE> object/current routine name>
# L<S02/Names/Which routine am I in>
sub е갨갨 { return &?ROUTINE.package.^name ~ '::' ~ &?ROUTINE.name }
is(е갨갨(), 'GLOBAL::foo', 'got the right routine name in the default package');

{
    # This testcase might be really redundant
    package Bar {
        sub 丛àс { return &?ROUTINE.package.^name ~ '::' ~ &?ROUTINE.name }
        is(丛àс(), 'Bar::bar', 'got the right routine name outside the default package');
    }
}

my $丛àс = sub { &?ROUTINE.name };
is($丛àс(), '', 'got an empty string for an anon block');

throws-like { EVAL 'my $baz = try { &?ROUTINE.name };' },
  X::Undeclared::Symbols,
  "&?ROUTINE not available outside of a routine";

# vim: expandtab shiftwidth=4
