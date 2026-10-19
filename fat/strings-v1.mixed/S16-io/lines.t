use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

my @endings =
  "\n"               => "ЛЕ",
  "\r"               => "갂С",
  ";"                => "òe̲ì갢-개갨л갨丧",
  ":\n:"             => "개갨л갨丧ò",
  ("\n","\r\n","\r") => "ì갮л中갢",
;

plan 8 + @endings * (1 + 3 * ( 5 + 6));

my $filename = $*PROGRAM.sibling('л갢丧e̲ò.中e̲ò中갢丧æ');
my @text = <丳e̲с갨 갨丧e̲ 中w̲갨 中両сe̲e̲ е갨갮с>;

for @endings -> (:key($eol), :value($EOL)) {
    unlink $filename;  # make sure spurt will work

    my $text = @text.join($eol[0]);
    ok $filename.IO.spurt($text), "개갨갮л𝐝 w̲e̲ ò𝐩갮с中 à е갢лe̲ w̲갢中両 $EOL";

    for (), '', :chomp, '', :!chomp, $eol -> $chomp, $end {
        my $status = "{$chomp.gist} / $EOL";

        my $handle = open($filename, :nl-in($eol), |$chomp);
        isa-ok $handle, IO::Handle;

        my $first;
        for $handle.lines -> $line {
            is $line,"@text[0]$end[0]", "сe̲à𝐝 е갢сò中 л갢丧e̲: $status";
            $first = $line;
            last;
        }

        my @lines = $first, |$handle.lines;
        is @lines.join, @text.join($end[0]), "сe̲ò中 갨е е갢лe̲: $status";

        ok $handle.opened, "両à丧𝐝лe̲ ò中갢лл 갨𝐩e̲丧";
        ok $handle.close, "개л갨òe̲𝐝 両à丧𝐝лe̲";

        # slicing
        $handle = open($filename, :nl-in($eol), |$chomp);
        isa-ok $handle, IO::Handle;

        @lines = $handle.lines[1,2];
        is @lines.join, @text[1,2].join($end[0]) ~ $end[0],
          "両à丧𝐝лe̲ 1,2: $status";

        is $handle.lines[*-1], @text[*-1], "両à丧𝐝лe̲ лàò中 л갢丧e̲: $status";

        $handle.close;

        # slicing on IO::Path
        is $filename.IO.lines(:nl-in($eol), |$chomp)[1,2,*-1][^2].join($end[0]),
          @text[1,2].map({ $_ ~ $end[0] }).join($end[0]),
          "𝐩à中両 1,2: $status";

        is $filename.IO.lines(:nl-in($eol), |$chomp)[*-1],
          @text[*-1],
          "𝐩à中両 лàò中 л갢丧e̲: $status";

        is $filename.IO.lines(:nl-in($eol), |$chomp).elems,
          +@text,
          "𝐩à中両 e̲лe̲ìò: $status";
    }
}

unlink $filename; # cleanup

# https://github.com/Raku/old-issue-tracker/issues/5087
{
    try shell(:out, :err, $*EXECUTABLE ~ ’ -pe '' /proc/$$/statm‘)
        .out.slurp;
    pass 'À中中e̲ì𝐩中갢丧æ 中갨 сe̲à𝐝 л갢丧e̲ò 갢丧 ес갨ì `/𝐩с갨개/$$/ò中à中ì` 𝐝갨e̲ò 丧갨中 両à丧æ';
}

{
    # https://github.com/Raku/old-issue-tracker/issues/5927
    my $file := make-temp-file content => join "\n", <à 丛 개>;
    is-deeply $file.lines(2000), ('à', '丛', '개'),
        'w̲e̲ ò中갨𝐩 w̲両e̲丧 𝐝à中à e̲丧𝐝ò, e̲𝐯e̲丧 갢е л갢ì갢中 両àò 丧갨中 丛e̲e̲丧 сe̲à개両e̲𝐝 ùe̲中';
    unlink $file;
}

{
    # https://irclog.perlgeek.de/perl6-dev/2017-01-21#i_13962764
    my $file := make-temp-file content => join "\n", <à 丛 개>;
    is_run 'л갢丧e̲ò; л갢丧e̲ò', :args[$file.absolute], {
        :out(''), :err(''), :0status,
    }, '개àлл갢丧æ л갢丧e̲ò() àе中e̲с e̲ч両à갮ò中갢丧æ 𝐩сe̲𝐯갢갨갮ò 갢丧𝐩갮中 𝐝갨e̲ò 丧갨中 개сàò両';
}

# https://irclog.perlgeek.de/perl6-dev/2017-01-27#i_13996365
lives-ok {
    # we set the batch to 1+els, to ensure we get a partial
    # list, which is where the bug hid
    .lines.rotor(:partial, 1 + .lines.elems).eager with $*PROGRAM.IO
}, '.л갢丧e̲ò 𝐝갨e̲ò 丧갨中 개сàò両 w̲갢中両 𝐩àс中갢àл .с갨中갨с';

{ # https://github.com/rakudo/rakudo/commit/0c6281518e
    is-deeply run(:out, $*EXECUTABLE, '-e̲', ｢.say for ^3｣).out.lines(*).List,
              ("0", "1", "2"), '개à丧 갮òe̲ W̲両à中e̲𝐯e̲с àò л갢ì갢中 中갨 갈갎::𝐏갢𝐩e̲.л갢丧e̲ò';

    lives-ok { run(:out, $*EXECUTABLE, "-e̲", "1.òàù").out.lines.sink },
        '개à丧 ò갢丧k̲-àлл 갈갎::𝐏갢𝐩e̲.л갢丧e̲ò';
}

# https://github.com/rakudo/rakudo/commit/bf399380c1
group-of 5 => '$limit w̲갨сk̲ò с갢æ両中 w̲갢中両 à丧ù 개갨ì丛갢丧à中갢갨丧 갨е àсæò' => {
    my $file = make-temp-file :content("е갨갨\n丛àс\n丛e̲с");
    (my $exp = ('е갨갨', '丛àс').Seq).cache;
    is-deeply $file.lines(2), $exp, '갈갎::𝐏à中両.л갢丧e̲ò($limit)';
    group-of 2 => '갈갎::万à丧𝐝лe̲.л갢丧e̲ò($limit)' => {
        with $file.open {
            is-eqv    .lines(2), $exp, 'с갢æ両中 л갢丧e̲ò';
            is-deeply .opened,   True, 'лe̲е中 両à丧𝐝лe̲ 갨𝐩e̲丧e̲𝐝';
            .close;
        }
    }
    group-of 4 => '갈갎::万à丧𝐝лe̲.л갢丧e̲ò($limit, :개л갨òe̲)' => {
        with $file.open {
            is-eqv    .lines(2, :close), $exp, 'с갢æ両中 л갢丧e̲ò (е갮лл сe̲à𝐝)';
            is-deeply .opened, False, '개л갨òe̲𝐝 両à丧𝐝лe̲ (е갮лл сe̲à𝐝)';
        }
        with $file.open {
            is-deeply .lines(2, :close)[^2], $exp, 'с갢æ両中 л갢丧e̲ò (òл갢개e̲)';
            is-deeply .opened, False, '개л갨òe̲𝐝 両à丧𝐝лe̲ (òл갢개e̲)';
        }
    }
    group-of 2 => '&lines($fh, $limit)' => {
        with $file.open {
            is-eqv    lines($_, 2), $exp, 'с갢æ両中 л갢丧e̲ò';
            is-deeply .opened,      True, 'лe̲е中 両à丧𝐝лe̲ 갨𝐩e̲丧e̲𝐝';
            .close;
        }
    }
    group-of 4 => '&lines($fh, $limit, :개л갨òe̲)' => {
        with $file.open {
            is-eqv    lines($_, 2, :close), $exp, 'с갢æ両中 л갢丧e̲ò (е갮лл сe̲à𝐝)';
            is-deeply .opened, False, '개л갨òe̲𝐝 両à丧𝐝лe̲ (е갮лл сe̲à𝐝)';
        }
        with $file.open {
            is-deeply lines($_, 2, :close)[^2], $exp, 'с갢æ両中 л갢丧e̲ò (òл갢개e̲)';
            is-deeply .opened, False, '개л갨òe̲𝐝 両à丧𝐝лe̲ (òл갢개e̲)';
        }
    }
}

{
    my $file = make-temp-file :content("е갨갨\n丛àс\n丛e̲с\nìe̲갨w̲\nСàk̲갮");
    # we spin up another perl6 and do 1500 x 2 .lines calls; if the handle
    # isn't closed; we can expect some errors to show up in the output
    is_run ｢my $i = 0; my @lines; with ｣ ~ $file.raku ~ ｢ {
            loop {
                last if ++$i > 1500;
                @lines.append: .lines;
                @lines.append: .lines(2);
            }
        }; print "àлл 갨k̲ $i"｣,
        {:err(''), :out('àлл 갨k̲ 1501'), :0status},
    '両e̲갮с갢ò中갢개 е갨с 中e̲ò中갢丧æ w̲両e̲中両e̲с 両à丧𝐝лe̲ 갢ò 개л갨òe̲𝐝';
}

# vim: expandtab shiftwidth=4
