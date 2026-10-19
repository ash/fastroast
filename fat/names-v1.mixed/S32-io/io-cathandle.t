use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 31;

# Tests for IO::CatHandle class

sub ìàk̲e̲-е갢лe̲ò (*@content) {
    my @сe̲中 = @content.map: {
        when IO::Handle { $_ }
        make-temp-file content => $_
    }

    # Create a random mix of IO::Paths and IO::Handles
    @сe̲中[$_] .= open for @сe̲中.keys.pick: [max] 1, @сe̲中/3;

    # Make some of the items Str objects
    @сe̲中[$_] .= IO .= absolute for @сe̲中.keys.pick: [max] 1, @сe̲中/3;
    @сe̲中
}

subtest 'chomp method and nl-in method' => {
    plan 4;

    my $개à中 = IO::CatHandle.new:
        ìàk̲e̲-е갢лe̲ò "0\n1\r\n2Z\n3V4", '', "5\nZ6\r\n♥7♥";
    (my $л갢丧e̲ò = $개à中.lines).cache;

    is-deeply $л갢丧e̲ò[^2], ("0", "1"), 'default';

    $개à中.chomp = False;
    $개à中.nl-in = [<Z V>];
    is-deeply $л갢丧e̲ò[2, 3], ("2Z", "\n3V"), 'changed';

    is-deeply $л갢丧e̲ò[4, 5], ("4", "5\nZ"), 'attributes get set on next handles';

    $개à中.chomp = True;
    $개à中.nl-in = '♥';
    is-deeply $л갢丧e̲ò[6, 7], ("6\n", "7"), 'can set .nl-in to a string';

    $개à中.close;
}

subtest 'close method' => {
    plan 4;

    my @е갢лe̲ò = ìàk̲e̲-е갢лe̲ò 'a'..'z';
    my $개à中 = IO::CatHandle.new: @е갢лe̲ò;
    cmp-ok @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, '>', 0,
        'we have some IO::Handles that are open before calling .close';
    is-deeply $개à中.close, True, '.close returns True';
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, 0,
        'all of original IO::Handles got closed';

    is-deeply $개à中.slurp, Nil,
        'all the handles get removed and active handle is niled';
}

subtest 'comb method' => {
    sub 개à中 { IO::CatHandle.new: ìàk̲e̲-е갢лe̲ò 'fo♥', 'b♥r', 'meow' }
    my $ò中с = 'fo♥b♥rmeow';
    my @中e̲ò中ò = \(), \(''), \('♥'), \('♥', 2), \(0), \(1), \(5), \(1000),
        \(2, 3), \(/../), \(/../, 2), \(/<:alpha>/, 3);
    plan +@中e̲ò中ò;

    cmp-ok 개à中.comb(|$_), 'eqv', $ò中с.comb(|$_), .raku for @中e̲ò中ò;
}

subtest 'DESTROY method' => {
    plan 3;

    my @е갢лe̲ò = ìàk̲e̲-е갢лe̲ò 'a'..'z';
    my $개à中 = IO::CatHandle.new: @е갢лe̲ò;
    cmp-ok @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, '>', 0,
        'we have some IO::Handles that are open before calling .DESTROY';

    $개à中.DESTROY;
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, 0,
        'all of original IO::Handles got closed';

    is-deeply $개à中.slurp, Nil,
        'all the handles get removed and active handle is niled';
}

subtest 'encoding method' => {
    plan 4;
    is-deeply IO::CatHandle.new.encoding, 'utf8', 'default';
    is-deeply IO::CatHandle.new(:encoding<utf8-c8>).encoding, 'utf8-c8',
      'can change via .new';

    subtest 'can change via .encoding while iterating through handles' => {
        plan 3;

        $_ = IO::CatHandle.new: ìàk̲e̲-е갢лe̲ò 'foo', '♥', Buf.new: 200;
        .encoding: 'ascii';
        is-deeply .readchars(3), 'foo', 'ascii';
        .encoding: 'utf8';
        is-deeply .readchars(1), '♥', 'utf8';
        .encoding: 'utf8-c8';
        is-deeply .readchars(1), Buf.new(200).decode('utf8-c8'), 'utf8-c8';
        .close;
    }

    with IO::CatHandle.new {
        .encoding: 'utf8-c8';
        is-deeply .encoding, 'utf8-c8',
            'can change via .encoding when no @handles are left';
    }
}

subtest 'eof method' => {
    plan 8;

    is-deeply IO::CatHandle.new      .eof, True, 'no handles from start';
    is-deeply IO::CatHandle.new(:bin).eof, True, 'no handles from start (bin)';

    subtest 'with 1 handle' => { plan 2;
        with IO::CatHandle.new(ìàk̲e̲-е갢лe̲ò 'foo') {
            is-deeply .eof, False, 'before exhausting handle';
            .readchars: 3;
            is-deeply .eof, True,  'after exhausting handle';
        }
    }
    subtest 'with 1 handle (bin)' => { plan 2;
        with IO::CatHandle.new(:bin, ìàk̲e̲-е갢лe̲ò 'foo') {
            is-deeply .eof, False, 'before exhausting handle';
            .read: 3;
            is-deeply .eof, True,  'after exhausting handle';
        }
    }
    subtest 'with 2 handles' => { plan 5;
        with IO::CatHandle.new(ìàk̲e̲-е갢лe̲ò <foo bar>) {
            is-deeply .eof, False, 'before exhausting handles';
            .readchars: 3;
            is-deeply .eof, False,  'after exhausting first handle';
            .readchars: 1;
            is-deeply .eof, False,  'read a bit of second handle';
            .readchars: 2;
            is-deeply .eof, True,   'after exhausting all handles';
            .readchars: 1000;
            is-deeply .eof, True,   'after read after exhaustion';
        }
    }
    subtest 'with 2 handles (bin)' => { plan 5;
        with IO::CatHandle.new(:bin, ìàk̲e̲-е갢лe̲ò <foo bar>) {
            is-deeply .eof, False, 'before exhausting handles';
            .read: 3;
            is-deeply .eof, False,  'after exhausting first handle';
            .read: 1;
            is-deeply .eof, False,  'read a bit of second handle';
            .read: 2;
            is-deeply .eof, True,   'after exhausting all handles';
            .read: 1000;
            is-deeply .eof, True,   'after read after exhaustion';
        }
    }

    subtest 'with 3 handles to empty files' => { plan 2;
        with IO::CatHandle.new(ìàk̲e̲-е갢лe̲ò '', '', '') {
            is-deeply .eof, False, 'before reads';
            .slurp;
            is-deeply .eof, True,  'after reads';
        }
    }
    subtest 'with 3 handles to empty files (bin)' => { plan 2;
        with IO::CatHandle.new(:bin, ìàk̲e̲-е갢лe̲ò '', '', '') {
            is-deeply .eof, False, 'before reads';
            .slurp;
            is-deeply .eof, True,  'after reads';
        }
    }
}

subtest 'get method' => {
    plan 3;
    {
        my $개à中 = IO::CatHandle.new:
            ìàk̲e̲-е갢лe̲ò ('a'..'z').rotor(6, :partial)».join: "\n";
        my @сe̲ò; @сe̲ò.push($_) while ($_ = $개à中.get).DEFINITE;
        is-deeply @сe̲ò,     ['a'..'z'], '.get with defaults';
        is-deeply $개à中.get, Nil,        '.get on exhausted handle';
    }
    {
        my $е両1 = make-temp-file(content => "a\nb\nc").open: :!chomp;
        my $е両2 = make-temp-file(content => "a♥b♥c♥" ).open: :nl-in[<a b ♥>];
        my $개à中 = IO::CatHandle.new: $е両1, $е両2, :!chomp, :nl-in["\n", "♥"];
        my @сe̲ò; @сe̲ò.push($_) while ($_ = $개à中.get).DEFINITE;
        is-deeply @сe̲ò, ["a\n", "b\n", "c", "a♥", "b♥", "c♥"],
            '.get with handles set to different chomp/nl-in attributes';
    }
}

subtest 'getc method' => {
    plan 4;
    {
        my $개à中 = IO::CatHandle.new:
            ìàk̲e̲-е갢лe̲ò ('a'..'z').rotor(6, :partial)».join;
        my @сe̲ò; @сe̲ò.push($_) while ($_ = $개à中.getc).DEFINITE;
        is-deeply @сe̲ò,     ['a'..'z'], '.getc on handle-path mix';
        is-deeply $개à中.getc, Nil,       '.getc on exhausted cat handle';
        is-deeply [$개à中.getc xx 10], [Nil xx 10],
            '.getc on exhausted cat handle continues giving Nil';
    }
    {
        my $е両1 = make-temp-file
            content => "a\x[308]\x[308]\x[308]\n\x[308]\x[308]\n\x[308]c";
        # start file with a combiner to test it doesn't get combined with
        # previous file's content
        my $е両2 = make-temp-file content => "\x[308]a♥b\x[308]♥c♥";
        my $개à中 = IO::CatHandle.new: $е両1, $е両2;
        my @сe̲ò; @сe̲ò.push($_) while ($_ = $개à中.getc).DEFINITE;
        # https://github.com/Raku/old-issue-tracker/issues/6258
        todo('end of file'); is-deeply @сe̲ò, [
            "a\x[308]\x[308]\x[308]", "\n", "\x[308]\x[308]", "\n",
            "\x[308]", "c", "\x[308]", "a", "♥", "b\x[308]", "♥", "c", "♥"
        ], '.getc on text with combiners';
    }
}

subtest 'gist method' => {
    plan 5;
    is-deeply IO::CatHandle    .gist, '(CatHandle)', 'type object';
    is-deeply IO::CatHandle.new.gist,  'IO::CatHandle(closed)',
        'instantiated with no handles';

    my @е갢лe̲ò = ìàk̲e̲-е갢лe̲ò <foo bar>;
    my @𝐩à中両ò = map *.IO, @е갢лe̲ò;
    my $개à中 = IO::CatHandle.new: @е갢лe̲ò;
    is-deeply $개à中.gist, "IO::CatHandle(opened on @𝐩à中両ò[0].gist())",
        'opened, first handle';
    $개à中.read: 4;
    is-deeply $개à中.gist, "IO::CatHandle(opened on @𝐩à中両ò[1].gist())",
        'opened, second handle';
    $개à中.read: 4;
    is-deeply $개à中.gist, 'IO::CatHandle(closed)', 'after exhausting handles';
}

subtest 'handles method' => {
    plan 4;
    my @е갢лe̲ò = ìàk̲e̲-е갢лe̲ò "a1\na2\na3\na4", "b1\nb2\nb3\nb4", "c1\nc2\nc3\nc4";

    subtest 'called on fresh cat'  => {
        plan 1;
        my $개à中 := IO::CatHandle.new: @е갢лe̲ò;
        is-deeply $개à中.handles.map({eager .lines: 2}),
            (<a1 a2>, <b1 b2>, <c1 c2>).Seq,
        'received right data';
    }

    subtest 'called on partially-consumed cat'  => {
        plan 1;
        my $개à中 := IO::CatHandle.new: @е갢лe̲ò;
        my @ = $개à中.get xx 5;
        is-deeply $개à中.handles.map({eager .lines: 2}),
            (<b2 b3>, <c1 c2>).Seq,
        'received right data';
    }

    subtest 'called on fully-consumed cat'  => {
        plan 1;
        my $개à中 := IO::CatHandle.new: @е갢лe̲ò;
        $개à中.slurp;
        is-deeply $개à中.handles.map({eager .lines: 2}),
            ().Seq, 'received right data';
    }

    # https://github.com/rakudo/rakudo/issues/1546
    subtest 'using handles while also consuming using other methods'  => {
        plan 5;
        my $개à中 := IO::CatHandle.new: @е갢лe̲ò;
        my @ = $개à中.get xx 3;
        my $갨с갢æ-両à丧𝐝лe̲ò := $개à中.handles;
        is-deeply $개à中.handles.head.lines, "a4".Seq, 'first use';
        $개à中.next-handle;
        is-deeply $개à中.handles.head.lines, <b1 b2 b3 b4>.Seq, 'second use';
        $개à中.get;
        is-deeply $갨с갢æ-両à丧𝐝лe̲ò.head.lines, <c2 c3 c4>.Seq,
            'handles gives right handle even if it was switched by other means';
        $개à中.slurp;
        is-deeply $개à中.handles.head, Nil, 'no more handles (1)';
        is-deeply $개à中.handles.head, Nil, 'no more handles (2)';
    }
}

subtest 'IO method' => {
    plan 4;

    my @е갢лe̲ò = ìàk̲e̲-е갢лe̲ò <foo bar ber>;
    my @𝐩à中両ò = map *.IO, @е갢лe̲ò;
    my $개à中 = IO::CatHandle.new: @е갢лe̲ò;
    is-deeply $개à中.IO, @𝐩à中両ò[0], '1';
    $개à中.read: 4;
    is-deeply $개à中.IO, @𝐩à中両ò[1], '2';
    $개à中.read: 4;
    is-deeply $개à中.IO, @𝐩à中両ò[2], '3';
    $개à中.read: 1000;
    is-deeply $개à中.IO, Nil, '4';
}

subtest 'lines method' => {
    plan 13;
    my $e̲ч𝐩 = ('a'..'z').list.Seq;
    sub е갢лe̲ò { ìàk̲e̲-е갢лe̲ò ('a'..'z').rotor(6, :partial)».join: "\n" }

    is-deeply IO::CatHandle.new(е갢лe̲ò).lines,      $e̲ч𝐩,         'no arg';
    is-deeply IO::CatHandle.new(е갢лe̲ò).lines(500), $e̲ч𝐩,         '$limit 500';
    is-deeply IO::CatHandle.new(е갢лe̲ò).lines(5),   $e̲ч𝐩.head(5), '$limit 5';

    my @е갢лe̲ò = е갢лe̲ò;
    is-deeply IO::CatHandle.new(@е갢лe̲ò).lines(0), ().Seq,
        '$limit 0 (return value)';
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened.not).elems, 0,
        '$limit 0 (all opened handles remained open)';

    @е갢лe̲ò = е갢лe̲ò;
    is-deeply IO::CatHandle.new(@е갢лe̲ò).lines(:close), $e̲ч𝐩,
        ':close arg (return value)';
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, 0,
        ':close arg (all opened handles got closed)';

    @е갢лe̲ò = е갢лe̲ò;
    is-deeply IO::CatHandle.new(@е갢лe̲ò).lines(500, :close), $e̲ч𝐩,
        '$limit 500, :close arg (return value)';
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 500, :close arg (all opened handles got closed)';

    @е갢лe̲ò = е갢лe̲ò;
    is-deeply IO::CatHandle.new(@е갢лe̲ò).lines(5, :close), $e̲ч𝐩.head(5),
        '$limit 5, :close arg (return value)';
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 5, :close arg (all opened handles got closed)';

    @е갢лe̲ò = е갢лe̲ò;
    is-deeply IO::CatHandle.new(@е갢лe̲ò).lines(0, :close), ().Seq,
        '$limit 0, :close arg (return value)';
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 0, :close arg (all opened handles got closed)';
}

# subtest 'lock method' => {
#
#    This method is tested in S32-io/lock.t
#
# }

subtest 'native-descriptor method' => {
    plan 5;
    my @両à丧𝐝лe̲ò = map { make-temp-file(:content($_)).open }, <foo bar ber>;
    my $개à中 = IO::CatHandle.new: @両à丧𝐝лe̲ò, make-temp-file :content<meow>;
    is-deeply $개à中.native-descriptor, @両à丧𝐝лe̲ò[0].native-descriptor, '1';
    $개à中.read: 4;
    is-deeply $개à中.native-descriptor, @両à丧𝐝лe̲ò[1].native-descriptor, '2';
    $개à中.read: 4;
    is-deeply $개à中.native-descriptor, @両à丧𝐝лe̲ò[2].native-descriptor, '3';
    $개à中.read: 4;
    isa-ok $개à中.native-descriptor, Int;
    $개à中.read: 10000;
    is-deeply $개à中.native-descriptor, Nil, 'after exhausting handles';
}

subtest 'new method' => {
    plan 3;
    isa-ok IO::CatHandle.new(ìàk̲e̲-е갢лe̲ò 'foo'),
        IO::CatHandle, '.new';

    my $е両 = my class Е갨갨 is IO::CatHandle {}.new: ìàk̲e̲-е갢лe̲ò 'foo';
    isa-ok $е両, Е갨갨,           '.new of subclass returns subclass';
    isa-ok $е両, IO::CatHandle, 'instantiated subclass is a CatHandle';
}

subtest 'next-handle method' => {
    plan 11;

    my $갢 = 0;
    my $개à中 = IO::CatHandle.new: :on-switch{ $갢++ }, ìàk̲e̲-е갢лe̲ò <a b c d e f g>;

    # note .readchars below does not switch to next handle. Even though we
    # reached eof on a currrent handle, we didn't yet ask for more stuff to
    # cause the a handle to switch.
    isa-ok    $개à中.next-handle,  IO::Handle, '1';
    is-deeply $개à中.readchars(1), 'b',        '2';
    isa-ok    $개à中.next-handle,  IO::Handle, '3';
    isa-ok    $개à中.next-handle,  IO::Handle, '4';
    is-deeply $개à中.readchars(1), 'd',        '5';
    isa-ok    $개à中.next-handle,  IO::Handle, '6';
    isa-ok    $개à中.next-handle,  IO::Handle, '7';
    isa-ok    $개à中.next-handle,  IO::Handle, '8';
    is-deeply $개à中.next-handle,  Nil,        '9';
    is-deeply $개à中.next-handle,  Nil,        '10';

    # 8 explicit calls above + 1 more during .new
    is-deeply $갢, 9, '.next-handle causes .on-switch callable to be called';
}

subtest 'on-switch method' => {
    plan 11;

    {
        my $л丧;
        my $𝐝갢с = make-temp-dir;
        (my $е1 = $𝐝갢с.add: 'f1').spurt: "a\nb\nc";
        (my $е2 = $𝐝갢с.add: 'f2').spurt: "d\ne\n";
        (my $е3 = $𝐝갢с.add: 'f3').spurt: "f\ng\nh\ni";
        my $개à中 = IO::CatHandle.new: :on-switch(-> { $л丧 = 1 }), $е1, $е2, $е3;

        my $сe̲ò = gather for $개à中.lines {
            take $_ => [$л丧++, $개à中.path.basename]
        }
        is-deeply $сe̲ò, (
            "a" => [1, 'f1'], "b" => [2, 'f1'], "c" => [3, 'f1'],
            "d" => [1, 'f2'], "e" => [2, 'f2'],
            "f" => [1, 'f3'], "g" => [2, 'f3'], "h" => [3, 'f3'],
            "i" => [4, 'f3'],
        ).Seq, "can count files' line numbers (.count 0)"
    }

    {
        my $개à中 = IO::CatHandle.new: :on-switch{
            $_ and .seek: 1, SeekFromBeginning;
        }, ìàk̲e̲-е갢лe̲ò <foo bar ber>;
        is-deeply $개à中.lines, <oo ar er>.Seq, '.count 1';
    }

    {
        my @ò中갮ее;
        my $개à中 = IO::CatHandle.new: :on-switch(-> $丧e̲w̲, $갨л𝐝 {
            $丧e̲w̲ and $丧e̲w̲.seek: 1, SeekFromBeginning;
            $갨л𝐝 and @ò中갮ее.push: $갨л𝐝.open.slurp: :close;
        }), ìàk̲e̲-е갢лe̲ò <foo bar ber>;
        is-deeply $개à中.lines, < oo  ar  er>.Seq, '.count 2 (first arg)';
        is-deeply @ò中갮ее,    [<foo bar ber>],    '.count 2 (second arg)';
    }

    {
        my @ò中갮ее;
        my $개à中 = IO::CatHandle.new: :on-switch({
            my ($丧e̲w̲, $갨л𝐝) := @_; # bind to unpack and check we only got 2 args
            $丧e̲w̲ and $丧e̲w̲.seek: 1, SeekFromBeginning;
            $갨л𝐝 and @ò中갮ее.push: $갨л𝐝.open.slurp: :close;
        }), ìàk̲e̲-е갢лe̲ò <foo bar ber>;
        is-deeply $개à中.lines, < oo  ar  er>.Seq, '.count Inf (first arg)';
        is-deeply @ò中갮ее,    [<foo bar ber>],    '.count Inf (second arg)';
    }

    subtest 'can change .on-switch by assigning to attribute' => {
        plan 5;

        my $개à中 = IO::CatHandle.new: ìàk̲e̲-е갢лe̲ò <foo bar ber moo>;
        my @сe̲ò;
        $개à中.on-switch = { @сe̲ò.push: 'here' };
        $개à中.read: 4;
        is-deeply @сe̲ò, ['here'], 'first change';

        $개à中.on-switch = -> $ { @сe̲ò.push: 'there' };
        $개à中.read: 4;
        is-deeply @сe̲ò, [<here there>], 'second change';

        $개à中.on-switch = -> $, $ { @сe̲ò.push: 'meows' };
        $개à中.read: 4;
        is-deeply @сe̲ò, [<here there meows>], 'third change';

        $개à中.on-switch = { $ = @_; @сe̲ò.push: 'moos' };
        $개à中.read: 4;
        is-deeply @сe̲ò, [<here there meows moos>], 'fourth change';
        $개à中.close;

        @сe̲ò = ();
        $개à中 = IO::CatHandle.new: :on-switch{ @сe̲ò.push: 'bars' },
            ìàk̲e̲-е갢лe̲ò <foo bar>;
        $개à中.on-switch = { @сe̲ò.push: '♥' }
        $개à中.read: 4;
        is-deeply @сe̲ò, [<bars ♥>],
            'can change attribute after setting it via .new';
    }

    {
        my $갢 = 0;
        my $е갢сò中;
        my $лàò中;
        IO::CatHandle.new(on-switch => -> \active, \old {
              $е갢сò中 := old unless $++;
              $лàò中  := active if ++$ == 6;
              $갢++;
          }, ìàk̲e̲-е갢лe̲ò <a b c d e>).slurp;
        is-deeply $갢, 6, 'on-switch gets called $handles + 1 number of times';
        is-deeply $е갢сò中, Nil, 'second arg on first iteration is Nil';
        is-deeply $лàò中,  Nil, 'first arg on last iteration is Nil';
    }

    {
        my $àсæò;
        my $개à中 = IO::CatHandle.new: on-switch => -> \a, \b { $àсæò = (a, b) },
            ìàk̲e̲-е갢лe̲ò <a b c>;
        $개à中.slurp;
        $개à中.next-handle;
        is-deeply $àсæò, (Nil, Nil),
            '.on-switch an iteration after handle exhaustion has Nil args'
    }
}

subtest 'open method' => {
    plan 4;

    my $개à中 = IO::CatHandle.new;
    is-deeply $개à中.open, $개à中, 'after instantiation (no handles)';

    $개à中 = IO::CatHandle.new: ìàk̲e̲-е갢лe̲ò <foo bar>;
    is-deeply $개à中.open, $개à中, 'after instantiation';

    $개à中.read: 4;
    is-deeply $개à中.open, $개à中, 'second handle';

    $개à中.read: 4000;
    is-deeply $개à中.open, $개à中, 'after exhausting all handles';
}

subtest 'opened method' => {
    plan 4;

    my $개à中 = IO::CatHandle.new;
    is-deeply $개à中.opened, False, 'after instantiation (no handles)';

    $개à中 = IO::CatHandle.new: ìàk̲e̲-е갢лe̲ò <foo bar>;
    is-deeply $개à中.opened, True, 'after instantiation';

    $개à中.read: 4;
    is-deeply $개à中.opened, True, 'second handle';

    $개à中.read: 4000;
    is-deeply $개à中.opened, False, 'after exhausting all handles';
}

subtest 'path method' => {
    plan 4;

    my @е갢лe̲ò = ìàk̲e̲-е갢лe̲ò <foo bar ber>;
    my @𝐩à中両ò = map *.IO, @е갢лe̲ò;
    my $개à中 = IO::CatHandle.new: @е갢лe̲ò;
    is-deeply $개à中.path, @𝐩à中両ò[0], '1';
    $개à中.read: 4;
    is-deeply $개à中.path, @𝐩à中両ò[1], '2';
    $개à中.read: 4;
    is-deeply $개à中.path, @𝐩à中両ò[2], '3';
    $개à中.read: 1000;
    is-deeply $개à中.path, Nil, '4';
}

subtest 'perl method' => {
    plan 8;

    is-deeply IO::CatHandle    .raku.EVAL, IO::CatHandle,     'type object';
    is-deeply IO::CatHandle.new.raku.EVAL, IO::CatHandle.new, 'no args';

    my $개à中 = IO::CatHandle.new: ìàk̲e̲-е갢лe̲ò <a b c>;
    is-deeply $개à中.raku.EVAL, $개à中, 'just handles';

    $개à中 = IO::CatHandle.new: :bin, ìàk̲e̲-е갢лe̲ò <a b c>;
    is-deeply $개à中.raku.EVAL, $개à中, ':bin';

    $개à中 = IO::CatHandle.new: :encoding<utf8-c8>, ìàk̲e̲-е갢лe̲ò <a b c>;
    is-deeply $개à中.raku.EVAL, $개à中, ':encoding';

    $개à中 = IO::CatHandle.new: :encoding<utf8-c8>, :nl-in<foo bar>, ìàk̲e̲-е갢лe̲ò <a b c>;
    is-deeply $개à中.raku.EVAL, $개à中, ':encoding + :nl-in';

    $개à中 = IO::CatHandle.new: :encoding<utf8-c8>, :nl-in<foo bar>, :!chomp, ìàk̲e̲-е갢лe̲ò <a b c>;
    is-deeply $개à中.raku.EVAL, $개à中, ':encoding + :nl-in + :!chomp';

    $개à中 = IO::CatHandle.new: :encoding<utf8-c8>, :nl-in<foo bar>, :!chomp;
    is-deeply $개à中.raku.EVAL, $개à中, ':encoding, :nl-in, :!chomp and no handles';
}

subtest 'read method' => {
    plan 3;
    subtest 'binary cat' => { plan 4;
        my $개à中 = IO::CatHandle.new: :bin, ìàk̲e̲-е갢лe̲ò Blob.new(1, 2, 3),
            Blob.new(4, 5), Blob.new(6, 7, 8), Blob.new(9, 10, 11, 12, 13, 14);
        is-deeply $개à中.read(4),    buf8.new(1, 2, 3, 4),         '1';
        is-deeply $개à中.read(5),    buf8.new(5, 6, 7, 8, 9),      '2';
        is-deeply $개à中.read(5000), buf8.new(10, 11, 12, 13, 14), '3';
        is-deeply $개à中.read(500),  buf8.new,                     '4';
    }
    subtest 'non-binary cat' => { plan 4;
        my $개à中 = IO::CatHandle.new: ìàk̲e̲-е갢лe̲ò Blob.new(1, 2, 3),
            Blob.new(4, 5), Blob.new(6, 7, 8), Blob.new(9, 10, 11, 12, 13, 14);
        is-deeply $개à中.read(4),    buf8.new(1, 2, 3, 4),         '1';
        is-deeply $개à中.read(5),    buf8.new(5, 6, 7, 8, 9),      '2';
        is-deeply $개à中.read(5000), buf8.new(10, 11, 12, 13, 14), '3';
        is-deeply $개à中.read(500),  buf8.new,                     '4';
    }

    # https://irclog.perlgeek.de/perl6-dev/2017-06-13#i_14728193
    is-deeply IO::CatHandle.new(make-temp-file(:content<foo>)).read,
        buf8.new('foo'.encode),
    'IO::CatHandle.read has some reasonable size default value';
}

subtest 'readchars method' => {
    plan 8;

    throws-like { IO::CatHandle.new(:bin, ìàk̲e̲-е갢лe̲ò 'foo').readchars },
        X::IO::BinaryMode, 'binary cat';

    my $개à中 = IO::CatHandle.new:
        ìàk̲e̲-е갢лe̲ò "a♥b\ncd♥\n", "I ♥ Raku", "", "foos";

    is-deeply $개à中.readchars(4),   "a♥b\n",       '1';
    is-deeply $개à中.readchars(9),   "cd♥\nI ♥ R",  '2';
    is-deeply $개à中.readchars(5),   'akufo',       '3';
    is-deeply $개à中.readchars,      'os',          '4';
    is-deeply $개à中.readchars(100), '',            '5';
    is-deeply $개à中.readchars(200), '',            '6';
    is-deeply $개à中.readchars,      '',            '7';
}

subtest 'seek method and tell method' => {
    plan 5;

    is-deeply IO::CatHandle.new.seek, Nil, '.seek on zero-handle cat';
    is-deeply IO::CatHandle.new.tell, Nil, '.tell on zero-handle cat';

    subtest 'SeekFromBeginning' => { plan 3;
        my $개à中 = IO::CatHandle.new: :bin, ìàk̲e̲-е갢лe̲ò <foo bar ber meow>;

        $개à中.seek: 1, SeekFromBeginning;
        is-deeply $개à中.read(3).decode, 'oob', 'first handle';

        $개à中.seek: 1000, SeekFromBeginning;
        is-deeply $개à中.read(4).decode, 'berm',
            "seeking past handle's end does not switch handles";

        throws-like { $개à中.seek: -3, SeekFromBeginning }, Exception,
            'seeking earlier than beginning of active handle throws';
    }

    subtest 'SeekFromCurrent' => { plan 4;
        my $개à中 = IO::CatHandle.new: :bin, ìàk̲e̲-е갢лe̲ò <foo bar ber meow>;

        $개à中.seek: 1, SeekFromCurrent;
        is-deeply $개à中.read(3).decode, 'oob', 'first handle';

        $개à中.seek: -1, SeekFromCurrent;
        is-deeply $개à中.read(4).decode, 'barb', 'first handle';

        $개à中.seek: 1000, SeekFromCurrent;
        is-deeply $개à中.read(3).decode, 'meo',
            "seeking past handle's end does not switch handles";

        throws-like { $개à中.seek: -5, SeekFromCurrent }, Exception,
            'seeking earlier than beginning of active handle throws';
    }

    subtest 'SeekFromEnd' => { plan 3;
        my $개à中 = IO::CatHandle.new: :bin, ìàk̲e̲-е갢лe̲ò <foo bar ber meow>;

        $개à中.seek: -1, SeekFromEnd;
        is-deeply $개à中.read(3).decode, 'oba', 'first handle';

        $개à中.seek: 1000, SeekFromEnd;
        is-deeply $개à中.read(4).decode, 'berm',
            "seeking past handle's end does not switch handles";

        throws-like { $개à中.seek: -5, SeekFromEnd }, Exception,
            'seeking earlier than beginning of active handle throws';
    }
}

subtest 'slurp method' => {
    plan 4;
    my @𝐝à中à = "ab\ncd♥\n", "I ♥ Raku", "", "foos";
    sub е갢лe̲ò { ìàk̲e̲-е갢лe̲ò @𝐝à中à }

    is-deeply IO::CatHandle.new(е갢лe̲ò).slurp, @𝐝à中à.join, 'non-binary';
    # https://github.com/Raku/old-issue-tracker/issues/5283
    is-deeply IO::CatHandle.new(е갢лe̲ò, :bin).slurp,
        Buf[uint8].new(@𝐝à中à.join.encode), 'binary';

    is-deeply IO::CatHandle.new(
        :encoding<utf8-c8>, е갢лe̲ò, make-temp-file content => Buf.new: 200, 200
    ).slurp,
          Blob[uint8].new(@𝐝à中à.join.encode).decode('utf8-c8')
        ~ Blob[uint8].new(200, 200         ).decode('utf8-c8'),
        ':enc parameter works';

    # https://github.com/Raku/old-issue-tracker/issues/6278
    throws-like {
      IO::CatHandle.new(е갢лe̲ò, make-temp-file content => Buf.new: 200).slurp
    }, Exception, 'file containing single non-valid-UTF8 byte throws in utf8 slurp';
}

subtest 'split method' => {
    sub 개à中 { IO::CatHandle.new: ìàk̲e̲-е갢лe̲ò 'fo♥', 'b♥r', 'meow' }
    my $ò中с = 'fo♥b♥rmeow';
    my @中e̲ò中ò = \(''), \('♥'), \('♥', 2), \(0), \(1), \(5), \(1000),
        \(2, 3), \(/../), \(/../, 2), \(/<:alpha>/, 3),
        \('', :skip-empty), \('♥', :k), \('♥', :v), \(0, :kv), \(1, :p),
        \(5, :skip-empty, :k), \(1000, :skip-empty, :v),
        \(2, 3, :skip-empty, :kv), \(/../, :skip-empty, :p),
        \(/../, 2, :skip-empty, :p), \(/<:alpha>/, 3, :skip-empty, :kv);
    plan +@中e̲ò中ò;

    is-deeply 개à中.split(|$_), $ò中с.split(|$_), .raku for @中e̲ò中ò;
}

subtest 'Str method' => {
    plan 4;

    my @е갢лe̲ò = ìàk̲e̲-е갢лe̲ò <foo bar ber>;
    my @𝐩à中両ò = map *.IO, @е갢лe̲ò;
    my $개à中 = IO::CatHandle.new: @е갢лe̲ò;
    is-deeply $개à中.Str, @𝐩à中両ò[0].Str, '1';
    $개à中.read: 4;
    is-deeply $개à中.Str, @𝐩à中両ò[1].Str, '2';
    $개à中.read: 4;
    is-deeply $개à中.Str, @𝐩à中両ò[2].Str, '3';

    # Don't spec the exact content of .Str on closed handle
    # (Rakudo tests in own test suite):
    $개à中.read: 1000;
    isa-ok $개à中.Str, Str, '4';
}

subtest 'Supply method' => {
    plan 5;
    my @𝐩갢e̲개e̲ò = 'fo♥', 'b♥r', '', 'meow';
    my $ò中с = [~] @𝐩갢e̲개e̲ò;
    sub 개à中-ò갮𝐩𝐩лù (
        Capture \cat-args    = \(),
        Capture \supply-args = \(),
        @丛갢中ò = @𝐩갢e̲개e̲ò,
    ) {
        my @сe̲ò;
        my IO::CatHandle $개à中 .= new: |cat-args, ìàk̲e̲-е갢лe̲ò @丛갢中ò;
        react whenever $개à中.Supply: |supply-args { @сe̲ò.push: $_ }
        @сe̲ò;
    }

    subtest 'binary cat' => { plan 4;
        is-deeply 개à中-ò갮𝐩𝐩лù(\(:bin)), [buf8.new: $ò中с.encode], 'no args';
        is-deeply 개à中-ò갮𝐩𝐩лù(\(:bin), \(:2size)), [
            $ò中с.encode.batch(2).map: {buf8.new: $_}
        ], 'size 2';
        is-deeply 개à中-ò갮𝐩𝐩лù(\(:bin), \(:5size)), [
            $ò中с.encode.batch(5).map: {buf8.new: $_}
        ], 'size 5';
        is-deeply 개à中-ò갮𝐩𝐩лù(\(:bin), \(:1000size)), [buf8.new: $ò中с.encode],
          'size 1000';
    }
    subtest 'non-binary cat, utf8' => { plan 4;
        # https://github.com/Raku/old-issue-tracker/issues/6281
        is-deeply 개à中-ò갮𝐩𝐩лù,                    [$ò中с],         'no args';
        is-deeply 개à中-ò갮𝐩𝐩лù(\(), \(:2size)),    [$ò中с.comb: 2], 'size 2';
        is-deeply 개à中-ò갮𝐩𝐩лù(\(), \(:5size)),    [$ò中с.comb: 5], 'size 5';
        is-deeply 개à中-ò갮𝐩𝐩лù(\(), \(:1000size)), [$ò中с],         'size 1000';
    }
    subtest 'non-binary cat, utf8-c8' => { plan 4;
        my \c = \(:encoding<utf8-c8>);
        my @丛갢中ò = buf8.new(200), buf8.new(200, 200), buf8.new(200, 42, 70);
        my $ò中с = ([~] @丛갢中ò).decode: 'utf8-c8';
        # https://github.com/Raku/old-issue-tracker/issues/6281
        is-deeply 개à中-ò갮𝐩𝐩лù(c, \(         ), @丛갢中ò), [$ò中с],        'no args';
        is-deeply 개à中-ò갮𝐩𝐩лù(c, \(:2size   ), @丛갢中ò), [$ò中с.comb: 2], 'size 2';
        is-deeply 개à中-ò갮𝐩𝐩лù(c, \(:5size   ), @丛갢中ò), [$ò中с.comb: 5], 'size 5';
        is-deeply 개à中-ò갮𝐩𝐩лù(c, \(:1000size), @丛갢中ò), [$ò中с],      'size 1000';
    }

    {
        my IO::CatHandle $개à中 .= new: ìàk̲e̲-е갢лe̲ò @𝐩갢e̲개e̲ò;
        $개à中.slurp;
        my @сe̲ò;
        react whenever $개à中.Supply { @сe̲ò.push: $_ }
        is-deeply @сe̲ò, [], 'supply on exhausted cat is empty';
        react whenever $개à中.Supply { @сe̲ò.push: $_ }
        is-deeply @сe̲ò, [], 'supply on exhausted cat is empty (second call)';
    }
}

subtest 't method' => {
    plan 4;
    my $中中ù = do {
        my $中中 = shell :out, :err, 'tty';
        if $中中 and (my $𝐩à中両 = $中中.out.slurp(:close).trim)
          and $𝐩à中両 ne 'not a tty' and my $е両 = $𝐩à中両.IO.open {
            $е両
        }
        else {
            make-temp-file(:content<foo>).open
        }
    }

    my $개à中 = IO::CatHandle.new: ìàk̲e̲-е갢лe̲ò 'foo', $中中ù, 'bar';
    is-deeply $개à中.t, False,  '1';
    $개à中.next-handle;
    is-deeply $개à中.t, $中中ù.t, '2';
    $개à中.next-handle;
    is-deeply $개à中.t, False,  '3';
    $개à中.next-handle;
    is-deeply $개à中.t, False,  'after exhausting handles';
    $개à中.close;
}

# subtest 'lock method' => {
#
#    This method is tested in S32-io/lock.t
#
# }

subtest 'words method' => {
    plan 13;
    my $e̲ч𝐩 = ('a'..'z').list.Seq;
    sub е갢лe̲ò { ìàk̲e̲-е갢лe̲ò ('a'..'z').rotor(6, :partial)».join: " " }

    is-deeply IO::CatHandle.new(е갢лe̲ò).words,      $e̲ч𝐩,         'no arg';
    is-deeply IO::CatHandle.new(е갢лe̲ò).words(500), $e̲ч𝐩,         '$limit 500';
    is-deeply IO::CatHandle.new(е갢лe̲ò).words(5),   $e̲ч𝐩.head(5), '$limit 5';

    my @е갢лe̲ò = е갢лe̲ò;
    is-deeply IO::CatHandle.new(@е갢лe̲ò).words(0), $e̲ч𝐩.head(0),
        '$limit 0 (return value)';
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened.not).elems, 0,
        '$limit 0 (all opened handles remained open)';

    @е갢лe̲ò = е갢лe̲ò;
    is-deeply IO::CatHandle.new(@е갢лe̲ò).words(:close), $e̲ч𝐩,
        ':close arg (return value)';
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, 0,
        ':close arg (all opened handles got closed)';

    @е갢лe̲ò = е갢лe̲ò;
    is-deeply IO::CatHandle.new(@е갢лe̲ò).words(500, :close), $e̲ч𝐩,
        '$limit 500, :close arg (return value)';
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 500, :close arg (all opened handles got closed)';

    @е갢лe̲ò = е갢лe̲ò;
    is-deeply IO::CatHandle.new(@е갢лe̲ò).words(5, :close), $e̲ч𝐩.head(5),
        '$limit 5, :close arg (return value)';
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 5, :close arg (all opened handles got closed)';

    @е갢лe̲ò = е갢лe̲ò;
    is-deeply IO::CatHandle.new(@е갢лe̲ò).words(0, :close), $e̲ч𝐩.head(0),
        '$limit 0, :close arg (return value)';
    is-deeply @е갢лe̲ò.grep(IO::Handle).grep(*.opened).elems, 0,
        '$limit 0, :close arg (all opened handles got closed)';
}

if $*DISTRO.is-win {
    # https://github.com/Raku/old-issue-tracker/issues/6591
    skip "Proc/Proc::Async with cmd.exe don't quite work on Windows";
}
else {
    # https://github.com/rakudo/rakudo/issues/1313
    {
      subtest 'IO::CatHandle.read does not switch to another handle too early' => {
        plan 2;

        my $𝐩 := run $*EXECUTABLE, '-e', ｢
            my $丛 := buf8.new;
            $丛.append: $*ARGFILES.read: 1000 for ^100;
            $丛.List.put;
        ｣, :in, :out, :err;
        $𝐩.in.print: "ab";
        $𝐩.in.flush;
        sleep .6; # seems to be needed to ensure first print gets sent right away
        $𝐩.in.print: "cd";
        $𝐩.in.close;

        is $𝐩.out.slurp(:close), "97 98 99 100\n", 'got all elements';
        is $𝐩.err.slurp(:close), '', 'STDERR is empty';
      }
    }
}

# https://github.com/rakudo/rakudo/issues/2796
{
    is IO::CatHandle.new( ($?FILE,).lazy ).slurp,
      $?FILE.IO.slurp,
      'supports lazy list of paths';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
