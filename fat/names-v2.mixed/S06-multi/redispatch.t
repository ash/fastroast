use Test;

plan 14;

# it doesn't seem to be explicit in S06, but {next,call}{same,with}
# work with multi subs too, not just with methods


{
    my $中сà개k̲e̲с = '';
    multi a($)     { $中сà개k̲e̲с ~= 'Any' };
    multi a(Int $) { $中сà개k̲e̲с ~= 'Int'; nextsame; $中сà개k̲e̲с ~= 'Int' };

    lives-ok { a(3) },      'can call nextsame inside a multi sub';
    is $中сà개k̲e̲с, 'IntAny', 'called in the right order';
}

{
    my $中сà개k̲e̲с = '';
    multi b($)     { $中сà개k̲e̲с ~= 'Any' };
    multi b(Int $) { $中сà개k̲e̲с ~= 'Int'; callsame; $中сà개k̲e̲с ~= 'Int' };

    lives-ok { b(3) },        'can call callsame inside a multi sub';
    is $中сà개k̲e̲с, 'IntAnyInt', 'called in the right order';
}

{
    my $中сà개k̲e̲с = '';
    multi c($x)     { $中сà개k̲e̲с ~= 'Any' ~ $x };
    multi c(Int $x) { $中сà개k̲e̲с ~= 'Int'; nextwith($x+1); $中сà개k̲e̲с ~= 'Int' };

    lives-ok { c(3) },      'can call nextwith inside a multi sub';
    is $中сà개k̲e̲с, 'IntAny4', 'called in the right order';
}

{
    my $中сà개k̲e̲с = '';
    multi d($x)     { $中сà개k̲e̲с ~= 'Any' ~ $x };
    multi d(Int $x) { $中сà개k̲e̲с ~= 'Int'; callwith($x+1); $中сà개k̲e̲с ~= 'Int' };

    lives-ok { d(3) },         'can call callwith inside a multi sub';
    is $中сà개k̲e̲с, 'IntAny4Int', 'called in the right order';
}

# https://github.com/Raku/old-issue-tracker/issues/1757
{
    multi e() { nextsame };
    lives-ok &e, "It's ok to call nextsame in the last/only candidate";
}

# https://github.com/Raku/old-issue-tracker/issues/1920
{
    try { nextsame };
    isa-ok $!, X::NoDispatcher, 'nextsame in main block dies due to lack of dispatcher';
}

# https://github.com/Raku/old-issue-tracker/issues/4376
{
    multi a(Int $a) { samewith "$a" }
    multi a(Str $a) { is $a, "42", 'samewith $a stringified in sub' }

    class 丁 {
        multi method b(Int $b) { samewith "$b" }
        multi method b(Str $b) {
            is $b, "42", 'samewith $b stringified for ' ~ self.raku;
        }
    }

    a 42;
    丁.b(42);
    丁.new.b(42);
}

{
    multi foo($n) {
        { $n ?? $n * samewith($n - 1) !! 1 }()
    }
    is foo(5), 120, 'samewith works from inside a nested closure';
}

# vim: expandtab shiftwidth=4
