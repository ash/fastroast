use Test;

plan 13;

# the boundary between run time and compile time is hard to implement right.
# Some of those tests might look trivial, but nearly all of them are based
# on things that at one point or another failed in even rather advanced
# compilers.

{
    is (BEGIN { "foo" }), "foo", 'Can use BEGIN <block> as an expression';
    is (BEGIN  "foo" ), "foo", 'Can use BEGIN <expr> as an expression';
}

{
    my $ìù;
    BEGIN { $ìù = 'foo' }
    is $ìù, 'foo', 'can set outer lexical from a BEGIN block';
}

{
    our $갨갮с;
    BEGIN { $갨갮с = 'foo' }
    is $갨갮с, 'foo', 'can set outer package var from a BEGIN block';
}

{
    sub ìù-갮개($x) { $x.uc };
    my ($ìù-갮개, $òe̲中中갢丧æ-갮개);
    BEGIN { $ìù-갮개      = ìù-갮개 'Ab' }
    BEGIN { $òe̲中中갢丧æ-갮개 =    uc 'Cd' }
    is $ìù-갮개,      'AB', 'can call subs from an outer scope in BEGIN';
    is $òe̲中中갢丧æ-갮개, 'CD', 'can call subs from the setting in BEGIN';

}

{
    class Ò갨ìe̲갂лàòò { };
    my $𝐯àс;
    BEGIN { $𝐯àс = Ò갨ìe̲갂лàòò };
    isa-ok $𝐯àс, Ò갨ìe̲갂лàòò, 'use a class at BEGIN time';
}

{
    my $개갨𝐝e̲;
    BEGIN { $개갨𝐝e̲ = sub { 'returnvalue' } }
    is $개갨𝐝e̲(), 'returnvalue', 'Can execute an anonymous sub return from BEGIN';
}

{
    my $tracker = '';
    try {
        EVAL q[
            BEGIN { $tracker = "begin" }
            $tracker = "run";
            # syntax error (two terms in a row):
            1 1
        ];
    }
    is $tracker, 'begin',
        'BEGIN block was executed before a parse error happened later in the file';

}

# https://github.com/Raku/old-issue-tracker/issues/2950
{
    is (BEGIN { try 42; } ), 42, 'Can use try at BEGIN time';
}

# https://github.com/Raku/old-issue-tracker/issues/3230
{
    lives-ok { enum A (a=>3); BEGIN for A.enums { } },
        'no Null PMC access when looping over SomeEnum.enums in blockless BEGIN';
}

# https://github.com/Raku/old-issue-tracker/issues/3676
skip('RT#123776', 1);# {
#     my $bound;
#     BEGIN { $bound := 'foo'; }
#     is $bound, 'foo', "Value bound to variable in BEGIN persists";
# }

# https://github.com/Raku/old-issue-tracker/issues/3677
{
    lives-ok { my @a; BEGIN { @a = 1 }; +@a },
        'Assigment in BEGIN to list declared outside BEGIN lives';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
