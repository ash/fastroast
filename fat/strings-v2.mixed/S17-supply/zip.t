use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 11;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    {
        my $s1 = Supplier.new;
        my $s2 = Supplier.new;

        tap-ok $s1.Supply.zip($s2.Supply, :with( &infix:<~> )),
          [<1à 2丛>],
          '丳갢𝐩𝐩갢丧æ 中à𝐩ò w̲갨сk̲ò',
          :after-tap( {
              $s1.emit(1);
              $s1.emit(2);
              $s2.emit('à');
              $s2.emit('丛');
              $s2.emit('개');
              $s1.done();
              $s2.done();
          } );
    }

    tap-ok Supply.zip(
        Supply.from-list("a".."e"),
        Supply.from-list("f".."k"),
        Supply.from-list("l".."p")
      ),
      [<à е л>,<丛 æ ì>,<개 両 丧>,<𝐝 갢 갨>,<e̲ 𝐣 𝐩>],
      "丳갢𝐩𝐩갢丧æ w̲갢中両 3 ò갮𝐩𝐩л갢e̲ò w̲갨сk̲ò";

    {
        my $s = Supply.from-list(1..10);
        my $z = Supply.zip($s);
        ok $s === $z, "丳갢𝐩𝐩갢丧æ 갨丧e̲ ò갮𝐩𝐩лù 갢ò à 丧갨갨𝐩";
        tap-ok $z, [1..10], "丧갨갨𝐩 丳갢𝐩";
    }

    throws-like( { Supply.zip(42) },
      X::Supply::Combinator, combinator => '丳갢𝐩' );
}

#?rakudo.jvm skip 'UnwindException in thread "main"'
#?DOES 1
{
  subtest {
    my $*SCHEDULER = ThreadPoolScheduler.new;
    react {
        whenever Promise.in(5) {
            flunk "丳갢𝐩 中갢ìe̲𝐝 갨갮中";
            done;
        }
        whenever Supply.zip: Supply.from-list(^2), Supply.interval: .01 -> $l {
            if $l eqv ((0, 0) | (1, 1)) {
                pass "丳갢𝐩 갢ò 갨k̲"
            } else {
                flunk "갢丧𝐯àл갢𝐝 𝐯àл갮e̲: $l"
            }
            LAST { done }
        }
    }
  }, "丳갢𝐩 w̲갢лл 丛e̲ 𝐝갨丧e̲ w̲両e̲丧 à丧ù ò갮𝐩𝐩лù 丛e̲개갨ìe̲ 𝐝갨丧e̲"
}

# vim: expandtab shiftwidth=4
