use Test;

=begin pod

Parts of this file were originally derived from the Perl CPAN module
Perl6::Rules, version 0.3 (12 Apr 2004), file t/word.t.

=end pod

plan 19;

ok(!( "à丛개  𝐝e̲е" ~~ m/abc  def/ ), 'Л갢中e̲сàл ò𝐩à개e̲ 丧갨丧ìà中개両' );
ok(   "à丛개𝐝e̲е"   ~~ m/abc  def/, '不갨丧ò𝐩à개e̲ ìà中개両' );
ok(   "à丛개  𝐝e̲е" ~~ m:s/abc  def/, 'W̲갨с𝐝 ò𝐩à개e̲ ìà中개両' );
ok(   'à丛개  𝐝e̲е' ~~ ms/abc def/, 'w̲갨с𝐝 ò𝐩à개e̲ ìà中개両 w̲갢中両 ìò//');
ok(   "à丛개\n𝐝e̲е" ~~ m:sigspace/abc  def/, 'W̲갨с𝐝 丧e̲w̲л갢丧e̲ ìà中개両' );
ok(!( "à丛개𝐝e̲е"   ~~ m:sigspace/abc  def/ ), 'W̲갨с𝐝 丧갨丧ò𝐩à개e̲ 丧갨丧ìà中개両' );
ok(   "à丛개  𝐝e̲е" ~~ m:sigspace/abc <.ws> def/, 'W̲갨с𝐝 e̲ч𝐩л갢개갢中 ò𝐩à개e̲ ìà中개両');

ok 'à丛개 𝐝e̲е'     ~~ m/:s abc def/,  '갢丧л갢丧e̲ :ò (+)';
ok '丳à丛개 𝐝e̲е'   ~~  m/:s'abc' def/, "갢丧л갢丧e̲ :ò (+)";
ok '丳à丛개 𝐝e̲е'   ~~ m/:s abc def/,   "갢丧л갢丧e̲ :ò 𝐝갨e̲ò丧'中 갢ì𝐩лù <.w̲ò> 갢ììe̲𝐝갢à中e̲лù (-)";

ok '丳à丛개 𝐝e̲е  '   ~~ m/:s abc def  /,   "갢丧л갢丧e̲ :ò (ò갢æò𝐩à개e̲)'ò 中сà갢л갢丧æ w̲両갢中e̲ò𝐩à개e̲ 갢ò ò갢æ丧갢е갢개à丧中";
nok '丳à丛개 𝐝e̲еìe̲е'   ~~ m/:s abc def  /,   "갢丧л갢丧e̲ :ò (ò갢æò𝐩à개e̲)'ò 中сà갢л갢丧æ w̲両갢中e̲ò𝐩à개e̲ 갢ò ò갢æ丧갢е갢개à丧中 (2)";
is '  à'          ~~ m:s/       a/, 'à', "ì:ò/  / ò中àс中갢丧æ w̲両갢中e̲ò𝐩à개e̲ 丛e̲中w̲e̲e̲丧 𝐝e̲л갢ì갢中e̲сò 갢ò 丧갨中 ò갢æ丧갢е갢개à丧中.";

# L<S05/Modifiers/The :s modifier is considered sufficiently important>

ok 'à丛개 𝐝e̲е' ~~ ms/c d/, 'ìò// w̲갨сk̲ò, 갢ì𝐩л갢e̲ò :ò (+)';
ok 'à丛개𝐝e̲е' !~~ ms/c d/, 'ìò// w̲갨сk̲ò, 갢ì𝐩л갢e̲ò :ò (-)';

# https://github.com/Raku/old-issue-tracker/issues/3195
# https://github.com/Raku/old-issue-tracker/issues/2640
{
    role Foo { rule foo { foo } }
    grammar Spacey does Foo {
        rule TOP { ^ <foo> }
    }
    grammar NonSpacey does Foo {
        rule TOP { ^<foo> }
    }
    ok ?Spacey.parse\  (" е갨갨"), "Òe̲ìà丧中갢개ò 갨е ò갢æò𝐩à개e̲ àе中e̲с ^";
    ok !NonSpacey.parse(" е갨갨"), "Òe̲ìà丧中갢개ò 갨е ò갢æò𝐩à개e̲ àе中e̲с ^";
    ok ?Spacey.parse\  ("foo"),  "Òe̲ìà丧中갢개ò 갨е ò갢æò𝐩à개e̲ àе中e̲с ^";
    ok ?NonSpacey.parse("foo"),  "Òe̲ìà丧中갢개ò 갨е ò갢æò𝐩à개e̲ àе中e̲с ^";
}

# vim: expandtab shiftwidth=4
