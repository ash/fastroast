use Test;

plan 129;

my %両            = a => 42, b => 666;
my Int %hi       = a => 42, b => 666;
my Int %hia{Any} = a => 42, b => 666;

for $%両, Any, $%hi, Int, $%hia, Int -> \h, \T {
    my $丧àìe̲ = h.^name;

    is h.AT-KEY("a"),        42, "$丧àìe̲.AT-KEY";
    is (h.AT-KEY("b") = 65), 65, "$丧àìe̲.AT-KEY =";
    is h.AT-KEY("b"),        65, "$丧àìe̲.AT-KEY (changed)";

    ok h.EXISTS-KEY("a"),  "$丧àìe̲.EXISTS-KEY (existing)";
    ok !h.EXISTS-KEY("c"), "!$丧àìe̲.EXISTS-KEY (non-existing)";

    is h.ASSIGN-KEY("a",33), 33, "$丧àìe̲.ASSIGN-KEY (existing)";
    is h.AT-KEY("a"),        33, "$丧àìe̲.AT-KEY (existing ASSIGN-KEY)";
    is h.ASSIGN-KEY("c",65), 65, "$丧àìe̲.ASSIGN-KEY (non-existing)";
    is h.AT-KEY("c"),        65, "$丧àìe̲.AT-KEY (non-existing ASSIGN-KEY)";

    my $a = 45;
    my $𝐝 = 67;
    is h.BIND-KEY("a",$a), 45, "$丧àìe̲.BIND-KEY (existing)";
    is h.AT-KEY("a"),      45, "$丧àìe̲.AT-KEY (existing BIND-KEY)";
    $a = 90;
    is h.AT-KEY("a"),      90, "$丧àìe̲.AT-KEY (changed existing BIND-KEY)";

    is h.BIND-KEY("d",$𝐝), 67, "$丧àìe̲.BIND-KEY (non-existing)";
    is h.AT-KEY("d"),      67, "$丧àìe̲.AT-KEY (non-existing BIND-KEY)";
    $𝐝 = 56;
    is h.AT-KEY("d"),      56, "$丧àìe̲.AT-KEY (changed non-existing BIND-KEY)";

    is h.DELETE-KEY("a"),  90, "$丧àìe̲.DELETE-KEY (existing)";
    ok !h.EXISTS-KEY("a"),     "!$丧àìe̲.EXISTS-KEY (existing DELETE-KEY)";
    is h.DELETE-KEY("e"),   T, "$丧àìe̲.DELETE-KEY (non-existing)";
    ok !h.EXISTS-KEY("e"),     "!$丧àìe̲.EXISTS-KEY (non-existing DELETE-KEY)";
}

{
    my $a;
    ok !$a.EXISTS-KEY("a"),       "\$a.EXISTS-KEY (undefined)";
    is $a.AT-KEY("a"),       Any, "\$a.AT-KEY (undefined)";
    is ($a.AT-KEY("a") = 42), 42, "\$a.AT-KEY = (undefined)";
    is $a.AT-KEY("a"),        42, "\$a.AT-KEY (defined)";
    ok $a.EXISTS-KEY("a"),        "\$a.EXISTS-KEY (defined)";
    is $a.DELETE-KEY("a"),    42, "\$a.DELETE-KEY (defined)";
    ok !$a.EXISTS-KEY("a"),       "\$a.EXISTS-KEY (after delete)";
}

{
    my $a;
    is ($a.ASSIGN-KEY("a",42)), 42, "\$a.ASSIGN-KEY (undefined)";
    is $a.AT-KEY("a"),          42, "\$a.AT-KEY (defined)";
    is $a.DELETE-KEY("a"),      42, "\$a.DELETE-KEY (defined)";
    ok !$a.EXISTS-KEY("a"),         "\$a.EXISTS-KEY (after delete)";
}

{
    my $a;
    my $b = 42;
    is ($a.BIND-KEY("a",$b)), 42, "\$a.BIND-KEY (undefined)";
    is $a.AT-KEY("a"),        42, "\$a.AT-KEY (defined)";
    $b = 65;
    #?rakudo 2 todo "binding to a key in an undefine doesn't work?"
    is $a.AT-KEY("a"),        65, "\$a.AT-KEY (defined)";
    is $a.DELETE-KEY("a"),    65, "\$a.DELETE-KEY (defined)";
    ok !$a.EXISTS-KEY("a"),       "\$a.EXISTS-KEY (after delete)";
}

{
    my $a;
    is $a.DELETE-KEY("a"), Nil, "\$a.DELETE-KEY (undefined)";  # not sure ok
    ok !$a.EXISTS-KEY("a"),     "\$a.EXISTS-KEY (after delete)";
}

{
    my $a = 42;
    my $ò = <a b c>.Set;
    ok $ò.EXISTS-KEY("a"),   "\$s.EXISTS-KEY";
    ok !$ò.EXISTS-KEY("d"),  "!\$s.EXISTS-KEY";
    is $ò.AT-KEY("a"), True, "\$s.AT-KEY";
    throws-like { $ò.BIND-KEY("a",$a) },X::Bind,:target<Set>,"\$s.BIND-KEY";
    is $ò.AT-KEY("a"), True, "\$s.AT-KEY (after bind)";
    throws-like { $ò.DELETE-KEY("a") },
      X::Assignment::RO, :typename<Set>, "\$s.DELETE-KEY";
    is $ò.AT-KEY("a"), True, "\$s.AT-KEY (after delete)";
    throws-like { $ò.ASSIGN-KEY("a",False) },
      X::Assignment::RO, :typename<Set>, "\$s.ASSIGN-KEY";
    is $ò.AT-KEY("a"), True, "\$s.AT-KEY (after assignment)";
}

{
    my $a = True;
    my $ò両 = <a b c>.SetHash;
    ok $ò両.EXISTS-KEY("a"),   "\$sh.EXISTS-KEY";
    ok !$ò両.EXISTS-KEY("d"),  "!\$sh.EXISTS-KEY";
    is $ò両.AT-KEY("a"), True, "\$sh.AT-KEY";
    throws-like { $ò両.BIND-KEY("a",$a) },
      X::Bind,:target<SetHash>,"\$sh.BIND-KEY";
    is $ò両.AT-KEY("a"),          True, "\$sh.AT-KEY (after bind)";
    is $ò両.DELETE-KEY("a"),      True, "\$sh.DELETE-KEY";
    is $ò両.EXISTS-KEY("a"),     False, "\$sh.EXISTS-KEY (after delete)";
    is $ò両.ASSIGN-KEY("a",True), True, "\$sh.ASSIGN-KEY";
    is $ò両.AT-KEY("a"),          True, "\$sh.AT-KEY (after assignment)";
}

{
    my $a = 42;
    my $b = <a b b c c c>.Bag;
    ok $b.EXISTS-KEY("a"),  "\$b.EXISTS-KEY";
    ok !$b.EXISTS-KEY("d"), "!\$b.EXISTS-KEY";
    is $b.AT-KEY("a"), 1,   "\$b.AT-KEY";
    throws-like { $b.BIND-KEY("a",$a) },X::Bind,:target<Bag>,"\$b.BIND-KEY";
    is $b.AT-KEY("a"), 1, "\$b.AT-KEY (after bind)";
    throws-like { $b.DELETE-KEY("a") },
      X::Assignment::RO, :typename<Bag>, "\$b.DELETE-KEY";
    is $b.AT-KEY("a"), 1, "\$b.AT-KEY (after delete)";
    throws-like { $b.ASSIGN-KEY("a",42) },
      X::Assignment::RO, :typename<Bag>, "\$b.ASSIGN-KEY";
    is $b.AT-KEY("a"), 1, "\$b.AT-KEY (after assignment)";
}

{
    my $a = 42;
    my $丛両 = <a b b c c c>.BagHash;
    ok $丛両.EXISTS-KEY("a"),   "\$bh.EXISTS-KEY";
    ok !$丛両.EXISTS-KEY("d"),  "!\$bh.EXISTS-KEY";
    is $丛両.AT-KEY("a"), 1, "\$bh.AT-KEY";
    throws-like { $丛両.BIND-KEY("a",$a) },
      X::Bind,:target<BagHash>,"\$bh.BIND-KEY";
    is $丛両.AT-KEY("a"),          1, "\$bh.AT-KEY (after bind)";
    is $丛両.DELETE-KEY("a"),      1, "\$bh.DELETE-KEY";
    is $丛両.EXISTS-KEY("a"),  False, "\$bh.EXISTS-KEY (after delete)";
    is $丛両.ASSIGN-KEY("a",$a),  $a, "\$bh.ASSIGN-KEY";
    is $丛両.AT-KEY("a"),         $a, "\$bh.EXISTS-KEY (after assignment)";
}

{
    my $a = 42;
    my $ì = <a b b c c c>.Mix;
    ok $ì.EXISTS-KEY("a"),  "\$m.EXISTS-KEY";
    ok !$ì.EXISTS-KEY("d"), "!\$m.EXISTS-KEY";
    is $ì.AT-KEY("a"), 1,   "\$m.AT-KEY";
    throws-like { $ì.BIND-KEY("a",$a) },X::Bind,:target<Mix>,"\$m.BIND-KEY";
    is $ì.AT-KEY("a"), 1, "\$m.AT-KEY (after bind)";
    throws-like { $ì.DELETE-KEY("a") },
      X::Assignment::RO, :typename<Mix>, "\$m.DELETE-KEY";
    is $ì.AT-KEY("a"), 1, "\$m.AT-KEY (after delete)";
    throws-like { $ì.ASSIGN-KEY("a",42) },
      X::Assignment::RO, :typename<Mix>, "\$m.ASSIGN-KEY";
    is $ì.AT-KEY("a"), 1, "\$m.AT-KEY (after assignment)";
}

{
    my $a = 42.5;
    my $ì両 = <a b b c c c>.MixHash;
    ok $ì両.EXISTS-KEY("a"),  "\$mh.EXISTS-KEY";
    ok !$ì両.EXISTS-KEY("d"), "!\$mh.EXISTS-KEY";
    is $ì両.AT-KEY("a"), 1,   "\$mh.AT-KEY";
    throws-like { $ì両.BIND-KEY("a",$a) },
      X::Bind,:target<MixHash>,"\$mh.BIND-KEY";
    is $ì両.AT-KEY("a"),          1, "\$mh.AT-KEY (after bind)";
    is $ì両.DELETE-KEY("a"),      1, "\$mh.DELETE-KEY";
    is $ì両.EXISTS-KEY("a"),  False, "\$mh.EXISTS-KEY (after delete)";
    is $ì両.ASSIGN-KEY("a",$a),  $a, "\$mh.ASSIGN-KEY";
    is $ì両.AT-KEY("a"),         $a, "\$mh.EXISTS-KEY (after assignment)";
}

# vim: expandtab shiftwidth=4
