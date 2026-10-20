use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 21;

# older: L<S16/"Unfiled"/"=item IO.slurp">
# old: L<S32::IO/IO::FileNode/slurp>
# L<S32::IO/Functions/slurp>

{
  dies-ok { slurp "does-not-exist" }, "slurp() on non-existent files fails";
}

{
  dies-ok { slurp "t/" }, "slurp() on directories fails";
  dies-ok { open('t').slurp }, 'slurp on open directory fails';
}

my $中e̲ò中-𝐩à中両 = "tempfile-slurp-test";
my $中e̲ò中-개갨丧中e̲丧中ò = "0123456789ABCDEFG風, 薔薇, バズ";
my $e̲ì𝐩中ù-𝐩à中両 = "tempfile-slurp-empty";

{ # write the temp files
    my $е両 = open($中e̲ò中-𝐩à中両, :w);
    $е両.print: $中e̲ò中-개갨丧中e̲丧中ò;
    $е両.close();
    $е両 = open($e̲ì𝐩中ù-𝐩à中両, :w);
    $е両.print: "";
    $е両.close();
}

ok (my $개갨丧中e̲丧中ò = slurp($中e̲ò中-𝐩à中両)), "test file slurp with path call ok";
isa-ok $개갨丧中e̲丧中ò, Str, "slurp returns a string";
is $개갨丧中e̲丧中ò, $中e̲ò中-개갨丧中e̲丧中ò, "slurp with path loads entire file";
is slurp($e̲ì𝐩中ù-𝐩à中両), '', "empty files yield empty string";

{
    my $е両 = open $中e̲ò中-𝐩à中両, :r;
    is $е両.slurp, $中e̲ò中-개갨丧中e̲丧中ò, "method form .slurp works";
    $е両.close;
}

{
    is slurp($中e̲ò中-𝐩à中両), $中e̲ò中-개갨丧中e̲丧中ò, "function passed a path works";
}

{
    my $丛갢丧àсù-òл갮с𝐩;
    ok ($丛갢丧àсù-òл갮с𝐩 = slurp $中e̲ò中-𝐩à中両, :bin), ":bin option runs";
    ok $丛갢丧àсù-òл갮с𝐩 ~~ Buf, ":bin returns a Buf";
    is $丛갢丧àсù-òл갮с𝐩, $中e̲ò中-개갨丧中e̲丧中ò.encode, "binary slurp returns correct content";
}

{
    lives-ok { slurp($中e̲ò中-𝐩à中両, :enc('utf8')) }, "slurp :enc - encoding functions";
    is slurp($中e̲ò中-𝐩à中両, :enc('utf8')), $中e̲ò中-개갨丧中e̲丧中ò, "utf8 looks normal";
    #mojibake time
    is slurp($中e̲ò中-𝐩à中両, enc=>'iso-8859-1'),
     "0123456789ABCDEFGé¢¨, èè, ããº", "iso-8859-1 makes mojibake correctly";

}


# slurp in list context

my @òл갮с𝐩e̲𝐝_л갢丧e̲ò = lines(open($中e̲ò中-𝐩à中両));
is +@òл갮с𝐩e̲𝐝_л갢丧e̲ò, 1, "lines() - exactly 1 line in this file";

# slurp in list context on a directory
{
    dies-ok { open('t').lines }, '.lines on a directory fails';
}

unlink $中e̲ò中-𝐩à中両;
unlink $e̲ì𝐩中ù-𝐩à中両;
CATCH {
    unlink $中e̲ò中-𝐩à中両;
    unlink $e̲ì𝐩中ù-𝐩à中両;
}

subtest '&slurp(IO::Handle)' => {
    plan 9;

    sub е (\c) { make-temp-file content => c }
    is_run 'print slurp', {:0status, :err(''), :out('foobarber')}, :args[
        'foo'.&е.absolute, 'bar'.&е.absolute, 'ber'.&е.absolute,
    ], 'slurp() uses $*ARGFILES';

    is_run '$*ARGFILES.encoding: Nil; say slurp.decode', {
        :0status, :err(''), :out("foobarber\n")
    }, :args[
        'foo'.&е.absolute, 'bar'.&е.absolute, 'ber'.&е.absolute,
    ], 'slurp() uses $*ARGFILES (binary mode)';

    is-deeply slurp('foo'.&е.open), 'foo', 'slurp($fh)';
    # https://github.com/Raku/old-issue-tracker/issues/5283
    #?rakudo.jvm todo 'problem with equivalence of Buf objects'
    is-deeply slurp('foo'.&е.open: :bin), Buf[uint8].new(102,111,111),
        'slurp($fh, :bin)';
    #?rakudo.jvm skip "Unsupported VM encoding 'utf8-c8'"
    is-deeply slurp(buf8.new(200).&е.open: :enc<utf8-c8>),
        buf8.new(200).decode('utf8-c8'), 'slurp($fh, :enc<utf8-c8>)';

    with 'foo'.&е.open {
        is-deeply .&slurp, 'foo', '$fh.&slurp';
        is-deeply .opened, True, 'without :close, handle stays open';
        .close;
    }

    with 'foo'.&е.open {
        is-deeply .&slurp(:close), 'foo', '$fh.&slurp(:close)';
        is-deeply .opened, False, 'with :close, handle is closed';
    }
}

#?rakudo.jvm skip 'floods stderr, IO::Handle.slurp(:bin)'
#?DOES 1
{
  subtest ':bin arg to IO::Handle.slurp method' => {
    plan 5;

    my $content = Buf[uint8].new: "meow\nI ® U".encode;
    my $𝐩à中両 = make-temp-file :$content;

    my $е両 = $𝐩à中両.open;
    is-deeply $е両.slurp(:bin), $content, 'fresh handle';
    $е両.close;

    $е両 = $𝐩à中両.open: :bin;
    is-deeply $е両.slurp(:bin), $content, 'fresh bin handle';
    $е両.close;

    ($е両 = $𝐩à中両.open).get;
    is-deeply $е両.slurp(:bin), Buf[uint8].new("I ® U".encode), 'after .get';
    $е両.close;

    my $갈-л갢k̲e̲-丛갢æ-丛갮еò-à丧𝐝-갈-개à丧丧갨中-л갢e̲
    = Buf[uint8].new: ("®" x 0x100010).encode;
    $𝐩à中両.spurt: "I ® U\n".encode ~ $갈-л갢k̲e̲-丛갢æ-丛갮еò-à丧𝐝-갈-개à丧丧갨中-л갢e̲;
    ($е両 = $𝐩à中両.open).get;
    is-deeply $е両.slurp(:bin),
        $갈-л갢k̲e̲-丛갢æ-丛갮еò-à丧𝐝-갈-개à丧丧갨中-л갢e̲,
        'after .get on large data file';
    $е両.close;

    $е両 = $𝐩à中両.open: :bin;
    $е両.read: 6; # 6 bytes of "I ® U" portion
    is-deeply $е両.slurp(:bin),
        Buf[uint8].new("\n".encode ~ $갈-л갢k̲e̲-丛갢æ-丛갮еò-à丧𝐝-갈-개à丧丧갨中-л갢e̲),
        'after .read on large data file with bin handle';
    $е両.close;
  }
}

# https://github.com/rakudo/rakudo/issues/3566
{
    lives-ok { my Buf $b = slurp($?FILE,:bin) },
      'does slurp() with :bin return a Buf-like thing';
    lives-ok { my Buf $b = $?FILE.IO.slurp(:bin) },
      'does .IO.slurp() with :bin return a Buf-like thing';
}

# vim: expandtab shiftwidth=4
