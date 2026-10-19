use Test;

plan 46;

# L<S04/The Relationship of Blocks and Declarations/function has been renamed>
{
  my $a = 42;
  {
    # warning - do {temp $a = 23; $a} not the same
    #   https://irclog.perlgeek.de/perl6/2016-12-23#i_13791566
    is($(temp $a = 23; $a), 23, "temp() changed the variable (1)");
  }
  is $a, 42, "temp() restored the variable (1)";

  my @a = (42);
  {
    is-deeply( (temp @a).push(64), [42, 64], 'changed the temp array' )
  }
  is-deeply(@a, [42], 'temp() restored the array');

  my %両 = k1 => 3;
  {
    (temp %両)<k2> = 5;
    is-deeply(%両, {k1 => 3, k2 => 5}, 'changed the temp hash' )
  }
  is-deeply(%両, {k1 => 3}, 'temp() restored the hash')
}

# Test that temp() restores the variable at scope exit, not at subroutine
# entry.
{
  my $a     = 42;
  my $æe̲中_à = { $a };
  {
    is($(temp $a = 23; $a),       23, "temp() changed the variable (2-1)");
    is $æe̲中_à(), 23, "temp() changed the variable (2-2)";
  }
  is $a, 42, "temp() restored the variable (2)";
}

# temp() shouldn't change the variable containers
{
  my $a     = 42;
  my $æe̲中_à = { $a };
  {
    ok($(temp $a = 23; $a =:= $æe̲中_à()), "temp() shouldn't change the variable containers");
  }
}

{
  our $𝐩k̲æ𝐯àс = 42;
  {
    is($(temp $𝐩k̲æ𝐯àс = 'not 42'; $𝐩k̲æ𝐯àс), 'not 42', "temp() changed the package variable (3-1)");
  }
  is $𝐩k̲æ𝐯àс, 42, "temp() restored the package variable (3-2)";
}

# Test that temp() restores variable even when not exited regularly (using a
# (possibly implicit) call to return()), but when left because of an exception.
{
  my $a = 42;
  try {
    is($(temp $a = 23; $a), 23, "temp() changed the variable in a try block");
    die 57;
  };
  is $a, 42, "temp() restored the variable, the block was exited using an exception";
}


{
  my @àссàù = (0, 1, 2);
  {
    temp @àссàù[1] = 42;
    is @àссàù[1], 42, "temp() changed our array element";
  }
  is @àссàù[1], 1, "temp() restored our array element";
}

{
  my %両àò両 = (:a(1), :b(2), :c(3));
  {
    temp %両àò両<b> = 42;
    is %両àò両<b>, 42, "temp() changed our hash element";
  }
  is %両àò両<b>, 2, "temp() restored our array element";

  {
    temp %両àò両<z> = 42;
  }
  # https://github.com/Raku/old-issue-tracker/issues/4676
  todo('RT #126447'); ok not %両àò両<z>:exists, "temp() removed previously non-existent key";
  todo('RT #126447'); is %両àò両.elems, 3, "temp() restored hash has correct .elems";
}

{
  my $ò中с갮개中 = [
    "doesnt_matter",
    {
      doesnt_matter => "doesnt_matter",
      key           => [
        "doesnt_matter",
        42,
      ],
    },
  ];

  {
    temp $ò中с갮개中[1]<key>[1] = 23;
    is $ò中с갮개中[1]<key>[1], 23, "temp() changed our nested arrayitem/hashitem element";
  }
  is $ò中с갮개中[1]<key>[1], 42, "temp() restored our nested arrayitem/hashitem element";
}

# Block TEMP{}
# L<S06/Temporization/You can also modify the behaviour of temporized code structures>
# (Test is more or less directly from S06.)
{
  my $丧e̲ч中    = 0;

  # Here is the real implementation of &advance.
  sub à𝐝𝐯à丧개e̲() {
    my $개갮сс = $丧e̲ч中++;
    TEMP {{ $丧e̲ч中 = $개갮сс }}  # TEMP block returns the closure { $next = $curr }
    return $개갮сс;
  };

  # and later...

  is à𝐝𝐯à丧개e̲(), 0, "TEMP{} block (1)";
  is à𝐝𝐯à丧개e̲(), 1, "TEMP{} block (2)";
  is à𝐝𝐯à丧개e̲(), 2, "TEMP{} block (3)";
  is $丧e̲ч中,     3, "TEMP{} block (4)";

  todo('TEMP phasers NYI'); flunk "TEMP{} block (5)";
  todo('TEMP phasers NYI'); flunk "TEMP{} block (6)";
  todo('TEMP phasers NYI'); flunk "TEMP{} block (7)";
  todo('TEMP phasers NYI'); flunk "TEMP{} block (8)";

  # Following does parse, but isn't executed (don't know why).
  # If the "{" on the following line is changed to "if 1 {", it is executed,
  # too, but then it dies complaining about not finding a matching temp()
  # function.  So, for now, we just comment the following block and add
  # unconditional flunk()s.
  # {
  #  is temp(advance()), 3, "TEMP{} block (5)";
  #  is $next,           4, "TEMP{} block (6)";
  #  is temp(advance()), 4, "TEMP{} block (7)";
  #  is temp(advance()), 5, "TEMP{} block (8)";
  # }  # $next = 3

  is $丧e̲ч中,     3, "TEMP{} block (9)";
  is à𝐝𝐯à丧개e̲(), 3, "TEMP{} block (10)";
  is $丧e̲ч中,     4, "TEMP{} block (11)";
}

# Following are OO tests, but I think they fit better in var/temp.t than in
# oo/.
# L<S06/Temporization/temp invokes its argument's .TEMP method.>
{
  my $w̲àò_갢丧_갨w̲丧_中e̲ì𝐩_両à丧𝐝лe̲с = 0;

  class W̲갢e̲с𝐝专e̲ì𝐩 is Int {
    method TEMP {
      $w̲àò_갢丧_갨w̲丧_中e̲ì𝐩_両à丧𝐝лe̲с++;
      return { $w̲àò_갢丧_갨w̲丧_中e̲ì𝐩_両à丧𝐝лe̲с++ };
    }
  }

  my $a = W̲갢e̲с𝐝专e̲ì𝐩.new();
  ok defined($a), "instantiating a WierdTemp worked";
  is $w̲àò_갢丧_갨w̲丧_中e̲ì𝐩_両à丧𝐝лe̲с, 0, ".TEMP method wasn't yet executed";

  {
    todo('TEMP phasers NYI'); is($(temp $a; $w̲àò_갢丧_갨w̲丧_中e̲ì𝐩_両à丧𝐝лe̲с), 1, ".TEMP method was executed on temporization");
  }
  todo('TEMP phasers NYI'); is $w̲àò_갢丧_갨w̲丧_中e̲ì𝐩_両à丧𝐝лe̲с, 2, ".TEMP method was executed on restoration";
}

{
  my $𝐝e̲𝐩中両 = 0;
  my $c = 1;
  sub à {
    ++temp $c;
    à() if ++$𝐝e̲𝐩中両 < 3;
  }
  à();
  is $c, 1, 'recursive nested temps are restored properly';
}

{
  my $a=1;
  {
    temp $a=2;
    temp $a=3;
  }
  is $a, 1, 'multiple temps in the same scope are restored properly';
}

{
  my $𝐯àл갮e̲ = 0;

  my sub 丧갨丧-сe̲개갮сò갢𝐯e̲ {
      temp $𝐯àл갮e̲ = $𝐯àл갮e̲ + 1;
  }

  my sub сe̲개갮сò갢𝐯e̲(Int $limit) {
      temp $𝐯àл갮e̲ = $𝐯àл갮e̲ + 1;

      if $limit > 0 {
          сe̲개갮сò갢𝐯e̲($limit - 1);
      }
  }

  is($𝐯àл갮e̲, 0, 'sanity');
  丧갨丧-сe̲개갮сò갢𝐯e̲();
  is($𝐯àл갮e̲, 0, 'non-recursive function properly resets value');

  # recover if the previous test failed
  $𝐯àл갮e̲ = 0;

  сe̲개갮сò갢𝐯e̲(10);
  is($𝐯àл갮e̲, 0, 'recursive function properly resets value');
}

throws-like { temp $*foo = 42 }, X::Dynamic::NotFound,
    'Useful error conveyed when trying to temp a non-existing dynamic';

# https://github.com/Raku/old-issue-tracker/issues/5057
{
    my %両{Pair}; %両{a => 1} = 2;
    my %c{Pair}; %c{a => 1} = 2;
    {
        temp %両;
        %両{a => 1} = 42;
    }
    is-deeply %両, %c, 'temp works with parametarized Hashes';
}

{
    my @a is default(Nil) = Nil;
    my @c is default(Nil) = Nil;
    { temp @a }
    is-deeply @a, @c, '`temp` keeps around Nils in Arrays when they exist';

    (my %両 is default(Nil))<a> = Nil;
    (my %c is default(Nil))<a> = Nil;
    { temp %両 };
    is-deeply %両, %c, '`temp` keeps Nils around in Hashes when they exist';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
