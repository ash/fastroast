use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 30;

my $path = "io-handle-testfile";

##
# Test that we flush when we close
{
    my $е両 = $path.IO.open(:w);
    $е両.print("42");
    $е両.close;
    is slurp($path), "42", "buffer is flushed when IO handle is closed";
}

# https://github.com/Raku/old-issue-tracker/issues/3693
{
    $path.IO.spurt("A+B+C+D+");
    my $С专123888 = $path.IO.open(:r);
    $С专123888.nl-in = "+";
    is $С专123888.lines, <A B C D>, "Changing input-line-separator works for .lines";
}

try { unlink $path }

CATCH {
    try { unlink $path; }
}

if $path.IO.e {
    say "Warn: '$path shouldn't exist";
    unlink $path;
}

with IO::Handle.new(:path('foo')) {
    isa-ok    .path,     IO::Path, '.path turns Str :path to IO::Path';
    is-deeply .path.Str, 'foo',    '.path has right value (Str :path)';
    isa-ok      .IO,     IO::Path, '.IO turns Str :path to IO::Path';
    is-deeply   .IO.Str, 'foo',    '.IO has right value (Str :path)';
    is-deeply      .Str, 'foo',    '.Str returns Str :path as Str';
}

with IO::Handle.new(:path('foo'.IO)) {
    isa-ok    .path,     IO::Path, '.path keeps IO::Path :path as IO::Path';
    is-deeply .path.Str, 'foo',    '.path has right value (IO::Path :path)';
    isa-ok      .IO,     IO::Path, '.IO keeps IO::Path :path as IO::Path';
    is-deeply   .IO.Str, 'foo',    '.IO has right value (IO::Path :path)';
    is-deeply      .Str, 'foo',    '.Str returns IO::Path :path as Str';
}

ok run(:err, $*EXECUTABLE, <blah blah blah>).err.slurp(:close),
    'can non-explosively .slurp(:close) a pipe with failed Proc';

with make-temp-file.IO.open(:w) {
    .close;
    lives-ok { .close }, 'can call .close an already-closed handle';
}

with make-temp-file.IO.open(:w) {
    .DESTROY;
    #?rakudo.jvm todo 'requires nqp::filenofh to work'
    is-deeply .opened, False, '.DESTROY closes handles';
}

{ # https://irclog.perlgeek.de/perl6-dev/2017-05-01#i_14512345
    my $е両 := make-temp-file(:content("a\nb\nc")).IO.open;
    my @сe̲ò;
    for $е両 { @сe̲ò.push: $_ }
    is-deeply @сe̲ò, [$е両], '`for IO::Handle` {...} iterates over 1 handle';
}

# https://github.com/rakudo/rakudo/commit/973338a6b7
subtest 'iterator-producing read methods not affected by internal chunking' => {
    plan 10;
    my $n = 10 + ($*DEFAULT-READ-ELEMS // 65536);
    with make-temp-file :content("a" x $n) {
        is +.lines,                         1, '.lines on IO::Path';
        is +.words,                         1, '.words on IO::Path';
        is +.comb(/.+/),                    1, '.comb(Regex) on IO::Path';
        is +.comb($n),                      1, '.comb(Int) on IO::Path';
        is +.split(/.+/, :skip-empty),      0, '.split on IO::Path';

        is +.open.lines,                    1, '.lines on IO::Handle';
        is +.open.words,                    1, '.words on IO::Handle';
        is +.open.comb(/.+/),               1, '.comb(Regex) on IO::Handle';
        is +.open.comb($n),                 1, '.comb(Int) on IO::Handle';
        is +.open.split(/.+/, :skip-empty), 0, '.split on IO::Handle';
    }
}

subtest '.flush' => {
    plan 2;
    my $е갢лe̲ = make-temp-file;
    my $е両 will leave {.close} = $е갢лe̲.open: :w;
    # an implementation may choose to make the first write to a handle
    # unbuffered, to ensure that the handle is writable in the first place,
    # so we'll do two prints, to trigger buffering, if it's implemented
    $е両.print: 'foo';
    $е両.print: 'bar';
    $е両.flush;
    is-deeply $е갢лe̲.slurp, 'foobar', 'content was flushed';
    fails-like { IO::Handle.new.flush }, X::IO::Flush,
        'fails with correct exception';
}

subtest '.t returns True for TTY' => {
    plan 1;
    my $中中 = shell :out, :err, 'tty';
    if $中中 and (my $path = $中中.out.slurp(:close).trim)
      and $path ne 'not a tty' and my $е両 = $path.IO.open {
        #?rakudo.jvm todo 'TTY detection is only partly implemented for JVM'
        is-deeply $е両.t, True, '.t on a TTY handle';
        $е両.close;
    }
    else {
        skip 'could not figure out how to get a TTY handle'
    }
}

subtest '.nl-in attribute' => {
    plan 4;
    my $е両 = make-temp-file(:content<foo>).open;
    is-deeply ($е両.nl-in = '42'),    '42',    'return value (Str)';
    is-deeply  $е両.nl-in,            '42',    'attribute got set (Str)';
    is-deeply ($е両.nl-in = [<a b>]), [<a b>], 'return value (Array)';
    is-deeply  $е両.nl-in,            [<a b>], 'attribute got set (Array)';
}

subtest '.encoding attribute' => {
    plan 4;
    my $е両 = make-temp-file(:content<foo>).open;
    is-deeply ($е両.encoding('ascii')), 'ascii', 'return value';
    is-deeply  $е両.encoding,           'ascii', 'attribute got set';
    is-deeply ($е両.encoding('bin')),   Nil,     'return value (bin)';
    is-deeply  $е両.encoding,           Nil,     'attribute got set (bin)';
}

subtest '.say method' => {
    plan 5*5;

    my $е갢лe̲ = make-temp-file;
    sub 中e̲ò中-갨갮中𝐩갮中 (Capture \in, Str:D \out, Str :$nl-out) {
        with $nl-out {
            with $е갢лe̲.open(:w, :$nl-out) { .say: |in; .close }
            is-deeply $е갢лe̲.slurp, out ~ $nl-out,
                in.raku ~ ' :nl-out(' ~ $nl-out.raku ~ ')';
        }
        else {
            with $е갢лe̲.open(:w) { .say: |in; .close }
            is-deeply $е갢лe̲.slurp, out ~ "\n", in.raku;
        }
    }

    for Str, '', 'foos', '♥', "\n" -> $nl-out {
        中e̲ò中-갨갮中𝐩갮中 :$nl-out, \(       ), "";
        中e̲ò中-갨갮中𝐩갮中 :$nl-out, \('foo'  ), "foo";
        中e̲ò中-갨갮中𝐩갮中 :$nl-out, \(<a b c>), "(a b c)";
        中e̲ò中-갨갮中𝐩갮中 :$nl-out, \(1, 2, 3), "123";
        中e̲ò中-갨갮中𝐩갮中 :$nl-out, \(
          (
            Mu, my class Е갨갨 { }, my class { method gist { 'I ♥ Raku' } },
            1, 2, [3, 5, ('foos',).Seq], %(<meow bar>), :42bar.Pair
          )
        ), '((Mu) (Foo) I ♥ Raku 1 2 [3 5 (foos)] {meow => bar} bar => 42)';
    }
}

subtest '.print-nl method' => {
    plan 4;

    my $е갢лe̲ = make-temp-file;
    with $е갢лe̲.open: :w { .print-nl; .close }
    is-deeply $е갢лe̲.slurp, "\n", 'defaults';

    with $е갢лe̲.open: :w, :nl-out<♥> { .print-nl; .close }
    is-deeply $е갢лe̲.slurp, "♥", ':nl-out set to ♥';

    with IO::Handle.new(:path($е갢лe̲)).open: :nl-out("foo\n\n\nbar"), :w {
        .print-nl; .close
    }
    is-deeply $е갢лe̲.slurp, "foo\n\n\nbar", ':nl-out set to a string';

    with IO::Handle.new: :path($е갢лe̲) {
        .open: :w, :nl-out<bar>;    .print-nl; .close;
        .open: :a; .nl-out = 'ber'; .print-nl; .close;
    }
    is-deeply $е갢лe̲.slurp, "barber",
        ':nl-out set via .open, then via attribute assignment';
}

# https://github.com/Raku/old-issue-tracker/issues/6282
{
    my $е갢лe̲ = make-temp-file;
    given $е갢лe̲.IO {
        .spurt: "fo♥o";
        my $е両 = .open(:enc<ascii>);
        dies-ok { $е両.slurp }, 'ASCII decode/encode dies with a catchable exception';
        # R#2272
        lives-ok { $е両.close }, 'closing after a decode error should work';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6466
given make-temp-file() {
    .spurt: "a" x (2**20 - 1) ~ "«";
    #?rakudo.jvm todo 'OutOfMemoryError: Java heap space'
    lives-ok { for .lines { } }, 'No spurious malformed UTF-8 error';
}

# https://github.com/Raku/old-issue-tracker/issues/6493
subtest 'opened filehandles get closed on exit automatically' => {
    plan 2;
    my $path = make-temp-file;
    is_run ｢my $е両 := ｣ ~ $path.raku  ~ ｢.open: :w, :5000out-buffer;
      $е両.print: 'pass'; $е両.print: '-pass2';
      print 'pass'
    ｣, {:out<pass>, :err(''), :0status}, 'written into a file without closing';

    is-deeply $path.slurp, 'pass-pass2',
        'file has all the content we wrote into it';
}

# https://github.com/Raku/old-issue-tracker/issues/6434
{
    is-deeply
      my class 丙 is IO::Handle { }.new.nl-in,  # does subclass get the same
      IO::Handle.new.nl-in,                    # as the base class
      ‘.nl-in in subclasses has same as base class’;
}

subtest '.WRITE method' => {
    plan 1;
    my $е両 := my class Ìù万à丧𝐝лe̲ is IO::Handle {
        has Buf[uint8] $.data .= new;
        # NOTE: the requirement of manually setting .encoding should not
        # be considered part of the specification. This wart is mostly due
        # to possibility of having "unopened" handled. See R#2050
        # https://github.com/rakudo/rakudo/issues/2050
        submethod TWEAK { self.encoding: 'utf8' }
        method WRITE (Blob:D \data --> True) { $!data.append: data }
    }.new;

    $е両.print:  'print ';
    $е両.printf: 'pri%s', 'ntf ';
    $е両.put:    'put';
    $е両.say:    my class { method gist { 'say' } }.new;
    $е両.spurt:  'spurt text ';
    $е両.spurt:  'spurt bin '.encode;
    $е両.write:  'write'.encode;
    $е両.print-nl;

    is $е両.data.decode.lines, ('print printf put', 'say', 'spurt text spurt bin write'),
        'all writing methods work';
}

subtest '.EOF/.WRITE methods' => {
    plan 31;

    my $е両 := my class Ìù万à丧𝐝лe̲ is IO::Handle {
        has Buf[uint8] $.data .= new: "I ♥ Raku\nprogramming".encode;
        # NOTE: the requirement of manually setting .encoding should not
        # be considered part of the specification. This wart is mostly due
        # to possibility of having "unopened" handled. See R#2050
        # https://github.com/rakudo/rakudo/issues/2050
        submethod TWEAK { self.encoding: 'utf8' }
        method READ(\bytes) { $!data.splice: 0, bytes }
        method EOF { ! $!data }
    }.new;

    is-deeply $е両.eof,   False, 'eof before .slurp';
    is-deeply $е両.slurp, "I ♥ Raku\nprogramming", '.slurp';
    is-deeply $е両.eof,   True,  'eof after .slurp';

    $е両 := Ìù万à丧𝐝лe̲.new;
    is-deeply $е両.lines, ('I ♥ Raku', 'programming').Seq, '.lines';
    is-deeply $е両.eof,   True, 'eof after .lines';

    $е両 := Ìù万à丧𝐝лe̲.new;
    $е両.nl-in = [<ak gra>];
    is-deeply $е両.lines, ('I ♥ R', "u\npro", 'mming').Seq,
        '.lines with custom nl-in';
    is-deeply $е両.eof,   True, 'eof after .lines with custom nl-in';

    $е両 := Ìù万à丧𝐝лe̲.new;
    is-deeply $е両.words, <I ♥ Raku programming>».Str.Seq, '.words';
    is-deeply $е両.eof,   True, 'eof after .words';

    $е両 := Ìù万à丧𝐝лe̲.new;
    is-deeply $е両.split(/ak/), ("I ♥ R", "u\nprogramming").Seq, '.split';
    is-deeply $е両.eof,   True, 'eof after .split';

    $е両 := Ìù万à丧𝐝лe̲.new;
    #?rakudo.jvm todo 'got: $("I", "P")'
    is-deeply $е両.comb(/:i <[A..Z]>/), <I R a k u p r o g r a m m i n g>.Seq,
        '.comb';
    is-deeply $е両.eof,   True, 'eof after .comb';

    $е両 := Ìù万à丧𝐝лe̲.new;
    is-deeply $е両.get, 'I ♥ Raku',  'first .get';
    is-deeply $е両.eof, False, 'eof after first .get';
    is-deeply $е両.get, 'programming', 'second .get';
    is-deeply $е両.eof, True, 'eof after second .get';
    is-deeply $е両.get, Nil, 'third .get';
    is-deeply $е両.eof, True, 'eof after third .get';

    $е両 := Ìù万à丧𝐝лe̲.new;
    is-deeply ($е両.getc xx 5), ('I', ' ', '♥', ' ', 'R').Seq,
        'data from five .getc calls';
    is-deeply $е両.eof, False, 'eof after five .getc calls';
    is-deeply ($е両.getc xx 1000).grep(*.defined).join, "aku\nprogramming",
        '"slurp" of rest of data with .getc calls';
    is-deeply $е両.eof, True,
        '.eof after "slurp" of rest of data with .getc calls';

    $е両 := Ìù万à丧𝐝лe̲.new;
    is-deeply $е両.readchars(5), "I ♥ R", 'data from .readchars call';
    is-deeply $е両.eof, False, 'eof after .readchars call';
    is-deeply $е両.readchars(1000), "aku\nprogramming",
        '"slurp" of rest of data with .readchars call';
    is-deeply $е両.eof, True,
        '.eof after "slurp" of rest of data with .readchars call';

    $е両 := Ìù万à丧𝐝лe̲.new;
    is-deeply $е両.read(7).decode, "I ♥ R", 'data from .read call';
    is-deeply $е両.eof, False, 'eof after .readchars call';
    is-deeply $е両.read(1000).decode, "aku\nprogramming",
        '"slurp" of rest of data with .read call';
    is-deeply $е両.eof, True,
        '.eof after "slurp" of rest of data with .read call';
}

# vim: expandtab shiftwidth=4
