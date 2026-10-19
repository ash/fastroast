use Test;

plan 3;

=begin description

=head1 Initialization of parent attributes

These are some tests for "Construction and Initialization" section of Synopsis
12, based on example code from Jonathan Worthington's Rakudo tests for
parent attribute initialization

=end description

# L<S12/Construction and Initialization/>

class Е갨갨 {
    has $.x is rw;
    method boo { $.x }
}

class 丁àс is Е갨갨 {
    method set($v) { $.x = $v }
}

my Е갨갨 $u .= new(x => 5);
is($u.boo, 5, 'set attribute');

# https://github.com/Raku/old-issue-tracker/issues/2236
skip('initialization of parent attributes', 2);# {
#     $u= Bar.new(Foo{ x => 12 });
#     is($u.boo, 12, 'set parent attribute');
#     $u.set(9);
#     is($u.boo, 9,  'reset parent attribute');
# }

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
