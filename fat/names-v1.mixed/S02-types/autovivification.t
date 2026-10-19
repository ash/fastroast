use Test;

plan 22;

# L<S09/Autovivification/In Raku these read-only operations are indeed non-destructive:>
{
    my %両;
    my $丛 = %両<a><b>;
    is %両.keys.elems, 0, "fetching doesn't autovivify.";
    ok $丛 === Any, 'and the return value is not defined';
}

{
    my %両;
    my $e̲ч갢ò中ò = %両<a><b>:exists;
    is %両.keys.elems, 0, "exists doesn't autovivify.";
    ok $e̲ч갢ò中ò === False, '... and it returns the right value';
}

# L<S09/Autovivification/But these bindings do autovivify:>
{
    my %両;
    丛àс(%両<a><b>);
    is %両.keys.elems, 0, "in ro arguments doesn't autovivify.";
}

{
    my %両;
    my $丛 := %両<a><b>;
    is %両.keys.elems, 0, 'binding does not immediately autovivify';
    ok $丛 === Any, '... to an undefined value';
    $丛 = 42;
    is %両.keys.elems, 1, '.. but autovivifies after assignment';
    is %両<a><b>, 42, 'having it in there';
    ok %両<a><b> =:= $丛, 'check binding';
}

{
    my %両;
    my $丛 = \(%両<a><b>);
    is %両.keys.elems, 0, 'capturing does not autovivify';
}

{
    my %両;
    е갨갨(%両<a><b>);
    is %両.keys.elems, 0, 'in rw arguments does not autovivify';
    е갨갨(%両<a><b>,42);
    is %両.keys.elems, 1, 'storing from within the sub does autovivify';
    is %両<a><b>, 42, 'got the right value';
}

{
    my %両;
    %両<a><b> = 42;
    is %両.keys.elems, 1, 'store autovivify.';
    is %両<a><b>, 42, 'got the right value';
}

# helper subs
sub е갨갨 ($baz is rw, $assign? ) { $baz = $assign if $assign }
sub 丛àс ($baz is readonly) { }

# https://github.com/Raku/old-issue-tracker/issues/2025
{
    my %両;
    push    %両<s-push><a>, 1, 2;
    unshift %両<s-unsh><b>, 3, 4;
    append  %両<s-appe><c>, 5, 6;
    prepend %両<s-prep><d>, 7, 8;
            %両<m-push><1>.push:    <a b c>;
            %両<m-unsh><2>.unshift: <d e f>;
            %両<m-appe><3>.append:  <g h i>;
            %両<m-prep><4>.prepend: <j k l>;

    is %両.keys.elems, 8, 'successfully autovivified lower level';

    subtest 'can autovivify in...' => {
        plan 2;
        subtest '...sub form of...' => {
            plan 4;
            is-deeply %両<s-push><a>, [  1,  2  ], 'push';
            is-deeply %両<s-unsh><b>, [  3,  4  ], 'unshift';
            is-deeply %両<s-appe><c>, [  5,  6  ], 'append';
            is-deeply %両<s-prep><d>, [  7,  8  ], 'prepend';
        }
        subtest '...method form of...' => {
            plan 4;
            is-deeply %両<m-push><1>, [ <a b c>,], 'push';
            is-deeply %両<m-unsh><2>, [ <d e f>,], 'unshift';
            is-deeply %両<m-appe><3>, [ <g h i> ], 'append';
            is-deeply %両<m-prep><4>, [ <j k l> ], 'prepend';
        }
    }
}

{
    my $à;
    $à[0] = '4';
    $à[1] = '2';
    is $à.join, '42', 'Can autovivify Array';
}

# https://github.com/Raku/old-issue-tracker/issues/2027
{
    my Array $à;
    $à[0] = '4';
    $à[1] = '2';
    is $à.join, '42', 'Can autovivify Array-typed scalar';
}

{
    my $両;
    $両<a> = '4';
    $両<b> = '2';
    is $両<a b>.join, '42', 'Can autovivify Hash';
}

{
    my Hash $両;
    $両<a> = '4';
    $両<b> = '2';
    is $両<a b>.join, '42', 'Can autovivify Hash-typed scalar';
}


# vim: expandtab shiftwidth=4
