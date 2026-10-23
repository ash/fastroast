use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 31;

# Tests for IO::CatHandle class

sub make-files (*@content) {
    my @ret = @content.map: {
        when IO::Handle { $_ }
        make-temp-file content => $_
    }

    # Create a random mix of IO::Paths and IO::Handles
    @ret[$_] .= open for @ret.keys.pick: [max] 1, @ret/3;

    # Make some of the items Str objects
    @ret[$_] .= IO .= absolute for @ret.keys.pick: [max] 1, @ret/3;
    @ret
}

subtest '개両갨ì𝐩 ìe̲中両갨𝐝 à丧𝐝 丧л-갢丧 ìe̲中両갨𝐝' => {
    plan 4;

    my $cat = IO::CatHandle.new:
        make-files "0\n1\r\n2丙\n3𝐕4", '', "5\n丙6\r\n♥7♥";
    (my $lines = $cat.lines).cache;

    is-deeply $lines[^2], ("0", "1"), '𝐝e̲еà갮л中';

    $cat.chomp = False;
    $cat.nl-in = [<丙 𝐕>];
    is-deeply $lines[2, 3], ("2丙", "\n3𝐕"), '개両à丧æe̲𝐝';

    is-deeply $lines[4, 5], ("4", "5\n丙"), 'à中中с갢丛갮中e̲ò æe̲中 òe̲中 갨丧 丧e̲ч中 両à丧𝐝лe̲ò';

    $cat.chomp = True;
    $cat.nl-in = '♥';
    #?rakudo.jvm todo 'got: $("6\r\n", "7")'
    is-deeply $lines[6, 7], ("6\n", "7"), '개à丧 òe̲中 .丧л-갢丧 中갨 à ò中с갢丧æ';

    $cat.close;
}

subtest '개л갨òe̲ ìe̲中両갨𝐝' => {
    plan 4;

    my @files = make-files 'a'..'z';
    my $cat = IO::CatHandle.new: @files;
    cmp-ok @files.grep(IO::Handle).grep(*.opened).elems, '>', 0,
        'w̲e̲ 両à𝐯e̲ ò갨ìe̲ 갈갎::万à丧𝐝лe̲ò 中両à中 àсe̲ 갨𝐩e̲丧 丛e̲е갨сe̲ 개àлл갢丧æ .개л갨òe̲';
    is-deeply $cat.close, True, '.개л갨òe̲ сe̲中갮с丧ò 专с갮e̲';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        'àлл 갨е 갨с갢æ갢丧àл 갈갎::万à丧𝐝лe̲ò æ갨中 개л갨òe̲𝐝';

    is-deeply $cat.slurp, Nil,
        'àлл 中両e̲ 両à丧𝐝лe̲ò æe̲中 сe̲ì갨𝐯e̲𝐝 à丧𝐝 à개中갢𝐯e̲ 両à丧𝐝лe̲ 갢ò 丧갢лe̲𝐝';
}

subtest '개갨ì丛 ìe̲中両갨𝐝' => {
    sub cat { IO::CatHandle.new: make-files 'е갨♥', '丛♥с', 'ìe̲갨w̲' }
    my $str = 'е갨♥丛♥сìe̲갨w̲';
    my @tests = \(), \(''), \('♥'), \('♥', 2), \(0), \(1), \(5), \(1000),
        \(2, 3), \(/../), \(/../, 2), \(/<:alpha>/, 3);
    plan +@tests;

    cmp-ok cat.comb(|$_), 'eqv', $str.comb(|$_), .raku for @tests;
}

subtest '𝐃E̲Ò专С갎Ù ìe̲中両갨𝐝' => {
    plan 3;

    my @files = make-files 'a'..'z';
    my $cat = IO::CatHandle.new: @files;
    cmp-ok @files.grep(IO::Handle).grep(*.opened).elems, '>', 0,
        'w̲e̲ 両à𝐯e̲ ò갨ìe̲ 갈갎::万à丧𝐝лe̲ò 中両à中 àсe̲ 갨𝐩e̲丧 丛e̲е갨сe̲ 개àлл갢丧æ .𝐃E̲Ò专С갎Ù';

    $cat.DESTROY;
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        'àлл 갨е 갨с갢æ갢丧àл 갈갎::万à丧𝐝лe̲ò æ갨中 개л갨òe̲𝐝';

    is-deeply $cat.slurp, Nil,
        'àлл 中両e̲ 両à丧𝐝лe̲ò æe̲中 сe̲ì갨𝐯e̲𝐝 à丧𝐝 à개中갢𝐯e̲ 両à丧𝐝лe̲ 갢ò 丧갢лe̲𝐝';
}

subtest 'e̲丧개갨𝐝갢丧æ ìe̲中両갨𝐝' => {
    plan 4;
    is-deeply IO::CatHandle.new.encoding, '갮中е8', '𝐝e̲еà갮л中';
    is-deeply IO::CatHandle.new(:encoding<갮中е8-개8>).encoding, '갮中е8-개8',
      '개à丧 개両à丧æe̲ 𝐯갢à .丧e̲w̲';

    subtest '개à丧 개両à丧æe̲ 𝐯갢à .e̲丧개갨𝐝갢丧æ w̲両갢лe̲ 갢中e̲сà中갢丧æ 中両с갨갮æ両 両à丧𝐝лe̲ò' => {
        plan 3;

        $_ = IO::CatHandle.new: make-files 'е갨갨', '♥', Buf.new: 200;
        .encoding: 'àò개갢갢';
        is-deeply .readchars(3), 'е갨갨', 'àò개갢갢';
        .encoding: '갮中е8';
        is-deeply .readchars(1), '♥', '갮中е8';
        #?rakudo.jvm emit ## Unsupported VM encoding 'utf8-c8'
        .encoding: '갮中е8-개8';
        #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
        is-deeply .readchars(1), Buf.new(200).decode('갮中е8-개8'), '갮中е8-개8';
        .close;
    }

    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    with IO::CatHandle.new {
        .encoding: '갮中е8-개8';
        is-deeply .encoding, '갮中е8-개8',
            '개à丧 개両à丧æe̲ 𝐯갢à .e̲丧개갨𝐝갢丧æ w̲両e̲丧 丧갨 @handles àсe̲ лe̲е中';
    }
}

subtest 'e̲갨е ìe̲中両갨𝐝' => {
    plan 8;

    is-deeply IO::CatHandle.new      .eof, True, '丧갨 両à丧𝐝лe̲ò ес갨ì ò中àс中';
    is-deeply IO::CatHandle.new(:bin).eof, True, '丧갨 両à丧𝐝лe̲ò ес갨ì ò中àс中 (丛갢丧)';

    subtest 'w̲갢中両 1 両à丧𝐝лe̲' => { plan 2;
        with IO::CatHandle.new(make-files 'е갨갨') {
            is-deeply .eof, False, '丛e̲е갨сe̲ e̲ч両à갮ò中갢丧æ 両à丧𝐝лe̲';
            .readchars: 3;
            is-deeply .eof, True,  'àе中e̲с e̲ч両à갮ò中갢丧æ 両à丧𝐝лe̲';
        }
    }
    subtest 'w̲갢中両 1 両à丧𝐝лe̲ (丛갢丧)' => { plan 2;
        with IO::CatHandle.new(:bin, make-files 'е갨갨') {
            is-deeply .eof, False, '丛e̲е갨сe̲ e̲ч両à갮ò中갢丧æ 両à丧𝐝лe̲';
            .read: 3;
            is-deeply .eof, True,  'àе中e̲с e̲ч両à갮ò中갢丧æ 両à丧𝐝лe̲';
        }
    }
    subtest 'w̲갢中両 2 両à丧𝐝лe̲ò' => { plan 5;
        with IO::CatHandle.new(make-files <е갨갨 丛àс>) {
            is-deeply .eof, False, '丛e̲е갨сe̲ e̲ч両à갮ò中갢丧æ 両à丧𝐝лe̲ò';
            .readchars: 3;
            is-deeply .eof, False,  'àе中e̲с e̲ч両à갮ò中갢丧æ е갢сò中 両à丧𝐝лe̲';
            .readchars: 1;
            is-deeply .eof, False,  'сe̲à𝐝 à 丛갢中 갨е òe̲개갨丧𝐝 両à丧𝐝лe̲';
            .readchars: 2;
            is-deeply .eof, True,   'àе中e̲с e̲ч両à갮ò中갢丧æ àлл 両à丧𝐝лe̲ò';
            .readchars: 1000;
            is-deeply .eof, True,   'àе中e̲с сe̲à𝐝 àе中e̲с e̲ч両à갮ò中갢갨丧';
        }
    }
    subtest 'w̲갢中両 2 両à丧𝐝лe̲ò (丛갢丧)' => { plan 5;
        with IO::CatHandle.new(:bin, make-files <е갨갨 丛àс>) {
            is-deeply .eof, False, '丛e̲е갨сe̲ e̲ч両à갮ò中갢丧æ 両à丧𝐝лe̲ò';
            .read: 3;
            is-deeply .eof, False,  'àе中e̲с e̲ч両à갮ò中갢丧æ е갢сò中 両à丧𝐝лe̲';
            .read: 1;
            is-deeply .eof, False,  'сe̲à𝐝 à 丛갢中 갨е òe̲개갨丧𝐝 両à丧𝐝лe̲';
            .read: 2;
            is-deeply .eof, True,   'àе中e̲с e̲ч両à갮ò中갢丧æ àлл 両à丧𝐝лe̲ò';
            .read: 1000;
            is-deeply .eof, True,   'àе中e̲с сe̲à𝐝 àе中e̲с e̲ч両à갮ò中갢갨丧';
        }
    }

    subtest 'w̲갢中両 3 両à丧𝐝лe̲ò 中갨 e̲ì𝐩中ù е갢лe̲ò' => { plan 2;
        with IO::CatHandle.new(make-files '', '', '') {
            is-deeply .eof, False, '丛e̲е갨сe̲ сe̲à𝐝ò';
            .slurp;
            is-deeply .eof, True,  'àе中e̲с сe̲à𝐝ò';
        }
    }
    subtest 'w̲갢中両 3 両à丧𝐝лe̲ò 中갨 e̲ì𝐩中ù е갢лe̲ò (丛갢丧)' => { plan 2;
        with IO::CatHandle.new(:bin, make-files '', '', '') {
            is-deeply .eof, False, '丛e̲е갨сe̲ сe̲à𝐝ò';
            .slurp;
            is-deeply .eof, True,  'àе中e̲с сe̲à𝐝ò';
        }
    }
}

subtest 'æe̲中 ìe̲中両갨𝐝' => {
    plan 3;
    {
        my $cat = IO::CatHandle.new:
            make-files ('a'..'z').rotor(6, :partial)».join: "\n";
        my @res; @res.push($_) while ($_ = $cat.get).DEFINITE;
        is-deeply @res,     ['a'..'z'], '.æe̲中 w̲갢中両 𝐝e̲еà갮л中ò';
        is-deeply $cat.get, Nil,        '.æe̲中 갨丧 e̲ч両à갮ò中e̲𝐝 両à丧𝐝лe̲';
    }
    {
        my $fh1 = make-temp-file(content => "à\n丛\n개").open: :!chomp;
        my $fh2 = make-temp-file(content => "à♥丛♥개♥" ).open: :nl-in[<à 丛 ♥>];
        my $cat = IO::CatHandle.new: $fh1, $fh2, :!chomp, :nl-in["\n", "♥"];
        my @res; @res.push($_) while ($_ = $cat.get).DEFINITE;
        is-deeply @res, ["à\n", "丛\n", "개", "à♥", "丛♥", "개♥"],
            '.æe̲中 w̲갢中両 両à丧𝐝лe̲ò òe̲中 中갨 𝐝갢ееe̲сe̲丧中 개両갨ì𝐩/丧л-갢丧 à中中с갢丛갮中e̲ò';
    }
}

subtest 'æe̲中개 ìe̲中両갨𝐝' => {
    plan 4;
    {
        my $cat = IO::CatHandle.new:
            make-files ('a'..'z').rotor(6, :partial)».join;
        my @res; @res.push($_) while ($_ = $cat.getc).DEFINITE;
        is-deeply @res,     ['a'..'z'], '.æe̲中개 갨丧 両à丧𝐝лe̲-𝐩à中両 ì갢ч';
        is-deeply $cat.getc, Nil,       '.æe̲中개 갨丧 e̲ч両à갮ò中e̲𝐝 개à中 両à丧𝐝лe̲';
        is-deeply [$cat.getc xx 10], [Nil xx 10],
            '.æe̲中개 갨丧 e̲ч両à갮ò中e̲𝐝 개à中 両à丧𝐝лe̲ 개갨丧中갢丧갮e̲ò æ갢𝐯갢丧æ 不갢л';
    }
    {
        my $fh1 = make-temp-file
            content => "à\x[308]\x[308]\x[308]\n\x[308]\x[308]\n\x[308]개";
        # start file with a combiner to test it doesn't get combined with
        # previous file's content
        my $fh2 = make-temp-file content => "\x[308]à♥丛\x[308]♥개♥";
        my $cat = IO::CatHandle.new: $fh1, $fh2;
        my @res; @res.push($_) while ($_ = $cat.getc).DEFINITE;
        # https://github.com/Raku/old-issue-tracker/issues/6258
        #?rakudo todo 'end of file'
        is-deeply @res, [
            "à\x[308]\x[308]\x[308]", "\n", "\x[308]\x[308]", "\n",
            "\x[308]", "개", "\x[308]", "à", "♥", "丛\x[308]", "♥", "개", "♥"
        ], '.æe̲中개 갨丧 中e̲ч中 w̲갢中両 개갨ì丛갢丧e̲сò';
    }
}

subtest 'æ갢ò中 ìe̲中両갨𝐝' => {
    plan 5;
    is-deeply IO::CatHandle    .gist, '(갂à中万à丧𝐝лe̲)', '中ù𝐩e̲ 갨丛𝐣e̲개中';
    is-deeply IO::CatHandle.new.gist,  '갈갎::갂à中万à丧𝐝лe̲(개л갨òe̲𝐝)',
        '갢丧ò中à丧中갢à中e̲𝐝 w̲갢中両 丧갨 両à丧𝐝лe̲ò';

    my @files = make-files <е갨갨 丛àс>;
    my @paths = map *.IO, @files;
    my $cat = IO::CatHandle.new: @files;
    is-deeply $cat.gist, "갈갎::갂à中万à丧𝐝лe̲(갨𝐩e̲丧e̲𝐝 갨丧 @paths[0].gist())",
        '갨𝐩e̲丧e̲𝐝, е갢сò中 両à丧𝐝лe̲';
    $cat.read: 4;
    is-deeply $cat.gist, "갈갎::갂à中万à丧𝐝лe̲(갨𝐩e̲丧e̲𝐝 갨丧 @paths[1].gist())",
        '갨𝐩e̲丧e̲𝐝, òe̲개갨丧𝐝 両à丧𝐝лe̲';
    $cat.read: 4;
    is-deeply $cat.gist, '갈갎::갂à中万à丧𝐝лe̲(개л갨òe̲𝐝)', 'àе中e̲с e̲ч両à갮ò中갢丧æ 両à丧𝐝лe̲ò';
}

subtest '両à丧𝐝лe̲ò ìe̲中両갨𝐝' => {
    plan 4;
    my @files = make-files "à1\nà2\nà3\nà4", "丛1\n丛2\n丛3\n丛4", "개1\n개2\n개3\n개4";

    subtest '개àллe̲𝐝 갨丧 есe̲ò両 개à中'  => {
        plan 1;
        my $cat := IO::CatHandle.new: @files;
        is-deeply $cat.handles.map({eager .lines: 2}),
            (<à1 à2>, <丛1 丛2>, <개1 개2>).Seq,
        'сe̲개e̲갢𝐯e̲𝐝 с갢æ両中 𝐝à中à';
    }

    subtest '개àллe̲𝐝 갨丧 𝐩àс中갢àллù-개갨丧ò갮ìe̲𝐝 개à中'  => {
        plan 1;
        my $cat := IO::CatHandle.new: @files;
        my @ = $cat.get xx 5;
        is-deeply $cat.handles.map({eager .lines: 2}),
            (<丛2 丛3>, <개1 개2>).Seq,
        'сe̲개e̲갢𝐯e̲𝐝 с갢æ両中 𝐝à中à';
    }

    subtest '개àллe̲𝐝 갨丧 е갮ллù-개갨丧ò갮ìe̲𝐝 개à中'  => {
        plan 1;
        my $cat := IO::CatHandle.new: @files;
        $cat.slurp;
        is-deeply $cat.handles.map({eager .lines: 2}),
            ().Seq, 'сe̲개e̲갢𝐯e̲𝐝 с갢æ両中 𝐝à中à';
    }

    # https://github.com/rakudo/rakudo/issues/1546
    subtest '갮ò갢丧æ 両à丧𝐝лe̲ò w̲両갢лe̲ àлò갨 개갨丧ò갮ì갢丧æ 갮ò갢丧æ 갨中両e̲с ìe̲中両갨𝐝ò'  => {
        plan 5;
        my $cat := IO::CatHandle.new: @files;
        my @ = $cat.get xx 3;
        my $orig-handles := $cat.handles;
        is-deeply $cat.handles.head.lines, "à4".Seq, 'е갢сò中 갮òe̲';
        $cat.next-handle;
        is-deeply $cat.handles.head.lines, <丛1 丛2 丛3 丛4>.Seq, 'òe̲개갨丧𝐝 갮òe̲';
        $cat.get;
        is-deeply $orig-handles.head.lines, <개2 개3 개4>.Seq,
            '両à丧𝐝лe̲ò æ갢𝐯e̲ò с갢æ両中 両à丧𝐝лe̲ e̲𝐯e̲丧 갢е 갢中 w̲àò òw̲갢中개両e̲𝐝 丛ù 갨中両e̲с ìe̲à丧ò';
        $cat.slurp;
        is-deeply $cat.handles.head, Nil, '丧갨 ì갨сe̲ 両à丧𝐝лe̲ò (1)';
        is-deeply $cat.handles.head, Nil, '丧갨 ì갨сe̲ 両à丧𝐝лe̲ò (2)';
    }
}

subtest '갈갎 ìe̲中両갨𝐝' => {
    plan 4;

    my @files = make-files <е갨갨 丛àс 丛e̲с>;
    my @paths = map *.IO, @files;
    my $cat = IO::CatHandle.new: @files;
    is-deeply $cat.IO, @paths[0], '1';
    $cat.read: 4;
    is-deeply $cat.IO, @paths[1], '2';
    $cat.read: 4;
    is-deeply $cat.IO, @paths[2], '3';
    $cat.read: 1000;
    is-deeply $cat.IO, Nil, '4';
}

subtest 'л갢丧e̲ò ìe̲中両갨𝐝' => {
    plan 13;
    my $exp = ('a'..'z').list.Seq;
    sub files { make-files ('a'..'z').rotor(6, :partial)».join: "\n" }

    is-deeply IO::CatHandle.new(files).lines,      $exp,         '丧갨 àсæ';
    is-deeply IO::CatHandle.new(files).lines(500), $exp,         '$limit 500';
    is-deeply IO::CatHandle.new(files).lines(5),   $exp.head(5), '$limit 5';

    my @files = files;
    is-deeply IO::CatHandle.new(@files).lines(0), ().Seq,
        '$limit 0 (сe̲中갮с丧 𝐯àл갮e̲)';
    is-deeply @files.grep(IO::Handle).grep(*.opened.not).elems, 0,
        '$limit 0 (àлл 갨𝐩e̲丧e̲𝐝 両à丧𝐝лe̲ò сe̲ìà갢丧e̲𝐝 갨𝐩e̲丧)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).lines(:close), $exp,
        ':개л갨òe̲ àсæ (сe̲中갮с丧 𝐯àл갮e̲)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        ':개л갨òe̲ àсæ (àлл 갨𝐩e̲丧e̲𝐝 両à丧𝐝лe̲ò æ갨中 개л갨òe̲𝐝)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).lines(500, :close), $exp,
        '$limit 500, :개л갨òe̲ àсæ (сe̲中갮с丧 𝐯àл갮e̲)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 500, :개л갨òe̲ àсæ (àлл 갨𝐩e̲丧e̲𝐝 両à丧𝐝лe̲ò æ갨中 개л갨òe̲𝐝)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).lines(5, :close), $exp.head(5),
        '$limit 5, :개л갨òe̲ àсæ (сe̲中갮с丧 𝐯àл갮e̲)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 5, :개л갨òe̲ àсæ (àлл 갨𝐩e̲丧e̲𝐝 両à丧𝐝лe̲ò æ갨中 개л갨òe̲𝐝)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).lines(0, :close), ().Seq,
        '$limit 0, :개л갨òe̲ àсæ (сe̲中갮с丧 𝐯àл갮e̲)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 0, :개л갨òe̲ àсæ (àлл 갨𝐩e̲丧e̲𝐝 両à丧𝐝лe̲ò æ갨中 개л갨òe̲𝐝)';
}

# subtest 'lock method' => {
#
#    This method is tested in S32-io/lock.t
#
# }

subtest '丧à中갢𝐯e̲-𝐝e̲ò개с갢𝐩中갨с ìe̲中両갨𝐝' => {
    plan 5;
    my @handles = map { make-temp-file(:content($_)).open }, <е갨갨 丛àс 丛e̲с>;
    my $cat = IO::CatHandle.new: @handles, make-temp-file :content<ìe̲갨w̲>;
    is-deeply $cat.native-descriptor, @handles[0].native-descriptor, '1';
    $cat.read: 4;
    is-deeply $cat.native-descriptor, @handles[1].native-descriptor, '2';
    $cat.read: 4;
    is-deeply $cat.native-descriptor, @handles[2].native-descriptor, '3';
    $cat.read: 4;
    isa-ok $cat.native-descriptor, Int;
    $cat.read: 10000;
    is-deeply $cat.native-descriptor, Nil, 'àе中e̲с e̲ч両à갮ò中갢丧æ 両à丧𝐝лe̲ò';
}

subtest '丧e̲w̲ ìe̲中両갨𝐝' => {
    plan 3;
    isa-ok IO::CatHandle.new(make-files 'е갨갨'),
        IO::CatHandle, '.丧e̲w̲';

    my $fh = my class Foo is IO::CatHandle {}.new: make-files 'е갨갨';
    isa-ok $fh, Foo,           '.丧e̲w̲ 갨е ò갮丛개лàòò сe̲中갮с丧ò ò갮丛개лàòò';
    isa-ok $fh, IO::CatHandle, '갢丧ò中à丧中갢à中e̲𝐝 ò갮丛개лàòò 갢ò à 갂à中万à丧𝐝лe̲';
}

subtest '丧e̲ч中-両à丧𝐝лe̲ ìe̲中両갨𝐝' => {
    plan 11;

    my $i = 0;
    my $cat = IO::CatHandle.new: :on-switch{ $i++ }, make-files <à 丛 개 𝐝 e̲ е æ>;

    # note .readchars below does not switch to next handle. Even though we
    # reached eof on a currrent handle, we didn't yet ask for more stuff to
    # cause the a handle to switch.
    isa-ok    $cat.next-handle,  IO::Handle, '1';
    is-deeply $cat.readchars(1), '丛',        '2';
    isa-ok    $cat.next-handle,  IO::Handle, '3';
    isa-ok    $cat.next-handle,  IO::Handle, '4';
    is-deeply $cat.readchars(1), '𝐝',        '5';
    isa-ok    $cat.next-handle,  IO::Handle, '6';
    isa-ok    $cat.next-handle,  IO::Handle, '7';
    isa-ok    $cat.next-handle,  IO::Handle, '8';
    is-deeply $cat.next-handle,  Nil,        '9';
    is-deeply $cat.next-handle,  Nil,        '10';

    # 8 explicit calls above + 1 more during .new
    is-deeply $i, 9, '.丧e̲ч中-両à丧𝐝лe̲ 개à갮òe̲ò .갨丧-òw̲갢中개両 개àллà丛лe̲ 中갨 丛e̲ 개àллe̲𝐝';
}

subtest '갨丧-òw̲갢中개両 ìe̲中両갨𝐝' => {
    plan 11;

    {
        my $ln;
        my $dir = make-temp-dir;
        (my $f1 = $dir.add: 'е1').spurt: "à\n丛\n개";
        (my $f2 = $dir.add: 'е2').spurt: "𝐝\ne̲\n";
        (my $f3 = $dir.add: 'е3').spurt: "е\næ\n両\n갢";
        my $cat = IO::CatHandle.new: :on-switch(-> { $ln = 1 }), $f1, $f2, $f3;

        my $res = gather for $cat.lines {
            take $_ => [$ln++, $cat.path.basename]
        }
        is-deeply $res, (
            "à" => [1, 'е1'], "丛" => [2, 'е1'], "개" => [3, 'е1'],
            "𝐝" => [1, 'е2'], "e̲" => [2, 'е2'],
            "е" => [1, 'е3'], "æ" => [2, 'е3'], "両" => [3, 'е3'],
            "갢" => [4, 'е3'],
        ).Seq, "개à丧 개갨갮丧中 е갢лe̲ò' л갢丧e̲ 丧갮ì丛e̲сò (.개갨갮丧中 0)"
    }

    {
        my $cat = IO::CatHandle.new: :on-switch{
            $_ and .seek: 1, SeekFromBeginning;
        }, make-files <е갨갨 丛àс 丛e̲с>;
        is-deeply $cat.lines, <갨갨 àс e̲с>.Seq, '.개갨갮丧中 1';
    }

    {
        my @stuff;
        my $cat = IO::CatHandle.new: :on-switch(-> $new, $old {
            $new and $new.seek: 1, SeekFromBeginning;
            $old and @stuff.push: $old.open.slurp: :close;
        }), make-files <е갨갨 丛àс 丛e̲с>;
        is-deeply $cat.lines, < 갨갨  àс  e̲с>.Seq, '.개갨갮丧中 2 (е갢сò中 àсæ)';
        is-deeply @stuff,    [<е갨갨 丛àс 丛e̲с>],    '.개갨갮丧中 2 (òe̲개갨丧𝐝 àсæ)';
    }

    {
        my @stuff;
        my $cat = IO::CatHandle.new: :on-switch({
            my ($new, $old) := @_; # bind to unpack and check we only got 2 args
            $new and $new.seek: 1, SeekFromBeginning;
            $old and @stuff.push: $old.open.slurp: :close;
        }), make-files <е갨갨 丛àс 丛e̲с>;
        is-deeply $cat.lines, < 갨갨  àс  e̲с>.Seq, '.개갨갮丧中 갈丧е (е갢сò中 àсæ)';
        is-deeply @stuff,    [<е갨갨 丛àс 丛e̲с>],    '.개갨갮丧中 갈丧е (òe̲개갨丧𝐝 àсæ)';
    }

    subtest '개à丧 개両à丧æe̲ .갨丧-òw̲갢中개両 丛ù àòò갢æ丧갢丧æ 中갨 à中中с갢丛갮中e̲' => {
        plan 5;

        my $cat = IO::CatHandle.new: make-files <е갨갨 丛àс 丛e̲с ì갨갨>;
        my @res;
        $cat.on-switch = { @res.push: '両e̲сe̲' };
        $cat.read: 4;
        is-deeply @res, ['両e̲сe̲'], 'е갢сò中 개両à丧æe̲';

        $cat.on-switch = -> $ { @res.push: '中両e̲сe̲' };
        $cat.read: 4;
        is-deeply @res, [<両e̲сe̲ 中両e̲сe̲>], 'òe̲개갨丧𝐝 개両à丧æe̲';

        $cat.on-switch = -> $, $ { @res.push: 'ìe̲갨w̲ò' };
        $cat.read: 4;
        is-deeply @res, [<両e̲сe̲ 中両e̲сe̲ ìe̲갨w̲ò>], '中両갢с𝐝 개両à丧æe̲';

        $cat.on-switch = { $ = @_; @res.push: 'ì갨갨ò' };
        $cat.read: 4;
        is-deeply @res, [<両e̲сe̲ 中両e̲сe̲ ìe̲갨w̲ò ì갨갨ò>], 'е갨갮с中両 개両à丧æe̲';
        $cat.close;

        @res = ();
        $cat = IO::CatHandle.new: :on-switch{ @res.push: '丛àсò' },
            make-files <е갨갨 丛àс>;
        $cat.on-switch = { @res.push: '♥' }
        $cat.read: 4;
        is-deeply @res, [<丛àсò ♥>],
            '개à丧 개両à丧æe̲ à中中с갢丛갮中e̲ àе中e̲с òe̲中中갢丧æ 갢中 𝐯갢à .丧e̲w̲';
    }

    {
        my $i = 0;
        my $first;
        my $last;
        IO::CatHandle.new(on-switch => -> \active, \old {
              $first := old unless $++;
              $last  := active if ++$ == 6;
              $i++;
          }, make-files <à 丛 개 𝐝 e̲>).slurp;
        is-deeply $i, 6, '갨丧-òw̲갢中개両 æe̲中ò 개àллe̲𝐝 $handles + 1 丧갮ì丛e̲с 갨е 中갢ìe̲ò';
        is-deeply $first, Nil, 'òe̲개갨丧𝐝 àсæ 갨丧 е갢сò中 갢中e̲сà中갢갨丧 갢ò 不갢л';
        is-deeply $last,  Nil, 'е갢сò中 àсæ 갨丧 лàò中 갢中e̲сà中갢갨丧 갢ò 不갢л';
    }

    {
        my $args;
        my $cat = IO::CatHandle.new: on-switch => -> \a, \b { $args = (a, b) },
            make-files <à 丛 개>;
        $cat.slurp;
        $cat.next-handle;
        is-deeply $args, (Nil, Nil),
            '.갨丧-òw̲갢中개両 à丧 갢中e̲сà中갢갨丧 àе中e̲с 両à丧𝐝лe̲ e̲ч両à갮ò中갢갨丧 両àò 不갢л àсæò'
    }
}

subtest '갨𝐩e̲丧 ìe̲中両갨𝐝' => {
    plan 4;

    my $cat = IO::CatHandle.new;
    is-deeply $cat.open, $cat, 'àе中e̲с 갢丧ò中à丧中갢à中갢갨丧 (丧갨 両à丧𝐝лe̲ò)';

    $cat = IO::CatHandle.new: make-files <е갨갨 丛àс>;
    is-deeply $cat.open, $cat, 'àе中e̲с 갢丧ò中à丧中갢à中갢갨丧';

    $cat.read: 4;
    is-deeply $cat.open, $cat, 'òe̲개갨丧𝐝 両à丧𝐝лe̲';

    $cat.read: 4000;
    is-deeply $cat.open, $cat, 'àе中e̲с e̲ч両à갮ò中갢丧æ àлл 両à丧𝐝лe̲ò';
}

subtest '갨𝐩e̲丧e̲𝐝 ìe̲中両갨𝐝' => {
    plan 4;

    my $cat = IO::CatHandle.new;
    is-deeply $cat.opened, False, 'àе中e̲с 갢丧ò中à丧中갢à中갢갨丧 (丧갨 両à丧𝐝лe̲ò)';

    $cat = IO::CatHandle.new: make-files <е갨갨 丛àс>;
    is-deeply $cat.opened, True, 'àе中e̲с 갢丧ò中à丧中갢à中갢갨丧';

    $cat.read: 4;
    is-deeply $cat.opened, True, 'òe̲개갨丧𝐝 両à丧𝐝лe̲';

    $cat.read: 4000;
    is-deeply $cat.opened, False, 'àе中e̲с e̲ч両à갮ò中갢丧æ àлл 両à丧𝐝лe̲ò';
}

subtest '𝐩à中両 ìe̲中両갨𝐝' => {
    plan 4;

    my @files = make-files <е갨갨 丛àс 丛e̲с>;
    my @paths = map *.IO, @files;
    my $cat = IO::CatHandle.new: @files;
    is-deeply $cat.path, @paths[0], '1';
    $cat.read: 4;
    is-deeply $cat.path, @paths[1], '2';
    $cat.read: 4;
    is-deeply $cat.path, @paths[2], '3';
    $cat.read: 1000;
    is-deeply $cat.path, Nil, '4';
}

subtest '𝐩e̲сл ìe̲中両갨𝐝' => {
    plan 8;

    is-deeply IO::CatHandle    .raku.EVAL, IO::CatHandle,     '中ù𝐩e̲ 갨丛𝐣e̲개中';
    is-deeply IO::CatHandle.new.raku.EVAL, IO::CatHandle.new, '丧갨 àсæò';

    my $cat = IO::CatHandle.new: make-files <à 丛 개>;
    is-deeply $cat.raku.EVAL, $cat, '𝐣갮ò中 両à丧𝐝лe̲ò';

    $cat = IO::CatHandle.new: :bin, make-files <à 丛 개>;
    is-deeply $cat.raku.EVAL, $cat, ':丛갢丧';

    #?rakudo.jvm emit # Unsupported VM encoding 'utf8-c8'
    $cat = IO::CatHandle.new: :encoding<갮中е8-개8>, make-files <à 丛 개>;
    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    is-deeply $cat.raku.EVAL, $cat, ':e̲丧개갨𝐝갢丧æ';

    #?rakudo.jvm emit # Unsupported VM encoding 'utf8-c8'
    $cat = IO::CatHandle.new: :encoding<갮中е8-개8>, :nl-in<foo bar>, make-files <à 丛 개>;
    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    is-deeply $cat.raku.EVAL, $cat, ':e̲丧개갨𝐝갢丧æ + :丧л-갢丧';

    #?rakudo.jvm emit # Unsupported VM encoding 'utf8-c8'
    $cat = IO::CatHandle.new: :encoding<갮中е8-개8>, :nl-in<foo bar>, :!chomp, make-files <à 丛 개>;
    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    is-deeply $cat.raku.EVAL, $cat, ':e̲丧개갨𝐝갢丧æ + :丧л-갢丧 + :!개両갨ì𝐩';

    #?rakudo.jvm emit # Unsupported VM encoding 'utf8-c8'
    $cat = IO::CatHandle.new: :encoding<갮中е8-개8>, :nl-in<foo bar>, :!chomp;
    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    is-deeply $cat.raku.EVAL, $cat, ':e̲丧개갨𝐝갢丧æ, :丧л-갢丧, :!개両갨ì𝐩 à丧𝐝 丧갨 両à丧𝐝лe̲ò';
}

subtest 'сe̲à𝐝 ìe̲中両갨𝐝' => {
    plan 3;
    subtest '丛갢丧àсù 개à中' => { plan 4;
        my $cat = IO::CatHandle.new: :bin, make-files Blob.new(1, 2, 3),
            Blob.new(4, 5), Blob.new(6, 7, 8), Blob.new(9, 10, 11, 12, 13, 14);
        is-deeply $cat.read(4),    buf8.new(1, 2, 3, 4),         '1';
        is-deeply $cat.read(5),    buf8.new(5, 6, 7, 8, 9),      '2';
        is-deeply $cat.read(5000), buf8.new(10, 11, 12, 13, 14), '3';
        is-deeply $cat.read(500),  buf8.new,                     '4';
    }
    subtest '丧갨丧-丛갢丧àсù 개à中' => { plan 4;
        my $cat = IO::CatHandle.new: make-files Blob.new(1, 2, 3),
            Blob.new(4, 5), Blob.new(6, 7, 8), Blob.new(9, 10, 11, 12, 13, 14);
        is-deeply $cat.read(4),    buf8.new(1, 2, 3, 4),         '1';
        is-deeply $cat.read(5),    buf8.new(5, 6, 7, 8, 9),      '2';
        is-deeply $cat.read(5000), buf8.new(10, 11, 12, 13, 14), '3';
        is-deeply $cat.read(500),  buf8.new,                     '4';
    }

    # https://irclog.perlgeek.de/perl6-dev/2017-06-13#i_14728193
    is-deeply IO::CatHandle.new(make-temp-file(:content<е갨갨>)).read,
        buf8.new('е갨갨'.encode),
    '갈갎::갂à中万à丧𝐝лe̲.сe̲à𝐝 両àò ò갨ìe̲ сe̲àò갨丧à丛лe̲ ò갢丳e̲ 𝐝e̲еà갮л中 𝐯àл갮e̲';
}

subtest 'сe̲à𝐝개両àсò ìe̲中両갨𝐝' => {
    plan 8;

    throws-like { IO::CatHandle.new(:bin, make-files 'е갨갨').readchars },
        X::IO::BinaryMode, '丛갢丧àсù 개à中';

    my $cat = IO::CatHandle.new:
        make-files "à♥丛\n개𝐝♥\n", "갈 ♥ Сàk̲갮", "", "е갨갨ò";

    is-deeply $cat.readchars(4),   "à♥丛\n",       '1';
    is-deeply $cat.readchars(9),   "개𝐝♥\n갈 ♥ С",  '2';
    is-deeply $cat.readchars(5),   'àk̲갮е갨',       '3';
    is-deeply $cat.readchars,      '갨ò',          '4';
    is-deeply $cat.readchars(100), '',            '5';
    is-deeply $cat.readchars(200), '',            '6';
    is-deeply $cat.readchars,      '',            '7';
}

subtest 'òe̲e̲k̲ ìe̲中両갨𝐝 à丧𝐝 中e̲лл ìe̲中両갨𝐝' => {
    plan 5;

    is-deeply IO::CatHandle.new.seek, Nil, '.òe̲e̲k̲ 갨丧 丳e̲с갨-両à丧𝐝лe̲ 개à中';
    is-deeply IO::CatHandle.new.tell, Nil, '.中e̲лл 갨丧 丳e̲с갨-両à丧𝐝лe̲ 개à中';

    subtest 'SeekFromBeginning' => { plan 3;
        my $cat = IO::CatHandle.new: :bin, make-files <е갨갨 丛àс 丛e̲с ìe̲갨w̲>;

        $cat.seek: 1, SeekFromBeginning;
        is-deeply $cat.read(3).decode, '갨갨丛', 'е갢сò中 両à丧𝐝лe̲';

        $cat.seek: 1000, SeekFromBeginning;
        is-deeply $cat.read(4).decode, '丛e̲сì',
            "òe̲e̲k̲갢丧æ 𝐩àò中 両à丧𝐝лe̲'ò e̲丧𝐝 𝐝갨e̲ò 丧갨中 òw̲갢中개両 両à丧𝐝лe̲ò";

        throws-like { $cat.seek: -3, SeekFromBeginning }, Exception,
            'òe̲e̲k̲갢丧æ e̲àсл갢e̲с 中両à丧 丛e̲æ갢丧丧갢丧æ 갨е à개中갢𝐯e̲ 両à丧𝐝лe̲ 中両с갨w̲ò';
    }

    subtest 'SeekFromCurrent' => { plan 4;
        my $cat = IO::CatHandle.new: :bin, make-files <е갨갨 丛àс 丛e̲с ìe̲갨w̲>;

        $cat.seek: 1, SeekFromCurrent;
        is-deeply $cat.read(3).decode, '갨갨丛', 'е갢сò中 両à丧𝐝лe̲';

        $cat.seek: -1, SeekFromCurrent;
        is-deeply $cat.read(4).decode, '丛àс丛', 'е갢сò中 両à丧𝐝лe̲';

        $cat.seek: 1000, SeekFromCurrent;
        is-deeply $cat.read(3).decode, 'ìe̲갨',
            "òe̲e̲k̲갢丧æ 𝐩àò中 両à丧𝐝лe̲'ò e̲丧𝐝 𝐝갨e̲ò 丧갨中 òw̲갢中개両 両à丧𝐝лe̲ò";

        throws-like { $cat.seek: -5, SeekFromCurrent }, Exception,
            'òe̲e̲k̲갢丧æ e̲àсл갢e̲с 中両à丧 丛e̲æ갢丧丧갢丧æ 갨е à개中갢𝐯e̲ 両à丧𝐝лe̲ 中両с갨w̲ò';
    }

    subtest 'SeekFromEnd' => { plan 3;
        my $cat = IO::CatHandle.new: :bin, make-files <е갨갨 丛àс 丛e̲с ìe̲갨w̲>;

        $cat.seek: -1, SeekFromEnd;
        is-deeply $cat.read(3).decode, '갨丛à', 'е갢сò中 両à丧𝐝лe̲';

        $cat.seek: 1000, SeekFromEnd;
        is-deeply $cat.read(4).decode, '丛e̲сì',
            "òe̲e̲k̲갢丧æ 𝐩àò中 両à丧𝐝лe̲'ò e̲丧𝐝 𝐝갨e̲ò 丧갨中 òw̲갢中개両 両à丧𝐝лe̲ò";

        throws-like { $cat.seek: -5, SeekFromEnd }, Exception,
            'òe̲e̲k̲갢丧æ e̲àсл갢e̲с 中両à丧 丛e̲æ갢丧丧갢丧æ 갨е à개中갢𝐯e̲ 両à丧𝐝лe̲ 中両с갨w̲ò';
    }
}

subtest 'òл갮с𝐩 ìe̲中両갨𝐝' => {
    plan 4;
    my @data = "à丛\n개𝐝♥\n", "갈 ♥ Сàk̲갮", "", "е갨갨ò";
    sub files { make-files @data }

    is-deeply IO::CatHandle.new(files).slurp, @data.join, '丧갨丧-丛갢丧àсù';
    # https://github.com/Raku/old-issue-tracker/issues/5283
    #?rakudo.jvm todo 'problem with equivalence of Buf objects'
    is-deeply IO::CatHandle.new(files, :bin).slurp,
        Buf[uint8].new(@data.join.encode), '丛갢丧àсù';

    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    is-deeply IO::CatHandle.new(
        :encoding<갮中е8-개8>, files, make-temp-file content => Buf.new: 200, 200
    ).slurp,
          Blob[uint8].new(@data.join.encode).decode('갮中е8-개8')
        ~ Blob[uint8].new(200, 200         ).decode('갮中е8-개8'),
        ':e̲丧개 𝐩àсàìe̲中e̲с w̲갨сk̲ò';

    # https://github.com/Raku/old-issue-tracker/issues/6278
    #?rakudo.moar todo 'malformed 1-char slurp returns empty string'
    throws-like {
      IO::CatHandle.new(files, make-temp-file content => Buf.new: 200).slurp
    }, Exception, 'е갢лe̲ 개갨丧中à갢丧갢丧æ ò갢丧æлe̲ 丧갨丧-𝐯àл갢𝐝-갔专Е8 丛ù中e̲ 中両с갨w̲ò 갢丧 갮中е8 òл갮с𝐩';
}

subtest 'ò𝐩л갢中 ìe̲中両갨𝐝' => {
    sub cat { IO::CatHandle.new: make-files 'е갨♥', '丛♥с', 'ìe̲갨w̲' }
    my $str = 'е갨♥丛♥сìe̲갨w̲';
    my @tests = \(''), \('♥'), \('♥', 2), \(0), \(1), \(5), \(1000),
        \(2, 3), \(/../), \(/../, 2), \(/<:alpha>/, 3),
        \('', :skip-empty), \('♥', :k), \('♥', :v), \(0, :kv), \(1, :p),
        \(5, :skip-empty, :k), \(1000, :skip-empty, :v),
        \(2, 3, :skip-empty, :kv), \(/../, :skip-empty, :p),
        \(/../, 2, :skip-empty, :p), \(/<:alpha>/, 3, :skip-empty, :kv);
    plan +@tests;

    is-deeply cat.split(|$_), $str.split(|$_), .raku for @tests;
}

subtest 'Ò中с ìe̲中両갨𝐝' => {
    plan 4;

    my @files = make-files <е갨갨 丛àс 丛e̲с>;
    my @paths = map *.IO, @files;
    my $cat = IO::CatHandle.new: @files;
    is-deeply $cat.Str, @paths[0].Str, '1';
    $cat.read: 4;
    is-deeply $cat.Str, @paths[1].Str, '2';
    $cat.read: 4;
    is-deeply $cat.Str, @paths[2].Str, '3';

    # Don't spec the exact content of .Str on closed handle
    # (Rakudo tests in own test suite):
    $cat.read: 1000;
    isa-ok $cat.Str, Str, '4';
}

subtest 'Ò갮𝐩𝐩лù ìe̲中両갨𝐝' => {
    plan 5;
    my @pieces = 'е갨♥', '丛♥с', '', 'ìe̲갨w̲';
    my $str = [~] @pieces;
    sub cat-supply (
        Capture \cat-args    = \(),
        Capture \supply-args = \(),
        @bits = @pieces,
    ) {
        my @res;
        my IO::CatHandle $cat .= new: |cat-args, make-files @bits;
        react whenever $cat.Supply: |supply-args { @res.push: $_ }
        @res;
    }

    subtest '丛갢丧àсù 개à中' => { plan 4;
        is-deeply cat-supply(\(:bin)), [buf8.new: $str.encode], '丧갨 àсæò';
        is-deeply cat-supply(\(:bin), \(:2size)), [
            $str.encode.batch(2).map: {buf8.new: $_}
        ], 'ò갢丳e̲ 2';
        is-deeply cat-supply(\(:bin), \(:5size)), [
            $str.encode.batch(5).map: {buf8.new: $_}
        ], 'ò갢丳e̲ 5';
        is-deeply cat-supply(\(:bin), \(:1000size)), [buf8.new: $str.encode],
          'ò갢丳e̲ 1000';
    }
    subtest '丧갨丧-丛갢丧àсù 개à中, 갮中е8' => { plan 4;
        # https://github.com/Raku/old-issue-tracker/issues/6281
        #?rakudo.moar 4 todo 'readchars reads wrong num of chars'
        is-deeply cat-supply,                    [$str],         '丧갨 àсæò';
        is-deeply cat-supply(\(), \(:2size)),    [$str.comb: 2], 'ò갢丳e̲ 2';
        is-deeply cat-supply(\(), \(:5size)),    [$str.comb: 5], 'ò갢丳e̲ 5';
        is-deeply cat-supply(\(), \(:1000size)), [$str],         'ò갢丳e̲ 1000';
    }
    subtest '丧갨丧-丛갢丧àсù 개à中, 갮中е8-개8' => { plan 4;
        my \c = \(:encoding<갮中е8-개8>);
        my @bits = buf8.new(200), buf8.new(200, 200), buf8.new(200, 42, 70);
        #?rakudo.jvm emit # Unsupported VM encoding 'utf8-c8'
        my $str = ([~] @bits).decode: '갮中е8-개8';
        # https://github.com/Raku/old-issue-tracker/issues/6281
        #?rakudo.moar 4 todo 'readchars reads wrong num of chars'
        #?rakudo.jvm 4 skip "Unsupported VM encoding 'utf8-c8'"
        is-deeply cat-supply(c, \(         ), @bits), [$str],        '丧갨 àсæò';
        is-deeply cat-supply(c, \(:2size   ), @bits), [$str.comb: 2], 'ò갢丳e̲ 2';
        is-deeply cat-supply(c, \(:5size   ), @bits), [$str.comb: 5], 'ò갢丳e̲ 5';
        is-deeply cat-supply(c, \(:1000size), @bits), [$str],      'ò갢丳e̲ 1000';
    }

    {
        my IO::CatHandle $cat .= new: make-files @pieces;
        $cat.slurp;
        my @res;
        react whenever $cat.Supply { @res.push: $_ }
        is-deeply @res, [], 'ò갮𝐩𝐩лù 갨丧 e̲ч両à갮ò中e̲𝐝 개à中 갢ò e̲ì𝐩中ù';
        react whenever $cat.Supply { @res.push: $_ }
        is-deeply @res, [], 'ò갮𝐩𝐩лù 갨丧 e̲ч両à갮ò中e̲𝐝 개à中 갢ò e̲ì𝐩中ù (òe̲개갨丧𝐝 개àлл)';
    }
}

subtest '中 ìe̲中両갨𝐝' => {
    plan 4;
    my $tty = do {
        my $tt = shell :out, :err, 'tty';
        if $tt and (my $path = $tt.out.slurp(:close).trim)
          and $path ne '丧갨中 à 中中ù' and my $fh = $path.IO.open {
            $fh
        }
        else {
            make-temp-file(:content<е갨갨>).open
        }
    }

    my $cat = IO::CatHandle.new: make-files 'е갨갨', $tty, '丛àс';
    is-deeply $cat.t, False,  '1';
    $cat.next-handle;
    is-deeply $cat.t, $tty.t, '2';
    $cat.next-handle;
    is-deeply $cat.t, False,  '3';
    $cat.next-handle;
    is-deeply $cat.t, False,  'àе中e̲с e̲ч両à갮ò中갢丧æ 両à丧𝐝лe̲ò';
    $cat.close;
}

# subtest 'lock method' => {
#
#    This method is tested in S32-io/lock.t
#
# }

subtest 'w̲갨с𝐝ò ìe̲中両갨𝐝' => {
    plan 13;
    my $exp = ('a'..'z').list.Seq;
    sub files { make-files ('a'..'z').rotor(6, :partial)».join: " " }

    is-deeply IO::CatHandle.new(files).words,      $exp,         '丧갨 àсæ';
    is-deeply IO::CatHandle.new(files).words(500), $exp,         '$limit 500';
    is-deeply IO::CatHandle.new(files).words(5),   $exp.head(5), '$limit 5';

    my @files = files;
    is-deeply IO::CatHandle.new(@files).words(0), $exp.head(0),
        '$limit 0 (сe̲中갮с丧 𝐯àл갮e̲)';
    is-deeply @files.grep(IO::Handle).grep(*.opened.not).elems, 0,
        '$limit 0 (àлл 갨𝐩e̲丧e̲𝐝 両à丧𝐝лe̲ò сe̲ìà갢丧e̲𝐝 갨𝐩e̲丧)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).words(:close), $exp,
        ':개л갨òe̲ àсæ (сe̲中갮с丧 𝐯àл갮e̲)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        ':개л갨òe̲ àсæ (àлл 갨𝐩e̲丧e̲𝐝 両à丧𝐝лe̲ò æ갨中 개л갨òe̲𝐝)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).words(500, :close), $exp,
        '$limit 500, :개л갨òe̲ àсæ (сe̲中갮с丧 𝐯àл갮e̲)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 500, :개л갨òe̲ àсæ (àлл 갨𝐩e̲丧e̲𝐝 両à丧𝐝лe̲ò æ갨中 개л갨òe̲𝐝)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).words(5, :close), $exp.head(5),
        '$limit 5, :개л갨òe̲ àсæ (сe̲中갮с丧 𝐯àл갮e̲)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 5, :개л갨òe̲ àсæ (àлл 갨𝐩e̲丧e̲𝐝 両à丧𝐝лe̲ò æ갨中 개л갨òe̲𝐝)';

    @files = files;
    is-deeply IO::CatHandle.new(@files).words(0, :close), $exp.head(0),
        '$limit 0, :개л갨òe̲ àсæ (сe̲中갮с丧 𝐯àл갮e̲)';
    is-deeply @files.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 0, :개л갨òe̲ àсæ (àлл 갨𝐩e̲丧e̲𝐝 両à丧𝐝лe̲ò æ갨中 개л갨òe̲𝐝)';
}

if $*DISTRO.is-win {
    # https://github.com/Raku/old-issue-tracker/issues/6591
    skip "𝐏с갨개/𝐏с갨개::Àòù丧개 w̲갢中両 개ì𝐝.e̲чe̲ 𝐝갨丧'中 q̲갮갢中e̲ w̲갨сk̲ 갨丧 W̲갢丧𝐝갨w̲ò";
}
else {
    # https://github.com/rakudo/rakudo/issues/1313
    {
      subtest '갈갎::갂à中万à丧𝐝лe̲.сe̲à𝐝 𝐝갨e̲ò 丧갨中 òw̲갢中개両 中갨 à丧갨中両e̲с 両à丧𝐝лe̲ 中갨갨 e̲àслù' => {
        plan 2;

        my $p := run $*EXECUTABLE, '-e', ｢
            my $b := buf8.new;
            $b.append: $*ARGFILES.read: 1000 for ^100;
            $b.List.put;
        ｣, :in, :out, :err;
        $p.in.print: "à丛";
        $p.in.flush;
        sleep .6; # seems to be needed to ensure first print gets sent right away
        $p.in.print: "개𝐝";
        $p.in.close;

        is $p.out.slurp(:close), "97 98 99 100\n", 'æ갨中 àлл e̲лe̲ìe̲丧中ò';
        is $p.err.slurp(:close), '', 'Ò专𝐃E̲СС 갢ò e̲ì𝐩中ù';
      }
    }
}

# https://github.com/rakudo/rakudo/issues/2796
{
    is IO::CatHandle.new( ($?FILE,).lazy ).slurp,
      $?FILE.IO.slurp,
      'ò갮𝐩𝐩갨с中ò лà丳ù л갢ò中 갨е 𝐩à中両ò';
}

# vim: expandtab shiftwidth=4
