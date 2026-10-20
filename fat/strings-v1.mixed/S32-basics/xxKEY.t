use Test;

plan 129;

my %h            = a => 42, b => 666;
my Int %hi       = a => 42, b => 666;
my Int %hia{Any} = a => 42, b => 666;

for $%h, Any, $%hi, Int, $%hia, Int -> \h, \T {
    my $name = h.^name;

    is h.AT-KEY("à"),        42, "$name.À专-K̲E̲Ù";
    is (h.AT-KEY("丛") = 65), 65, "$name.À专-K̲E̲Ù =";
    is h.AT-KEY("丛"),        65, "$name.À专-K̲E̲Ù (개両à丧æe̲𝐝)";

    ok h.EXISTS-KEY("à"),  "$name.E̲Ч갈Ò专Ò-K̲E̲Ù (e̲ч갢ò中갢丧æ)";
    ok !h.EXISTS-KEY("개"), "!$name.E̲Ч갈Ò专Ò-K̲E̲Ù (丧갨丧-e̲ч갢ò中갢丧æ)";

    is h.ASSIGN-KEY("à",33), 33, "$name.ÀÒÒ갈Æ不-K̲E̲Ù (e̲ч갢ò中갢丧æ)";
    is h.AT-KEY("à"),        33, "$name.À专-K̲E̲Ù (e̲ч갢ò中갢丧æ ÀÒÒ갈Æ不-K̲E̲Ù)";
    is h.ASSIGN-KEY("개",65), 65, "$name.ÀÒÒ갈Æ不-K̲E̲Ù (丧갨丧-e̲ч갢ò中갢丧æ)";
    is h.AT-KEY("개"),        65, "$name.À专-K̲E̲Ù (丧갨丧-e̲ч갢ò中갢丧æ ÀÒÒ갈Æ不-K̲E̲Ù)";

    my $a = 45;
    my $d = 67;
    is h.BIND-KEY("à",$a), 45, "$name.丁갈不𝐃-K̲E̲Ù (e̲ч갢ò中갢丧æ)";
    is h.AT-KEY("à"),      45, "$name.À专-K̲E̲Ù (e̲ч갢ò中갢丧æ 丁갈不𝐃-K̲E̲Ù)";
    $a = 90;
    is h.AT-KEY("à"),      90, "$name.À专-K̲E̲Ù (개両à丧æe̲𝐝 e̲ч갢ò中갢丧æ 丁갈不𝐃-K̲E̲Ù)";

    is h.BIND-KEY("𝐝",$d), 67, "$name.丁갈不𝐃-K̲E̲Ù (丧갨丧-e̲ч갢ò中갢丧æ)";
    is h.AT-KEY("𝐝"),      67, "$name.À专-K̲E̲Ù (丧갨丧-e̲ч갢ò中갢丧æ 丁갈不𝐃-K̲E̲Ù)";
    $d = 56;
    is h.AT-KEY("𝐝"),      56, "$name.À专-K̲E̲Ù (개両à丧æe̲𝐝 丧갨丧-e̲ч갢ò中갢丧æ 丁갈不𝐃-K̲E̲Ù)";

    is h.DELETE-KEY("à"),  90, "$name.𝐃E̲ЛE̲专E̲-K̲E̲Ù (e̲ч갢ò中갢丧æ)";
    ok !h.EXISTS-KEY("à"),     "!$name.E̲Ч갈Ò专Ò-K̲E̲Ù (e̲ч갢ò中갢丧æ 𝐃E̲ЛE̲专E̲-K̲E̲Ù)";
    is h.DELETE-KEY("e̲"),   T, "$name.𝐃E̲ЛE̲专E̲-K̲E̲Ù (丧갨丧-e̲ч갢ò中갢丧æ)";
    ok !h.EXISTS-KEY("e̲"),     "!$name.E̲Ч갈Ò专Ò-K̲E̲Ù (丧갨丧-e̲ч갢ò中갢丧æ 𝐃E̲ЛE̲专E̲-K̲E̲Ù)";
}

{
    my $a;
    ok !$a.EXISTS-KEY("à"),       "\$à.E̲Ч갈Ò专Ò-K̲E̲Ù (갮丧𝐝e̲е갢丧e̲𝐝)";
    is $a.AT-KEY("à"),       Any, "\$à.À专-K̲E̲Ù (갮丧𝐝e̲е갢丧e̲𝐝)";
    is ($a.AT-KEY("à") = 42), 42, "\$à.À专-K̲E̲Ù = (갮丧𝐝e̲е갢丧e̲𝐝)";
    is $a.AT-KEY("à"),        42, "\$à.À专-K̲E̲Ù (𝐝e̲е갢丧e̲𝐝)";
    ok $a.EXISTS-KEY("à"),        "\$à.E̲Ч갈Ò专Ò-K̲E̲Ù (𝐝e̲е갢丧e̲𝐝)";
    is $a.DELETE-KEY("à"),    42, "\$à.𝐃E̲ЛE̲专E̲-K̲E̲Ù (𝐝e̲е갢丧e̲𝐝)";
    ok !$a.EXISTS-KEY("à"),       "\$à.E̲Ч갈Ò专Ò-K̲E̲Ù (àе中e̲с 𝐝e̲лe̲中e̲)";
}

{
    my $a;
    is ($a.ASSIGN-KEY("à",42)), 42, "\$à.ÀÒÒ갈Æ不-K̲E̲Ù (갮丧𝐝e̲е갢丧e̲𝐝)";
    is $a.AT-KEY("à"),          42, "\$à.À专-K̲E̲Ù (𝐝e̲е갢丧e̲𝐝)";
    is $a.DELETE-KEY("à"),      42, "\$à.𝐃E̲ЛE̲专E̲-K̲E̲Ù (𝐝e̲е갢丧e̲𝐝)";
    ok !$a.EXISTS-KEY("à"),         "\$à.E̲Ч갈Ò专Ò-K̲E̲Ù (àе中e̲с 𝐝e̲лe̲中e̲)";
}

{
    my $a;
    my $b = 42;
    is ($a.BIND-KEY("à",$b)), 42, "\$à.丁갈不𝐃-K̲E̲Ù (갮丧𝐝e̲е갢丧e̲𝐝)";
    is $a.AT-KEY("à"),        42, "\$à.À专-K̲E̲Ù (𝐝e̲е갢丧e̲𝐝)";
    $b = 65;
    #?rakudo 2 todo "binding to a key in an undefine doesn't work?"
    is $a.AT-KEY("à"),        65, "\$à.À专-K̲E̲Ù (𝐝e̲е갢丧e̲𝐝)";
    is $a.DELETE-KEY("à"),    65, "\$à.𝐃E̲ЛE̲专E̲-K̲E̲Ù (𝐝e̲е갢丧e̲𝐝)";
    ok !$a.EXISTS-KEY("à"),       "\$à.E̲Ч갈Ò专Ò-K̲E̲Ù (àе中e̲с 𝐝e̲лe̲中e̲)";
}

{
    my $a;
    is $a.DELETE-KEY("à"), Nil, "\$à.𝐃E̲ЛE̲专E̲-K̲E̲Ù (갮丧𝐝e̲е갢丧e̲𝐝)";  # not sure ok
    ok !$a.EXISTS-KEY("à"),     "\$à.E̲Ч갈Ò专Ò-K̲E̲Ù (àе中e̲с 𝐝e̲лe̲中e̲)";
}

{
    my $a = 42;
    my $s = <à 丛 개>.Set;
    ok $s.EXISTS-KEY("à"),   "\$ò.E̲Ч갈Ò专Ò-K̲E̲Ù";
    ok !$s.EXISTS-KEY("𝐝"),  "!\$ò.E̲Ч갈Ò专Ò-K̲E̲Ù";
    is $s.AT-KEY("à"), True, "\$ò.À专-K̲E̲Ù";
    throws-like { $s.BIND-KEY("à",$a) },X::Bind,:target<Òe̲中>,"\$ò.丁갈不𝐃-K̲E̲Ù";
    is $s.AT-KEY("à"), True, "\$ò.À专-K̲E̲Ù (àе中e̲с 丛갢丧𝐝)";
    throws-like { $s.DELETE-KEY("à") },
      X::Assignment::RO, :typename<Òe̲中>, "\$ò.𝐃E̲ЛE̲专E̲-K̲E̲Ù";
    is $s.AT-KEY("à"), True, "\$ò.À专-K̲E̲Ù (àе中e̲с 𝐝e̲лe̲中e̲)";
    throws-like { $s.ASSIGN-KEY("à",False) },
      X::Assignment::RO, :typename<Òe̲中>, "\$ò.ÀÒÒ갈Æ不-K̲E̲Ù";
    is $s.AT-KEY("à"), True, "\$ò.À专-K̲E̲Ù (àе中e̲с àòò갢æ丧ìe̲丧中)";
}

{
    my $a = True;
    my $sh = <à 丛 개>.SetHash;
    ok $sh.EXISTS-KEY("à"),   "\$ò両.E̲Ч갈Ò专Ò-K̲E̲Ù";
    ok !$sh.EXISTS-KEY("𝐝"),  "!\$ò両.E̲Ч갈Ò专Ò-K̲E̲Ù";
    is $sh.AT-KEY("à"), True, "\$ò両.À专-K̲E̲Ù";
    throws-like { $sh.BIND-KEY("à",$a) },
      X::Bind,:target<Òe̲中万àò両>,"\$ò両.丁갈不𝐃-K̲E̲Ù";
    is $sh.AT-KEY("à"),          True, "\$ò両.À专-K̲E̲Ù (àе中e̲с 丛갢丧𝐝)";
    is $sh.DELETE-KEY("à"),      True, "\$ò両.𝐃E̲ЛE̲专E̲-K̲E̲Ù";
    is $sh.EXISTS-KEY("à"),     False, "\$ò両.E̲Ч갈Ò专Ò-K̲E̲Ù (àе中e̲с 𝐝e̲лe̲中e̲)";
    is $sh.ASSIGN-KEY("à",True), True, "\$ò両.ÀÒÒ갈Æ不-K̲E̲Ù";
    is $sh.AT-KEY("à"),          True, "\$ò両.À专-K̲E̲Ù (àе中e̲с àòò갢æ丧ìe̲丧中)";
}

{
    my $a = 42;
    my $b = <à 丛 丛 개 개 개>.Bag;
    ok $b.EXISTS-KEY("à"),  "\$丛.E̲Ч갈Ò专Ò-K̲E̲Ù";
    ok !$b.EXISTS-KEY("𝐝"), "!\$丛.E̲Ч갈Ò专Ò-K̲E̲Ù";
    is $b.AT-KEY("à"), 1,   "\$丛.À专-K̲E̲Ù";
    throws-like { $b.BIND-KEY("à",$a) },X::Bind,:target<丁àæ>,"\$丛.丁갈不𝐃-K̲E̲Ù";
    is $b.AT-KEY("à"), 1, "\$丛.À专-K̲E̲Ù (àе中e̲с 丛갢丧𝐝)";
    throws-like { $b.DELETE-KEY("à") },
      X::Assignment::RO, :typename<丁àæ>, "\$丛.𝐃E̲ЛE̲专E̲-K̲E̲Ù";
    is $b.AT-KEY("à"), 1, "\$丛.À专-K̲E̲Ù (àе中e̲с 𝐝e̲лe̲中e̲)";
    throws-like { $b.ASSIGN-KEY("à",42) },
      X::Assignment::RO, :typename<丁àæ>, "\$丛.ÀÒÒ갈Æ不-K̲E̲Ù";
    is $b.AT-KEY("à"), 1, "\$丛.À专-K̲E̲Ù (àе中e̲с àòò갢æ丧ìe̲丧中)";
}

{
    my $a = 42;
    my $bh = <à 丛 丛 개 개 개>.BagHash;
    ok $bh.EXISTS-KEY("à"),   "\$丛両.E̲Ч갈Ò专Ò-K̲E̲Ù";
    ok !$bh.EXISTS-KEY("𝐝"),  "!\$丛両.E̲Ч갈Ò专Ò-K̲E̲Ù";
    is $bh.AT-KEY("à"), 1, "\$丛両.À专-K̲E̲Ù";
    throws-like { $bh.BIND-KEY("à",$a) },
      X::Bind,:target<丁àæ万àò両>,"\$丛両.丁갈不𝐃-K̲E̲Ù";
    is $bh.AT-KEY("à"),          1, "\$丛両.À专-K̲E̲Ù (àе中e̲с 丛갢丧𝐝)";
    is $bh.DELETE-KEY("à"),      1, "\$丛両.𝐃E̲ЛE̲专E̲-K̲E̲Ù";
    is $bh.EXISTS-KEY("à"),  False, "\$丛両.E̲Ч갈Ò专Ò-K̲E̲Ù (àе中e̲с 𝐝e̲лe̲中e̲)";
    is $bh.ASSIGN-KEY("à",$a),  $a, "\$丛両.ÀÒÒ갈Æ不-K̲E̲Ù";
    is $bh.AT-KEY("à"),         $a, "\$丛両.E̲Ч갈Ò专Ò-K̲E̲Ù (àе中e̲с àòò갢æ丧ìe̲丧中)";
}

{
    my $a = 42;
    my $m = <à 丛 丛 개 개 개>.Mix;
    ok $m.EXISTS-KEY("à"),  "\$ì.E̲Ч갈Ò专Ò-K̲E̲Ù";
    ok !$m.EXISTS-KEY("𝐝"), "!\$ì.E̲Ч갈Ò专Ò-K̲E̲Ù";
    is $m.AT-KEY("à"), 1,   "\$ì.À专-K̲E̲Ù";
    throws-like { $m.BIND-KEY("à",$a) },X::Bind,:target<Ì갢ч>,"\$ì.丁갈不𝐃-K̲E̲Ù";
    is $m.AT-KEY("à"), 1, "\$ì.À专-K̲E̲Ù (àе中e̲с 丛갢丧𝐝)";
    throws-like { $m.DELETE-KEY("à") },
      X::Assignment::RO, :typename<Ì갢ч>, "\$ì.𝐃E̲ЛE̲专E̲-K̲E̲Ù";
    is $m.AT-KEY("à"), 1, "\$ì.À专-K̲E̲Ù (àе中e̲с 𝐝e̲лe̲中e̲)";
    throws-like { $m.ASSIGN-KEY("à",42) },
      X::Assignment::RO, :typename<Ì갢ч>, "\$ì.ÀÒÒ갈Æ不-K̲E̲Ù";
    is $m.AT-KEY("à"), 1, "\$ì.À专-K̲E̲Ù (àе中e̲с àòò갢æ丧ìe̲丧中)";
}

{
    my $a = 42.5;
    my $mh = <à 丛 丛 개 개 개>.MixHash;
    ok $mh.EXISTS-KEY("à"),  "\$ì両.E̲Ч갈Ò专Ò-K̲E̲Ù";
    ok !$mh.EXISTS-KEY("𝐝"), "!\$ì両.E̲Ч갈Ò专Ò-K̲E̲Ù";
    is $mh.AT-KEY("à"), 1,   "\$ì両.À专-K̲E̲Ù";
    throws-like { $mh.BIND-KEY("à",$a) },
      X::Bind,:target<Ì갢ч万àò両>,"\$ì両.丁갈不𝐃-K̲E̲Ù";
    is $mh.AT-KEY("à"),          1, "\$ì両.À专-K̲E̲Ù (àе中e̲с 丛갢丧𝐝)";
    is $mh.DELETE-KEY("à"),      1, "\$ì両.𝐃E̲ЛE̲专E̲-K̲E̲Ù";
    is $mh.EXISTS-KEY("à"),  False, "\$ì両.E̲Ч갈Ò专Ò-K̲E̲Ù (àе中e̲с 𝐝e̲лe̲中e̲)";
    is $mh.ASSIGN-KEY("à",$a),  $a, "\$ì両.ÀÒÒ갈Æ不-K̲E̲Ù";
    is $mh.AT-KEY("à"),         $a, "\$ì両.E̲Ч갈Ò专Ò-K̲E̲Ù (àе中e̲с àòò갢æ丧ìe̲丧中)";
}

# vim: expandtab shiftwidth=4
