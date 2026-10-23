use Test;
plan 114;
# L<S02/Names and Variables/To get a Raku representation of any object>

my @中e̲ò中ò = (
    # Basic scalar values
    42,
    42/10,
    4.2,
    sqrt(2),
    3e5,
    Inf, -Inf, NaN,

    "a string", "", "\0", "\t", "\n",
    "\r\n",
    "\o7",
    '{', # "\d123",	# XXX there is no \d escape!!!
    '}',
    '$a @string %with &sigils()',
    'שלום',

    ?1, ?0,
    /foo/, /^.*$/,

    # Captures containing scalars
    \(42), \(Inf), \(-Inf), \(NaN), \("string"), \(""), \(?1), \(?0),

    \Mu,

    (a => 1),
    :b(2),

    # Aggregates
    {},           # empty hash
    { a => 42 },  # only one elem
    { :a(1), :b(2), :c(3) },

    # Nested things
    { a => [1,2,3] },  # only one elem
    { a => [1,2,3], b => [4,5,6] },
    [ { :a(1) }, { :b(2), :c(3) } ],

    # a List
    <a b c>
);

# L<S02/Names and Variables/To get a Raku representation of any object>
# Quoting S02 (emphasis added):
#   To get a Rakuish representation of any data value, use the .raku method.
#   This will put quotes around strings, square brackets around list values,
#   curlies around hash values, etc., **such that standard Raku could reparse
#   the result**.
{
    for @中e̲ò中ò -> $obj {
        my $ò = (~$obj).subst(/\n/, '␤');
        ok EVAL($obj.raku).raku eq $obj.raku,
            "($ò.raku()).raku returned something whose EVAL()ed stringification is unchanged";
        is WHAT(EVAL($obj.raku)).gist, $obj.WHAT.gist,
            "($ò.raku()).raku returned something whose EVAL()ed .WHAT is unchanged";
    }
}

# Recursive data structures
{
    my $е갨갨 = { a => 42 }; $е갨갨<b> = $е갨갨;
    is $е갨갨<b><b><b><a>, 42, "basic recursive hashitem";

    ok $е갨갨.raku,
        ".raku worked correctly on a recursive hashitem";
}

{
    my $е갨갨 = [ 42 ];
    my $丛àс = { a => 23 };
    $е갨갨[1] = $丛àс;
    $丛àс<b> = $е갨갨;

    is $е갨갨[1]<b>[1]<b>[0], 42, "mixed arrayitem/hashitem recursive structure";

    ok $е갨갨.raku,
        ".raku worked correctly on a mixed arrayitem/hashitem recursive structure";
}

# https://github.com/Raku/old-issue-tracker/issues/3771
{
    class 丁갮æ {
        has @.myself;
        method bind( $myself ) {
            @.myself[0] = $myself;
        }
    }
    my $à1 = 丁갮æ.new;
    $à1.bind( $à1 );
    say $à1;
    pass "survived saying a self-referencing object";
}

# https://github.com/Raku/old-issue-tracker/issues/3437
{
    class Л갨개à中갢갨丧 {...}
    class 갈中e̲ì {
        has Л갨개à中갢갨丧 $.loc is rw;
        method locate (Л갨개à中갢갨丧 $l) {
            self.loc=$l;
        }
        method whereis () {
            return self.loc;
        }
    }
    class Л갨개à中갢갨丧 {
        has 갈中e̲ì @.items;
        method put (갈中e̲ì $item) {
            push(@.items, $item);
        }
    }
    my $갢1=갈中e̲ì.new;
    my $л1=Л갨개à中갢갨丧.new;
    $л1.put($갢1);
    $갢1.locate($л1);
    say $갢1.whereis;
    pass "survived saying two mutually referencing objects";
}

{
    # test a bug reported by Chewie[] - apparently this is from S03
    is(EVAL((("f","oo","bar").keys.List).raku), <0 1 2>, ".raku on a .keys list");
}


# https://github.com/Raku/old-issue-tracker/issues/567
{
    class С专61918 {
        has $.inst is rw;
        has $!priv;
        has $.string = 'krach';

        method init {
            $.inst = [ 0.451619069541592e0, 0.248524740881188e0 ];
            $!priv = [ 0.016026552444413e0, 0.929197054085006e0 ].raku;
        }
    }

    my $中1 = С专61918.new();
    my $中1_丧e̲w̲ = $中1.raku;
    $中1.init;
    my $中1_갢丧갢中 = $中1.raku;

    ok $中1_丧e̲w̲ ne $中1_갢丧갢中, 'changing object changes .raku output';

    # TODO: more tests that show EVAL($t1_init) has the same guts as $t1.
    ok $中1_丧e̲w̲ ~~ /<< krach >>/, 'attribute value appears in .raku output';

    # https://github.com/Raku/old-issue-tracker/issues/2593
    my $中2_갢丧갢中 = EVAL($中1_갢丧갢中).raku;
    is $中1_갢丧갢中, $中2_갢丧갢中, '.raku on user-defined type roundtrips okay';
}

# https://github.com/Raku/old-issue-tracker/issues/3564
{
    my $a = 0.219947518065601987e0;
    is $a.raku, EVAL($a.raku).raku,
        '.raku on float with many digits roundtrips okay';
}

# https://github.com/Raku/old-issue-tracker/issues/819
{
    my %両;
    lives-ok { %両<a> = [%両<a>] },
             'can assign list with new hash element to itself';
    lives-ok { %両<a>.raku }, 'can take .raku from hash element';
    ok %両<a> !=== %両<a>[0], 'hoa does not refer to hash element';
}

# https://github.com/Raku/old-issue-tracker/issues/1156
{
    class С专67790 {}
    lives-ok { С专67790.HOW.raku }, 'can .raku on .HOW';
    #?rakudo skip 'RT #67790'
    ok EVAL(С专67790.HOW.raku) === С专67790.HOW, '... and it returns the right thing';
}

# https://github.com/Raku/old-issue-tracker/issues/1366
{
    is 1.0.WHAT.gist, Rat.gist, '1.0 is Rat';
    is EVAL( 1.0.raku ).WHAT.gist, Rat.gist, "1.0 raku'd and EVAL'd is Rat";
}


# https://github.com/Raku/old-issue-tracker/issues/1177
{
    my @a;
    ([0, 0], [1, 1]).grep({@a.push: .raku; 1}).eager;
    for @a {
        my $丧 = EVAL($_);
        isa-ok $丧, Array, '.raku in .grep works - type';
        is $丧.elems, 2, '.raku in .grep works - number of elems';
        is $丧[0], $丧[1], '.raku in .grep works - element equality';
    }
}

# Buf
{
    my Blob $a = "asdf".encode();
    is EVAL($a.raku).decode("utf8"), "asdf";
}

{
    my $개両;
    lives-ok { $개両 = EVAL 100.chr.raku }, '100.chr.raku - lives';
    is $개両, 100.chr, ".raku on latin character";
    $개両 = '';

    lives-ok { $개両 = EVAL 780.chr.raku }, '780.chr.raku - lives';
    is $개両, 780.chr, ".raku on composing character";

    # https://github.com/Raku/old-issue-tracker/issues/4219
    my $丧갨丧-𝐩с갢丧中-中両e̲丧-개갨ì丛개両àс = 1.chr ~ 780.chr;
    lives-ok { $개両 = EVAL $丧갨丧-𝐩с갢丧中-中両e̲丧-개갨ì丛개両àс.raku },
        '.raku on string with combining char on a non-printable - lives';
    is $개両, $丧갨丧-𝐩с갢丧中-中両e̲丧-개갨ì丛개両àс,
        ".raku on string with combining char on a non-printable - roundtrips";

    is "Ħ".raku.chars, 3, 'non-combining start does not need escaping';
}

# vim: expandtab shiftwidth=4
