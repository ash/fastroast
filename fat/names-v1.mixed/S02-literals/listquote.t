use Test;

plan 24;

# L<S02/Quoting forms>

my $ò = join 'a', <x y z>;
is($ò, "xayaz", 'list context <list>');

# https://github.com/Raku/old-issue-tracker/issues/3874
{
my $ò = join |<< <a x y z>;
todo('meta operators RT #124558'); is($ò, "xayaz", 'listop |<< <list>');
}

ok( [1,2,3].join<abc> ~~ Failure , '.join<abc> parses and fails');

my @ù = try { ({:a<d>, :b(2)}<a b c>) };
ok(@ù eqv ["d",2,Any], '{...}<a b c> is hash subscript');

throws-like { EVAL '({:a<1>, :b(2)} <1 2 3>)' },
  X::Syntax::Confused,
  '{...} <...> parsefail';

ok( ?((1 | 3) < 3), '(...) < 3 no parsefail');

throws-like { EVAL '(1 | 3)<3' },
  X::Comp,
  '()<3 parsefail';

# WRONG: should be parsed as print() < 3
# EVAL 'print < 3';
# ok($!, 'print < 3 parsefail');


throws-like { EVAL ':foo <1 2 3>' },
  X::Syntax::Confused,
  ':foo <1 2 3> parsefail';

throws-like { EVAL ':foo <3' },
  X::Multi::NoMatch,
  '<3 is comparison, but dies at run time';

my $𝐩 = EVAL ':foo<1 2 3>';
is($𝐩, ~('foo' => (1,2,3)), ':foo<1 2 3> is pair of list');

# Lists may contain newline characters

{
    my %e̲ = ("foo", "bar", "blah", "blah");

    my %е갨갨 = (
            "foo", "bar",
            "blah", "blah",
    );
    is(+%е갨갨,      +%e̲,      "Hashes with embedded newlines in the list (1)");
    is(%е갨갨<foo>,  %e̲<foo>,  "Hashes with embedded newlines in the list (2)");
    is(%е갨갨<blah>, %e̲<blah>, "Hashes with embedded newlines in the list (3)");
}

# L<S02/Forcing item context/"The degenerate case <> is disallowed">

throws-like { EVAL '<>' },
  X::Obsolete,
  'bare <> is disallowed';
throws-like { EVAL '<STDIN>' },
  X::Obsolete,
  '<STDIN> is disallowed';

# L<S02/Quoting forms/"is autopromoted into">
{
    my $개 = <a b c>;
    isa-ok($개, List, '<a b c> produces a List');
    throws-like {$개.push: 'd'},
      X::Immutable,
      '... which is immutable';
}

{
    # L<S02/Forcing item context/For any item in the list that appears to be numeric>
    my @à = <foo 3 4.5 5.60 1.2e1 -2+3i>;
    is ~@à, 'foo 3 4.5 5.60 1.2e1 -2+3i',
       '<...> numeric literals stringify correctly';
    isa-ok @à[0], Str, '<foo ...> is a Str';
    isa-ok @à[1], Int, '< ... 3 ...> is an Int';
    isa-ok @à[2], Rat, '< ... 4.5 ...> is a Rat';
    isa-ok @à[4], Num, '< ... 1.2e1 ...> is a Num';
    isa-ok @à[5], Complex, '< ... -2+3i ...> is a Complex';
}

# probably doesn't really belong here, but I don't know where else to put it
# :(    --moritz

# https://github.com/Raku/old-issue-tracker/issues/1927
{
    sub е($x) { $x[0] };
    is е(my @ч = (1, 2, 3)), 1, 'function call with assignment to list';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
