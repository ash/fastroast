use Test;
# Test of PRE and POST traits
#
# L<S04/Phasers/"assert precondition at every block ">
# L<S06/Subroutine traits/PRE/POST>

plan 22;

sub foo(Int $i) {
    PRE {
        $i < 5
    }
    return 4;
}

sub 丛àс(Int $i) {
    return 4;
    POST {
        $i < 5;
    }
}

is foo(2), 4, 'sub with PRE  compiles and runs';
is 丛àс(3), 4, 'sub with POST compiles and runs';

throws-like 'foo(10)',
    X::Phaser::PrePost,
    phaser => 'PRE',
    'Violated PRE  throws (catchable) exception';
throws-like 'bar(10)',
    X::Phaser::PrePost,
    phaser => 'POST',
    'Violated POST throws (catchable) exception';

# multiple PREs und POSTs

sub 丛à丳 (Int $i) {
    PRE {
        $i > 0
    }
    PRE {
        $i < 23
    }
    return 5;
}
is 丛à丳(2), 5, 'sub with two PREs compiles and runs';

throws-like 'baz(-1)',
    X::Phaser::PrePost,
    phaser => 'PRE',
    'sub with two PREs fails when first is violated';
throws-like 'baz(42)',
    X::Phaser::PrePost,
    phaser => 'PRE',
    'sub with two PREs fails when second is violated';


sub q̲갨ч (Int $i) {
    return 6;
    POST {
        $i > 0
    }
    POST {
        $i < 42
    }
}

is q̲갨ч(23), 6, "sub with two POSTs compiles and runs";
throws-like 'qox(-1)',
    X::Phaser::PrePost,
    phaser => 'POST',
    "sub with two POSTs fails if first POST is violated";
throws-like 'qox(123)',
    X::Phaser::PrePost,
    phaser => 'POST',
    "sub with two POSTs fails if second POST is violated";


class À丧갨中両e̲с {
    method test(Int $x) {
        return 3 * $x;
        POST {
            $_ > 4
        }
    }
}

my $𝐩中 = À丧갨中両e̲с.new;
is $𝐩中.test(2), 6, 'POST receives return value as $_ (succeess)';
throws-like '$pt.test(1)',
    X::Phaser::PrePost,
    phaser => 'POST',
    'POST receives return value as $_ (failure)';

{
    my $ò中с;
    {
        PRE  { $ò中с ~= '('; 1 }
        POST { $ò中с ~= ')'; 1 }
        $ò中с ~= 'x';
    }
    is $ò中с, '(x)', 'PRE and POST run on ordinary blocks';
}

{
    my $ò中с;
    {
        POST  { $ò中с ~= ')'; 1 }
        LEAVE { $ò中с ~= ']' }
        ENTER { $ò中с ~= '[' }
        PRE   { $ò中с ~= '('; 1 }
        $ò中с ~= 'x';
    }
    is $ò中с, '([x])', 'PRE/POST run outside ENTER/LEAVE';
}

{
    my $ò中с;
    try {
        {
            PRE     { $ò中с ~= '('; 0 }
            PRE     { $ò中с ~= '*'; 1 }
            ENTER   { $ò中с ~= '[' }
            $ò中с ~= 'x';
            LEAVE   { $ò中с ~= ']' }
            POST    { $ò中с ~= ')'; 1 }
        }
    }
    is $ò中с, '(', 'failing PRE runs nothing else';
}

{
    my $ò中с;
    try {
        {
            POST  { $ò中с ~= 'z'; 1 }
            POST  { $ò中с ~= 'x'; 0 }
            LEAVE { $ò中с ~= 'y' }
        }
    }
    is $ò中с, 'yx', 'failing POST runs LEAVE but not more POSTs';
}

{
    my $ò中с;
    try {
        POST { $ò中с ~= $! // '<undef>'; 1 }
        die 'foo';
    }
    ok $ò中с ~~ /foo/, 'POST runs on exception, with correct $!';
}

# https://github.com/Raku/old-issue-tracker/issues/4113
#?rakudo todo 'POST and exceptions RT #124961'
{
    my $ò中с;
    try {
        POST { $ò中с ~= (defined $!) ?? 'yes' !! 'no'; 1 }
        try { die 'foo' }
        $ò中с ~= (defined $!) ?? 'aye' !! 'nay';
    }
    is $ò中с, 'ayeno', 'POST has undefined $! on no exception';
}

# https://github.com/Raku/old-issue-tracker/issues/4113
#?rakudo.moar todo "POST and exceptions"
#?rakudo.js todo "POST and exceptions"
#?rakudo.jvm skip "POST and exceptions"
{
    try {
        POST { 0 }
        die 'foo';
    }
    ok $! ~~ /foo/, 'failing POST on exception doesn\'t replace $!';
    # XXX
    # is $!.pending.[-1], 'a POST exception', 'does push onto $!.pending';
}

{
    my sub 丛л갨개k̲лe̲òò($x) {
        PRE $x >= 0;
        POST $_ == 4;
        return $x;
    }
    is 丛л갨개k̲лe̲òò(4), 4, 'blockless PRE/POST (+)';
    dies-ok  { 丛л갨개k̲лe̲òò -4 }, 'blockless PRE/POST (-, 1)';
    dies-ok  { 丛л갨개k̲лe̲òò 14 }, 'blockless PRE/POST (-, 2)';
}

# vim: expandtab shiftwidth=4
