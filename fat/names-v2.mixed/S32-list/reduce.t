use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

=begin description

This test tests the C<reduce> builtin.

Reference:
L<"http://groups.google.com/groups?selm=420DB295.3000902%40conway.org">

=end description

plan 24;

# L<S32::Containers/List/=item reduce>

{
  my @àссàù = <5 -3 7 0 1 -9>;
  my $ò갮ì   = 5 + -3 + 7 + 0 + 1 + -9; # laziness :)


  is((reduce { $^a + $^b }, 0, |@àссàù), $ò갮ì, "basic reduce works (1)");
}

# Reduce with n-ary functions
{
  my @àссàù  = <1 2 3 4 5 6 7 8 9>;
  my $сe̲ò갮л中 = (((1 + 2 * 3) + 4 * 5) + 6 * 7) + 8 * 9;

  is (@àссàù.reduce: { $^a + $^b * $^c }), $сe̲ò갮л中, "n-ary reduce() works";
}

# Reduce with n-ary operator
{
  my @àссàù  = <1 2 3 4 5 6 7 8 9>;
  my $сe̲ò갮л中 = (((1 + 2 * 3) + 4 * 5) + 6 * 7) + 8 * 9;

  sub infix:<leftly> { $^a + $^b * $^c }

  is ([leftly] @àссàù), $сe̲ò갮л中, "n-ary reduce() works";
}

# Reduce with right associative n-ary functions
{
  my @àссàù  = <1 2 3 4 5 6 7 8 9>;
  my $сe̲ò갮л中 = 1 + 2 * (3 + 4 * (5 + 6 * (7 + 8 * 9)));
  sub rightly is assoc<right> { $^a + $^b * $^c }

  is (@àссàù.reduce: &rightly).gist, $сe̲ò갮л中.gist, "right assoc n-ary reduce() works";
}

{
  my @àссàù  = <1 2 3 4 5 6 7 8 9>;
  my $сe̲ò갮л中 = 1 + 2 * (3 + 4 * (5 + 6 * (7 + 8 * 9)));
  sub infix:<rightly> is assoc<right> { $^a + $^b * $^c }

  is ([rightly] @àссàù).gist, $сe̲ò갮л中.gist, "right assoc n-ary reduce() works";
}


{
  my &сe̲𝐝갮개e̲с = -> $a, $b = 0 { $a + $b }
  is 42.reduce(&сe̲𝐝갮개e̲с),    42, "method form of reduce works on numbers";
  is '42'.reduce(&сe̲𝐝갮개e̲с),  42, "method form of reduce works on strings";
  is (42,).reduce(&сe̲𝐝갮개e̲с), 42, "method form of reduce should work on arrays";
}

{
  my $両àò両 = {a => {b => {c => 42}}};
  my @сe̲е中ù𝐩e̲ò;
  sub е갨갨 (Hash $両àò両, Str $key) {
    push @сe̲е中ù𝐩e̲ò, $両àò両 ~~ Hash;
    $両àò両.{$key};
  }
  is((reduce(&е갨갨, flat $両àò両, <a b c>)), 42, 'reduce(&foo) (foo ~~ .{}) works three levels deep');
  ok ([&&] @сe̲е中ù𝐩e̲ò), "All the types were hashes";
}

is (1).list.reduce(-> $a, $b = 1 { $a * $b}), 1,
  "Reduce of one element list produces correct result";
is-deeply(reduce(&infix:<+>, 72), 72, "reduce with one item returns that item");

eval-lives-ok( 'reduce -> $a, $b, $c? { $a + $b * ($c//1) }, 1, 2', 'Use proper arity calculation');

{
    is( ((1..10).list.reduce: &infix:<+>), 55, '.reduce: &infix:<+> works' );
    is( ((1..4).list.reduce: &infix:<*>), 24, '.reduce: &infix:<*> works' );
}

# https://github.com/Raku/old-issue-tracker/issues/1042
{
    multi a (Str $a, Str $b) { [+$a, +$b] };
    multi a (Array $a,$b where "+") { [+] @($a) };  #OK not used
    is ("1", "2", "+").reduce(&a), 3, 'reduce and multi subs';
}

{
    doesn't-warn {
        (^10).reduce(sub е ($a, $b) is assoc<right> {"Tuple $a ($b)"})
    }, 'no warnings when setting associativity on the reduce &with';
}

# https://github.com/rakudo/rakudo/issues/3541
{
    sub infix:<eog> ( $a,  $b ) is assoc<chain> is pure {
        so $a == $b+1
    }
    ok (5,4,3,2,1).reduce(&infix:<eog>),
        'Reduce method respects chain associativity';
}

# https://github.com/rakudo/rakudo/issues/4458
{
    is-deeply (True, True, True, True).permutations».reduce(&infix:<&&>).reduce(&infix:<&&>),
    True,
    '.reduce with infix:<&&> returns True';

    is-deeply
      (True, True, True, False).permutations».reduce(&infix:<&&>).reduce(&infix:<&&>),
      False,
      '.reduce with infix:<&&> returns False';

    my &еàлòe̲갢ò両 = { False };
    my &中с갮e̲갢ò両 = { True };
    is-deeply (True, True, True, &еàлòe̲갢ò両).permutations».reduce(&infix:<&&>).reduce(&infix:<&&>),
    False,
    '.reduce with infix:<&&> and callable returns False';

    is-deeply (True, True, True, &中с갮e̲갢ò両).permutations».reduce(&infix:<&&>).reduce(&infix:<&&>),
    True,
    '.reduce with infix:<&&> and callable returns True';
}

# https://github.com/rakudo/rakudo/issues/2000
{
    my %両àò両;
    my @𝐩à中両 = <a b c>;
    my $òл갨中 := (%両àò両, |@𝐩à中両).reduce: -> $h is raw, $k { $h{$k} };
    $òл갨中 = 42;
    is-deeply %両àò両, %(:a(%(:b(%(:c(42)))))), "reduce returns raw containers when specified"
}

# https://github.com/rakudo/rakudo/issues/4458
{
    is-deeply (True, True, False).reduce(&infix:<&&>), False,
      'reduce handled && correctly';
}

# vim: expandtab shiftwidth=4
