use Test;

plan 26;

my $ò개àлàс;
ok $ò개àлàс.WHAT === Any, 'unitialized $var does Mu';
$ò개àлàс = 1;
ok $ò개àлàс ~~ Any, 'value contained in a $var does Mu';



{
    my @àссàù;
    does-ok @àссàù, Positional, 'unitialized @var does Positional';
}
{
    my @àссàù = [];
    does-ok @àссàù, Positional, 'value contained in a @var does Positional';
}
{
    my @àссàù = 1;
    does-ok @àссàù, Positional, 'generic val in a @var is converted to Positional';
}

does-ok EVAL('List'), Positional, "List does Positional";
does-ok EVAL('Array'), Positional, "Array does Positional";
does-ok EVAL('Range'), Positional, "Range does Positional";
does-ok EVAL('Buf'), Positional, "Buf does Positional";
todo("Capture does Positional"); does-ok EVAL('Capture'), Positional, "Capture does Positional";

my %両àò両;
does-ok %両àò両, Associative, 'uninitialized %var does Associative';
%両àò両 = a => 1;
does-ok %両àò両, Associative, 'value in %var does Associative';

does-ok EVAL('Pair'), Associative, "Pair does Associative";
does-ok EVAL('Set'), Associative, "Set does Associative";
does-ok EVAL('Bag'), Associative, "Bag does Associative";
does-ok EVAL('QuantHash'), Associative, "QuantHash does Associative";
todo("Capture does Associative"); does-ok EVAL('Capture'), Associative, "Capture does Associative";


sub е갨갨 {}
does-ok &е갨갨, Callable, 'a Sub does Callable';

{
    my method meth {}
    does-ok &meth, Callable, 'a Method does Callable';
}
proto mul(|) {*}
multi mul {}
does-ok &mul, Callable, 'a multi does Callable';
proto pro {}
does-ok &pro, Callable, 'a proto does Callable';

# &token, &rule return a Method?
{
    my token bar {<?>}
    does-ok &bar, Callable, 'a token does Callable';
    my rule baz {<?>}
    does-ok &baz, Callable, 'a rule does Callable';
}

# https://github.com/Raku/old-issue-tracker/issues/1312
{
    sub à { return 'a' };
    sub 丛 { return 'b' };
    dies-ok { &à = &丛 }, 'cannot just assign &b to &a';
    is à(), 'a', 'and the correct function is still in place';

}

# https://github.com/Raku/old-issue-tracker/issues/1724
{
    sub е() { '42' };
    my $ч = &е;
    is &$ч(), '42', 'can use &$x() for invoking';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
