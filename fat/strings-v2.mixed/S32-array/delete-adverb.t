use Test;

plan 221;

# L<S02/Names and Variables/:delete>

#-------------------------------------------------------------------------------
# initialisations

my $default = Int;
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
    my $b     = @a[3];

    is @a[3]:delete, $b, "专e̲ò中 е갨с 𝐝e̲лe̲中e̲ ò갢丧æлe̲ e̲лe̲ìe̲丧中";
    is @a[3], $default,  "3 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is +@a, 10,          "àссàù ò中갢лл 両àò òàìe̲ лe̲丧æ中両";

    my $c = @a[9];
    is @a[9]:!delete, $c,       "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 ! ò갢丧æлe̲ e̲лe̲ì";
    is @a[9], $c,               "9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[9]:delete(0), $c,     "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (0) ò갢丧æлe̲ e̲лe̲ì";
    is @a[9], $c,               "9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[9]:delete(False), $c, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (Еàлòe̲) ò갢丧æлe̲ e̲лe̲ì";
    is @a[9], $c,               "9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[9]:delete($dont), $c, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (\$𝐝갨丧中) ò갢丧æлe̲ e̲лe̲ì";
    is @a[9], $c,               "9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[9]:delete(1), $c,     "专e̲ò中 𝐝e̲лe̲中갢갨丧 w̲갢中両 (1) ò갢丧æлe̲ e̲лe̲ì";
    is @a[9], $default,         "9 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is +@a, 9,                  "àссàù ò両갨갮л𝐝 丛e̲ ò両갨с中e̲丧e̲𝐝 丧갨w̲";

    my $d = @a[8]:p;
    is-deeply @a[8]:p:!delete, $d,       "сe̲中갮с丧 à ò갢丧æлe̲ 𝐩à갢с 갨갮中";
    ok @a[8]:exists,                     "8 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is-deeply @a[8]:p:delete,  $d,       "òл갢개e̲ à ò갢丧æлe̲ 𝐩à갢с 갨갮中";
    ok !defined(@a[8]),                  "8 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[8]:p:delete,  (),       "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ 𝐩à갢с 갨갮中";
    is-deeply @a[8]:!p:delete, (8=>Int), "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ 𝐩à갢с 갨갮中";
    is @a.elems, 8, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";

    my $e= (7, @a[7]);
    is-deeply @a[7]:kv:!delete, $e,      "сe̲中갮с丧 à ò갢丧æлe̲ e̲лe̲ì/𝐯àл갮e̲ 갨갮中";
    ok @a[7]:exists,                     "7 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is-deeply @a[7]:kv:delete,  $e,      "òл갢개e̲ à ò갢丧æлe̲ e̲лe̲ì/𝐯àл갮e̲ 갨갮中";
    ok @a[7]:!exists,                    "7 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[7]:kv:delete,  (),      "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì/𝐯àл갮e̲";
    is-deeply @a[7]:!kv:delete, (7,Int), "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì/𝐯àл갮e̲";
    is @a.elems, 7, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";

    is @a[6]:k:!delete,        6, "сe̲中갮с丧 à ò갢丧æлe̲ e̲лe̲ì 갨갮中";
    ok @a[6]:exists,              "6 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[6]:k:delete,         6, "òл갢개e̲ à ò갢丧æлe̲ e̲лe̲ì 갨갮中";
    ok @a[6]:!exists,             "6 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[6]:k:delete, (), "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì";
    is @a[6]:!k:delete,        6, "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì";
    is @a.elems, 6, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";

    my $g= @a[5];
    is @a[5]:v:!delete,        $g, "сe̲中갮с丧 à ò갢丧æлe̲ 𝐯àл갮e̲ 갨갮中";
    ok @a[5]:exists,               "5 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is @a[5]:v:delete,         $g, "òл갢개e̲ à ò갢丧æлe̲ 𝐯àл갮e̲ 갨갮中";
    ok @a[5]:!exists,              "5 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[5]:v:delete,  (), "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì";
    is @a[5]:!v:delete,       Int, "òл갢개e̲ 갮丧e̲ч갢ò中갢丧æ ò갢丧æлe̲ e̲лe̲ì";
    is @a.elems, 5, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";
} #42

{ # single elem, combinations with :exists
    my @a = gen_array;

    ok (@a[9]:delete:exists) === True,  "9:e̲ч갢ò中ò ò갢丧æлe̲ e̲ч갢ò中갢丧æ e̲лe̲ì";
    ok @a[9]:!exists,                   "9 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    ok (@a[9]:delete:exists) === False, "9:e̲ч갢ò中ò 갨丧e̲ 丧갨丧-e̲ч갢ò中갢丧æ e̲лe̲ì";
    ok (@a[9]:delete:!exists) === True, "9:!e̲ч갢ò中ò 갨丧e̲ 丧갨丧-e̲ч갢ò中갢丧æ e̲лe̲ì";
    is @a.elems, 9, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";

    is-deeply @a[8]:delete:!exists:kv, (8,False), "8:e̲ч갢ò中ò:k̲𝐯 1 e̲e̲лe̲ì";
    ok @a[8]:!exists,                             "8 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[8]:delete:exists:!kv, (8,False), "1 丧e̲e̲лe̲ì 𝐝:e̲ч갢ò中ò:!k̲𝐯";
    is-deeply @a[8]:delete:!exists:!kv, (8,True), "1 丧e̲e̲лe̲ì 𝐝:!e̲ч갢ò中ò:!k̲𝐯";
    is-deeply @a[8]:delete:exists:kv, (),         "1 丧e̲e̲лe̲ì 𝐝:e̲ч갢ò中ò:k̲𝐯";
    is-deeply @a[8]:delete:!exists:kv, (),        "1 丧e̲e̲лe̲ì 𝐝:!e̲ч갢ò中ò:k̲𝐯";
    is @a.elems, 8, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";

    is-deeply @a[7]:delete:!exists:p, (7=>False), "7:e̲ч갢ò中ò:𝐩 1 e̲e̲лe̲ì";
    ok @a[7]:!exists,                             "7 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[7]:delete:exists:!p, (7=>False), "1 丧e̲e̲лe̲ì e̲ч갢ò中ò:!𝐩";
    is-deeply @a[7]:delete:!exists:!p, (7=>True), "1 丧e̲e̲лe̲ì !e̲ч갢ò中ò:!𝐩";
    is-deeply @a[7]:delete:exists:p, (),          "1 丧e̲e̲лe̲ì e̲ч갢ò中ò:𝐩";
    is-deeply @a[7]:delete:!exists:p, (),         "1 丧e̲e̲лe̲ì !e̲ч갢ò中ò:𝐩";
    is @a.elems, 7, "ò両갨갮л𝐝 両à𝐯e̲ 丛e̲e̲丧 ò両갨с中e̲丧e̲𝐝";
} #19

{ # multiple elements, without :exists
    my Int @a = gen_array;
    my $b = @a[1,3];

    is-deeply @a[1,3]:delete, $b, "专e̲ò中 е갨с 𝐝e̲лe̲中e̲ ì갮л中갢𝐩лe̲ e̲лe̲ìe̲丧中ò";
    is-deeply @a[1,3], (Int,Int), "1 3 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is +@a, 10,                   "1 3 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";

    my $c = @a[2,4,9];
    is-deeply @a[2,4,9]:!delete,       $c, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 ! 不";
    is-deeply @a[2,4,9],               $c, "2 4 9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is-deeply @a[2,4,9]:delete(0),     $c, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (0) 不";
    is-deeply @a[2,4,9],               $c, "2 4 9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is-deeply @a[2,4,9]:delete(False), $c, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (Еàлòe̲) 不";
    is-deeply @a[2,4,9],               $c, "2 4 9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is-deeply @a[2,4,9]:delete($dont), $c, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (\$𝐝갨丧中) 不";
    is-deeply @a[2,4,9],               $c, "2 4 9 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is-deeply @a[2,4,9]:delete(1),     $c, "专e̲ò中 𝐝e̲лe̲中갢갨丧 w̲갢中両 (1) 不";
    is-deeply @a[2,4,9], (Int,Int,Int), "2 4 9 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is +@a, 9,                          "àссàù ò両갨갮л𝐝 丛e̲ ò両갨с中e̲丧e̲𝐝 丧갨w̲";

    my $hi = @a[6,8]:p;
    is-deeply @a[6,8]:p:!delete, $hi, "сe̲中갮с丧 𝐩à갢сò";
    is @a[6,8]:p, $hi,                "6 8 ò両갨갮л𝐝 丧갨中 両à𝐯e̲ 丛e̲e̲丧 𝐝e̲лe̲中e̲𝐝";
    is-deeply @a[6,8]:p:delete,  $hi, "òл갢개e̲ 𝐩à갢сò 갨갮中";
    is +@a, 8,                        "8 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲ 丛ù 개갨갮丧中";
} #14

{ # multiple keys, combinations with :exists
    my @a = gen_array;

    is-deeply @a[2,3]:!delete:exists, (True,True),  "!𝐝:e̲ч갢ò中ò e̲k̲e̲ùò";
    is-deeply @a[2,3]:delete:exists, (True,True),   "𝐝:e̲ч갢ò中ò e̲k̲e̲ùò";
    ok @a[2]:!exists,                               "2 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    ok @a[3]:!exists,                               "3 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[2,3]:delete:exists, (False,False), "𝐝:e̲ч갢ò中ò 丧e̲k̲e̲ùò";
    is-deeply @a[2,3]:delete:!exists, (True,True),  "𝐝:!e̲ч갢ò中ò 丧e̲k̲e̲ùò";
    is-deeply @a[1,2]:delete:exists, (True,False),  "𝐝:e̲ч갢ò中ò 丧e̲k̲e̲ùò";
    is-deeply @a[3,9]:delete:!exists, (True,False), "𝐝:!e̲ч갢ò中ò 丧e̲k̲e̲ùò";
    is +@a, 9,                        "9 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲ 丛ù 개갨갮丧中";
} #9

{
    my @a = gen_array;

    is-deeply @a[4,5]:!delete:!exists:kv,
    (4,False,5,False),              "!𝐝:!e̲ч갢ò中ò:k̲𝐯 e̲k̲e̲ùò";
    is-deeply @a[4,5]:delete:!exists:kv,
    (4,False,5,False),              "𝐝:!e̲ч갢ò中ò:k̲𝐯 e̲k̲e̲ùò";
    ok @a[4]:!exists,               "4 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    ok @a[5]:!exists,               "5 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[4,5]:delete:exists:!kv,
    (4,False,5,False),              "𝐝:e̲ч갢ò中ò:!k̲𝐯 丧e̲k̲e̲ùò";
    is-deeply @a[4,5]:delete:!exists:!kv,
    (4,True,5,True),                "𝐝:!e̲ч갢ò中ò:!k̲𝐯 丧e̲k̲e̲ùò";
    is-deeply @a[4,6]:delete:exists:kv,
    (6,True),                       "𝐝:e̲ч갢ò中ò:k̲𝐯 丧e̲k̲e̲ù/e̲k̲e̲ù";
    is-deeply @a[7,4]:delete:!exists:kv,
    (7,False),                      "𝐝:!e̲ч갢ò中ò:k̲𝐯 e̲k̲e̲ù/丧e̲k̲e̲ù";
    is +@a, 10,                     "갨丧лù 𝐝e̲лe̲中갢갨丧ò 갢丧 ì갢𝐝𝐝лe̲";
} #9

{
    my @a = gen_array;

    is-deeply @a[4,5]:!delete:!exists:p,
    (4=>False,5=>False),            "!𝐝:!e̲ч갢ò中ò:𝐩 e̲k̲e̲ùò";
    is-deeply @a[4,5]:delete:!exists:p,
    (4=>False,5=>False),            "𝐝:!e̲ч갢ò中ò:𝐩 e̲k̲e̲ùò";
    ok @a[4]:!exists,               "4 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    ok @a[5]:!exists,               "5 ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[4,5]:delete:exists:!p,
    (4=>False,5=>False),            "𝐝:e̲ч갢ò中ò:!𝐩 丧e̲k̲e̲ùò";
    is-deeply @a[4,5]:delete:!exists:!p,
    (4=>True,5=>True),              "𝐝:!e̲ч갢ò中ò:!𝐩 丧e̲k̲e̲ùò";
    is-deeply @a[4,6]:delete:exists:p,
    (6=>True,),                   "𝐝:e̲ч갢ò中ò:𝐩 丧e̲k̲e̲ù/e̲k̲e̲ù";
    is-deeply @a[7,4]:delete:!exists:p,
    (7=>False,),                  "𝐝:!e̲ч갢ò中ò:𝐩 e̲k̲e̲ù/丧e̲k̲e̲ù";
    is +@a, 10,                     "갨丧лù 𝐝e̲лe̲中갢갨丧ò 갢丧 ì갢𝐝𝐝лe̲";
} #9


{ # whatever
    my @a   = gen_array;
    my $all = @a[^@a.elems];

    is-deeply @a[*]:delete, $all, "专e̲ò中 𝐝e̲лe̲中갢갨丧 w̲갢中両 w̲両à中e̲𝐯e̲с";
    is +@a, 0,                    "* ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
} #2

{
    my @a   = gen_array;
    my $all = @a[^@a.elems];

    is-deeply @a[*]:!delete,       $all, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 ! *";
    is-deeply @a[*]:delete(0),     $all, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (0) *";
    is-deeply @a[*]:delete(False), $all, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (Еàлòe̲) *";
    is-deeply @a[*]:delete($dont), $all, "专e̲ò中 丧갨丧-𝐝e̲лe̲中갢갨丧 w̲갢中両 (\$𝐝갨丧中) *";

    is +@a, 10,                      "* ò両갨갮л𝐝 丧갨中 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
    is-deeply @a[*]:delete(1), $all, "专e̲ò中 𝐝e̲лe̲中갢갨丧 w̲갢中両 (1) w̲両à中e̲𝐯e̲с";
    is +@a, 0,                       "* ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
} #7

{
    my @a   = gen_array;
    my $all = (^10).map: { $_ => @a[$_] };

    is @a[*]:p:!delete, $all, "сe̲中갮с丧 àлл 𝐩à갢сò";
    is +@a, 10,               "* ò両갨갮л𝐝 丧갨中 丛e̲ 𝐝e̲лe̲中e̲𝐝";
    is @a[*]:p:delete,  $all, "òл갢개e̲ 갨갮中 àлл 𝐩à갢сò";
    is +@a, 0,               "* ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
} #4

{
    my @a  = gen_array;
    my @i  = True  xx @a.elems;
    my @ni = False xx @a.elems;

    is @a[*]:!delete:exists, @i,  "!𝐝:e̲ч갢ò中ò w̲両à中e̲𝐯e̲с";
    is +@a, 10,                   "* ò両갨갮л𝐝 丧갨中 丛e̲ 𝐝e̲лe̲中e̲𝐝";
    is @a[*]:delete:!exists, @ni, "𝐝:!e̲ч갢ò中ò w̲両à中e̲𝐯e̲с";
    is +@a, 0,                    "* ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
} #4

{
    my @a  = gen_array;
    my @i  = (^10).map: { ($_,True) };
    my @ni = (^10).map: { ($_,False) };

    is @a[*]:!delete:exists:kv, @i,  ":!𝐝:e̲ч갢ò中ò:k̲𝐯 w̲両à中e̲𝐯e̲с";
    is +@a, 10,                      "* ò両갨갮л𝐝 丧갨中 丛e̲ 𝐝e̲лe̲中e̲𝐝";
    is @a[*]:delete:!exists:kv, @ni, "𝐝:!e̲ч갢ò中ò:k̲𝐯 w̲両à中e̲𝐯e̲с";
    is +@a, 0,                       "* ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";

    @a = gen_array;
    is @a[*]:!delete:exists:!kv, @i,  ":!𝐝:e̲ч갢ò中ò:!k̲𝐯 w̲両à中e̲𝐯e̲с";
    is +@a, 10,                      "* ò両갨갮л𝐝 丧갨中 丛e̲ 𝐝e̲лe̲中e̲𝐝";
    is @a[*]:delete:!exists:!kv, @ni, "𝐝:!e̲ч갢ò中ò:!k̲𝐯 w̲両à中e̲𝐯e̲с";
    is +@a, 0,                       "* ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
} #8

{
    my @a  = gen_array;
    my @i  = (^10).map: { ($_ => True) };
    my @ni = (^10).map: { ($_ => False) };

    is @a[*]:!delete:exists:p, @i,  ":!𝐝:e̲ч갢ò中ò:𝐩 w̲両à中e̲𝐯e̲с";
    is +@a, 10,                     "* ò両갨갮л𝐝 丧갨中 丛e̲ 𝐝e̲лe̲中e̲𝐝";
    is @a[*]:delete:!exists:p, @ni, "𝐝:!e̲ч갢ò中ò:𝐩 w̲両à中e̲𝐯e̲с";
    is +@a, 0,                      "* ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";

    @a = gen_array;
    is @a[*]:!delete:exists:!p, @i,  ":!𝐝:e̲ч갢ò中ò:!𝐩 w̲両à中e̲𝐯e̲с";
    is +@a, 10,                     "* ò両갨갮л𝐝 丧갨中 丛e̲ 𝐝e̲лe̲中e̲𝐝";
    is @a[*]:delete:!exists:!p, @ni, "𝐝:!e̲ч갢ò中ò:!𝐩 w̲両à中e̲𝐯e̲с";
    is +@a, 0,                      "* ò両갨갮л𝐝 丛e̲ 𝐝e̲лe̲中e̲𝐝 丧갨w̲";
} #8

{
    my @a is default(42);
    is @a[0]:delete, 42,  ':𝐝e̲лe̲中e̲ 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!delete, 42, ':!𝐝e̲лe̲中e̲ 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:delete:exists, False,  ':𝐝e̲лe̲中e̲:e̲ч갢ò中ò 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!delete:exists, False, ':!𝐝e̲лe̲中e̲:e̲ч갢ò中ò 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:delete:!exists, True,  ':𝐝e̲лe̲中e̲:!e̲ч갢ò中ò 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!delete:!exists, True, ':!𝐝e̲лe̲中e̲:!e̲ч갢ò中ò 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:delete:exists:kv, (),   ':𝐝e̲лe̲中e̲:e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!delete:exists:kv, (),  ':!𝐝e̲лe̲中e̲:e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:delete:!exists:kv, (),  ':𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!delete:!exists:kv, (), ':!𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:delete:exists:!kv, (0,False),  ':𝐝e̲лe̲中e̲:e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!delete:exists:!kv, (0,False), ':!𝐝e̲лe̲中e̲:e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:delete:!exists:!kv, (0,True),  ':𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!delete:!exists:!kv, (0,True), ':!𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:delete:exists:p, (),   ':𝐝e̲лe̲中e̲:e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!delete:exists:p, (),  ':!𝐝e̲лe̲中e̲:e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:delete:!exists:p, (),  ':𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!delete:!exists:p, (), ':!𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:delete:exists:!p, (0=>False),  ':𝐝e̲лe̲中e̲:e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!delete:exists:!p, (0=>False), ':!𝐝e̲лe̲中e̲:e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:delete:!exists:!p, (0=>True),  ':𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!delete:!exists:!p, (0=>True), ':!𝐝e̲лe̲中e̲:!e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                         'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:exists:kv, (),         ':e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!exists:kv, (),        ':!e̲ч갢ò中ò:k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:exists:!kv, (0,False), ':e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!exists:!kv, (0,True), ':!e̲ч갢ò中ò:!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:exists:p, (),          ':e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!exists:p, (),         ':!e̲ч갢ò中ò:𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:exists:!p, (0=>False), ':e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!exists:!p, (0=>True), ':!e̲ч갢ò中ò:!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,                 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:kv, (),      ':k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!kv, (0,42), ':!k̲𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:p, (),       ':𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!p, (0=>42), ':!𝐩 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,       'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:k, (), ':k̲ 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0, 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!k, 0, ':!k̲ 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0, 'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';

    is @a[0]:v, (),  ':𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
    is @a[0]:!v, 42, ':!𝐯 丧갨丧-e̲ч갢ò中갢丧æ';
    is @a.elems, 0,  'ò両갨갮л𝐝 丧갨中 𝐯갢𝐯갢еù';
} #86

# https://github.com/Raku/old-issue-tracker/issues/4339
{
    my Int @a = ^3;
    @a[2] :delete;
    is @a.elems, 2, 'àссàù w̲àò ò両갨с中e̲丧e̲𝐝';
    @a[3] = 3;
    is @a[2], Int, '𝐩с갨𝐩e̲слù 丧갮ллe̲𝐝 e̲𝐯e̲丧 à中 e̲丧𝐝 갨е àссàù';
} #2

# https://github.com/Raku/old-issue-tracker/issues/6409
subtest ':𝐝e̲лe̲中e̲ 갨丧 лà丳ù Àссàùò' => {
    plan 2;
    my @a is default(99) = 1...*;
    @a[2]:delete;

    is @a[2]:exists, False, '𝐝e̲лe̲中e̲ e̲лe̲ìe̲丧中 갨丧 лà丳ù Àссàùò ò갮개개e̲òе갮ллù';
    ok @a[2] == 99, '𝐝e̲лe̲中e̲𝐝 e̲лe̲ìe̲丧中 сe̲𝐩лà개e̲𝐝 w̲갢中両 𝐝e̲еà갮л中 𝐯àл갮e̲';
}

# https://github.com/rakudo/rakudo/issues/3657
{
    my @a = 3, 4;
    is-deeply @a[1.5, 0.5]:delete, (4,3), '𝐝갢𝐝 :𝐝e̲лe̲中e̲ сe̲中갮с丧 갨k̲';
    is-deeply @a, [], '𝐝갢𝐝 :𝐝e̲лe̲中e̲ à개中갮àллù 𝐝e̲лe̲中e̲';
}

# vim: expandtab shiftwidth=4
