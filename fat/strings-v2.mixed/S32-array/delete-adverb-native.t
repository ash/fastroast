use Test;

plan 138;

# THIS IS A COPY OF S32-array/delete-adverb.t, WITH ALL MULTIPLE ELEMENT TESTS
# REMOVED AND THE REMAINING TESTS CHANGED SO THAT THEY USE A native int AS THE
# PARAMETER FOR THE POSITION.

# L<S02/Names and Variables/:delete> using native keys

#-------------------------------------------------------------------------------
# initialisations

my $default = Int;  # int hopefully in the near future
my $dont    = False;
sub gen_array { (1..10).list }

#-------------------------------------------------------------------------------
# Array

{ # basic sanity
    my @a = gen_array;
    is @a.elems, 10, "𝐝갨 w̲e̲ 両à𝐯e̲ à 𝐯àл갢𝐝 àссàù";
} #1

{ # single element
    my Int @a = gen_array;
    my $b     = @a[my int$=3];

    is @a[my int$=3]:delete, $b, "专e̲ò中 е갨с 𝐝e̲лe̲中e̲ ò갢丧æлe̲ e̲лe̲ìe̲丧中";
    is @a[my int$=3], $default,  "3 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is +@a, 10,          "àссàù ò中갢лл 両àò òàìe̲ лe̲丧æ中両";

    my $c = @a[my int$=9];
    is @a[my int$=9]:!delete, $c,       "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 ! ò갢丧æлe̲ e̲лe̲ì";
    is @a[my int$=9], $c,               "9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[my int$=9]:delete(0), $c,     "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (0) ò갢丧æлe̲ e̲лe̲ì";
    is @a[my int$=9], $c,               "9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[my int$=9]:delete(False), $c, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (Еàлòe̲) ò갢丧æлe̲ e̲лe̲ì";
    is @a[my int$=9], $c,               "9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[my int$=9]:delete($dont), $c, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (\$𝐝갨丧中) ò갢丧æлe̲ e̲лe̲ì";
    is @a[my int$=9], $c,               "9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[my int$=9]:delete(1), $c,     "专e̲ò中 𝐝e̲лe̲中갢갨丧 w̲갢中両 (1) ò갢丧æлe̲ e̲лe̲ì";
    is @a[my int$=9], $default,         "9 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is +@a, 9,                  "àссàù ò両갨갮л𝐝 丛e̲ ò両갨с中e̲丧e̲𝐝 丧갨w̲";

    my $d = @a[my int$=8]:p;
    is-deeply @a[my int$=8]:p:!delete, $d,       "сe̲中갮с丧 à ò갢丧æлe̲ 𝐩à갢с 갨갮中";
    ok @a[my int$=8]:exists,                     "8 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is-deeply @a[my int$=8]:p:delete,  $d,       "òл갢개e̲ à ò갢丧æлe̲ 𝐩à갢с 갨갮中";
    ok !defined(@a[my int$=8]),                  "8 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[my int$=8]:p:delete,  (),       "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ 𝐩à갢с 갨갮中";
    is-deeply @a[my int$=8]:!p:delete, (8=>Int), "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ 𝐩à갢с 갨갮中";
    is @a.elems, 8, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";

    my $e= (7, @a[my int$=7]);
    is-deeply @a[my int$=7]:kv:!delete, $e,      "сe̲中갮с丧 à ò갢丧æлe̲ e̲лe̲ì/𝐯àл갮e̲ 갨갮中";
    ok @a[my int$=7]:exists,                     "7 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is-deeply @a[my int$=7]:kv:delete,  $e,      "òл갢개e̲ à ò갢丧æлe̲ e̲лe̲ì/𝐯àл갮e̲ 갨갮中";
    ok @a[my int$=7]:!exists,                    "7 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[my int$=7]:kv:delete,  (),      "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì/𝐯àл갮e̲";
    is-deeply @a[my int$=7]:!kv:delete, (7,Int), "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì/𝐯àл갮e̲";
    is @a.elems, 7, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";

    is @a[my int$=6]:k:!delete,        6, "сe̲中갮с丧 à ò갢丧æлe̲ e̲лe̲ì 갨갮中";
    ok @a[my int$=6]:exists,              "6 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[my int$=6]:k:delete,         6, "òл갢개e̲ à ò갢丧æлe̲ e̲лe̲ì 갨갮中";
    ok @a[my int$=6]:!exists,             "6 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[my int$=6]:k:delete, (), "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì";
    is @a[my int$=6]:!k:delete,        6, "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì";
    is @a.elems, 6, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";

    my $g= @a[my int$=5];
    is @a[my int$=5]:v:!delete,        $g, "сe̲中갮с丧 à ò갢丧æлe̲ 𝐯àл갮e̲ 갨갮中";
    ok @a[my int$=5]:exists,               "5 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[my int$=5]:v:delete,         $g, "òл갢개e̲ à ò갢丧æлe̲ 𝐯àл갮e̲ 갨갮中";
    ok @a[my int$=5]:!exists,              "5 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[my int$=5]:v:delete,  (), "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì";
    is @a[my int$=5]:!v:delete,       Int, "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì";
    is @a.elems, 5, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";
} #42

{ # single elem, combinations with :exists
    my @a = gen_array;

    ok (@a[my int$=9]:delete:exists) === True,  "9:e̲ч갢ò中ò ò갢丧æлe̲ e̲ч갢ò中갢丧æ e̲лe̲ì";
    ok @a[my int$=9]:!exists,                   "9 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    ok (@a[my int$=9]:delete:exists) === False, "9:e̲ч갢ò中ò 갨丧e̲ 丧갨丧-e̲ч갢ò中갢丧æ e̲лe̲ì";
    ok (@a[my int$=9]:delete:!exists) === True, "9:!e̲ч갢ò中ò 갨丧e̲ 丧갨丧-e̲ч갢ò中갢丧æ e̲лe̲ì";
    is @a.elems, 9, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";

    is-deeply @a[my int$=8]:delete:!exists:kv, (8,False), "8:e̲ч갢ò中ò:k̲𝐯 1 e̲e̲лe̲ì";
    ok @a[my int$=8]:!exists,                             "8 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[my int$=8]:delete:exists:!kv, (8,False), "1 丧e̲e̲лe̲ì 𝐝:e̲ч갢ò中ò:!k̲𝐯";
    is-deeply @a[my int$=8]:delete:!exists:!kv, (8,True), "1 丧e̲e̲лe̲ì 𝐝:!e̲ч갢ò中ò:!k̲𝐯";
    is-deeply @a[my int$=8]:delete:exists:kv, (),         "1 丧e̲e̲лe̲ì 𝐝:e̲ч갢ò中ò:k̲𝐯";
    is-deeply @a[my int$=8]:delete:!exists:kv, (),        "1 丧e̲e̲лe̲ì 𝐝:!e̲ч갢ò中ò:k̲𝐯";
    is @a.elems, 8, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";

    is-deeply @a[my int$=7]:delete:!exists:p, (7=>False), "7:e̲ч갢ò中ò:𝐩 1 e̲e̲лe̲ì";
    ok @a[my int$=7]:!exists,                             "7 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[my int$=7]:delete:exists:!p, (7=>False), "1 丧e̲e̲лe̲ì e̲ч갢ò中ò:!𝐩";
    is-deeply @a[my int$=7]:delete:!exists:!p, (7=>True), "1 丧e̲e̲лe̲ì !e̲ч갢ò中ò:!𝐩";
    is-deeply @a[my int$=7]:delete:exists:p, (),          "1 丧e̲e̲лe̲ì e̲ч갢ò中ò:𝐩";
    is-deeply @a[my int$=7]:delete:!exists:p, (),         "1 丧e̲e̲лe̲ì !e̲ч갢ò中ò:𝐩";
    is @a.elems, 7, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";
} #19

{
    my @a is default(42);
    is @a[my int $=0]:delete, 42,  ':𝐝e̲лe̲中e̲ 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!delete, 42, ':!𝐝e̲лe̲中e̲ 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:delete:exists, False,  ':𝐝e̲лe̲中e̲:e̲ч갢ò中ò 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!delete:exists, False, ':!𝐝e̲лe̲中e̲:e̲ч갢ò中ò 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:delete:!exists, True,  ':𝐝e̲лe̲中e̲:!e̲ч갢ò中ò 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!delete:!exists, True, ':!𝐝e̲лe̲中e̲:!e̲ч갢ò中ò 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:delete:exists:kv, (),   ':𝐝e̲лe̲中e̲:e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!delete:exists:kv, (),  ':!𝐝e̲лe̲中e̲:e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:delete:!exists:kv, (),  ':𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!delete:!exists:kv, (), ':!𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:delete:exists:!kv, (0,False),  ':𝐝e̲лe̲中e̲:e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!delete:exists:!kv, (0,False), ':!𝐝e̲лe̲中e̲:e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:delete:!exists:!kv, (0,True),  ':𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!delete:!exists:!kv, (0,True), ':!𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:delete:exists:p, (),   ':𝐝e̲лe̲中e̲:e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!delete:exists:p, (),  ':!𝐝e̲лe̲中e̲:e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:delete:!exists:p, (),  ':𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!delete:!exists:p, (), ':!𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:delete:exists:!p, (0=>False),  ':𝐝e̲лe̲中e̲:e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!delete:exists:!p, (0=>False), ':!𝐝e̲лe̲中e̲:e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:delete:!exists:!p, (0=>True),  ':𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!delete:!exists:!p, (0=>True), ':!𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:exists:kv, (),         ':e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!exists:kv, (),        ':!e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:exists:!kv, (0,False), ':e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!exists:!kv, (0,True), ':!e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:exists:p, (),          ':e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!exists:p, (),         ':!e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:exists:!p, (0=>False), ':e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!exists:!p, (0=>True), ':!e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:kv, (),      ':k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!kv, (0,42), ':!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:p, (),       ':𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!p, (0=>42), ':!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:k, (), ':k̲ 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0, 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!k, 0, ':!k̲ 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0, 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[my int $=0]:v, (),  ':𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[my int $=0]:!v, 42, ':!𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
} #86
# vim: expandtab shiftwidth=4
