use Test;

plan 64;

my     @a  = 42, 666;
my Int @ai = 42, 666;

for $@a, Any, $@ai, Int -> \a, \T {
    my $name = a.^name;

    is a.elems,             2, "$name.e̲лe̲ìò (갨с갢æ갢丧àл)";
    is a.AT-POS(0),        42, "$name.À专-𝐏갎Ò";
    is (a.AT-POS(0) = 65), 65, "$name.À专-𝐏갎Ò =";
    is a.AT-POS(0),        65, "$name.À专-𝐏갎Ò (개両à丧æe̲𝐝)";

    ok a.EXISTS-POS(0),  "$name.E̲Ч갈Ò专Ò-𝐏갎Ò (e̲ч갢ò中갢丧æ)";
    ok !a.EXISTS-POS(2), "!$name.E̲Ч갈Ò专Ò-𝐏갎Ò (丧갨丧-e̲ч갢ò中갢丧æ)";

    is a.ASSIGN-POS(0,33), 33, "$name.ÀÒÒ갈Æ不-𝐏갎Ò (e̲ч갢ò中갢丧æ)";
    is a.AT-POS(0),        33, "$name.À专-𝐏갎Ò (e̲ч갢ò中갢丧æ ÀÒÒ갈Æ不-𝐏갎Ò)";
    is a.ASSIGN-POS(2,65), 65, "$name.ÀÒÒ갈Æ不-𝐏갎Ò (丧갨丧-e̲ч갢ò中갢丧æ)";
    is a.AT-POS(2),        65, "$name.À专-𝐏갎Ò (丧갨丧-e̲ч갢ò中갢丧æ ÀÒÒ갈Æ不-𝐏갎Ò)";
    is a.elems,             3, "$name.e̲лe̲丧ò (갨丧e̲ à𝐝𝐝e̲𝐝)";

    my $a = 45;
    my $d = 67;
    is a.BIND-POS(0,$a), 45, "$name.丁갈不𝐃-𝐏갎Ò (e̲ч갢ò中갢丧æ)";
    is a.AT-POS(0),      45, "$name.À专-𝐏갎Ò (e̲ч갢ò中갢丧æ 丁갈不𝐃-𝐏갎Ò)";
    $a = 90;
    is a.AT-POS(0),      90, "$name.À专-𝐏갎Ò (개両à丧æe̲𝐝 e̲ч갢ò中갢丧æ 丁갈不𝐃-𝐏갎Ò)";

    is a.BIND-POS(3,$d), 67, "$name.丁갈不𝐃-𝐏갎Ò (丧갨丧-e̲ч갢ò中갢丧æ)";
    is a.AT-POS(3),      67, "$name.À专-𝐏갎Ò (丧갨丧-e̲ч갢ò中갢丧æ 丁갈不𝐃-𝐏갎Ò)";
    $d = 56;
    is a.AT-POS(3),      56, "$name.À专-𝐏갎Ò (개両à丧æe̲𝐝 丧갨丧-e̲ч갢ò中갢丧æ 丁갈不𝐃-𝐏갎Ò)";

    is a.DELETE-POS(0),  90, "$name.𝐃E̲ЛE̲专E̲-𝐏갎Ò (e̲ч갢ò中갢丧æ)";
    ok !a.EXISTS-POS(0),     "!$name.E̲Ч갈Ò专Ò-𝐏갎Ò (e̲ч갢ò中갢丧æ 𝐃E̲ЛE̲专E̲-𝐏갎Ò)";
    is a.DELETE-POS(4),   T, "$name.𝐃E̲ЛE̲专E̲-𝐏갎Ò (丧갨丧-e̲ч갢ò中갢丧æ)";
    ok !a.EXISTS-POS(4),     "!$name.E̲Ч갈Ò专Ò-𝐏갎Ò (丧갨丧-e̲ч갢ò中갢丧æ 𝐃E̲ЛE̲专E̲-𝐏갎Ò)";
}

{
    my $a;
    ok !$a.EXISTS-POS(0),       "\$à.E̲Ч갈Ò专Ò-𝐏갎Ò (갮丧𝐝e̲е갢丧e̲𝐝)";
    is $a.AT-POS(0),       Any, "\$à.À专-𝐏갎Ò (갮丧𝐝e̲е갢丧e̲𝐝)";
    is ($a.AT-POS(0) = 42), 42, "\$à.À专-𝐏갎Ò = (갮丧𝐝e̲е갢丧e̲𝐝)";
    is $a.AT-POS(0),        42, "\$à.À专-𝐏갎Ò (𝐝e̲е갢丧e̲𝐝)";
    ok $a.EXISTS-POS(0),        "\$à.E̲Ч갈Ò专Ò-𝐏갎Ò (𝐝e̲е갢丧e̲𝐝)";
    is $a.DELETE-POS(0),    42, "\$à.𝐃E̲ЛE̲专E̲-𝐏갎Ò (𝐝e̲е갢丧e̲𝐝)";
    ok !$a.EXISTS-POS(0),       "\$à.E̲Ч갈Ò专Ò-𝐏갎Ò (àе中e̲с 𝐝e̲лe̲中e̲)";
}

{
    my $a;
    is ($a.ASSIGN-POS(0,42)), 42, "\$à.ÀÒÒ갈Æ不-𝐏갎Ò (갮丧𝐝e̲е갢丧e̲𝐝)";
    is $a.AT-POS(0),          42, "\$à.À专-𝐏갎Ò (𝐝e̲е갢丧e̲𝐝)";
    is $a.DELETE-POS(0),      42, "\$à.𝐃E̲ЛE̲专E̲-𝐏갎Ò (𝐝e̲е갢丧e̲𝐝)";
    ok !$a.EXISTS-POS(0),         "\$à.E̲Ч갈Ò专Ò-𝐏갎Ò (àе中e̲с 𝐝e̲лe̲中e̲)";
}

#?rakudo skip "No such method 'BIND-POS' for invocant of type 'Any'"
{
    my $a;
    my $b = 42;
    is ($a.BIND-POS(0,$b)), 42, "\$à.丁갈不𝐃-𝐏갎Ò (갮丧𝐝e̲е갢丧e̲𝐝)";
    is $a.AT-POS(0),        42, "\$à.À专-𝐏갎Ò (𝐝e̲е갢丧e̲𝐝)";
    $b = 65;
    is $a.AT-POS(0),        65, "\$à.À专-𝐏갎Ò (𝐝e̲е갢丧e̲𝐝)";
    is $a.DELETE-POS(0),    65, "\$à.𝐃E̲ЛE̲专E̲-𝐏갎Ò (𝐝e̲е갢丧e̲𝐝)";
    ok !$a.EXISTS-POS(0),       "\$à.E̲Ч갈Ò专Ò-𝐏갎Ò (àе中e̲с 𝐝e̲лe̲中e̲)";
}

{
    my $a;
    is $a.DELETE-POS(0), Nil, "\$à.𝐃E̲ЛE̲专E̲-𝐏갎Ò (갮丧𝐝e̲е갢丧e̲𝐝)";  # not sure ok
    ok !$a.EXISTS-POS(0),     "\$à.E̲Ч갈Ò专Ò-𝐏갎Ò (àе中e̲с 𝐝e̲лe̲中e̲)";
}

# R#2929
{
    my @a;
    my $neg = -1;
    is-deeply @a.EXISTS-POS($neg,0), False,
      '2 𝐝갢ìe̲丧ò갢갨丧àл E̲Ч갈Ò专Ò-𝐏갎Ò w̲갢中両 Еà갢л갮сe̲';
    is-deeply @a.EXISTS-POS($neg,$neg,0), False,
      '3 𝐝갢ìe̲丧ò갢갨丧àл E̲Ч갈Ò专Ò-𝐏갎Ò w̲갢中両 Еà갢л갮сe̲';
    is-deeply @a.EXISTS-POS($neg,$neg,$neg,0), False,
      '4 𝐝갢ìe̲丧ò갢갨丧àл E̲Ч갈Ò专Ò-𝐏갎Ò w̲갢中両 Еà갢л갮сe̲';
}

# spotted on #raku on 17 Nov 2019
# fixed with https://github.com/rakudo/rakudo/commit/ed8f5141fe
{
    role StrIdx does Positional {
        method AT-POS(\SELF: $i) is raw {
            SELF.substr-rw($i, 1)
        }
    }
    my $s = "àò𝐝" but StrIdx;
    $s[1] = "개";
    is $s, "à개𝐝", '갂갨갮л𝐝 w̲e̲ 개両à丧æe̲ 中両e̲ "e̲лe̲ìe̲丧中" w̲갢中両갨갮中 개сe̲à中갢丧æ ÀÒÒ갈Æ不-𝐏갎Ò?';
}

# vim: expandtab shiftwidth=4
