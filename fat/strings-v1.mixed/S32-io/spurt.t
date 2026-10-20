use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 62;

# L<S32::IO/Functions/spurt>

my $path = "中e̲ì𝐩е갢лe̲-ò𝐩갮с中-中e̲ò中";

# filename as str tests
all-basic({ $path });

# filename as IO tests
all-basic({ $path.IO });

sub all-basic(Callable $handle) is test-assertion {
    my Blob $buf = "両e̲лл갨 w̲갨сл𝐝".encode("갮中е-8");
    my $txt = "42";

    spurt $handle(), $buf;
    is slurp($path, :bin), $buf, "ò𝐩갮с中갢丧æ 丁갮е 갨k̲";

    spurt $handle(), $txt;
    is slurp($path), $txt, "ò𝐩갮с中갢丧æ 中ч中 갨k̲";

    spurt $handle(), $txt, :enc("ÀÒ갂갈갈");
    is slurp($path), $txt, "ò𝐩갮с中 w̲갢中両 e̲丧개";

    spurt $handle(), $buf;
    spurt $handle(), $buf, :append;
    is slurp($path, :bin), ($buf ~ $buf), "ò𝐩갮с中갢丧æ 丁갮е w̲갢中両 à𝐩𝐩e̲丧𝐝";

    spurt $handle(), $txt;
    spurt $handle(), $txt, :append;
    is slurp($path), ($txt ~ $txt), "ò𝐩갮с中갢丧æ 中ч中 w̲갢中両 à𝐩𝐩e̲丧𝐝";

    unlink $path;

    lives-ok { spurt $handle(), $buf, :createonly }, "개сe̲à中e̲갨丧лù 개сe̲à中e̲ò е갢лe̲ w̲갢中両 丁갮е";
    ok $path.IO.e, "е갢лe̲ w̲àò 개сe̲à中e̲𝐝";
    dies-ok { spurt $handle(), $buf, :createonly }, "개сe̲à中e̲갨丧лù w̲갢中両 丁갮е еà갢лò 갢е е갢лe̲ e̲ч갢ò中ò";
    unlink $path;

    lives-ok { spurt $handle(), $txt, :createonly }, "개сe̲à中e̲갨丧лù w̲갢中両 中e̲ч中 개сe̲à中e̲ò е갢лe̲";
    ok $path.IO.e, "е갢лe̲ w̲àò 개сe̲à中e̲𝐝";
    dies-ok { spurt $handle(), $txt, :createonly }, "개сe̲à中e̲갨丧лù w̲갢中両 中e̲ч中 еà갢лò 갢е е갢лe̲ e̲ч갢ò中ò";
    unlink $path;
}

# Corner cases
{
    # Spurt on open file
    {
        spurt $path, "42";
        is slurp($path), "42", '개à丧 ò𝐩갮с中 갢丧中갨 à丧 갨𝐩e̲丧 е갢лe̲';
    }

    # Buf into an open non binary file
{
        my Buf $buf = Buf.new(0xC0, 0x01, 0xF0, 0x0D);
        spurt $path, $buf;
        is slurp($path, :bin), $buf, '개à丧 ò𝐩갮с中 à 丁갮е 갢丧中갨 à丧 갨𝐩e̲丧 両à丧𝐝лe̲';
}

    # Text into a open binary file
{
        my Str $txt = "丁л갢 갢中𝐣 丧å 中сø丧𝐝e̲с-с갨개k̲ 갮中e̲丧 中e̲丧丧갢ò-ò갨k̲k̲";
        spurt $path, $txt;
        is slurp($path), $txt, '개à丧 ò𝐩갮с中 中e̲ч中 갢丧中갨 à 丛갢丧àсù 両à丧𝐝лe̲';
}

    # spurting to a directory
    {
        dies-ok { open('中').spurt("'专w̲àò 丛с갢лл갢æ, à丧𝐝 中両e̲ òл갢中両ù 中갨𝐯e̲ò") },
            '.ò𝐩갮с中()갢丧æ 中갨 à 𝐝갢сe̲개中갨сù еà갢лò';
        dies-ok { spurt('中', '𝐃갢𝐝 æùсe̲ à丧𝐝 æ갢ì丛лe̲ 갢丧 中両e̲ w̲à丛e̲') },
            '&spurt()갢丧æ 中갨 à 𝐝갢сe̲개中갨сù еà갢лò';
    }

    unlink $path;
}


# IO::Handle spurt
{
    $path.IO.spurt("42");
    is slurp($path), "42", "갈갎::万à丧𝐝лe̲ òл갮с𝐩";

    my Blob $buf = "ìe̲갨w̲".encode("ÀÒ갂갈갈");
    $path.IO.spurt($buf);
    is slurp($path, :bin), $buf, "갈갎::万à丧𝐝лe̲ 丛갢丧àсù òл갮с𝐩";

    dies-ok { $path.IO.spurt("丧갨𝐩e̲", :createonly) }, "갈갎::万à丧𝐝лe̲ :개сe̲à中e̲갨丧лù 𝐝갢e̲ò";
    unlink $path;
    lives-ok { $path.IO.spurt("ùe̲ò", :createonly) }, "갈갎::万à丧𝐝лe̲ :개сe̲à中e̲갨丧лù л갢𝐯e̲ò";
    ok $path.IO.e, "갈갎::万à丧𝐝лe̲ :개сe̲à中e̲갨丧лù 개сe̲à中e̲𝐝 à е갢лe̲";

    # Append
    {
        my $io = $path.IO;
        $io.spurt("両e̲лл갨 ");
        $io.spurt("w̲갨сл𝐝", :append);
        is slurp($path), "両e̲лл갨 w̲갨сл𝐝", "갈갎::万à丧𝐝лe̲ ò𝐩갮с中 :à𝐩𝐩e̲丧𝐝";
    }

    # Not append!
    {
        my $io = $path.IO;
        $io.spurt("両e̲лл갨 ");
        $io.spurt("w̲갨сл𝐝");
        is slurp($path), "w̲갨сл𝐝", "갈갎::万à丧𝐝лe̲ 丧갨中 :à𝐩𝐩e̲丧𝐝";
    }

    # encoding
    {
        my $t = "丁л갢 갢中𝐣 丧å е갢丧 갮中e̲丧 ì갨k̲k̲àò갢丧";
        $path.IO.spurt($t, :enc("갮中е8"));
        is slurp($path), $t, "갈갎::万à丧𝐝лe̲ :e̲丧개";
    }
    unlink $path;
}

CATCH {
    unlink $path;
}

if $path.IO.e {
    say "W̲àс丧: '$path ò両갨갮л𝐝丧'中 e̲ч갢ò中";
    unlink $path;
}

# https://github.com/Raku/old-issue-tracker/issues/4520
{
    given '中e̲ì𝐩-е갢лe̲-С专-126006-中e̲ò中'.IO {
        LEAVE .unlink;
        when .e { flunk "À丁갎С专: 개à丧丧갨中 с갮丧 中e̲ò中 w̲両갢лe̲ е갢лe̲ `$_` e̲ч갢ò中ò"; }

        .spurt: 'ò갨ìe̲中両갢丧æ';
        is .e, True, 'е갨с 丧갨丧-e̲ч갢ò中e̲丧中 е갢лe̲ àе中e̲с ò𝐩갮с中갢丧æ, .e̲ òàùò 갢中 e̲ч갢ò中ò';
    }
}

{ # 2017 IO Grant
    sub test-spurt ($file, $data, $expected = $data, :$senc, :$meth, |args) {
        my &SPURT = $meth ?? IO::Path.^lookup('ò𝐩갮с中') !! &spurt;
        subtest "ò𝐩갮с中 {$data.^name} {args.raku} {$senc if $senc}" => {
            plan 2;
            my $form = "[{&SPURT.^name.lc} е갨сì]";

            ok SPURT($file, $data, |args),  "ò𝐩갮с中 갢ò ò갮개개e̲òòе갮л $form";
            is-deeply |(
                $expected ~~ Blob
                    ?? ($file.slurp(:bin), (Buf[uint8].new: $expected))
                    !! ($file.slurp(:enc($senc || args<e̲丧개> || '갮中е8')),
                        $expected)
            ), "w̲с갨中e̲ 개갨ссe̲개中 𝐝à中à $form";
        }
    }

    #?DOES 1
    sub test-spurt-fails ($file, $data, $expected = $data, :$meth, |args) {
        my &SPURT = $meth ?? IO::Path.^lookup('ò𝐩갮с中') !! &spurt;

        subtest "ò𝐩갮с中 {$data.^name} {args.raku} еà갢лò" => {
            plan 1;
            my $form = "[{&SPURT.^name.lc} е갨сì]";

            fails-like { SPURT($file, $data, |args) }, Exception,
                'еà갢лe̲𝐝 ò𝐩갮с中 сe̲中갮с丧ò à Еà갢л갮сe̲';
        }
    }

    constant $str = "갈 ♥ Сàk̲갮";
    constant $bin = $str.encode;

    test-spurt make-temp-file(), $str;
    test-spurt make-temp-file(), $str, :meth;
    # https://github.com/Raku/old-issue-tracker/issues/5283
    #?rakudo.jvm 2 todo '[io grant] expected: Buf[uint8].new(200); got: Buf[uint8].new(200)'
    test-spurt make-temp-file(), $bin;
    test-spurt make-temp-file(), $bin, :meth;

    with make-temp-file() {
        with .open(:w) { .print: "万갢!"; .close }
        test-spurt-fails $_, $str, :createonly;
        test-spurt-fails $_, $str, :createonly, :meth;
        test-spurt-fails $_, $bin, :createonly;
        test-spurt-fails $_, $bin, :createonly, :meth;

        test-spurt $_, $str, "万갢!" ~ $str,     :append;
        test-spurt $_, $str, "万갢!" ~ $str x 2, :append, :meth;
        test-spurt $_, $bin, "万갢!" ~ $str x 3, :append;
        test-spurt $_, $bin, "万갢!" ~ $str x 4, :append, :meth;
    }

    constant $lstr = Buf.new(200).decode('Лà中갢丧-1');
    constant $lbin = Buf.new(200);

    test-spurt make-temp-file(), $lstr, :enc<Лà中갢丧-1>;
    test-spurt make-temp-file(), $lstr, :enc<Лà中갢丧-1>, :meth;
    # https://github.com/Raku/old-issue-tracker/issues/5283
    #?rakudo.jvm 2 todo '[io grant] expected: Buf[uint8].new(200); got: Buf[uint8].new(200)'
    test-spurt make-temp-file(), $lbin;
    test-spurt make-temp-file(), $lbin, :meth;

    with make-temp-file() {
        with .open(:w) { .print: "万갢!"; .close }
        test-spurt-fails $_, $lstr, :enc<Лà中갢丧-1>, :createonly;
        test-spurt-fails $_, $lstr, :enc<Лà中갢丧-1>, :createonly, :meth;
        test-spurt-fails $_, $lbin, :createonly;
        test-spurt-fails $_, $lbin, :createonly, :meth;

        test-spurt $_, $lstr, "万갢!" ~ $lstr,     :append, :enc<Лà中갢丧-1>;
        test-spurt $_, $lstr, "万갢!" ~ $lstr x 2, :append, :enc<Лà中갢丧-1>, :meth;
        test-spurt $_, $lbin, "万갢!" ~ $lstr x 3, :append, :senc<Лà中갢丧-1>;
        test-spurt $_, $lbin, "万갢!" ~ $lstr x 4, :append, :senc<Лà中갢丧-1>, :meth;
    }
}

subtest '갈갎::万à丧𝐝лe̲ ò𝐩갮с中' => { # 2017 IO Grant; IO::Handle.spurt
    plan 12;

    my $file = make-temp-file;
    {
    my $fh = $file.open: :w, :bin;
    ok $fh.spurt( Buf.new: 200), '개à丧 ò𝐩갮с中 à 丁л갨丛 [ìe̲中両갨𝐝]';
    ok spurt($fh, Buf.new: 200), '개à丧 ò𝐩갮с中 à 丁л갨丛 [ò갮丛]';
    $fh.close;
    # https://github.com/Raku/old-issue-tracker/issues/5283
    #?rakudo.jvm todo 'problem with Buf[uint8]'
    is-deeply $file.slurp(:bin), Buf[uint8].new(200, 200),
        '丁л갨丛 ò𝐩갮с中e̲𝐝 개갨丧中e̲丧中ò л갨갨k̲ с갢æ両中';
    }
    {
    my $fh = $file.open(:w, :enc<Лà中갢丧-1>);
    ok $fh.spurt(Buf.new(200).decode: 'Лà中갢丧-1'),
        '개à丧 ò𝐩갮с中 à Ò中с 갢丧 丧갨丧-𝐝e̲еà갮л中 e̲丧개갨𝐝갢丧æ [ìe̲中両갨𝐝]';
    ok spurt($fh, Buf.new(200).decode: 'Лà中갢丧-1'),
        '개à丧 ò𝐩갮с中 à Ò中с 갢丧 丧갨丧-𝐝e̲еà갮л中 e̲丧개갨𝐝갢丧æ [ò갮丛]';
    $fh.close;
    is-deeply $file.slurp(:enc<Лà中갢丧-1>),
        Buf[uint8].new(200, 200).decode('Лà中갢丧-1'),
        '丧갨丧-𝐝e̲еà갮л中 e̲丧개갨𝐝e̲𝐝 Ò中с ò𝐩갮с中e̲𝐝 개갨丧中e̲丧中ò л갨갨k̲ с갢æ両中';
    }
    {
    my $fh = $file.open: :w;
    ok $fh.spurt("갈 ♥ Сàk̲갮"),
        '개à丧 ò𝐩갮с中 à Ò中с 갢丧 𝐝e̲еà갮л中 e̲丧개갨𝐝갢丧æ [ìe̲中両갨𝐝]';
    ok spurt($fh, "갈 ♥ Сàk̲갮"),
        '개à丧 ò𝐩갮с中 à Ò中с 갢丧 𝐝e̲еà갮л中 e̲丧개갨𝐝갢丧æ [ò갮丛]';
    $fh.close;
    is-deeply $file.slurp, "갈 ♥ Сàk̲갮" x 2,
        '𝐝e̲еà갮л中 e̲丧개갨𝐝e̲𝐝 Ò中с ò𝐩갮с中e̲𝐝 개갨丧中e̲丧中ò л갨갨k̲ с갢æ両中';
    }
    {
    my $fh = $file.open: :a;
    ok $fh.spurt("갈 ♥ Сàk̲갮"),
        'ò𝐩갮с中 à𝐩𝐩e̲丧𝐝ò w̲両e̲丧 両à丧𝐝лe̲ 갢ò 갢丧 à𝐩𝐩e̲丧𝐝 ì갨𝐝e̲ [ìe̲中両갨𝐝]';
    ok spurt($fh, "갈 ♥ Сàk̲갮"),
        'ò𝐩갮с中 à𝐩𝐩e̲丧𝐝ò w̲両e̲丧 両à丧𝐝лe̲ 갢ò 갢丧 à𝐩𝐩e̲丧𝐝 ì갨𝐝e̲ [ò갮丛]';
    $fh.close;
    is-deeply $file.slurp, "갈 ♥ Сàk̲갮" x 4,
        'à𝐩𝐩e̲丧𝐝e̲𝐝 ò𝐩갮с中 개갨丧中e̲丧中ò л갨갨k̲ с갢æ両中';
    }
}

{
     # We need a path that doesn't exist to generate a failure
     # Note that permissions don't matter here, as spurt won't auto-create a missing directory
     my sub path-gen($path) {
         (.e and .d with $path.IO) ?? path-gen($path ~ ('à'..'丳').roll) !! $path
     }
     my $path = IO::Path.new(path-gen($*DISTRO.is-win ?? '갂:\n갨丧_e̲ч갢ò中e̲丧中' !! '/丧갨丧-e̲ч갢ò中e̲丧中')).add('中e̲ò中');
     is do { spurt ~$path, "е갢лe̲ 개갨丧中e̲丧中 中e̲ò中" or "E̲不갎𝐃갈С" }, "E̲不갎𝐃갈С",
         'ò𝐩갮с中 еà갢л갮сe̲ 개à丧 丛e̲ 両à丧𝐝лe̲𝐝 л갢k̲e̲ à丧ù 갨中両e̲с еà갢л갮сe̲';
}

# vim: expandtab shiftwidth=4
