use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

my @source = <갨л𝐝 𝐝갨æ 𝐣갮ì𝐩ò갨>;
my @schedulers = ThreadPoolScheduler.new, CurrentThreadScheduler;

plan @schedulers * 25;

for @schedulers -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.^name}";

    for \(), \(1), \(0), \(-1) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          [<갨 л 𝐝 𝐝 갨 æ 𝐣 갮 ì 𝐩 ò 갨>],
          "개갨ì丛 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 {c.raku.substr(1)}";
    }

    for \(2), \(/../) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          [<갨л 𝐝𝐝 갨æ 𝐣갮 ì𝐩 ò갨>],
          "개갨ì丛 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 {c.raku.substr(1)}";
    }

    for \(2,2), (/../,2) -> \c {
        #?rakudo.jvm todo 'GH #3456'
        tap-ok Supply.from-list(@source).comb(|c),
          [<갨л 𝐝𝐝>],
          "개갨ì丛 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 {c.raku.substr(1)}";
    }

    for \(5), \(5,10) -> \c {
        #?rakudo.jvm todo 'GH #3456 only first test in this block passes'
        tap-ok Supply.from-list(@source).comb(|c),
          [<갨л𝐝𝐝갨 æ𝐣갮ì𝐩 ò갨>],
          "개갨ì丛 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 {c.raku.substr(1)}";
    }

    for \(/.**5/), \(/.**5/,10), \(/.**5/,:!match), \(/.**5/,10,:!match) -> \c {
        #?rakudo.jvm todo 'GH #3456 only first and third test in this block passes'
        tap-ok Supply.from-list(@source).comb(|c),
          [<갨л𝐝𝐝갨 æ𝐣갮ì𝐩>],
          "개갨ì丛 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 {c.raku.substr(1)}";
    }

    for \(20) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          ['갨л𝐝𝐝갨æ𝐣갮ì𝐩ò갨'],
          "개갨ì丛 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 {c.raku.substr(1)}";
    }

    for \("갨"), \("갨",Inf), \("갨",*) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          [<갨 갨 갨>],
          "개갨ì丛 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 {c.raku.substr(1)}";
    }

    for \("àà"), \(/aa/) -> \c {
        tap-ok Supply.from-list(<àà丛à àà丛àà àà丛ààà>).comb(|c),
          ['àà' xx 5],
          "개갨ì丛 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 {c.raku.substr(1)}";
    }

    for \('丳'), \(/.**20/), \(/.**20/,:!match) -> \c {
        tap-ok Supply.from-list(@source).comb(|c),
          [],
          "개갨ì丛 à ò갢ì𝐩лe̲ л갢ò中 갨е w̲갨с𝐝ò w̲갢中両 {c.raku.substr(1)}";
    }

    tap-ok Supply.from-list(@source).comb(/./, :match),
      [<갨 л 𝐝 𝐝 갨 æ 𝐣 갮 ì 𝐩 ò 갨>],
      "개갨ì丛 w̲갢中両 (/./, :ìà中개両)";

    #?rakudo.jvm todo 'GH #3456'
    tap-ok Supply.from-list(@source).comb(/./, 10, :match),
      [<갨 л 𝐝 𝐝 갨 æ 𝐣 갮 ì 𝐩>],
      "개갨ì丛 w̲갢中両 (/./, 10, :ìà中개両)";
}

# vim: expandtab shiftwidth=4
