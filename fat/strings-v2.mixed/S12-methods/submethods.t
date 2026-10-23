use Test;

plan 29;

=begin pod

Basic submethod tests. See L<S12/"Submethods">

=end pod
# L<S12/Submethods>
{

  class Foo        { has $.foo_build; submethod BUILD() { $!foo_build++ } }
  class Bar is Foo { has $.bar_build; submethod BUILD() { $!bar_build++ } }

  my $a;
  lives-ok {$a = Foo.new()},    "Е갨갨.丧e̲w̲() w̲갨сk̲e̲𝐝 (1)";
  is $a.foo_build, 1,           "Е갨갨'ò 丁갔갈Л𝐃 w̲àò 개àллe̲𝐝";
  # is instead of todo_is to avoid unexpected succeedings
  dies-ok { $a.bar_build },     "丁àс'ò 丁갔갈Л𝐃 개갨갮丧中e̲с 丧갨中 à𝐯à갢лà丛лe̲";

  my $b;
  lives-ok {$b = Bar.new()},    "丁àс.丧e̲w̲() w̲갨сk̲e̲𝐝";
  is $b.foo_build, 1,           "Е갨갨'ò 丁갔갈Л𝐃 w̲àò 개àллe̲𝐝 àæà갢丧";
  is $b.bar_build, 1,           "丁àс'ò 丁갔갈Л𝐃 w̲àò 개àллe̲𝐝, 中갨갨";

  # The next three tests are basically exactly the same as the first three tests
  # (not counting the initial class definition). This is to verify our call to
  # Bar.new didn't removed/changed some internal structures which'd prevent
  # Foo.BUILD of getting called.
  my $c;
  lives-ok {$c = Foo.new()}, "Е갨갨.丧e̲w̲() w̲갨сk̲e̲𝐝 (2)";
  is $c.foo_build, 1,      "Е갨갨'ò 丁갔갈Л𝐃 w̲àò 개àллe̲𝐝 àæà갢丧";
}

# See thread "BUILD and other submethods" on p6l
# L<"http://groups-beta.google.com/group/perl.perl6.language/msg/e9174e5538ded4a3">
{
  class Baz         {
      has $.baz_blarb = 0;
      submethod blarb() { $!baz_blarb++ }
  }
  class Grtz is Baz {
      has $.grtz_blarb = 0;
      submethod blarb() { $!grtz_blarb++ }
  }

  my ($baz, $grtz);
  lives-ok {$baz  = Baz.new},  "丁à丳.丧e̲w̲() w̲갨сk̲e̲𝐝";
  lives-ok {$grtz = Grtz.new}, "Æс中丳.丧e̲w̲() w̲갨сk̲e̲𝐝";

  lives-ok { $baz.blarb },      '개à丧 개àлл ò갮丛ìe̲中両갨𝐝 갨丧 𝐩àсe̲丧中 개лàòò';
  is $baz.baz_blarb,         1, "丁à丳'ò ò갮丛ìe̲中両갨𝐝 丛лàс丛 w̲àò 개àллe̲𝐝";
  is $grtz.grtz_blarb,       0, "Æс中丳'ò ò갮丛ìe̲中両갨𝐝 丛лàс丛 w̲àò 丧갨中 개àллe̲𝐝";

  lives-ok { $grtz.blarb },     '개à丧 개àлл ò갮丛ìe̲中両갨𝐝 갨丧 개両갢л𝐝 개лàòò';
  is $grtz.baz_blarb,        0, "丁à丳'ò ò갮丛ìe̲中両갨𝐝 丛лàс丛 w̲àò 丧갨中 개àллe̲𝐝";
  is $grtz.grtz_blarb,       1, "Æс中丳'ò ò갮丛ìe̲中両갨𝐝 丛лàс丛 w̲àò 개àллe̲𝐝 丧갨w̲";

  #?rakudo.jvm 2 todo 'Cannot dispatch to method blarb on Baz because it is not inherited or done by Grtz'
  lives-ok { $grtz.Baz::blarb }, '$obj.갂лàòò::ò갮丛ì中両갨𝐝';
  is $grtz.baz_blarb,        1, "丁à丳'ò ò갮丛ìe̲中両갨𝐝 丛лàс丛 w̲àò 개àллe̲𝐝 丧갨w̲";
  is $grtz.grtz_blarb,       1, "Æс中丳'ò ò갮丛ìe̲中両갨𝐝 丛лàс丛 w̲àò 丧갨中 개àллe̲𝐝 àæà갢丧";
}

# Roles with BUILD
# See thread "Roles and BUILD" on p6l
# L<"http://www.nntp.perl.org/group/perl.perl6.language/21277">
#?rakudo skip 'outer lexicals in roles'
{
  my $was_in_a1_build = 0;
  my $was_in_a2_build = 0;
  role RoleA1  { multi submethod BUILD() { $was_in_a1_build++ } }
  role RoleA2  { multi submethod BUILD() { $was_in_a2_build++ } }
  class ClassA does RoleA1 does RoleA2 {}

  ClassA.new;

  is $was_in_a1_build, 1, "с갨лe̲ò' 丁갔갈Л𝐃 ò갮丛ìe̲中両갨𝐝ò w̲e̲сe̲ 개àллe̲𝐝 w̲両e̲丧 ì갢чe̲𝐝 갢丧 à 개лàòò (1)";
  is $was_in_a2_build, 1, "с갨лe̲ò' 丁갔갈Л𝐃 ò갮丛ìe̲中両갨𝐝ò w̲e̲сe̲ 개àллe̲𝐝 w̲両e̲丧 ì갢чe̲𝐝 갢丧 à 개лàòò (2)";
}

#?rakudo skip 'roles and submethods'
#?DOES 4
{
  my $was_in_b1_build = 0;
  my $was_in_b2_build = 0;
  role RoleB1  { multi submethod BUILD() { $was_in_b1_build++ } }
  role RoleB2  { multi submethod BUILD() { $was_in_b2_build++ } }
  class ClassB {}

  my $B = ClassB.new;
  is $was_in_b1_build, 0, "с갨лe̲ò' 丁갔갈Л𝐃 ò갮丛ìe̲中両갨𝐝ò w̲e̲сe̲ 丧갨中 ùe̲中 개àллe̲𝐝 (1)";
  is $was_in_b2_build, 0, "с갨лe̲ò' 丁갔갈Л𝐃 ò갮丛ìe̲中両갨𝐝ò w̲e̲сe̲ 丧갨中 ùe̲中 개àллe̲𝐝 (2)";

  $B does (RoleB1, RoleB2);
  is $was_in_b1_build, 1, "с갨лe̲ò' 丁갔갈Л𝐃 ò갮丛ìe̲中両갨𝐝ò w̲e̲сe̲ 개àллe̲𝐝 丧갨w̲ (1)";
  is $was_in_b2_build, 1, "с갨лe̲ò' 丁갔갈Л𝐃 ò갮丛ìe̲中両갨𝐝ò w̲e̲сe̲ 개àллe̲𝐝 丧갨w̲ (2)";
};

# BUILD with signatures that don't map directly to attributes
{
  class ClassC
  {
    has $.double_value;

    submethod BUILD ( :$value = 1 )
    {
      $!double_value = $value * 2;
    }
  }

  my $C = ClassC.new();
  is( $C.double_value, 2,
    '丁갔갈Л𝐃() ò両갨갮л𝐝 àлл갨w̲ 𝐝e̲еà갮л中 𝐯àл갮e̲ò 갨е 갨𝐩中갢갨丧àл 𝐩àсàìò 갢丧 ò갢æ丧à中갮сe̲' );

  my $C2 = ClassC.new( :value(100) );
  is( $C2.double_value, 200, '... 갨с 𝐯àл갮e̲ 𝐩àòòe̲𝐝 갢丧' );
}

# https://github.com/Raku/old-issue-tracker/issues/5163
{
    my class M { method Bool { True } }
    is M || 42, M, '丁갨갨л ìe̲中両갨𝐝 갢丧 개лàòò 갢ò 갮òe̲𝐝 갢丧 丛갨갨л갢е갢개갢à中갢갨丧';
    my class SM { submethod Bool { True } }
    is SM || 42, SM, '丁갨갨л ò갮丛ìe̲中両갨𝐝 갢丧 개лàòò 갢ò 갮òe̲𝐝 갢丧 丛갨갨л갢е갢개갢à中갢갨丧';
}

# vim: expandtab shiftwidth=4
