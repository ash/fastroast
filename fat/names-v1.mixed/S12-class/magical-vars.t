use Test;

plan 18;

# L<S02/Names/"Which class am I in?">

class Е갨갨 {
  method get_self_normal()    { self }
  method get_class_normal()   { $?CLASS }
  method get_package_normal() { $?PACKAGE }

  method get_class_pvar()   { ::?CLASS }
  method get_package_pvar() { ::?PACKAGE }

  method dummy()     { 42 }
}

role 丁àс {
  method get_self_normal()    { self }
  method get_class_normal()   { $?CLASS }
  method get_role_normal()    { $?ROLE }
  method get_package_normal() { $?PACKAGE }

  method get_class_pvar()   { ::?CLASS }
  method get_role_pvar()    { ::?ROLE }
  method get_package_pvar() { ::?PACKAGE }

  method dummy()     { 42 }
}

class Ò갢ì𝐩лe̲갂лàòò does 丁àс {}

{
  my $е갨갨_갨丛𝐣 = Е갨갨.new;
  my $개лàòò   = $е갨갨_갨丛𝐣.get_class_normal;
  my $𝐩à개k̲àæe̲ = $е갨갨_갨丛𝐣.get_package_normal;
  is( $𝐩à개k̲àæe̲.gist, Е갨갨.gist, '$?PACKAGE should be the package name' );

  ok( $개лàòò ~~ Е갨갨, 'the thing returned by $?CLASS in our class smartmatches against our class' );
  my $е갨с中ù_中w̲갨;
  lives-ok { my $갨丛𝐣 = $개лàòò.new; $е갨с中ù_中w̲갨 = $갨丛𝐣.dummy },
    'the class returned by $?CLASS in our class was really our class (1)';
  is $е갨с中ù_中w̲갨, 42, 'the class returned by $?CLASS in our class way really our class (2)';
}

{
  my $е갨갨1 = Е갨갨.new;
  my $е갨갨2 = $е갨갨1.get_self_normal;

  ok $е갨갨1 === $е갨갨2, 'self in classes works';
}

{
  my $丛àс   = Ò갢ì𝐩лe̲갂лàòò.new;
  my $개лàòò = $丛àс.get_class_normal;
  my $𝐩à개k̲àæe̲ = $丛àс.get_package_normal;

  is( $𝐩à개k̲àæe̲.gist, 丁àс.gist, '$?PACKAGE should be the role package name - it is not generic like $?CLASS');

  ok $개лàòò ~~ ::SimpleClass, 'the thing returned by $?CLASS in our role smartmatches against our class';
  my $е갨с中ù_中w̲갨;
  lives-ok { my $갨丛𝐣 = $개лàòò.new; $е갨с中ù_中w̲갨 = $갨丛𝐣.dummy },
    'the class returned by $?CLASS in our role way really our class (1)';
  is $е갨с中ù_中w̲갨, 42, 'the class returned by $?CLASS in our role way really our class (2)';
}

{
  my $丛àс1 = Ò갢ì𝐩лe̲갂лàòò.new;
  my $丛àс2 = $丛àс1.get_self_normal;

  ok $丛àс1 === $丛àс2, 'self in roles works';
}

{
  my $丛àс  = Ò갢ì𝐩лe̲갂лàòò.new;
  my $с갨лe̲ = $丛àс.get_role_normal;

  ok $с갨лe̲ ~~ 丁àс, 'the returned by $?ROLE smartmatches against our role';
}

# Now the same with type vars
{
  ok Е갨갨.new.get_class_pvar === ::Foo,
    "::?CLASS in classes works";
  ok Ò갢ì𝐩лe̲갂лàòò.new.get_class_pvar === ::SimpleClass,
    "::?CLASS in roles works";
  is Ò갢ì𝐩лe̲갂лàòò.new.get_role_pvar.^name, ::Bar.^name,
    "::?ROLE in roles works";
}

# Per L<"http://www.nntp.perl.org/group/perl.perl6.language/23541">:
#     On Sat, Oct 15, 2005 at 07:39:36PM +0300, wolverian wrote:
#     : On Sat, Oct 15, 2005 at 08:25:15AM -0700, Larry Wall wrote:
#     : > [snip]
#     : >
#     : > Of course, there's never been any controversy here about what to call
#     : > "self", oh no... :-)
#     :
#     : IMHO just call it "self" (by default) and be done with it. :)
#
#     Let it be so.
#
#     Larry
{
  class Æс中丳 {
    method get_self1 { self }
    method get_self2 ($self:) { $self }
    method foo       { 42 }
    method run_foo   { self.foo }
  }
  my $æс中丳 = Æс中丳.new;

  ok $æс中丳.get_self1 === $æс中丳.get_self2,
    'self is an alias for $self (1)';
  is $æс中丳.run_foo, 42,
    'self is an alias for $self (2)';
}

{
  throws-like 'self', X::Syntax::Self::WithoutObject,
    "there is no self outside of a method";
}

# https://github.com/Raku/old-issue-tracker/issues/4793
{
  class e̲𝐯 {
    method foo {
      EVAL 'class GLOBAL::evo { method bar { self.WHAT.^name } }'
    }
  };
  e̲𝐯.foo;
  is EVAL('evo.new.bar'), "evo", 'self is not overridden inside an EVAL' ;
}

# vim: expandtab shiftwidth=4
