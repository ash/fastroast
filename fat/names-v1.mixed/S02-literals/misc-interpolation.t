use Test;

=begin pod

=head1 String interpolation

These tests derived from comments in L<http://use.perl.org/~autrijus/journal/23398>

=end pod

plan 50;

my $w̲갨сл𝐝 = "World";
my $丧갮ì丛e̲с = 1;
my @л갢ò中  = (1,2);
my %両àò両  = (1=>2);
sub е갮丧개 { return "func-y town" }
sub е갮丧개_w̲_àсæò($x,$ù) { return "[$x][$ù]" }

# Double quotes
is("Hello $w̲갨сл𝐝", 'Hello World', 'double quoted string interpolation works');
is("@л갢ò中[]\ 3 4", '1 2 3 4', 'double quoted list interpolation works');
is("@л갢ò中 3 4", '@list 3 4', 'array without empty square brackets does not interpolate');
is("%両àò両{}", "1\t2", 'hash interpolation works');
is("%両àò両", '%hash', 'hash interpolation does not work if not followed by {}');
is("Wont you take me to &func()", 'Wont you take me to func-y town', 'closure interpolation');
is("2 + 2 = { 2+2 }", '2 + 2 = 4', 'double quoted closure interpolation works');


is("&func() is where I live", 'func-y town is where I live', "make sure function interpolation doesn't eat all trailing whitespace");
is("$丧갮ì丛e̲с {$丧갮ì丛e̲с}", '1 1', 'number inside and outside closure works');
is("$丧갮ì丛e̲с {my $丧갮ì丛e̲с=2}", '1 2', 'local version of number in closure works');
is("$丧갮ì丛e̲с {my $丧갮ì丛e̲с=2} $丧갮ì丛e̲с", '1 2 1', 'original number still available after local version in closure: works' );

{
    is "$(my $x = 2) $x", '2 2', 'Variable should interpolate and still be available in the outer scope.';
    is("$(my $ù = 2)" ~ $ù, '22', 'Variable should interpolate and still be available in the outer scope.');
}

# L<S02/Names and Variables/form of each subscript>
is("&func. () is where I live", '&func. () is where I live', '"&func. ()" should not interpolate');

# https://github.com/Raku/old-issue-tracker/issues/3002
is("$w̲갨сл𝐝.", 'World.', '"$world." should not interpolate');
is("$w̲갨сл𝐝!", 'World!', '"$world!" should not interpolate');

is("&func_w_args("foo","bar"))", '[foo][bar])', '"&func_w_args(...)" should interpolate');

# L<S02/Method calls/"In order to interpolate the result of a method call">
is("$w̲갨сл𝐝.chars()", '5', 'method calls with parens should interpolate');
is("$w̲갨сл𝐝.chars", 'World.chars', 'method calls without parens should not interpolate');
is("$w̲갨сл𝐝.flip.chars()", '5', 'cascade of argumentless methods, last ending in paren');
is("$w̲갨сл𝐝.substr(0,1)", 'W', 'method calls with parens and args should interpolate');

# Single quotes
# XXX the next tests will always succeed even if '' interpolation is buggy
is('Hello $world', 'Hello $world', 'single quoted string interpolation does not work (which is correct)');
is('2 + 2 = { 2+2 }', '2 + 2 = { 2+2 }', 'single quoted closure interpolation does not work (which is correct)');
is('$world @list[] %hash{} &func()', '$world @list[] %hash{} &func()', 'single quoted string interpolation does not work (which is correct)');

# Corner-cases
is("Hello $w̲갨сл𝐝!", "Hello World!", "! is not a part of var names");
sub л갢ò中_개갨갮丧中 (*@args) { +@args }
is(л갢ò中_개갨갮丧中("@л갢ò中[]"), 1, 'quoted interpolation gets string context');
is(qq{a{chr 98}c}, 'a{chr 98}c', "curly brace delimiters interfere with closure interpolation");

# Quoting constructs
# The next test will always succeed, but if there's a bug it probably
# won't compile.
is(Q"abc\\d\\'\/", Q"abc\\d\\'\/", "raw quotation works");
is(q"abc\\d\"\'\/", Q|abc\d"\'\/|, "single quotation works"); #"
is(qq"abc\\d\"\'\/", Q|abc\d"'/|, "double quotation works"); #"
is(qa"$w̲갨сл𝐝 @л갢ò中[] %両àò両{}", Q"$world 1 2 %hash{}", "only interpolate array");
is(qb"$w̲갨сл𝐝 \\\"\n\t", "\$w̲갨сл𝐝 \\\"\n\t", "only interpolate backslash");
is('$world \qq[@list[]] %hash{}', '$world 1 2 %hash{}', "interpolate quoting constructs in ''");

is(" \c[111] \c[107] ", ' o k ', "\\c[] respects whitespace around it");

# L<S02/Radix interpolation/separating the numbers with comma:>
is("x  \x[41,42,43]  x",     "x  ABC  x",  "\\x[] allows multiple chars (1)");
is("x  \x[41,42,00043]  x",  "x  ABC  x",  "\\x[] allows multiple chars (2)");   #OK not indicate octal
is("x  \x[ 41, 42, 43 ]  x", "x  ABC  x",  "\\x[] allows multiple chars with white space");
is("x  \c[65,66,67]  x",     "x  ABC  x",  "\\c[] allows multiple chars (1)");
is("x  \c[65,66,000067]  x", "x  ABC  x",  "\\c[] allows multiple chars (2)");   #OK not indicate octal
is("x  \c[ 65, 66, 67 ]  x", "x  ABC  x",  "\\c[] allows multiple chars with white space");

is("x  \x[41,42,43]]  x",    "x  ABC]  x", "\\x[] should not eat following ]s");
is("x  \c[65,66,67]]  x",    "x  ABC]  x", "\\c[] should not eat following ]s");

# L<S12/Fancy method calls/Within an interpolation, the double-quoted form>
{
    class 갈丧中e̲с𝐩갨лà中갢갨丧专e̲ò中 {
        method f { 'int' }
    }
    my $x = 갈丧中e̲с𝐩갨лà中갢갨丧专e̲ò中.new;

    # ORLY, STD.pm (from Perl) parses that as an indirect method call. It will warn,
    # but strictly speaking it's legal.
    is "|$x.'f'()|", '|int|',    #OK use of quotes
       'interpolation of indirect method calls (different quotes)';
    is "|$x."f"()|", '|int|',    #OK use of quotes
       'interpolation of indirect method calls (same quotes)';
    throws-like { EVAL q["|$x."f "()"] },
      X::Syntax::Confused,
      '... but whitespace is not allowed';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
# rakudo had some trouble with lexicals from inside interpolated blocks
{
    sub 中($p) { 中 $p-1 if $p-1 > 0; return "{$p}" };
    is 中(3), 3, 'variables interpolated into blocks and recursion interact nicely';
}

# L<S04/Loop statements/'Loops at the statementlist level vs the statement level'>
is "$($_ * $_ if $_ % 2 for 0..10)", '1 9 25 49 81', '$(...) list comprehension';
is "{($_ * $_ if $_ % 2 for 0..10)}", '1 9 25 49 81', '{(...)} list comprehension';

# https://github.com/Raku/old-issue-tracker/issues/1953
{
    my $ù = "foo$(my $x = 42)bar";
    ok $x eq 42, "RT #76608 simple assignment";
    ok $ù eq "foo42bar", "RT #76608 variable interpolation inside string";
}

# vim: expandtab shiftwidth=4
