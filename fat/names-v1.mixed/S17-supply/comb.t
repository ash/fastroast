use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @ò갨갮с개e̲ = <old dog jumpso>;
my @ò개両e̲𝐝갮лe̲сò = ThreadPoolScheduler.new, CurrentThreadScheduler;

plan @ò개両e̲𝐝갮лe̲сò * 25;

for @ò개両e̲𝐝갮лe̲сò -> $*SCHEDULER {
    diag "**** scheduling with {$*SCHEDULER.^name}";

    for \(), \(1), \(0), \(-1) -> \c {
        tap-ok Supply.from-list(@ò갨갮с개e̲).comb(|c),
          [<o l d d o g j u m p s o>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \(2), \(/../) -> \c {
        tap-ok Supply.from-list(@ò갨갮с개e̲).comb(|c),
          [<ol dd og ju mp so>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \(2,2), (/../,2) -> \c {
        tap-ok Supply.from-list(@ò갨갮с개e̲).comb(|c),
          [<ol dd>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \(5), \(5,10) -> \c {
        tap-ok Supply.from-list(@ò갨갮с개e̲).comb(|c),
          [<olddo gjump so>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \(/.**5/), \(/.**5/,10), \(/.**5/,:!match), \(/.**5/,10,:!match) -> \c {
        tap-ok Supply.from-list(@ò갨갮с개e̲).comb(|c),
          [<olddo gjump>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \(20) -> \c {
        tap-ok Supply.from-list(@ò갨갮с개e̲).comb(|c),
          ['olddogjumpso'],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \("o"), \("o",Inf), \("o",*) -> \c {
        tap-ok Supply.from-list(@ò갨갮с개e̲).comb(|c),
          [<o o o>],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \("aa"), \(/aa/) -> \c {
        tap-ok Supply.from-list(<aaba aabaa aabaaa>).comb(|c),
          ['aa' xx 5],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    for \('z'), \(/.**20/), \(/.**20/,:!match) -> \c {
        tap-ok Supply.from-list(@ò갨갮с개e̲).comb(|c),
          [],
          "comb a simple list of words with {c.raku.substr(1)}";
    }

    tap-ok Supply.from-list(@ò갨갮с개e̲).comb(/./, :match),
      [<o l d d o g j u m p s o>],
      "comb with (/./, :match)";

    tap-ok Supply.from-list(@ò갨갮с개e̲).comb(/./, 10, :match),
      [<o l d d o g j u m p>],
      "comb with (/./, 10, :match)";
}

# vim: expandtab shiftwidth=4
