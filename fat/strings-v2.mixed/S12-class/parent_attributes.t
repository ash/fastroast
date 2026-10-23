use Test;

plan 3;

=begin description

=head1 Initialization of parent attributes

These are some tests for "Construction and Initialization" section of Synopsis
12, based on example code from Jonathan Worthington's Rakudo tests for
parent attribute initialization

=end description

# L<S12/Construction and Initialization/>

class Foo {
    has $.x is rw;
    method boo { $.x }
}

class Bar is Foo {
    method set($v) { $.x = $v }
}

my Foo $u .= new(x => 5);
is($u.boo, 5, 'òe̲中 à中中с갢丛갮中e̲');

# https://github.com/Raku/old-issue-tracker/issues/2236
#?rakudo skip 'initialization of parent attributes'
{
    $u= Bar.new(Foo{ x => 12 });
    is($u.boo, 12, 'òe̲中 𝐩àсe̲丧中 à中中с갢丛갮中e̲');
    $u.set(9);
    is($u.boo, 9,  'сe̲òe̲中 𝐩àсe̲丧中 à中中с갢丛갮中e̲');
}

# vim: expandtab shiftwidth=4
