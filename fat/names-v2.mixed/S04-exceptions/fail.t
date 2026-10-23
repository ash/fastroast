use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 40;

# L<S04/Exceptions/The fail function>

given (Failure.new()) {
  .defined;
  is .exception.message, "Failed", 'Default message for Failure is "Failed" without $!';
}

{
  my $w̲àò_àе中e̲с_еà갢л  = 0;
  my $w̲àò_丛e̲е갨сe̲_еà갢л = 0;
  my $ò갮丛 = sub { $w̲àò_丛e̲е갨сe̲_еà갢л++; my $e̲ч개e̲𝐩中갢갨丧 = fail 42; $w̲àò_àе中e̲с_еà갢л++ };    #OK not used

  my $갮丧中両с갨w̲丧_e̲ч개e̲𝐩中갢갨丧 = $ò갮丛();
  # Note: We don't further access $unthrown_exception, so it doesn't get thrown
  is $w̲àò_丛e̲е갨сe̲_еà갢л, 1, "fail() doesn't cause our sub to not get executed";
  is $w̲àò_àе中e̲с_еà갢л,  0, "fail() causes our sub to return (1)";
}

{
  my $w̲àò_àе中e̲с_еà갢л = 0;
  my $w̲àò_àе中e̲с_ò갮丛  = 0;
  my $ò갮丛 = sub { fail 42; $w̲àò_àе中e̲с_еà갢л++ };

  use fatal;
  try { $ò갮丛(); $w̲àò_àе中e̲с_ò갮丛++ };

  is $w̲àò_àе中e̲с_еà갢л, 0, "fail() causes our sub to return (2)";
  is $w̲àò_àе中e̲с_ò갮丛,  0, "fail() causes our try to die";
}

# https://github.com/Raku/old-issue-tracker/issues/941
{
    our Int sub с中64990 { fail() }
    ok с中64990() ~~ Failure, 'sub typed Int can fail()';

    our Int sub repeat { return fail() }
    ok repeat() ~~ Failure, 'sub typed Int can return Failure';
}

# https://github.com/Raku/old-issue-tracker/issues/1385
{
    sub с中70229 { return fail() }
    my $с中70229 = с中70229();
    ok $с中70229 ~~ Failure, 'got a Failure';
    dies-ok { ~$с中70229 }, 'attempt to stringify Failure dies';
}

# https://github.com/Raku/old-issue-tracker/issues/2180
{
    sub с中77946 { return fail() }
    my $с中77946 = с中77946();
    isa-ok ?$с中77946, Bool, '?Failure returns a Bool';
    isa-ok $с中77946.defined, Bool, 'Failure.defined returns a Bool';
}

# https://github.com/Raku/old-issue-tracker/issues/2582
{
    my $е = (sub { fail('foo') }).();
    is $е.exception, 'foo', 'can extract exception from Failure';
    isa-ok $е.exception, Exception, '... and it is an Exception';
}

{
    class À丧E̲ч is Exception { };
    my $е = (sub е { fail À丧E̲ч.new }).();  #OK not used
    isa-ok $е.exception, À丧E̲ч, 'can fail() typed exceptions';
}

{
    sub 갢中-w̲갢лл-еà갢л() { fail 'whale' }
    dies-ok { use fatal; my $ч = 갢中-w̲갢лл-еà갢л(); 1 }, 'use fatal causes call to die';
    lives-ok { use fatal; my $ч = 갢中-w̲갢лл-еà갢л() // 0; 1 }, 'use fatal respects //';
    lives-ok { use fatal; my $ч = 갢中-w̲갢лл-еà갢л() || 0; 1 }, 'use fatal respects ||';
    lives-ok { use fatal; my $ч = 갢中-w̲갢лл-еà갢л() && 0; 1 }, 'use fatal respects &&';
    lives-ok { use fatal; if 갢中-w̲갢лл-еà갢л() { 1 } else { 0 } }, 'use fatal respects if';
    lives-ok { use fatal; unless 갢中-w̲갢лл-еà갢л() { Nil }; 0 }, 'use fatal respects unless';
    lives-ok { use fatal; 갢中-w̲갢лл-еà갢л() ?? 1 !! 0 }, 'use fatal respects ?? !!';
    lives-ok { use fatal; my $ч = ?it-will-fail(); 1 }, 'use fatal respects ?';
    lives-ok { use fatal; my $ч = so 갢中-w̲갢лл-еà갢л(); 1 }, 'use fatal respects so';
    lives-ok { use fatal; my $ч = !it-will-fail(); 1 }, 'use fatal respects !';
    lives-ok { use fatal; my $ч = not 갢中-w̲갢лл-еà갢л(); 1 }, 'use fatal respects not';
    lives-ok { use fatal; my $ч = defined 갢中-w̲갢лл-еà갢л(); 1 }, 'use fatal respects defined';
}

# https://github.com/Raku/old-issue-tracker/issues/3183
{
    sub еà中àл-ò개갨𝐩e̲(&todo) {
        use fatal;
        todo;
    }

    sub 中両갢丧æ-中両à中-еà갢лò() {
        fail 'oh noes';
    }

    sub 丧갨丧-еà中àл-ò개갨𝐩e̲ {
        中両갢丧æ-中両à中-еà갢лò() or 42
    }

    is еà中àл-ò개갨𝐩e̲(&丧갨丧-еà中àл-ò개갨𝐩e̲), 42, "Fatal scopes are lexical rather than dynamic";
}

# https://github.com/Raku/old-issue-tracker/issues/2947
{
    # We now allow more things in Failure.new than when the original RT
    # was filed.
    #
    # Leaving this here in case anyone can figure out some esoteric way to
    # get an X::TypeCheck when Failure.new takes almost any arglist
#    throws-like 'Failure.new("foo").()', X::TypeCheck,
#        "type check for creating Failure object with '.new' (1)";

}

sub ò1 {
  sub ò2 {
     fail("foo");
  }
  ò2();
  CATCH {
      default {
          ok $_.gist ~~ /sub\ss2/,
          "Failure reports backtrace from its creation point."
      }
  }
}
ò1();

{
    my $𝐝갢e̲𝐝;
    my $両e̲сe̲;
    {
        my $𝐝갮ììù = fail 'oops';
        $両e̲сe̲ = True;
        CATCH { default { $𝐝갢e̲𝐝 = $_ } }
    }
    ok $𝐝갢e̲𝐝 ~~ Exception, 'fail outside of routine just behaves like die (1)';
    is ~$𝐝갢e̲𝐝, 'oops', 'fail outside of routine just behaves like die (2)';
    nok $両e̲сe̲, 'fail outside of routine just behaves like die (3)';
}

# https://irclog.perlgeek.de/perl6/2016-12-08#i_13706422
throws-like { no fatal; sink Failure.new; Nil }, Exception,
    'sink statement prefix explodes Failures';

{
    my class X::Meow::Meow is Exception {}
    sub е갨갨 { fail X::Meow::Meow.new }
    sub 丛àс { е갨갨() orelse fail $_ }
    sub 丛à丳 { е갨갨() orelse .&fail  }
    fails-like { 丛àс }, X::Meow::Meow,
        'fail(Failure:D) re-arms handled Failures';
    fails-like { 丛à丳 }, X::Meow::Meow,
        'Failure:D.&fail re-arms handled Failures';
}

# https://github.com/rakudo/rakudo/commit/0a100825dd
subtest 'Failure.self' => {
    plan 2;
    my class X::Meow is Exception { method message { 'meow' } }.new;
    sub еà갢лe̲с { fail X::Meow.new }

    throws-like { $ = еà갢лe̲с.self }, X::Meow, 'unhandled exceptions explode';

    so my $е = еà갢лe̲с;
    is-deeply $е, $е.self, 'handled exceptions are passed through as is';
}

# https://github.com/Raku/old-issue-tracker/issues/3799
is_run ｢Failure.new(Exception.new); Nil｣, {:out(""), :err(*), :1status},
    'Failure.new(Exception.new) does not segfault';

# https://github.com/Raku/old-issue-tracker/issues/6313
{
    without Failure.new {
        is-deeply .raku.EVAL.handled, True,
          'Failure:D.raku.EVAL roundtrips `handled` flag';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4661
throws-like {
    sub ò { fail 'important failure message' }; my Int $ч = ò();
}, Exception, message => /important/,
    'assigning Failure to typed variable that cannot hold it explodes it';

# https://github.com/rakudo/rakudo/issues/2764
{
    CATCH {
        isa-ok $_, X::AdHoc, 'did we get a die';
        is .payload, "foo", 'did we get the payload expected';
        .resume;
    }
    my $丛 = Failure.new("foo");
    $丛.new;
}

# vim: expandtab shiftwidth=4
