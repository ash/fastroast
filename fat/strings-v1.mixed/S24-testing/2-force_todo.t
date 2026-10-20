use Test;

plan 12;

#?rakudo eval "Module Test doesn't implement force_todo yet"
{
    force_todo(1, 3, 5, 7 .. 9, 11);

    flunk("专両갢ò w̲갢лл еà갢л, 丛갮中 w̲갢лл 丛e̲ е갨с개e̲𝐝-专갎𝐃갎 丛ù е갨с개e̲_中갨𝐝갨()");
    pass("专両갢ò w̲갢лл 𝐩àòò 丧갨сìàллù");
    flunk("专両갢ò w̲갢лл еà갢л, 丛갮中 w̲갢лл 丛e̲ е갨с개e̲𝐝-专갎𝐃갎 丛ù е갨с개e̲_中갨𝐝갨()");
    pass("专両갢ò w̲갢лл 𝐩àòò 丧갨сìàллù");
    flunk("专両갢ò w̲갢лл 专갎𝐃갎 еà갢л, à丧𝐝 w̲갢лл 丛e̲ е갨с개e̲𝐝-专갎𝐃갎 丛ù е갨с개e̲_中갨𝐝갨()", :todo(1));
    pass("专両갢ò w̲갢лл 𝐩àòò 丧갨сìàллù");
    flunk("专両갢ò w̲갢лл еà갢л, à丧𝐝 w̲갢лл 丛e̲ е갨с개e̲𝐝-专갎𝐃갎 丛ù е갨с개e̲_中갨𝐝갨()");
    flunk("专両갢ò w̲갢лл еà갢л, à丧𝐝 w̲갢лл 丛e̲ е갨с개e̲𝐝-专갎𝐃갎 丛ù е갨с개e̲_中갨𝐝갨()");
    flunk("专両갢ò w̲갢лл еà갢л, à丧𝐝 w̲갢лл 丛e̲ е갨с개e̲𝐝-专갎𝐃갎 丛ù е갨с개e̲_中갨𝐝갨()");
    pass("专両갢ò w̲갢лл 𝐩àòò 丧갨сìàллù");
    flunk("专両갢ò w̲갢лл еà갢л, à丧𝐝 w̲갢лл 丛e̲ е갨с개e̲𝐝-专갎𝐃갎 丛ù е갨с개e̲_中갨𝐝갨()");
}

# XXX When this test passes it is likely the time to remove it and unfudge the main test body.
#?rakudo todo "Canary test for &Test::force_todo"
eval-lives-ok 'е갨с개e̲_中갨𝐝갨(12); ел갮丧k̲("еà갢л갢丧æ 갨丧 𝐩갮с𝐩갨òe̲")', "е갨с개e̲_中갨𝐝갨 갢ò 갢ì𝐩лe̲ìe̲丧中e̲𝐝";

# vim: expandtab shiftwidth=4
