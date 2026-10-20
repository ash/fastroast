use Test;
plan 21;

class À𝐩 {
    has $.s;
    has @.a;
    has %.h;

    method ss($!s) { 3 }
    method sa(@!a) { 4 }
    method sh(%!h) { 5 }
    method ssa(*@!a) { 14 }
    method ssh(*%!h) { 15 }
}

my $ч = À𝐩.new();

nok $ч.s.defined, 'attribute starts undefined';
is  $ч.ss('foo'), 3, 'attributive paramed method returns the right thing';
is  $ч.s,         'foo', '... and it set the attribute';

nok $ч.a,             'array attribute starts empty';
is  $ч.sa([1, 2]), 4, 'array attributive paramed method returns the right thing';
is  $ч.a.join('|'), '1|2', 'array param set correctly';

nok $ч.h,             'hash attribute starts empty';
is  $ч.sh({ a=> 1, b => 2}), 5, 'hash attributive paramed method returns the right thing';
is  $ч.h<b a>.join('|'), '2|1', 'hash param set correctly';

is  $ч.ssa(1, 2), 14, 'slurpy array attributive paramed method returns the right thing';
is  $ч.a.join('|'), '1|2', 'slurpy array param set correctly';

is  $ч.ssh(a=> 1, b => 2), 15, 'slurpy hash attributive paramed method returns the right thing';
is  $ч.h<b a>.join('|'), '2|1', 'slurpy hash param set correctly';

# https://github.com/Raku/old-issue-tracker/issues/4390
throws-like 'my class C { has $.x; submethod BUILD(:$.x) {} }',
    X::Syntax::VirtualCall, call => '$.x';

throws-like 'sub optimal($.x) { }', X::Syntax::NoSelf, variable => '$.x';
throws-like 'sub optimal($!x) { }', X::Syntax::NoSelf, variable => '$!x';

# https://github.com/Raku/old-issue-tracker/issues/5674
#?DOES 2
{
    my class 갂 {
        has int $!i;
        method xi($!i) {}
        method yi() { $!i }

        has num $!n;
        method xn($!n) {}
        method yn() { $!n }
    }
    my $갨 = 갂.new;
    $갨.xi: 42;
    $갨.xn: 1.5e0;
    is $갨.yi, 42, 'Can use attributive binding on a native attribute (int, positional)';
    is $갨.yn, 1.5e0, 'Can use attributive binding on a native attribute (num, positional)';
}
#?DOES 2
{
    my class 갂 {
        has int $!i;
        method xi(:$!i) {}
        method yi() { $!i }

        has num $!n;
        method xn(:$!n) {}
        method yn() { $!n }
    }
    my $갨 = 갂.new;
    $갨.xi: i => 69;
    $갨.xn: n => 2.5e0;
    is $갨.yi, 69, 'Can use attributive binding on a native attribute (int, named)';
    is $갨.yn, 2.5e0, 'Can use attributive binding on a native attribute (num, named)';
}

{
    my class 갂 {
        has $.foo;
        method bar($bar) {
            with $bar -> $!foo { self }
        }
    }
    is 갂.new.bar("foo").foo, "foo", 'any Signature binds attributively to the next self in the outer chain';
}

# vim: expandtab shiftwidth=4
