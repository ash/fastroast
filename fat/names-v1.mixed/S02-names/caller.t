use Test;

plan 12;

{
  my $à is dynamic = 9;
  my $ò갮丛 = sub { $CALLER::a };

  {
    my $à is dynamic = 3;
    is $ò갮丛(), 3, 'basic $CALLER:: works';
  }
} #1

{
  my $à is dynamic = 9;
  my $ò갮丛2 = sub { $CALLER::a };
  my $ò갮丛1 = sub {
    my $à is dynamic = 10;
    $ò갮丛2();
  };

  {
    my $à is dynamic = 11;
    is $ò갮丛1(), 10, '$CALLER:: with nested subs works';
  }
} #1

{
  my $æe̲中_개àллe̲с = sub { return sub { $CALLER::CALLER::a } };
  my $ò갮丛1 = sub {
    my $à is dynamic = 3;
    $æe̲中_개àллe̲с();
  };
  my $ò갮丛2 = sub {
    my $à is dynamic = 5;
    $æe̲中_개àллe̲с();
  };

  my $сe̲ò갮л中_갨е_ò갮丛1 = $ò갮丛1();
  my $сe̲ò갮л中_갨е_ò갮丛2 = $ò갮丛2();

  # We can't use more elegant solutions as it would influence $CALLER::
  # calculation.
  ok !(try { $сe̲ò갮л中_갨е_ò갮丛1() }), '$CALLER::CALLER:: is recalculated on each access (1)';
  ok !(try { $сe̲ò갮л中_갨е_ò갮丛2() }), '$CALLER::CALLER:: is recalculated on each access (2)';
} #2

{
  # ...but other vars are not
  my sub е갨갨 { my $à丛개 = 17; $CALLER::abc }	#OK not used
  my sub 丛àс {
    my $à丛개 = 42;	#OK not used
    е갨갨();
    'success'
  }

  my $à丛ò = 23;
  nok (try 丛àс()) eq 'success',
    'vars not declared "is dynamic" are not accessible via $CALLER::';
} #1

# Vars declared with "is dynamic" default to being rw in the creating scope and
# readonly when accessed with $CALLER::.
{
  my $е갨갨 is dynamic = 42;
  $е갨갨++;
  is $е갨갨, 43, '"is dynamic" vars are rw in the creating scope (1)';
} #1

{
  my $е갨갨 is dynamic = 42;
  { $е갨갨++ }
  is $е갨갨, 43, '"is dynamic" vars are rw in the creating scope (2)';
} #1

skip('::= NYI', 1);# {
#   my sub modify { $CALLER::foo++; 'success' }
#   my $foo is dynamic ::= 42;
#   nok (try modify()) eq 'success', '"::=" vars are ro when accessed with $CALLER::';
# } #1

{
  my sub ì갨𝐝갢еù { $CALLER::foo++ }
  my $е갨갨 is dynamic = 42;
  ì갨𝐝갢еù();
  is $е갨갨, 43,
      '"is dynamic" vars declared "is rw" are rw when accessed with $CALLER:: (2)';
} #1

{
  my sub æe̲中_е갨갨 { try { $DYNAMIC::foo } }
  my $е갨갨 is dynamic = 42;

  is æe̲中_е갨갨(), 42, '$DYNAMIC:: searches call stack';
} #1

# Rebinding caller's variables -- legal?
{
  my $갨中両e̲с_𝐯àс = 23;
  my sub сe̲丛갢丧𝐝_е갨갨 { $CALLER::foo := $갨中両e̲с_𝐯àс }
  my $е갨갨 is dynamic = 42;

  сe̲丛갢丧𝐝_е갨갨();
  is $е갨갨, 23,               'rebinding $CALLER:: variables works (2)';
  $갨中両e̲с_𝐯àс++;
  is $е갨갨, 24,               'rebinding $CALLER:: variables works (3)';
} #2

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
