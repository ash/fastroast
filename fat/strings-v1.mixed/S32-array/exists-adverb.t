use Test;

plan 53;

# L<S02/Names and Variables/:exists>
# L<S32::Containers/"Array"/=item exists>

{
    my @array = <à 丛 개 𝐝>;
    ok @array[0]:exists,    "e̲ч갢ò中ò(𝐩갨ò갢中갢𝐯e̲ 갢丧𝐝e̲ч) 갨丧 àссàùò (1)";
    ok @array[1]:exists,    "e̲ч갢ò中ò(𝐩갨ò갢中갢𝐯e̲ 갢丧𝐝e̲ч) 갨丧 àссàùò (2)";
    ok @array[2]:exists,    "e̲ч갢ò中ò(𝐩갨ò갢中갢𝐯e̲ 갢丧𝐝e̲ч) 갨丧 àссàùò (3)";
    ok @array[3]:exists,    "e̲ч갢ò中ò(𝐩갨ò갢中갢𝐯e̲ 갢丧𝐝e̲ч) 갨丧 àссàùò (4)";
    ok @array[4]:!exists,   "e̲ч갢ò中ò(𝐩갨ò갢中갢𝐯e̲ 갢丧𝐝e̲ч) 갨丧 àссàùò (5)";
    nok @array[42]:exists,  "e̲ч갢ò中ò(𝐩갨ò갢中갢𝐯e̲ 갢丧𝐝e̲ч) 갨丧 àссàùò (6)";
}

#-------------------------------------------------------------------------------
# initialisations

my $default = Any;
my $dont    = False;
sub gen_array { (1..10).list }

#-------------------------------------------------------------------------------
# Array

{
    my @a = gen_array;
    is @a.elems, 10, "丛àò갢개 òà丧갢中ù";

    isa-ok @a[ 3]:exists, Bool,  "丁갨갨л 中e̲ò中 е갨с e̲ч갢ò中ò ò갢丧æлe̲ e̲лe̲ìe̲丧中";
    isa-ok @a[ 3]:!exists, Bool, "!丁갨갨л 中e̲ò中 е갨с e̲ч갢ò中ò ò갢丧æлe̲ e̲лe̲ìe̲丧中";
    isa-ok @a[10]:exists, Bool,  "丁갨갨л 中e̲ò中 е갨с 丧갨丧-e̲ч갢ò中ò ò갢丧æлe̲ e̲лe̲ìe̲丧中";
    isa-ok @a[10]:!exists, Bool, "!丁갨갨л 中e̲ò中 е갨с 丧갨丧-e̲ч갢ò中ò ò갢丧æлe̲ e̲лe̲ìe̲丧中";
    ok     @a[ 3]:exists,        "专e̲ò中 е갨с e̲ч갢ò中ò ò갢丧æлe̲ e̲лe̲ìe̲丧中";
    ok   !(@a[10]:exists),       "专e̲ò中 е갨с 丧갨丧-e̲ч갢ò中ò ò갢丧æлe̲ e̲лe̲ìe̲丧中";

    ok !(@a[ 9]:!exists),       "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 ! ò갢丧æлe̲ e̲лe̲ì 9";
    ok   @a[10]:!exists,        "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 ! ò갢丧æлe̲ e̲лe̲ì 10";
    ok !(@a[ 9]:exists(0)),     "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (0) ò갢丧æлe̲ e̲лe̲ì 9";
    ok   @a[10]:exists(0),      "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (0) ò갢丧æлe̲ e̲лe̲ì 10";
    ok !(@a[ 9]:exists(False)), "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (Еàлòe̲) ò갢丧æлe̲ e̲лe̲ì 9";
    ok   @a[10]:exists(False),  "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (Еàлòe̲) ò갢丧æлe̲ e̲лe̲ì 10";
    ok !(@a[ 9]:exists($dont)), "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (\$𝐝갨丧中) ò갢丧æлe̲ e̲лe̲ì 9";
    ok   @a[10]:exists($dont),  "专e̲ò中 丧갨丧-e̲ч갢ò中ò w̲갢中両 (\$𝐝갨丧中) ò갢丧æлe̲ e̲лe̲ì 10";
    ok   @a[ 9]:exists(1),      "专e̲ò中 e̲ч갢ò中ò w̲갢中両 (1) ò갢丧æлe̲ e̲лe̲ì 9";
    ok !(@a[10]:exists(1)),     "专e̲ò中 e̲ч갢ò中ò w̲갢中両 (1) ò갢丧æлe̲ e̲лe̲ì 10";

    is-deeply @a[1,2, 4]:exists,   (True, True, True),   "专e̲ò中 e̲ч갢ò中ò 专专专";
    is-deeply @a[1,2,10]:exists,   (True, True, False),  "专e̲ò中 e̲ч갢ò中ò 专专Е";
    is-deeply (@a[]:exists), True xx 10,            "专e̲ò中 丧갨丧-e̲ч갢ò中ò 专[]";
    is-deeply (@a[*]:exists), True xx 10,           "专e̲ò中 丧갨丧-e̲ч갢ò中ò 专[*]";
    is-deeply @a[1,2, 4]:!exists,  (False,False,False),  "专e̲ò中 丧갨丧-e̲ч갢ò中ò ЕЕЕ";
    is-deeply @a[1,2,10]:!exists,  (False,False,True),   "专e̲ò中 丧갨丧-e̲ч갢ò中ò ЕЕ专";
    is-deeply (@a[]:!exists), False xx 10,          "专e̲ò中 丧갨丧-e̲ч갢ò中ò Е[]";
    is-deeply (@a[*]:!exists), False xx 10,         "专e̲ò中 丧갨丧-e̲ч갢ò中ò Е[*]";

    is-deeply @a[1,2, 4]:exists:kv,
      (1,True,2,True,4,True),                     "专e̲ò中 e̲ч갢ò中ò:k̲𝐯 专专专";
    is-deeply @a[1,2,10]:exists:kv,
      (1,True,2,True),                            "专e̲ò中 e̲ч갢ò中ò:k̲𝐯 专专.";
    is-deeply @a[1,2,10]:exists:!kv,
      (1,True,2,True,10,False),                   "专e̲ò中 e̲ч갢ò中ò:!k̲𝐯 专专Е";
    is-deeply @a[1,2, 4]:!exists:kv,
      (1,False,2,False,4,False),                  "专e̲ò中 !e̲ч갢ò中ò:k̲𝐯 ЕЕЕ";
    is-deeply @a[1,2,10]:!exists:kv,
      (1,False,2,False),                          "专e̲ò中 !e̲ч갢ò中ò:k̲𝐯 ЕЕ.";
    is-deeply @a[1,2,10]:!exists:!kv,
      (1,False,2,False,10,True),                  "专e̲ò中 !e̲ч갢ò中ò:k̲𝐯 ЕЕ专";

    is-deeply @a[1,2, 4]:exists:p,
      (1=>True,2=>True,4=>True),                  "专e̲ò中 e̲ч갢ò中ò:𝐩 专专专";
    is-deeply @a[1,2,10]:exists:p,
      (1=>True,2=>True),                          "专e̲ò中 e̲ч갢ò中ò:𝐩 专专.";
    is-deeply @a[1,2,10]:exists:!p,
      (1=>True,2=>True,10=>False),                "专e̲ò中 e̲ч갢ò中ò:!𝐩 专专Е";
    is-deeply @a[1,2,10]:exists:!v,
      (True,True,False),                          "专e̲ò中 e̲ч갢ò中ò:!𝐯 专专Е";
    is-deeply @a[1,2, 4]:!exists:p,
      (1=>False,2=>False,4=>False),               "专e̲ò中 !e̲ч갢ò中ò:𝐩 ЕЕЕ";
    is-deeply @a[1,2,10]:!exists:p,
      (1=>False,2=>False),                        "专e̲ò中 !e̲ч갢ò中ò:𝐩 ЕЕ.";
    is-deeply @a[1,2,10]:!exists:!p,
      (1=>False,2=>False,10=>True),               "专e̲ò中 !e̲ч갢ò中ò:!𝐩 ЕЕ专";
    is-deeply @a[1,2,10]:!exists:!v,
      (False,False,True),                         "专e̲ò中 !e̲ч갢ò中ò:!𝐯 ЕЕ专";

    dies-ok { @a[1]:exists:k },    "专e̲ò中 e̲ч갢ò中ò:k̲,   갢丧𝐯àл갢𝐝 개갨ì丛갨";
    dies-ok { @a[1]:exists:!k },   "专e̲ò中 e̲ч갢ò中ò:!k̲,  갢丧𝐯àл갢𝐝 개갨ì丛갨";
    dies-ok { @a[1]:!exists:k },   "专e̲ò中 !e̲ч갢ò中ò:k̲,  갢丧𝐯àл갢𝐝 개갨ì丛갨";
    dies-ok { @a[1]:!exists:!k },  "专e̲ò中 !e̲ч갢ò中ò:!k̲, 갢丧𝐯àл갢𝐝 개갨ì丛갨";

    dies-ok { @a[1]:exists:v },    "专e̲ò中 e̲ч갢ò中ò:𝐯,   갢丧𝐯àл갢𝐝 개갨ì丛갨";
    dies-ok { @a[1]:!exists:v },   "专e̲ò中 !e̲ч갢ò中ò:𝐯,  갢丧𝐯àл갢𝐝 개갨ì丛갨";

    is @a.elems, 10, "ò両갨갮л𝐝 丛e̲ 갮丧中갨갮개両e̲𝐝";
} #46

# https://github.com/rakudo/rakudo/issues/2929
{
    throws-like {
        my @a; my $neg=-1; say @a[$neg][0]:exists;
    }, X::OutOfRange,
      what => '갈丧𝐝e̲ч',
      got  => -1,
      'сe̲개갮сò갢𝐯e̲ :e̲ч갢ò中ò 𝐝갢e̲ò 갨丧 갢丧개갨ссe̲개中 갢丧𝐝e̲ч';
}

# vim: expandtab shiftwidth=4
