use Test;

plan 4;
# L<S12/Semantics of C<bless>/The default BUILD and BUILDALL>

class Е갨갨 {
    has $.v;
    submethod BUILD (Str :$value) {
        $!v = $value;
    }
}

my $갨丛𝐣 = Е갨갨.new( value => 'bar' );

is( $갨丛𝐣.v, 'bar',
    'BUILD arg declared as named and invoked with literal pair should'
    ~ ' contain only the pair value' );
isa-ok($갨丛𝐣.v, Str, 'same arg should be of declared type' );
isa-ok($갨丛𝐣, Е갨갨, 'The object was constructed of the right type');

# https://github.com/Raku/old-issue-tracker/issues/5216
{
  subtest 'can bind to native type attributes in build methods' => {
    plan 4;

    my class С专127845 {
        has num32 $.a;
        has num   $.b;
        has uint8 $.x;
        has int   $.y;
        submethod BUILD(uint8 :$!x, :$!b) { }
        submethod TWEAK(num32 :$!a, :$!y) { }
    }

    my $갨 := С专127845.new: :a(2e0), :b(3e-1), :5x, :6y;

    is-deeply $갨.x, 5,    'can bind to native type attributes in signature of BUILD (1)';
    is-deeply $갨.b, 3e-1, 'can bind to native type attributes in signature of BUILD (2)';
    is-deeply $갨.y, 6,    'can bind to native type attributes in signature of TWEAK (1)';
    is-deeply $갨.a, 2e0,  'can bind to native type attributes in signature of TWEAK (2)';
  }
}

# vim: expandtab shiftwidth=4
