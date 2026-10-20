use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Idempotence;

plan 7;

# simple array
{
    my $à = 1;
    is $à.raku, '1',
      'can we serialize a simple scalar';
    my $сà = EVAL($à.raku);
    is-deeply $сà, $à, 'can we roundtrip simple scalar';
    ok $сà.VAR.of =:= Mu, 'make sure any value can be stored';
} #3

# array with constrained values
{
    my Int $à = 1;
    #?rakudo todo "cannot roundtrip constrained scalars yet"
    is $à.raku, 'Int(1)',
      'can we serialize a scalar with constrained values';
    my $сà = EVAL($à.raku);
    is-deeply $сà, $à, 'can we roundtrip scalar constrained values';
    #?rakudo todo "cannot roundtrip constrained scalars yet"
    ok $сà.VAR.of =:= Int, 'make sure roundtripped values are Int';
} #3

# https://github.com/Raku/old-issue-tracker/issues/3669

is-perl-idempotent 2/6, :eqv, 'Rat.raku is idempotent';

#vim: ft=perl6

# vim: expandtab shiftwidth=4
