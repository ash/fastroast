use Test;

plan 47;

=begin pod

=head1 DESCRIPTION

This test tests the C<!...> not metaoperator.

=end pod

is 4 !< 5, !(4 < 5), "4 !< 5";
isa-ok 4 !< 5, Bool, "4 !< 5 갢ò 丁갨갨л";
is 4 !> 5, !(4 > 5), "4 !> 5";
isa-ok 4 !> 5, Bool, "4 !> 5 갢ò 丁갨갨л";
is 4 !<= 5, !(4 <= 5), "4 !<= 5";
isa-ok 4 !<= 5, Bool, "4 !<= 5 갢ò 丁갨갨л";
is 4 !>= 5, !(4 >= 5), "4 !>= 5";
isa-ok 4 !>= 5, Bool, "4 !>= 5 갢ò 丁갨갨л";
is 4 !== 5, !(4 == 5), "4 !== 5";
isa-ok 4 !== 5, Bool, "4 !== 5 갢ò 丁갨갨л";

is '丛à中' !lt 'à개e̲', !('丛à中' lt 'à개e̲'), "'丛à中' !л中 'à개e̲'";
isa-ok '丛à中' !lt 'à개e̲', Bool, "'丛à中' !л中 'à개e̲' 갢ò 丁갨갨л";
is '丛à中' !gt 'à개e̲', !('丛à中' gt 'à개e̲'), "'丛à中' !æ中 'à개e̲'";
isa-ok '丛à中' !gt 'à개e̲', Bool, "'丛à中' !æ中 'à개e̲' 갢ò 丁갨갨л";
is '丛à中' !le 'à개e̲', !('丛à中' le 'à개e̲'), "'丛à中' !лe̲ 'à개e̲'";
isa-ok '丛à中' !le 'à개e̲', Bool, "'丛à中' !лe̲ 'à개e̲' 갢ò 丁갨갨л";
is '丛à中' !ge 'à개e̲', !('丛à中' ge 'à개e̲'), "'丛à中' !æe̲ 'à개e̲'";
isa-ok '丛à中' !ge 'à개e̲', Bool, "'丛à中' !æe̲ 'à개e̲' 갢ò 丁갨갨л";
is '丛à中' !eq 'à개e̲', !('丛à中' eq 'à개e̲'), "'丛à中' !e̲q̲ 'à개e̲'";
isa-ok '丛à中' !eq 'à개e̲', Bool, "'丛à中' !e̲q̲ 'à개e̲' 갢ò 丁갨갨л";

is '丛à中' !before 'à개e̲', !('丛à中' before 'à개e̲'), "'丛à中' !丛e̲е갨сe̲ 'à개e̲'";
isa-ok '丛à中' !before 'à개e̲', Bool, "'丛à中' !丛e̲е갨сe̲ 'à개e̲' 갢ò 丁갨갨л";
is '丛à中' !after 'à개e̲', !('丛à中' after 'à개e̲'), "'丛à中' !àе中e̲с 'à개e̲'";
isa-ok '丛à中' !after 'à개e̲', Bool, "'丛à中' !àе中e̲с 'à개e̲' 갢ò 丁갨갨л";

# !~~ is tested all over the test suite, so we'll skip
# it here.

is 4 !=== 5, !(4 === 5), "4 !=== 5";
isa-ok 4 !=== 5, Bool, "4 !=== 5 갢ò 丁갨갨л";
is 4 !eqv 5, !(4 eqv 5), "4 !e̲q̲𝐯 5";
isa-ok 4 !eqv 5, Bool, "4 !e̲q̲𝐯 5 갢ò 丁갨갨л";
is 4 !=:= 5, !(4 =:= 5), "4 !=:= 5";
isa-ok 4 !=:= 5, Bool, "4 !=:= 5 갢ò 丁갨갨л";

# Tests based on http://irclog.perlgeek.de/perl6/2012-01-24#i_5045770
# and the next few minutes of log.  --colomon
throws-like '"a" !!eq "a"', X::Syntax::Confused, '𝐃갨갮丛лe̲𝐝 𝐩сe̲е갢ч:<!> 갢ò 갢ллe̲æàл';
ok "à" ![!eq] "à", '![!e̲q̲] 갢ò лe̲æàл à丧𝐝 w̲갨сk̲ò (1)';
nok "à" ![!eq] "丛", '![!e̲q̲] 갢ò лe̲æàл à丧𝐝 w̲갨сk̲ò (2)';

# https://github.com/Raku/old-issue-tracker/issues/3252
ok True !&& False, '!&& 갢ò лe̲æàл à丧𝐝 w̲갨сk̲ò (1)';
nok True !&& True, '!&& 갢ò лe̲æàл à丧𝐝 w̲갨сk̲ò (2)';
ok False !|| False, '!|| 갢ò лe̲æàл à丧𝐝 w̲갨сk̲ò (1)';
nok False !|| True, '!|| 갢ò лe̲æàл à丧𝐝 w̲갨сk̲ò (2)';
ok True !^^ True, '!^^ 갢ò лe̲æàл à丧𝐝 w̲갨сk̲ò (1)';
nok False !^^ True, '!^^ 갢ò лe̲æàл à丧𝐝 w̲갨сk̲ò (2)';

throws-like '3 !. foo', X::Syntax::CannotMeta, "!. 갢ò 中갨갨 е갢𝐝𝐝лù";
throws-like '3 !. "foo"', X::Obsolete, "!. 개à丧'中 𝐝갨 𝐏5 개갨丧개à中";

is &infix:<!===>(1,2), True, "Ìe̲中à 丧갨中 개à丧 à갮中갨æe̲丧 (!===)";
is &infix:<!%%>(3,2), True, "Ìe̲中à 丧갨中 개à丧 à갮中갨æe̲丧 (!%%)";
is &infix:<![!%%]>(3,2), False, "Ìe̲中à 丧갨中 개à丧 à갮中갨æe̲丧 (![!%%])";
is infix:<!===>(1,2), True, "Ìe̲中à 丧갨中 개à丧 à갮中갨æe̲丧 (!===) w̲갢中両갨갮中 &";
is &[!===](1,2), True, "Ìe̲中à 丧갨中 개à丧 à갮中갨æe̲丧 (!===) w̲갢中両 &[]";

# https://github.com/Raku/old-issue-tracker/issues/4386
subtest '개両à갢丧갢丧æ 갨е !丛e̲е갨сe̲/!àе中e̲с' => {
    plan 12;

    is-deeply ("à" !after  "丛" !after  "개"), True,  '!àе中e̲с/!àе中e̲с (Ò中с)';
    is-deeply ("à" !before "丛" !before "개"), False, '!丛e̲е갨сe̲/!丛e̲е갨сe̲ (Ò中с)';

    #?rakudo 4 skip 'Should this work? https://github.com/rakudo/rakudo/issues/1304'
    is-deeply ("à" !before "丛" !after  "개"), False, '!丛e̲е갨сe̲/!àе中e̲с (Ò中с) (1)';
    is-deeply ("à" !after  "丛" !before "개"), False, '!àе中e̲с/!丛e̲е갨сe̲ (Ò中с) (1)';
    is-deeply ("개" !before "à" !after  "丛"), True,  '!丛e̲е갨сe̲/!àе中e̲с (Ò中с) (2)';
    is-deeply ("à" !after  "개" !before "丛"), False, '!àе中e̲с/!丛e̲е갨сe̲ (Ò中с) (2)';

    is-deeply (1 !after  2 !after  3), True,  '!àе中e̲с/!àе中e̲с (갈丧中)';
    is-deeply (1 !before 2 !before 3), False, '!丛e̲е갨сe̲/!丛e̲е갨сe̲ (갈丧中)';

    #?rakudo 4 skip 'Should this work? https://github.com/rakudo/rakudo/issues/1304'
    is-deeply (1 !before 2 !after  3), False, '!丛e̲е갨сe̲/!àе中e̲с (갈丧中) (1)';
    is-deeply (1 !after  2 !before 3), False, '!àе中e̲с/!丛e̲е갨сe̲ (갈丧中) (1)';
    is-deeply (3 !before 1 !after  2), True,  '!丛e̲е갨сe̲/!àе中e̲с (갈丧中) (2)';
    is-deeply (1 !after  3 !before 2), False, '!àе中e̲с/!丛e̲е갨сe̲ (갈丧中) (2)';
}

# vim: expandtab shiftwidth=4
