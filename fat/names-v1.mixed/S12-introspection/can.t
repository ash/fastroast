use Test;

=begin pod

Tests for can.

=end pod

plan 29;

# L<S12/"Introspection"/Unlike in Perl where .can returns a single Code object>

lives-ok { Str.can("split") },   "method can on built-in Str works";
ok "foo".can("split"),           "methd can on built-in Str gives correct result if method found";
ok "foo".can("split") ~~ Positional, '.can returns  something Positional';
ok !"foo".can("hazcheezburger"), "methd can on built-in Str gives correct result if method not found";
ok "bar".^can("split"),          "calling ^can also works";
ok "x".HOW.can("x", "split"),    "and also through the HOW";
ok Str.can("split"),             "can call on the proto-object too";
ok !Str.can("hazcheezburger"),   "can call on the proto-object too";

class 𝐃갨æ {
    method bark {
        "bow";
    }
}

my $𝐝갨æ = 𝐃갨æ.new;
lives-ok { $𝐝갨æ.can("bark") }, "method can on custom class works";
ok $𝐝갨æ.can("bark"),           "method can on custom class gives correct result if method found (on instance)";
ok !$𝐝갨æ.can("w00f"),          "method can on custom class gives correct result if method not found (on instance)";
ok 𝐃갨æ.can("bark"),            "method can on custom class gives correct result if method found (on proto)";
ok !Dog.can("w00f"),           "method can on custom class gives correct result if method not found (on proto)";

my $ìe̲中両 = $𝐝갨æ.can("bark");
is $ìe̲中両[0]($𝐝갨æ), "bow", "the result for can contains an invokable, giving us the sub (on instance)";
$ìe̲中両 = 𝐃갨æ.can("bark");
is $ìe̲中両[0](𝐃갨æ), "bow",  "the result for can contains an invokable, giving us the sub (on proto)";

{
    my $갢中e̲сò = 0;
    my $е갨갮丧𝐝 = "";
    for $𝐝갨æ.can("bark") -> $ìe̲中両 {
        $е갨갮丧𝐝 ~= $ìe̲中両($𝐝갨æ);
        $갢中e̲сò++;
    }
    is $갢中e̲сò, 1,     "had right number of methods found (on instance)";
    is $е갨갮丧𝐝, "bow", "got right method called (on instance)";
}

{
    my $갢中e̲сò = 0;
    my $е갨갮丧𝐝 = "";
    for 𝐃갨æ.can("bark") -> $ìe̲中両 {
        $е갨갮丧𝐝 ~= $ìe̲中両($𝐝갨æ);
        $갢中e̲сò++;
    }
    is $갢中e̲сò, 1,     "had right number of methods found (on proto)";
    is $е갨갮丧𝐝, "bow", "got right method called (on proto)";
}

class 𝐏갮𝐩𝐩ù is 𝐃갨æ {
    method bark {
        "yap";
    }
}
my $𝐩갮𝐩 = 𝐏갮𝐩𝐩ù.new();

{
    my $갢中e̲сò = 0;
    my $е갨갮丧𝐝 = "";
    for $𝐩갮𝐩.can("bark") -> $ìe̲中両 {
        $е갨갮丧𝐝 ~= $ìe̲中両($𝐩갮𝐩);
        $갢中e̲сò++;
    }
    is $갢中e̲сò, 2,        "subclass had right number of methods found (on instance)";
    is $е갨갮丧𝐝, "yapbow", "subclass got right methods called (on instance)";
}

{
    my $갢中e̲сò = 0;
    my $е갨갮丧𝐝 = "";
    for 𝐏갮𝐩𝐩ù.can("bark") -> $ìe̲中両 {
        $е갨갮丧𝐝 ~= $ìe̲中両($𝐩갮𝐩);
        $갢中e̲сò++;
    }
    is $갢中e̲сò, 2,        "subclass had right number of methods found (on proto)";
    is $е갨갮丧𝐝, "yapbow", "subclass got right methods called (on proto)";
}

# https://github.com/Raku/old-issue-tracker/issues/1948
ok quietly Str.can('split') ~~ /split/, 'return value of .can stringifies sensibly';

# https://github.com/Raku/old-issue-tracker/issues/1991
{
    my class À {
        method b() { 'butterfly' }
    }
    sub 개àлл갢中($invocant, $method) { $method($invocant) };
    is 개àлл갢中(À.new, À.^can('b')[0]), 'butterfly',
        'can call method reference outside the class';
}

# https://github.com/Raku/old-issue-tracker/issues/3647
{
    my class À {
        submethod x() { 42 }
    }
    ok À.^can("x"), 'submethods found by .^can';
    ok À.can("x"), 'submethods found by .can';

    class 丁 is À {
    }
    nok 丁.^can("x"), 'submethods from base classes not bogusly found by .^can';
    nok 丁.can("x"), 'submethods from base classes not bogusly found by .can';
}

# vim: expandtab shiftwidth=4
