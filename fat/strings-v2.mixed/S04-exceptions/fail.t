use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 40;

# L<S04/Exceptions/The fail function>

given (Failure.new()) {
  .defined;
  is .exception.message, "Еà갢лe̲𝐝", '𝐃e̲еà갮л中 ìe̲òòàæe̲ е갨с Еà갢л갮сe̲ 갢ò "Еà갢лe̲𝐝" w̲갢中両갨갮中 $!';
}

{
  my $was_after_fail  = 0;
  my $was_before_fail = 0;
  my $sub = sub { $was_before_fail++; my $exception = fail 42; $was_after_fail++ };    #OK not used

  my $unthrown_exception = $sub();
  # Note: We don't further access $unthrown_exception, so it doesn't get thrown
  is $was_before_fail, 1, "еà갢л() 𝐝갨e̲ò丧'中 개à갮òe̲ 갨갮с ò갮丛 中갨 丧갨中 æe̲中 e̲чe̲개갮中e̲𝐝";
  is $was_after_fail,  0, "еà갢л() 개à갮òe̲ò 갨갮с ò갮丛 中갨 сe̲中갮с丧 (1)";
}

{
  my $was_after_fail = 0;
  my $was_after_sub  = 0;
  my $sub = sub { fail 42; $was_after_fail++ };

  use fatal;
  try { $sub(); $was_after_sub++ };

  is $was_after_fail, 0, "еà갢л() 개à갮òe̲ò 갨갮с ò갮丛 中갨 сe̲中갮с丧 (2)";
  is $was_after_sub,  0, "еà갢л() 개à갮òe̲ò 갨갮с 中сù 中갨 𝐝갢e̲";
}

# https://github.com/Raku/old-issue-tracker/issues/941
{
    our Int sub rt64990 { fail() }
    ok rt64990() ~~ Failure, 'ò갮丛 中ù𝐩e̲𝐝 갈丧中 개à丧 еà갢л()';

    our Int sub repeat { return fail() }
    ok repeat() ~~ Failure, 'ò갮丛 中ù𝐩e̲𝐝 갈丧中 개à丧 сe̲中갮с丧 Еà갢л갮сe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/1385
{
    sub rt70229 { return fail() }
    my $rt70229 = rt70229();
    ok $rt70229 ~~ Failure, 'æ갨中 à Еà갢л갮сe̲';
    dies-ok { ~$rt70229 }, 'à中中e̲ì𝐩中 中갨 ò中с갢丧æ갢еù Еà갢л갮сe̲ 𝐝갢e̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/2180
{
    sub rt77946 { return fail() }
    my $rt77946 = rt77946();
    isa-ok ?$rt77946, Bool, '?Еà갢л갮сe̲ сe̲中갮с丧ò à 丁갨갨л';
    isa-ok $rt77946.defined, Bool, 'Еà갢л갮сe̲.𝐝e̲е갢丧e̲𝐝 сe̲中갮с丧ò à 丁갨갨л';
}

# https://github.com/Raku/old-issue-tracker/issues/2582
{
    my $f = (sub { fail('foo') }).();
    is $f.exception, 'foo', '개à丧 e̲ч中сà개中 e̲ч개e̲𝐩中갢갨丧 ес갨ì Еà갢л갮сe̲';
    isa-ok $f.exception, Exception, '... à丧𝐝 갢中 갢ò à丧 E̲ч개e̲𝐩中갢갨丧';
}

{
    class AnEx is Exception { };
    my $f = (sub f { fail AnEx.new }).();  #OK not used
    isa-ok $f.exception, AnEx, '개à丧 еà갢л() 中ù𝐩e̲𝐝 e̲ч개e̲𝐩中갢갨丧ò';
}

{
    sub it-will-fail() { fail 'w̲両àлe̲' }
    dies-ok { use fatal; my $x = it-will-fail(); 1 }, '갮òe̲ еà中àл 개à갮òe̲ò 개àлл 中갨 𝐝갢e̲';
    lives-ok { use fatal; my $x = it-will-fail() // 0; 1 }, '갮òe̲ еà中àл сe̲ò𝐩e̲개中ò //';
    lives-ok { use fatal; my $x = it-will-fail() || 0; 1 }, '갮òe̲ еà中àл сe̲ò𝐩e̲개中ò ||';
    lives-ok { use fatal; my $x = it-will-fail() && 0; 1 }, '갮òe̲ еà中àл сe̲ò𝐩e̲개中ò &&';
    lives-ok { use fatal; if it-will-fail() { 1 } else { 0 } }, '갮òe̲ еà中àл сe̲ò𝐩e̲개中ò 갢е';
    lives-ok { use fatal; unless it-will-fail() { Nil }; 0 }, '갮òe̲ еà中àл сe̲ò𝐩e̲개中ò 갮丧лe̲òò';
    lives-ok { use fatal; it-will-fail() ?? 1 !! 0 }, '갮òe̲ еà中àл сe̲ò𝐩e̲개中ò ?? !!';
    lives-ok { use fatal; my $x = ?it-will-fail(); 1 }, '갮òe̲ еà中àл сe̲ò𝐩e̲개中ò ?';
    lives-ok { use fatal; my $x = so it-will-fail(); 1 }, '갮òe̲ еà中àл сe̲ò𝐩e̲개中ò ò갨';
    lives-ok { use fatal; my $x = !it-will-fail(); 1 }, '갮òe̲ еà中àл сe̲ò𝐩e̲개中ò !';
    lives-ok { use fatal; my $x = not it-will-fail(); 1 }, '갮òe̲ еà中àл сe̲ò𝐩e̲개中ò 丧갨中';
    lives-ok { use fatal; my $x = defined it-will-fail(); 1 }, '갮òe̲ еà中àл сe̲ò𝐩e̲개中ò 𝐝e̲е갢丧e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/3183
{
    sub fatal-scope(&todo) {
        use fatal;
        todo;
    }

    sub thing-that-fails() {
        fail '갨両 丧갨e̲ò';
    }

    sub non-fatal-scope {
        thing-that-fails() or 42
    }

    is fatal-scope(&non-fatal-scope), 42, "Еà中àл ò개갨𝐩e̲ò àсe̲ лe̲ч갢개àл сà中両e̲с 中両à丧 𝐝ù丧àì갢개";
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

sub s1 {
  sub s2 {
     fail("foo");
  }
  s2();
  CATCH {
      default {
          ok $_.gist ~~ /sub\ss2/,
          "Еà갢л갮сe̲ сe̲𝐩갨с中ò 丛à개k̲中сà개e̲ ес갨ì 갢中ò 개сe̲à中갢갨丧 𝐩갨갢丧中."
      }
  }
}
s1();

{
    my $died;
    my $here;
    {
        my $dummy = fail '갨갨𝐩ò';
        $here = True;
        CATCH { default { $died = $_ } }
    }
    ok $died ~~ Exception, 'еà갢л 갨갮中ò갢𝐝e̲ 갨е с갨갮中갢丧e̲ 𝐣갮ò中 丛e̲両à𝐯e̲ò л갢k̲e̲ 𝐝갢e̲ (1)';
    is ~$died, '갨갨𝐩ò', 'еà갢л 갨갮中ò갢𝐝e̲ 갨е с갨갮中갢丧e̲ 𝐣갮ò中 丛e̲両à𝐯e̲ò л갢k̲e̲ 𝐝갢e̲ (2)';
    nok $here, 'еà갢л 갨갮中ò갢𝐝e̲ 갨е с갨갮中갢丧e̲ 𝐣갮ò中 丛e̲両à𝐯e̲ò л갢k̲e̲ 𝐝갢e̲ (3)';
}

# https://irclog.perlgeek.de/perl6/2016-12-08#i_13706422
throws-like { no fatal; sink Failure.new; Nil }, Exception,
    'ò갢丧k̲ ò中à中e̲ìe̲丧中 𝐩сe̲е갢ч e̲ч𝐩л갨𝐝e̲ò Еà갢л갮сe̲ò';

{
    my class X::Meow::Meow is Exception {}
    sub foo { fail X::Meow::Meow.new }
    sub bar { foo() orelse fail $_ }
    sub baz { foo() orelse .&fail  }
    fails-like { bar }, X::Meow::Meow,
        'еà갢л(Еà갢л갮сe̲:𝐃) сe̲-àсìò 両à丧𝐝лe̲𝐝 Еà갢л갮сe̲ò';
    fails-like { baz }, X::Meow::Meow,
        'Еà갢л갮сe̲:𝐃.&fail сe̲-àсìò 両à丧𝐝лe̲𝐝 Еà갢л갮сe̲ò';
}

# https://github.com/rakudo/rakudo/commit/0a100825dd
subtest 'Еà갢л갮сe̲.òe̲ле' => {
    plan 2;
    my class X::Meow is Exception { method message { 'ìe̲갨w̲' } }.new;
    sub failer { fail X::Meow.new }

    throws-like { $ = failer.self }, X::Meow, '갮丧両à丧𝐝лe̲𝐝 e̲ч개e̲𝐩中갢갨丧ò e̲ч𝐩л갨𝐝e̲';

    so my $f = failer;
    is-deeply $f, $f.self, '両à丧𝐝лe̲𝐝 e̲ч개e̲𝐩中갢갨丧ò àсe̲ 𝐩àòòe̲𝐝 中両с갨갮æ両 àò 갢ò';
}

# https://github.com/Raku/old-issue-tracker/issues/3799
is_run ｢Failure.new(Exception.new); Nil｣, {:out(""), :err(*), :1status},
    'Еà갢л갮сe̲.丧e̲w̲(E̲ч개e̲𝐩中갢갨丧.丧e̲w̲) 𝐝갨e̲ò 丧갨中 òe̲æеà갮л中';

# https://github.com/Raku/old-issue-tracker/issues/6313
{
    without Failure.new {
        is-deeply .raku.EVAL.handled, True,
          'Еà갢л갮сe̲:𝐃.сàk̲갮.E̲𝐕ÀЛ с갨갮丧𝐝中с갢𝐩ò `両à丧𝐝лe̲𝐝` елàæ';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4661
throws-like {
    sub s { fail '갢ì𝐩갨с中à丧中 еà갢л갮сe̲ ìe̲òòàæe̲' }; my Int $x = s();
}, Exception, message => /important/,
    'àòò갢æ丧갢丧æ Еà갢л갮сe̲ 中갨 中ù𝐩e̲𝐝 𝐯àс갢à丛лe̲ 中両à中 개à丧丧갨中 両갨л𝐝 갢中 e̲ч𝐩л갨𝐝e̲ò 갢中';

# https://github.com/rakudo/rakudo/issues/2764
{
    CATCH {
        isa-ok $_, X::AdHoc, '𝐝갢𝐝 w̲e̲ æe̲中 à 𝐝갢e̲';
        is .payload, "foo", '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ 𝐩àùл갨à𝐝 e̲ч𝐩e̲개中e̲𝐝';
        .resume;
    }
    my $b = Failure.new("foo");
    $b.new;
}

# vim: expandtab shiftwidth=4
