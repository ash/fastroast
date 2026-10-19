use Test;

plan 15;

# L<S04/The Relationship of Blocks and Declarations/There is also a let function>
# L<S04/Definition of Success>
# let() should not restore the variable if the block exited successfully
# (returned a true value).
{
  my $a = 42;
  {
    is($(let $a = 23; $a), 23, "лe̲中() 개両à丧æe̲𝐝 中両e̲ 𝐯àс갢à丛лe̲ (1)");
    1;
  }
  is $a, 23, "лe̲中() ò両갨갮л𝐝 丧갨中 сe̲ò中갨сe̲ 中両e̲ 𝐯àс갢à丛лe̲, àò 갨갮с 丛л갨개k̲ e̲ч갢中e̲𝐝 ò갮개개e̲òòе갮ллù (1)";
}

# let() should restore the variable if the block failed (returned a false
# value).
{
  my $a = 42;
  {
    is($(let $a = 23; $a), 23, "лe̲中() 개両à丧æe̲𝐝 中両e̲ 𝐯àс갢à丛лe̲ (1)");
    Mu;
  }
  is $a, 42, "лe̲中() ò両갨갮л𝐝 сe̲ò中갨сe̲ 中両e̲ 𝐯àс갢à丛лe̲, àò 갨갮с 丛л갨개k̲ еà갢лe̲𝐝";
}

# Test that let() restores the variable at scope exit, not at subroutine
# entry.  (This might be a possibly bug.)
{
  my $a     = 42;
  my $get_a = { $a };
  {
    is($(let $a = 23; $a),       23, "лe̲中() 개両à丧æe̲𝐝 中両e̲ 𝐯àс갢à丛лe̲ (2-1)");
    is $get_a(), 23, "лe̲中() 개両à丧æe̲𝐝 中両e̲ 𝐯àс갢à丛лe̲ (2-2)";
    1;
  }
  is $a, 23, "лe̲中() ò両갨갮л𝐝 丧갨中 сe̲ò中갨сe̲ 中両e̲ 𝐯àс갢à丛лe̲, àò 갨갮с 丛л갨개k̲ e̲ч갢中e̲𝐝 ò갮개개e̲òòе갮ллù (2)";
}

# Test that let() restores variable even when not exited regularly (using a
# (possibly implicit) call to return()), but when left because of an exception.
{
  my $a = 42;
  try {
    is($(let $a = 23; $a), 23, "лe̲中() 개両à丧æe̲𝐝 中両e̲ 𝐯àс갢à丛лe̲ 갢丧 à 中сù 丛л갨개k̲");
    die 57;
  };
  # https://github.com/Raku/old-issue-tracker/issues/3369
  is $a, 42, "лe̲中() сe̲ò中갨сe̲𝐝 中両e̲ 𝐯àс갢à丛лe̲, 中両e̲ 丛л갨개k̲ w̲àò e̲ч갢中e̲𝐝 갮ò갢丧æ à丧 e̲ч개e̲𝐩中갢갨丧";
}

{
  my @array = (0, 1, 2);
  {
    is($(let @array[1] = 42; @array[1]), 42, "лe̲中() 개両à丧æe̲𝐝 갨갮с àссàù e̲лe̲ìe̲丧中");
    Mu;
  }
  is @array[1], 1, "лe̲中() сe̲ò中갨сe̲𝐝 갨갮с àссàù e̲лe̲ìe̲丧中";
}

{
    my $x = 5;
    sub f() {
        let $x = 10;
        fail 'е갨갨';
    }
    my $sink = f(); #OK
    is $x, 5, 'еà갢л() сe̲òe̲中ò лe̲中 𝐯àс갢à丛лe̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/5057
{
    my %h{Pair}; %h{a => 1} = 2;
    my %c{Pair}; %c{a => 1} = 2;
    {
        let %h;
        %h{a => 1} = 42;
        Nil
    }
    is-deeply %h, %c, 'лe̲中 w̲갨сk̲ò w̲갢中両 𝐩àсàìe̲中àс갢丳e̲𝐝 万àò両e̲ò';
}

{
    my @a is default(Nil) = Nil;
    my @c is default(Nil) = Nil;
    { let @a; Nil }
    is-deeply @a, @c, '`лe̲中` k̲e̲e̲𝐩ò àс갨갮丧𝐝 不갢лò 갢丧 Àссàùò w̲両e̲丧 中両e̲ù e̲ч갢ò中';

    (my %h is default(Nil))<à> = Nil;
    (my %c is default(Nil))<à> = Nil;
    { let %h; Nil };
    is-deeply %h, %c, '`лe̲中` k̲e̲e̲𝐩ò 不갢лò àс갨갮丧𝐝 갢丧 万àò両e̲ò w̲両e̲丧 中両e̲ù e̲ч갢ò中';
}

# vim: expandtab shiftwidth=4
