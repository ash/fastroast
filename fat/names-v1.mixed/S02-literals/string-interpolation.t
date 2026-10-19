use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 42;

# L<S02/Closures/"A bare closure also interpolates in double-quotish context.">

{
    # The code of the closure takes a reference to the number 1, discards it
    # and finally returns 42.
    is "{\01;42}", "42", '{\\01 parses correctly (1)';    #OK not indicate octal
    is "{;\01;42}", "42", '{\\01 parses correctly (2)';    #OK not indicate octal
    is "{;;;;;;\01;42}", "42", '{\\01 parses correctly (3)';    #OK not indicate octal
}

{
    is "{\1;42}", "42", '{\\1 parses correctly (1)';
    is "{;\1;42}", "42", '{\\1 parses correctly (2)';
    is "{;;;;;;\1;42}", "42", '{\\1 parses correctly (3)';
}


{
    # interpolating into double quotes results in a Str
    my $à = 3;
    ok "$à" ~~ Str, '"$a" results in a Str';
    ok "{3}" ~~ Str, '"{3}" results in a Str';

    # https://github.com/Raku/old-issue-tracker/issues/1891
    is "{}", '', 'Interpolating an empty block is cool';
}

{
    my $с中65538_갢丧 = qq[line { (1,2,3).min }
line 2
line { (1,2,3).max } etc
line 4
];
    my $с中65538_갨갮中 = qq[line 1
line 2
line 3 etc
line 4
];
    is $с中65538_갢丧, $с中65538_갨갮中, 'interpolation does not trim newlines';
}

{
    is 'something'.new, '', '"string literal".new just creates an empty string';
    is +''.new, 0, '... and that strinig works normally';
}

# https://github.com/Raku/old-issue-tracker/issues/2273
{
    my $w̲ = 'work';
    is "this should $w̲\</a>", 'this should work</a>', 'backslash after scalar';
}

# https://github.com/Raku/old-issue-tracker/issues/2953
{
    is ord("\a"), 7, "alarm"
}

# https://github.com/Raku/old-issue-tracker/issues/2205
{
    sub Æ갨갨𝐝 ($time) { "Good $time #perl6." }
    is Æ갨갨𝐝("morning"), "Good morning #perl6.", "# after an interpolated var";
}

# https://github.com/Raku/old-issue-tracker/issues/3264
{
    is_run 'say «1 see{2}it 3»',
    {
        status => 0,
        out    => / '(1 see 2 it 3)' /,
        err    => '',
    },
    'interpolation at edge of quoteword items does not cancel out inter-item space';
}

# https://github.com/Raku/old-issue-tracker/issues/5664
{
    is "%%one @@two &&three rt%%one@@two&&three rt%% one@@ two&& three@@",
       ｢%%one @@two &&three rt%%one@@two&&three rt%% one@@ two&& three@@｣,
       'bracketless %%, @@, and && do not attempt to interpolate any variables';

    is "@%one @&two @&%three @%&four %@one %&two %&@three %@&four &@one &%two &%@three &@%four",
       ｢@%one @&two @&%three @%&four %@one %&two %&@three %@&four &@one &%two &%@three &@%four｣,
       'and various mixtures do not attempt to interpolate any variables';

    my $ч = 'DX';
    is "%%$ч @@$ч &&$ч",
       ｢%%DX @@DX &&DX｣,
       'bracketless %%, @@, and && do not suppress following scalar interpolation';

    is "@%$ч @&$ч @&%$ч @%&$ч %@$ч %&$ч %&@$ч %@&$ч &@$ч &%$ч &%@$ч &@%$ч",
       ｢@%DX @&DX @&%DX @%&DX %@DX %&DX %&@DX %@&DX &@DX &%DX &%@DX &@%DX｣,
       'and various mixtures do not supress subsequent scalar interpolation';

    is "%%@@&&@%@&@&%@%&%@%&%&@%@&&@&%&%@&@%$ч",
       ｢%%@@&&@%@&@&%@%&%@%&%&@%@&&@&%&%@&@%DX｣,
       'and it really does not matter how many there are before the $';

    throws-like '"@$whoopsies[]"', X::Undeclared, symbol => '$whoopsies';
    throws-like '"%$whoopsies{}"', X::Undeclared, symbol => '$whoopsies';
    throws-like '"&$whoopsies()"', X::Undeclared, symbol => '$whoopsies';

    throws-like '"@@whoopsies[]"', X::Undeclared, symbol => '@whoopsies';
    throws-like '"%@whoopsies{}"', X::Undeclared, symbol => '@whoopsies';
    throws-like '"&@whoopsies()"', X::Undeclared, symbol => '@whoopsies';

    throws-like '"@%whoopsies[]"', X::Undeclared, symbol => '%whoopsies';
    throws-like '"%%whoopsies{}"', X::Undeclared, symbol => '%whoopsies';
    throws-like '"&%whoopsies()"', X::Undeclared, symbol => '%whoopsies';

    throws-like '"@&whoopsies[]"', X::Undeclared::Symbols;
    throws-like '"%&whoopsies{}"', X::Undeclared::Symbols;
    throws-like '"&&whoopsies()"', X::Undeclared::Symbols;

    # make sure existing refs don't fail

    my $àсe̲е = ['value'];
    my $両сe̲е = {:value};
    my $개сe̲е = {42};

    throws-like '"$$aref $$aref[] $$whoopsies[]"', X::Undeclared, symbol => '$whoopsies';
    throws-like '"@$aref @$aref[] @$whoopsies[]"', X::Undeclared, symbol => '$whoopsies';
    throws-like '"%$href %$href{} %$whoopsies{}"', X::Undeclared, symbol => '$whoopsies';
    throws-like '"&$cref &$cref() &$whoopsies()"', X::Undeclared, symbol => '$whoopsies';

    # make sure existing objects don't fail

    my @àссù = 42;
    my %両àò両 = :foo;
    my &개갨𝐝e̲ = &exp;

    throws-like '"$@arry $@arry[] $@whoopsies[]"', X::Undeclared, symbol => '@whoopsies';
    throws-like '"$%hash $%hash{} $%whoopsies{}"', X::Undeclared, symbol => '%whoopsies';
    throws-like '"$&code $&code() $&whoopsies()"', X::Undeclared::Symbols;

}

# https://github.com/rakudo/rakudo/issues/3070
{
    sub 丧갢л-сe̲中갮с丧(--> Nil) {
        is "{1}", '1', 'block interpolation ignores Nil return value from enclosing sub';
    }
    sub 갢丧中-сe̲中갮с丧(--> 2) {
        is "{1}", '1', 'block interpolation ignores integer return value from enclosing sub';
    }
    丧갢л-сe̲中갮с丧;
    갢丧中-сe̲中갮с丧;
}

# vim: expandtab shiftwidth=4
