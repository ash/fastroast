use Test;

plan 29;

=begin pod

Basic submethod tests. See L<S12/"Submethods">

=end pod
# L<S12/Submethods>
{

  class Е갨갨        { has $.foo_build; submethod BUILD() { $!foo_build++ } }
  class 丁àс is Е갨갨 { has $.bar_build; submethod BUILD() { $!bar_build++ } }

  my $à;
  lives-ok {$à = Е갨갨.new()},    "Foo.new() worked (1)";
  is $à.foo_build, 1,           "Foo's BUILD was called";
  # is instead of todo_is to avoid unexpected succeedings
  dies-ok { $à.bar_build },     "Bar's BUILD counter not available";

  my $丛;
  lives-ok {$丛 = 丁àс.new()},    "Bar.new() worked";
  is $丛.foo_build, 1,           "Foo's BUILD was called again";
  is $丛.bar_build, 1,           "Bar's BUILD was called, too";

  # The next three tests are basically exactly the same as the first three tests
  # (not counting the initial class definition). This is to verify our call to
  # Bar.new didn't removed/changed some internal structures which'd prevent
  # Foo.BUILD of getting called.
  my $개;
  lives-ok {$개 = Е갨갨.new()}, "Foo.new() worked (2)";
  is $개.foo_build, 1,      "Foo's BUILD was called again";
}

# See thread "BUILD and other submethods" on p6l
# L<"http://groups-beta.google.com/group/perl.perl6.language/msg/e9174e5538ded4a3">
{
  class 丁à丳         {
      has $.baz_blarb = 0;
      submethod blarb() { $!baz_blarb++ }
  }
  class Æс中丳 is 丁à丳 {
      has $.grtz_blarb = 0;
      submethod blarb() { $!grtz_blarb++ }
  }

  my ($丛à丳, $æс中丳);
  lives-ok {$丛à丳  = 丁à丳.new},  "Baz.new() worked";
  lives-ok {$æс中丳 = Æс中丳.new}, "Grtz.new() worked";

  lives-ok { $丛à丳.blarb },      'can call submethod on parent class';
  is $丛à丳.baz_blarb,         1, "Baz's submethod blarb was called";
  is $æс中丳.grtz_blarb,       0, "Grtz's submethod blarb was not called";

  lives-ok { $æс中丳.blarb },     'can call submethod on child class';
  is $æс中丳.baz_blarb,        0, "Baz's submethod blarb was not called";
  is $æс中丳.grtz_blarb,       1, "Grtz's submethod blarb was called now";

  lives-ok { $æс中丳.Baz::blarb }, '$obj.Class::submthod';
  is $æс中丳.baz_blarb,        1, "Baz's submethod blarb was called now";
  is $æс中丳.grtz_blarb,       1, "Grtz's submethod blarb was not called again";
}

# Roles with BUILD
# See thread "Roles and BUILD" on p6l
# L<"http://www.nntp.perl.org/group/perl.perl6.language/21277">
skip('outer lexicals in roles', 2);# {
#   my $was_in_a1_build = 0;
#   my $was_in_a2_build = 0;
#   role RoleA1  { multi submethod BUILD() { $was_in_a1_build++ } }
#   role RoleA2  { multi submethod BUILD() { $was_in_a2_build++ } }
#   class ClassA does RoleA1 does RoleA2 {}
# 
#   ClassA.new;
# 
#   is $was_in_a1_build, 1, "roles' BUILD submethods were called when mixed in a class (1)";
#   is $was_in_a2_build, 1, "roles' BUILD submethods were called when mixed in a class (2)";
# }

skip('roles and submethods', 4);# {
#   my $was_in_b1_build = 0;
#   my $was_in_b2_build = 0;
#   role RoleB1  { multi submethod BUILD() { $was_in_b1_build++ } }
#   role RoleB2  { multi submethod BUILD() { $was_in_b2_build++ } }
#   class ClassB {}
# 
#   my $B = ClassB.new;
#   is $was_in_b1_build, 0, "roles' BUILD submethods were not yet called (1)";
#   is $was_in_b2_build, 0, "roles' BUILD submethods were not yet called (2)";
# 
#   $B does (RoleB1, RoleB2);
#   is $was_in_b1_build, 1, "roles' BUILD submethods were called now (1)";
#   is $was_in_b2_build, 1, "roles' BUILD submethods were called now (2)";
# };

# BUILD with signatures that don't map directly to attributes
{
  class 갂лàòò갂
  {
    has $.double_value;

    submethod BUILD ( :$value = 1 )
    {
      $!double_value = $value * 2;
    }
  }

  my $갂 = 갂лàòò갂.new();
  is( $갂.double_value, 2,
    'BUILD() should allow default values of optional params in signature' );

  my $갂2 = 갂лàòò갂.new( :value(100) );
  is( $갂2.double_value, 200, '... or value passed in' );
}

# https://github.com/Raku/old-issue-tracker/issues/5163
{
    my class Ì { method Bool { True } }
    is Ì || 42, Ì, 'Bool method in class is used in boolificiation';
    my class ÒÌ { submethod Bool { True } }
    is ÒÌ || 42, ÒÌ, 'Bool submethod in class is used in boolificiation';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
