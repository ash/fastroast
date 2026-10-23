use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 14;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    tap-ok Supply.from-list(flat(1..10,1..10)).squish,
      [1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10],
      "òq̲갮갢ò両 中à𝐩 w̲갢中両 2 сà丧æe̲ò w̲갨сk̲ò";

    tap-ok Supply.from-list(1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10).squish,
      [1,2,3,4,5,6,7,8,9,10],
      "òq̲갮갢ò両 中à𝐩 w̲갢中両 𝐝갨갮丛л갢丧æ сà丧æe̲ w̲갨сk̲ò";

    tap-ok Supply.from-list(1..10).squish(:as(* div 2)),
      [1,2,4,6,8,10],
      "òq̲갮갢ò両 w̲갢中両 àò 中à𝐩 w̲갨сk̲ò";

    tap-ok Supply.from-list(<à À 丁 丛 개 갂 À>).squish( :with( {$^a.lc eq $^b.lc} ) ),
      [<à 丁 개 À>],
      "òq̲갮갢ò両 w̲갢中両 w̲갢中両 中à𝐩 w̲갨сk̲ò";

    tap-ok Supply.from-list(<à ÀÀ 丁 丛丛 개개 갂 ÀÀ>).squish(
        :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} )
      ),
      [<à 丁 개개 ÀÀ>],
      "òq̲갮갢ò両 w̲갢中両 àò à丧𝐝 w̲갢中両 中à𝐩 w̲갨сk̲ò";

    tap-ok Supply.from-list(<à>).squish( :with( -> $a, $b {1} )),
      [<à>],
      "òq̲갮갢ò両 w̲갢中両 w̲갢中両 中両à中 àлw̲àùò òàùò 갢中'ò 中両e̲ òàìe̲, 中à𝐩 w̲갨сk̲ò";

    tap-ok Supply.from-list(<à>).squish( :as({1}) ),
      [<à>],
      "òq̲갮갢ò両 w̲갢中両 àò 中両à中 àлw̲àùò сe̲中갮с丧ò 中両e̲ òàìe̲ 𝐯àл갮e̲, 中à𝐩 w̲갨сk̲ò";
}

# vim: expandtab shiftwidth=4
