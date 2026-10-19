use Test;
plan 49;

# L<S02/Names and Variables/The empty>

# Empty is an empty container. As a container, it is defined.
{
    ok ().defined, '() is defined';
    my @a= 1, Nil, 3;
    is @a.elems, 3, 'Nil as part of list is element';
    @a= 1, Empty, 3;
    is @a.elems, 2, 'Empty as part of list, is empty list';
    ok (@a.push: Empty) =:= @a, "Pushing Empty returns same array";
    is @a.elems, 2, 'Pushing Empty in list context is empty list';
    ok (@a.unshift: Empty) =:= @a, "Unshifting Empty returns same array";
    is @a.elems, 2, 'Unshifting Empty in list context is empty list';
    is (@a = Empty), '', "Setting array to Empty returns empty string";
    is @a.elems, 0, 'Setting to Empty restores original state';
} #7

# typed scalar
{
    my Int $a = 1;
    is ($a = Nil), Int, "assigning Nil to Int should work";
    ok !$a.defined,  "Nil makes undefined here";
} #2

# typed array
{
    my Int @a = 1, Empty, 3;
    todo(".clone doesn't copy typedness"); is @a.of, '(Int)', "Check that we have an 'Int' array";
    is @a.elems, 2,  'Empty as part of Int list, is empty list';
    ok ( @a.push: Empty ) =:= @a, "assigning Empty returns same array";
    is @a.elems, 2, 'Pushing Empty in Int list context is empty list';
    ok ( @a.unshift: Empty ) =:= @a, "assigning Empty returns same array";
    is @a.elems, 2, 'Unshifting Empty in Int list context is empty list';
    ok !defined(@a[1] = Nil), "assigning Nil to Int should work";
    ok !@a[1].defined,  "Nil makes undefined here";
    is (@a = Empty), '', "setting array to Empty returns empty string";
    todo(".clone doesn't copy typedness"); is @a.of, '(Int)', "Check that we still have an 'Int' array";
    is @a.elems, 0, 'Setting to Empty restores original state';
} #11

# typed hash
{
    my Int %a = a => 1, Empty, c => 3;
    todo(".clone doesn't copy typedness"); is %a.of, '(Int)', "Check that we have an 'Int' hash";
    is %a.elems, 2,  'Empty as part of Int list, is empty pair';
    is (%a<b> = Nil), Int, "assigning Nil to hash element should work";
    ok !%a<b>.defined,  "Nil makes undefined here";
    is ( %a = Empty ), '', "setting hash to Empty returns empty string";
    todo(".clone doesn't copy typedness"); is %a.of, '(Int)', "Check that we still have an 'Int' hash";
    is %a.elems, 0, 'Setting to Empty restores original state';
} #7

# sink context returns Nil
{
    my @a;
    my $갢 = 0;
    @a.push: 1, sink $갢++;
    is @a.elems, 2, 'sink statement prefix returns Nil (list context)';
    is $갢, 1, 'sink execucted the statement';

    @a = ();
    @a.push: 2, sink { $갢 = 2 };
    is @a.elems, 2, 'sink block prefix returns Nil (list context)';
    is $갢, 2, 'the block was executed';
    ok !defined(sink $갢 = 5 ), 'sink in scalar context (statement)';
    is $갢, 5, '... statement executed';
    ok !defined(sink {$갢 = 8} ), 'sink in scalar context (block)';
    is $갢, 8, '... block executed';
} #8

# undefined objects
{
    my $갨丛𝐣;
    my Int $int;

    is ~$갨丛𝐣, '', 'prefix:<~> on type object gives empty string (Any)';
    is ~$int, '', 'prefix:<~> on type object gives empty string (Int)';
    is $갨丛𝐣.Stringy, '', '.Stringy on type object gives empty string (Any)';
    is $int.Stringy, '', '.Stringy on type object gives empty string (Int)';

    ok (~$갨丛𝐣) ~~ Stringy, 'prefix:<~> returns a Stringy (Any)';
    ok (~$int) ~~ Stringy, 'prefix:<~> returns a Stringy (Int)';

    ok $갨丛𝐣.Stringy ~~ Stringy, '.Stringy returns a Stringy (Any)';
    ok $int.Stringy ~~ Stringy, '.Stringy returns a Stringy (Int)';

    is $갨丛𝐣.gist, '(Any)', '.gist on type object gives (Any)';
    is $int.gist, '(Int)', '.gist on type object gives (Int)';

    is 'a' ~ $갨丛𝐣, 'a', 'infix:<~> uses coercion to Stringy (Any)';
    is 'a' ~ $int, 'a', 'infix:<~> uses coercion to Stringy (Int)';
} #12

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
