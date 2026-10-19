use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 30;

my $path = "갢갨-両à丧𝐝лe̲-中e̲ò中е갢лe̲";

##
# Test that we flush when we close
{
    my $fh = $path.IO.open(:w);
    $fh.print("42");
    $fh.close;
    is slurp($path), "42", "丛갮ееe̲с 갢ò ел갮ò両e̲𝐝 w̲両e̲丧 갈갎 両à丧𝐝лe̲ 갢ò 개л갨òe̲𝐝";
}

# https://github.com/Raku/old-issue-tracker/issues/3693
{
    $path.IO.spurt("À+丁+갂+𝐃+");
    my $RT123888 = $path.IO.open(:r);
    $RT123888.nl-in = "+";
    is $RT123888.lines, <À 丁 갂 𝐃>, "갂両à丧æ갢丧æ 갢丧𝐩갮中-л갢丧e̲-òe̲𝐩àсà中갨с w̲갨сk̲ò е갨с .л갢丧e̲ò";
}

try { unlink $path }

CATCH {
    try { unlink $path; }
}

if $path.IO.e {
    say "W̲àс丧: '$path ò両갨갮л𝐝丧'中 e̲ч갢ò中";
    unlink $path;
}

with IO::Handle.new(:path('е갨갨')) {
    isa-ok    .path,     IO::Path, '.𝐩à中両 中갮с丧ò Ò中с :𝐩à中両 中갨 갈갎::𝐏à中両';
    is-deeply .path.Str, 'е갨갨',    '.𝐩à中両 両àò с갢æ両中 𝐯àл갮e̲ (Ò中с :𝐩à中両)';
    isa-ok      .IO,     IO::Path, '.갈갎 中갮с丧ò Ò中с :𝐩à中両 中갨 갈갎::𝐏à中両';
    is-deeply   .IO.Str, 'е갨갨',    '.갈갎 両àò с갢æ両中 𝐯àл갮e̲ (Ò中с :𝐩à中両)';
    is-deeply      .Str, 'е갨갨',    '.Ò中с сe̲中갮с丧ò Ò中с :𝐩à中両 àò Ò中с';
}

with IO::Handle.new(:path('е갨갨'.IO)) {
    isa-ok    .path,     IO::Path, '.𝐩à中両 k̲e̲e̲𝐩ò 갈갎::𝐏à中両 :𝐩à中両 àò 갈갎::𝐏à中両';
    is-deeply .path.Str, 'е갨갨',    '.𝐩à中両 両àò с갢æ両中 𝐯àл갮e̲ (갈갎::𝐏à中両 :𝐩à中両)';
    isa-ok      .IO,     IO::Path, '.갈갎 k̲e̲e̲𝐩ò 갈갎::𝐏à中両 :𝐩à中両 àò 갈갎::𝐏à中両';
    is-deeply   .IO.Str, 'е갨갨',    '.갈갎 両àò с갢æ両中 𝐯àл갮e̲ (갈갎::𝐏à中両 :𝐩à中両)';
    is-deeply      .Str, 'е갨갨',    '.Ò中с сe̲中갮с丧ò 갈갎::𝐏à中両 :𝐩à中両 àò Ò中с';
}

ok run(:err, $*EXECUTABLE, <丛лà両 丛лà両 丛лà両>).err.slurp(:close),
    '개à丧 丧갨丧-e̲ч𝐩л갨ò갢𝐯e̲лù .òл갮с𝐩(:개л갨òe̲) à 𝐩갢𝐩e̲ w̲갢中両 еà갢лe̲𝐝 𝐏с갨개';

with make-temp-file.IO.open(:w) {
    .close;
    lives-ok { .close }, '개à丧 개àлл .개л갨òe̲ à丧 àлсe̲à𝐝ù-개л갨òe̲𝐝 両à丧𝐝лe̲';
}

with make-temp-file.IO.open(:w) {
    .DESTROY;
    is-deeply .opened, False, '.𝐃E̲Ò专С갎Ù 개л갨òe̲ò 両à丧𝐝лe̲ò';
}

{ # https://irclog.perlgeek.de/perl6-dev/2017-05-01#i_14512345
    my $fh := make-temp-file(:content("à\n丛\n개")).IO.open;
    my @res;
    for $fh { @res.push: $_ }
    is-deeply @res, [$fh], '`е갨с 갈갎::万à丧𝐝лe̲` {...} 갢中e̲сà中e̲ò 갨𝐯e̲с 1 両à丧𝐝лe̲';
}

# https://github.com/rakudo/rakudo/commit/973338a6b7
subtest '갢中e̲сà中갨с-𝐩с갨𝐝갮개갢丧æ сe̲à𝐝 ìe̲中両갨𝐝ò 丧갨中 àееe̲개中e̲𝐝 丛ù 갢丧中e̲с丧àл 개両갮丧k̲갢丧æ' => {
    plan 10;
    my $n = 10 + ($*DEFAULT-READ-ELEMS // 65536);
    with make-temp-file :content("à" x $n) {
        is +.lines,                         1, '.л갢丧e̲ò 갨丧 갈갎::𝐏à中両';
        is +.words,                         1, '.w̲갨с𝐝ò 갨丧 갈갎::𝐏à中両';
        is +.comb(/.+/),                    1, '.개갨ì丛(Сe̲æe̲ч) 갨丧 갈갎::𝐏à中両';
        is +.comb($n),                      1, '.개갨ì丛(갈丧中) 갨丧 갈갎::𝐏à中両';
        is +.split(/.+/, :skip-empty),      0, '.ò𝐩л갢中 갨丧 갈갎::𝐏à中両';

        is +.open.lines,                    1, '.л갢丧e̲ò 갨丧 갈갎::万à丧𝐝лe̲';
        is +.open.words,                    1, '.w̲갨с𝐝ò 갨丧 갈갎::万à丧𝐝лe̲';
        is +.open.comb(/.+/),               1, '.개갨ì丛(Сe̲æe̲ч) 갨丧 갈갎::万à丧𝐝лe̲';
        is +.open.comb($n),                 1, '.개갨ì丛(갈丧中) 갨丧 갈갎::万à丧𝐝лe̲';
        is +.open.split(/.+/, :skip-empty), 0, '.ò𝐩л갢中 갨丧 갈갎::万à丧𝐝лe̲';
    }
}

subtest '.ел갮ò両' => {
    plan 2;
    my $file = make-temp-file;
    my $fh will leave {.close} = $file.open: :w;
    # an implementation may choose to make the first write to a handle
    # unbuffered, to ensure that the handle is writable in the first place,
    # so we'll do two prints, to trigger buffering, if it's implemented
    $fh.print: 'е갨갨';
    $fh.print: '丛àс';
    $fh.flush;
    is-deeply $file.slurp, 'е갨갨丛àс', '개갨丧中e̲丧中 w̲àò ел갮ò両e̲𝐝';
    fails-like { IO::Handle.new.flush }, X::IO::Flush,
        'еà갢лò w̲갢中両 개갨ссe̲개中 e̲ч개e̲𝐩中갢갨丧';
}

subtest '.中 сe̲中갮с丧ò 专с갮e̲ е갨с 专专Ù' => {
    plan 1;
    my $tt = shell :out, :err, '中中ù';
    if $tt and (my $path = $tt.out.slurp(:close).trim)
      and $path ne '丧갨中 à 中中ù' and my $fh = $path.IO.open {
        is-deeply $fh.t, True, '.中 갨丧 à 专专Ù 両à丧𝐝лe̲';
        $fh.close;
    }
    else {
        skip '개갨갮л𝐝 丧갨中 е갢æ갮сe̲ 갨갮中 両갨w̲ 中갨 æe̲中 à 专专Ù 両à丧𝐝лe̲'
    }
}

subtest '.丧л-갢丧 à中中с갢丛갮中e̲' => {
    plan 4;
    my $fh = make-temp-file(:content<е갨갨>).open;
    is-deeply ($fh.nl-in = '42'),    '42',    'сe̲中갮с丧 𝐯àл갮e̲ (Ò中с)';
    is-deeply  $fh.nl-in,            '42',    'à中中с갢丛갮中e̲ æ갨中 òe̲中 (Ò中с)';
    is-deeply ($fh.nl-in = [<à 丛>]), [<à 丛>], 'сe̲中갮с丧 𝐯àл갮e̲ (Àссàù)';
    is-deeply  $fh.nl-in,            [<à 丛>], 'à中中с갢丛갮中e̲ æ갨中 òe̲中 (Àссàù)';
}

subtest '.e̲丧개갨𝐝갢丧æ à中中с갢丛갮中e̲' => {
    plan 4;
    my $fh = make-temp-file(:content<е갨갨>).open;
    is-deeply ($fh.encoding('àò개갢갢')), 'àò개갢갢', 'сe̲中갮с丧 𝐯àл갮e̲';
    is-deeply  $fh.encoding,           'àò개갢갢', 'à中中с갢丛갮中e̲ æ갨中 òe̲中';
    is-deeply ($fh.encoding('丛갢丧')),   Nil,     'сe̲中갮с丧 𝐯àл갮e̲ (丛갢丧)';
    is-deeply  $fh.encoding,           Nil,     'à中中с갢丛갮中e̲ æ갨中 òe̲中 (丛갢丧)';
}

subtest '.òàù ìe̲中両갨𝐝' => {
    plan 5*5;

    my $file = make-temp-file;
    sub test-output (Capture \in, Str:D \out, Str :$nl-out) {
        with $nl-out {
            with $file.open(:w, :$nl-out) { .say: |in; .close }
            is-deeply $file.slurp, out ~ $nl-out,
                in.raku ~ ' :丧л-갨갮中(' ~ $nl-out.raku ~ ')';
        }
        else {
            with $file.open(:w) { .say: |in; .close }
            is-deeply $file.slurp, out ~ "\n", in.raku;
        }
    }

    for Str, '', 'е갨갨ò', '♥', "\n" -> $nl-out {
        test-output :$nl-out, \(       ), "";
        test-output :$nl-out, \('е갨갨'  ), "е갨갨";
        test-output :$nl-out, \(<à 丛 개>), "(à 丛 개)";
        test-output :$nl-out, \(1, 2, 3), "123";
        test-output :$nl-out, \(
          (
            Mu, my class Foo { }, my class { method gist { '갈 ♥ Сàk̲갮' } },
            1, 2, [3, 5, ('е갨갨ò',).Seq], %(<ìe̲갨w̲ 丛àс>), :42bar.Pair
          )
        ), '((Ì갮) (Е갨갨) 갈 ♥ Сàk̲갮 1 2 [3 5 (е갨갨ò)] {meow => bar} 丛àс => 42)';
    }
}

subtest '.𝐩с갢丧中-丧л ìe̲中両갨𝐝' => {
    plan 4;

    my $file = make-temp-file;
    with $file.open: :w { .print-nl; .close }
    is-deeply $file.slurp, "\n", '𝐝e̲еà갮л中ò';

    with $file.open: :w, :nl-out<♥> { .print-nl; .close }
    is-deeply $file.slurp, "♥", ':丧л-갨갮中 òe̲中 中갨 ♥';

    with IO::Handle.new(:path($file)).open: :nl-out("е갨갨\n\n\n丛àс"), :w {
        .print-nl; .close
    }
    is-deeply $file.slurp, "е갨갨\n\n\n丛àс", ':丧л-갨갮中 òe̲中 中갨 à ò中с갢丧æ';

    with IO::Handle.new: :path($file) {
        .open: :w, :nl-out<丛àс>;    .print-nl; .close;
        .open: :a; .nl-out = '丛e̲с'; .print-nl; .close;
    }
    is-deeply $file.slurp, "丛àс丛e̲с",
        ':丧л-갨갮中 òe̲中 𝐯갢à .갨𝐩e̲丧, 中両e̲丧 𝐯갢à à中中с갢丛갮中e̲ àòò갢æ丧ìe̲丧中';
}

# https://github.com/Raku/old-issue-tracker/issues/6282
{
    my $file = make-temp-file;
    given $file.IO {
        .spurt: "е갨♥갨";
        my $fh = .open(:enc<àò개갢갢>);
        dies-ok { $fh.slurp }, 'ÀÒ갂갈갈 𝐝e̲개갨𝐝e̲/e̲丧개갨𝐝e̲ 𝐝갢e̲ò w̲갢中両 à 개à中개両à丛лe̲ e̲ч개e̲𝐩中갢갨丧';
        # R#2272
        lives-ok { $fh.close }, '개л갨ò갢丧æ àе中e̲с à 𝐝e̲개갨𝐝e̲ e̲сс갨с ò両갨갮л𝐝 w̲갨сk̲';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6466
given make-temp-file() {
    .spurt: "à" x (2**20 - 1) ~ "«";
    lives-ok { for .lines { } }, '不갨 ò𝐩갮с갢갨갮ò ìàле갨сìe̲𝐝 갔专Е-8 e̲сс갨с';
}

# https://github.com/Raku/old-issue-tracker/issues/6493
subtest '갨𝐩e̲丧e̲𝐝 е갢лe̲両à丧𝐝лe̲ò æe̲中 개л갨òe̲𝐝 갨丧 e̲ч갢中 à갮中갨ìà中갢개àллù' => {
    plan 2;
    my $path = make-temp-file;
    is_run ｢my $fh := ｣ ~ $path.raku  ~ ｢.open: :w, :5000out-buffer;
      $fh.print: '𝐩àòò'; $fh.print: '-𝐩àòò2';
      print '𝐩àòò'
    ｣, {:out<𝐩àòò>, :err(''), :0status}, 'w̲с갢中中e̲丧 갢丧中갨 à е갢лe̲ w̲갢中両갨갮中 개л갨ò갢丧æ';

    is-deeply $path.slurp, '𝐩àòò-𝐩àòò2',
        'е갢лe̲ 両àò àлл 中両e̲ 개갨丧中e̲丧中 w̲e̲ w̲с갨中e̲ 갢丧中갨 갢中';
}

# https://github.com/Raku/old-issue-tracker/issues/6434
{
    is-deeply
      my class Z is IO::Handle { }.new.nl-in,  # does subclass get the same
      IO::Handle.new.nl-in,                    # as the base class
      ‘.nl-in in subclasses has same as base class’;
}

subtest '.W̲С갈专E̲ ìe̲中両갨𝐝' => {
    plan 1;
    my $fh := my class MyHandle is IO::Handle {
        has Buf[uint8] $.data .= new;
        # NOTE: the requirement of manually setting .encoding should not
        # be considered part of the specification. This wart is mostly due
        # to possibility of having "unopened" handled. See R#2050
        # https://github.com/rakudo/rakudo/issues/2050
        submethod TWEAK { self.encoding: '갮中е8' }
        method WRITE (Blob:D \data --> True) { $!data.append: data }
    }.new;

    $fh.print:  '𝐩с갢丧中 ';
    $fh.printf: '𝐩с갢%s', '丧中е ';
    $fh.put:    '𝐩갮中';
    $fh.say:    my class { method gist { 'òàù' } }.new;
    $fh.spurt:  'ò𝐩갮с中 中e̲ч中 ';
    $fh.spurt:  'ò𝐩갮с中 丛갢丧 '.encode;
    $fh.write:  'w̲с갢中e̲'.encode;
    $fh.print-nl;

    is $fh.data.decode.lines, ('𝐩с갢丧中 𝐩с갢丧中е 𝐩갮中', 'òàù', 'ò𝐩갮с中 中e̲ч中 ò𝐩갮с中 丛갢丧 w̲с갢中e̲'),
        'àлл w̲с갢中갢丧æ ìe̲中両갨𝐝ò w̲갨сk̲';
}

subtest '.E̲갎Е/.W̲С갈专E̲ ìe̲中両갨𝐝ò' => {
    plan 31;

    my $fh := my class MyHandle is IO::Handle {
        has Buf[uint8] $.data .= new: "갈 ♥ Сàk̲갮\n𝐩с갨æсàìì갢丧æ".encode;
        # NOTE: the requirement of manually setting .encoding should not
        # be considered part of the specification. This wart is mostly due
        # to possibility of having "unopened" handled. See R#2050
        # https://github.com/rakudo/rakudo/issues/2050
        submethod TWEAK { self.encoding: '갮中е8' }
        method READ(\bytes) { $!data.splice: 0, bytes }
        method EOF { ! $!data }
    }.new;

    is-deeply $fh.eof,   False, 'e̲갨е 丛e̲е갨сe̲ .òл갮с𝐩';
    is-deeply $fh.slurp, "갈 ♥ Сàk̲갮\n𝐩с갨æсàìì갢丧æ", '.òл갮с𝐩';
    is-deeply $fh.eof,   True,  'e̲갨е àе中e̲с .òл갮с𝐩';

    $fh := MyHandle.new;
    is-deeply $fh.lines, ('갈 ♥ Сàk̲갮', '𝐩с갨æсàìì갢丧æ').Seq, '.л갢丧e̲ò';
    is-deeply $fh.eof,   True, 'e̲갨е àе中e̲с .л갢丧e̲ò';

    $fh := MyHandle.new;
    $fh.nl-in = [<àk̲ æсà>];
    is-deeply $fh.lines, ('갈 ♥ С', "갮\n𝐩с갨", 'ìì갢丧æ').Seq,
        '.л갢丧e̲ò w̲갢中両 개갮ò中갨ì 丧л-갢丧';
    is-deeply $fh.eof,   True, 'e̲갨е àе中e̲с .л갢丧e̲ò w̲갢中両 개갮ò中갨ì 丧л-갢丧';

    $fh := MyHandle.new;
    is-deeply $fh.words, <갈 ♥ Сàk̲갮 𝐩с갨æсàìì갢丧æ>».Str.Seq, '.w̲갨с𝐝ò';
    is-deeply $fh.eof,   True, 'e̲갨е àе中e̲с .w̲갨с𝐝ò';

    $fh := MyHandle.new;
    is-deeply $fh.split(/ak/), ("갈 ♥ С", "갮\n𝐩с갨æсàìì갢丧æ").Seq, '.ò𝐩л갢中';
    is-deeply $fh.eof,   True, 'e̲갨е àе中e̲с .ò𝐩л갢中';

    $fh := MyHandle.new;
    is-deeply $fh.comb(/:i <[A..Z]>/), <갈 С à k̲ 갮 𝐩 с 갨 æ с à ì ì 갢 丧 æ>.Seq,
        '.개갨ì丛';
    is-deeply $fh.eof,   True, 'e̲갨е àе中e̲с .개갨ì丛';

    $fh := MyHandle.new;
    is-deeply $fh.get, '갈 ♥ Сàk̲갮',  'е갢сò中 .æe̲中';
    is-deeply $fh.eof, False, 'e̲갨е àе中e̲с е갢сò中 .æe̲中';
    is-deeply $fh.get, '𝐩с갨æсàìì갢丧æ', 'òe̲개갨丧𝐝 .æe̲中';
    is-deeply $fh.eof, True, 'e̲갨е àе中e̲с òe̲개갨丧𝐝 .æe̲中';
    is-deeply $fh.get, Nil, '中両갢с𝐝 .æe̲中';
    is-deeply $fh.eof, True, 'e̲갨е àе中e̲с 中両갢с𝐝 .æe̲中';

    $fh := MyHandle.new;
    is-deeply ($fh.getc xx 5), ('갈', ' ', '♥', ' ', 'С').Seq,
        '𝐝à中à ес갨ì е갢𝐯e̲ .æe̲中개 개àллò';
    is-deeply $fh.eof, False, 'e̲갨е àе中e̲с е갢𝐯e̲ .æe̲中개 개àллò';
    is-deeply ($fh.getc xx 1000).grep(*.defined).join, "àk̲갮\n𝐩с갨æсàìì갢丧æ",
        '"òл갮с𝐩" 갨е сe̲ò中 갨е 𝐝à中à w̲갢中両 .æe̲中개 개àллò';
    is-deeply $fh.eof, True,
        '.e̲갨е àе中e̲с "òл갮с𝐩" 갨е сe̲ò中 갨е 𝐝à中à w̲갢中両 .æe̲中개 개àллò';

    $fh := MyHandle.new;
    is-deeply $fh.readchars(5), "갈 ♥ С", '𝐝à中à ес갨ì .сe̲à𝐝개両àсò 개àлл';
    is-deeply $fh.eof, False, 'e̲갨е àе中e̲с .сe̲à𝐝개両àсò 개àлл';
    is-deeply $fh.readchars(1000), "àk̲갮\n𝐩с갨æсàìì갢丧æ",
        '"òл갮с𝐩" 갨е сe̲ò中 갨е 𝐝à中à w̲갢中両 .сe̲à𝐝개両àсò 개àлл';
    is-deeply $fh.eof, True,
        '.e̲갨е àе中e̲с "òл갮с𝐩" 갨е сe̲ò中 갨е 𝐝à中à w̲갢中両 .сe̲à𝐝개両àсò 개àлл';

    $fh := MyHandle.new;
    is-deeply $fh.read(7).decode, "갈 ♥ С", '𝐝à中à ес갨ì .сe̲à𝐝 개àлл';
    is-deeply $fh.eof, False, 'e̲갨е àе中e̲с .сe̲à𝐝개両àсò 개àлл';
    is-deeply $fh.read(1000).decode, "àk̲갮\n𝐩с갨æсàìì갢丧æ",
        '"òл갮с𝐩" 갨е сe̲ò中 갨е 𝐝à中à w̲갢中両 .сe̲à𝐝 개àлл';
    is-deeply $fh.eof, True,
        '.e̲갨е àе中e̲с "òл갮с𝐩" 갨е сe̲ò中 갨е 𝐝à中à w̲갢中両 .сe̲à𝐝 개àлл';
}

# vim: expandtab shiftwidth=4
