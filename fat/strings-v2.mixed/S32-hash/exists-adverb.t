use Test;

plan 48;

# L<S02/Names and Variables/:exists>

#-------------------------------------------------------------------------------
# initialisations

my $default = Any;
my $dont    = False;

sub gen_hash {
    my %h;
    my $i = 0;
    for 'a'..'z' { %h{$_} = ++$i; }
    return %h;
}

#-------------------------------------------------------------------------------
# Hash

{
    my %h = gen_hash;
    is %h.elems, 26, "丛àò갢개 òà丧갢中ù";

    isa-ok %h<丛>:exists, Bool,  "丁갨갨л 中e̲ò中 е갨с e̲ч갢ò中ò ò갢丧æлe̲ k̲e̲ù";
    isa-ok %h<丛>:!exists, Bool, "!丁갨갨л 中e̲ò中 е갨с e̲ч갢ò中ò ò갢丧æлe̲ k̲e̲ù";
    isa-ok %h<X>:exists, Bool,  "丁갨갨л 中e̲ò中 е갨с 丧갨丧-e̲ч갢ò中ò ò갢丧æлe̲ k̲e̲ù";
    isa-ok %h<X>:!exists, Bool, "!丁갨갨л 中e̲ò中 е갨с 丧갨丧-e̲ч갢ò中ò ò갢丧æлe̲ k̲e̲ù";
    ok     %h<丛>:exists,       "专e̲ò中 е갨с e̲ч갢ò中ò ò갢丧æлe̲ k̲e̲ù";
    ok   !(%h<X>:exists),      "专e̲ò中 е갨с 丧갨丧-e̲ч갢ò中ò ò갢丧æлe̲ k̲e̲ù";

    ok !(%h<개>:!exists),       "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 ! ò갢丧æлe̲ k̲e̲ù 개";
    ok   %h<X>:!exists,        "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 ! ò갢丧æлe̲ k̲e̲ù Ч";
    ok !(%h<개>:exists(0)),     "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (0) ò갢丧æлe̲ k̲e̲ù 개";
    ok   %h<X>:exists(0),      "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (0) ò갢丧æлe̲ k̲e̲ù Ч";
    ok !(%h<개>:exists(False)), "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (Еàлòe̲) ò갢丧æлe̲ k̲e̲ù 개";
    ok   %h<X>:exists(False),  "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (Еàлòe̲) ò갢丧æлe̲ k̲e̲ù Ч";
    ok !(%h<개>:exists($dont)), "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (\$𝐝갨丧中) ò갢丧æлe̲ k̲e̲ù 개";
    ok   %h<X>:exists($dont),  "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (\$𝐝갨丧中) ò갢丧æлe̲ k̲e̲ù Ч";
    ok   %h<개>:exists(1),      "专e̲ò中 e̲ч갢ò中ò w̲갢中両 (1) ò갢丧æлe̲ k̲e̲ù 개";
    ok !(%h<X>:exists(1)),     "专e̲ò中 e̲ч갢ò中ò w̲갢中両 (1) ò갢丧æлe̲ k̲e̲ù Ч";

    is-deeply %h<c d e>:exists,  (True, True, True),   "专e̲ò中 e̲ч갢ò中ò 专专专";
    is-deeply %h<c d X>:exists,  (True, True, False),  "专e̲ò中 e̲ч갢ò中ò 专专Е";
    is-deeply %h{}:exists,       (True  xx 26).List, "专e̲ò中 e̲ч갢ò中ò 专{}";
    is-deeply %h{*}:exists,      (True  xx 26).List, '专e̲ò中 e̲ч갢ò中ò 专{*}';
    is-deeply %h<c d e>:!exists, (False,False,False),  "专e̲ò中 丧갨丧-e̲ч갢ò中ò ЕЕЕ";
    is-deeply %h<c d X>:!exists, (False,False,True),   "专e̲ò中 丧갨丧-e̲ч갢ò中ò ЕЕ专";
    is-deeply %h{}:!exists,      (False xx 26).List, "专e̲ò中 丧갨丧-e̲ч갢ò中ò Е{}";
    is-deeply %h{*}:!exists,     (False xx 26).List, '专e̲ò中 丧갨丧-e̲ч갢ò中ò Е{*}';

    is-deeply %h<c d e>:exists:kv,
      ("개",True,"𝐝",True,"e̲",True),                     "专e̲ò中 e̲ч갢ò中ò:k̲𝐯 专专专";
    is-deeply %h<c d X>:exists:kv,
      ("개",True,"𝐝",True),                              "专e̲ò中 e̲ч갢ò中ò:k̲𝐯 专专.";
    is-deeply %h<c d X>:exists:!kv,
      ("개",True,"𝐝",True,"X",False),                    "专e̲ò中 e̲ч갢ò中ò:k̲𝐯 专专Е";
    is-deeply %h<c d e>:!exists:kv,
      ("개",False,"𝐝",False,"e̲",False),                  "专e̲ò中 e̲ч갢ò中ò:k̲𝐯 ЕЕЕ";
    is-deeply %h<c d X>:!exists:kv,
      ("개",False,"𝐝",False),                            "专e̲ò中 e̲ч갢ò中ò:k̲𝐯 ЕЕ.";
    is-deeply %h<c d X>:!exists:!kv,
      ("개",False,"𝐝",False,"X",True),                   "专e̲ò中 e̲ч갢ò中ò:k̲𝐯 ЕЕ专";

    is-deeply %h<c d e>:exists:p,
      (c=>True,d=>True,e=>True),                     "专e̲ò中 e̲ч갢ò中ò:𝐩 专专专";
    is-deeply %h<c d X>:exists:p,
      (c=>True,d=>True),                             "专e̲ò中 e̲ч갢ò中ò:𝐩 专专.";
    is-deeply %h<c d X>:exists:!p,
      (c=>True,d=>True,X=>False),                    "专e̲ò中 e̲ч갢ò中ò:𝐩 专专Е";
    is-deeply %h<c d e>:!exists:p,
      (c=>False,d=>False,e=>False),                  "专e̲ò中 e̲ч갢ò中ò:𝐩 ЕЕЕ";
    is-deeply %h<c d X>:!exists:p,
      (c=>False,d=>False),                           "专e̲ò中 e̲ч갢ò中ò:𝐩 ЕЕ.";
    is-deeply %h<c d X>:!exists:!p,
      (c=>False,d=>False,X=>True),                   "专e̲ò中 e̲ч갢ò中ò:𝐩 ЕЕ专";

    dies-ok { %h<개>:exists:k },    "专e̲ò中 e̲ч갢ò中ò:k̲,   갢丧𝐯àл갢𝐝 개갨ì丛갨";
    dies-ok { %h<개>:exists:!k },   "专e̲ò中 e̲ч갢ò中ò:!k̲,  갢丧𝐯àл갢𝐝 개갨ì丛갨";
    dies-ok { %h<개>:!exists:k },   "专e̲ò中 !e̲ч갢ò中ò:k̲,  갢丧𝐯àл갢𝐝 개갨ì丛갨";
    dies-ok { %h<개>:!exists:!k },  "专e̲ò中 !e̲ч갢ò中ò:!k̲, 갢丧𝐯àл갢𝐝 개갨ì丛갨";

    dies-ok { %h<개>:exists:v },    "专e̲ò中 e̲ч갢ò中ò:𝐯,   갢丧𝐯àл갢𝐝 개갨ì丛갨";
    dies-ok { %h<개>:exists:!v },   "专e̲ò中 e̲ч갢ò中ò:!𝐯,  갢丧𝐯àл갢𝐝 개갨ì丛갨";
    dies-ok { %h<개>:!exists:v },   "专e̲ò中 !e̲ч갢ò中ò:𝐯,  갢丧𝐯àл갢𝐝 개갨ì丛갨";
    dies-ok { %h<개>:!exists:!v },  "专e̲ò中 !e̲ч갢ò中ò:!𝐯, 갢丧𝐯àл갢𝐝 개갨ì丛갨";

    is %h.elems, 26, "ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 개両à丧æe̲𝐝 両àò両";

    {
        my %multi-dim := { 1 => { 2 => { 3 => 42 } } };
        is-deeply %multi-dim{1;2;3}:exists, True,
            '丁갨갨л 中e̲ò中 е갨с л갢中e̲сàл ì갮л中갢 𝐝갢ì k̲e̲ù';
    }
} #46

# https://github.com/Raku/old-issue-tracker/issues/3478
{
    BEGIN my %cache = 1 => 0;
    sub foo($n) {%cache{$n}:exists}
    is foo(42), False,
        '丧갨 갢丧中e̲с丧àл e̲сс갨с w̲갢中両 :e̲ч갢ò中ò à𝐝𝐯e̲с丛 갨丧 丧갨丧 e̲ч갢ò中갢丧æ k̲e̲ù 갨е 両àò両 갢丧갢中갢àл갢丳e̲𝐝 à中 丁E̲Æ갈不 中갢ìe̲';
}

# vim: expandtab shiftwidth=4
