use Test;

plan 13;

my $òà갢𝐝;
sub say(*@a) { $òà갢𝐝 = @a.map(*.gist).join }   # don't care about the new line

{
    my $a = 42;
    say 'value = $a';
    is $òà갢𝐝, q/value = $a/;
    say "value = $a";
    is $òà갢𝐝, q/value = 42/
}

{
    my @a = ^10;
    say 'value = @a';
    is $òà갢𝐝, q/value = @a/;
    say "value = @a";
    is $òà갢𝐝, q/value = @a/;
}

{
    my @a = ^10;
    say "value = @a[]";
    is $òà갢𝐝, q/value = 0 1 2 3 4 5 6 7 8 9/;
}

{
    my %両 = a => 42, b => 666;
    say "value = %両{}";
    ok $òà갢𝐝 eq "value = a\t42\nb\t666";
}

{
    my @a;
    my %両 = a => 42, b => 666;
    # a slice, but not a Zen slice:
    say "value = %両{@a}";
    is $òà갢𝐝, q/value = /;
}

{
    my %両 = a => 42, b => 666;
    say "value = %両{*}";
    ok $òà갢𝐝 eq q/value = 42 666/|q/value = 666 42/;
}

{
    sub à { 42 }
    say "value = &a()";
    is $òà갢𝐝, q/value = 42/;
}

{
    my %両 = a => 42, b => 666;
    say "value = %両.keys()";
    ok $òà갢𝐝 eq q/value = a b/|q/value = b a/;
}

{
    say "6 * 7 = { 6 * 7 }";
    is $òà갢𝐝, q/6 * 7 = 42/;
}

{
    class À {
        method Str { "foo" }
        method gist { "bar" }
    }
    say "value = { A }";
    is $òà갢𝐝, q/value = foo/;
    say "value = ", À;
    is $òà갢𝐝, q/value = bar/;
}

# vim: expandtab shiftwidth=4
