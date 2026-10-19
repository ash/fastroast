use v6.c;
use Test;
use lib $*PROGRAM.parent(4).add: 'packages/Test-Helpers';
use Test::Util;

plan 9;

# https://github.com/Raku/old-issue-tracker/issues/6320
{
  subtest '.open with "-" as path uses $*IN/$*OUT' => {
    plan 2;
    subtest 'STDOUT' => { plan 3;
        temp $*OUT = make-temp-file.open: :w;
        is-deeply '-'.IO.open(:bin, :w), $*OUT, 'returned handle is STDOUT';
        is-deeply $*OUT.encoding, Nil, 'set binary mode';
        '-'.IO.open: :enc<utf8-c8>, :w;
        is-deeply $*OUT.encoding, 'utf8-c8', 'changed encoding';
    }
    subtest 'STDIN' => { plan 3;
        temp $*IN = make-temp-file(:content<meows>).open;
        is-deeply '-'.IO.open(:bin), $*IN, 'returned handle is STDIN';
        is-deeply $*IN.encoding, Nil, 'set binary mode';
        '-'.IO.open: :enc<utf8-c8>;
        is-deeply $*IN.encoding, 'utf8-c8', 'changed encoding';
    }
  }
}

{
  subtest '.open with "-" as path can open closed $*IN/$*OUT' => {
    plan 3;
    subtest 'STDOUT' => { plan 4;
        temp $*OUT = IO::Handle.new: :path(make-temp-file);
        is-deeply '-'.IO.open(:bin, :w), $*OUT, 'returned handle is STDOUT';
        is-deeply $*OUT.opened,   True, '$*OUT is now opened';
        is-deeply $*OUT.encoding, Nil, 'set binary mode';
        '-'.IO.open: :enc<utf8-c8>, :w;
        is-deeply $*OUT.encoding, 'utf8-c8', 'changed encoding';
    }
    subtest 'STDIN' => { plan 4;
        temp $*IN = IO::Handle.new: :path(make-temp-file :content<meows>);
        is-deeply '-'.IO.open(:bin), $*IN, 'returned handle is STDIN';
        is-deeply $*IN.opened,   True, '$*IN is now opened';
        is-deeply $*IN.encoding, Nil,  'set binary mode';
        '-'.IO.open: :enc<utf8-c8>;
        is-deeply $*IN.encoding, 'utf8-c8', 'changed encoding';
    }

    is_run ｢
        use v6.c;
        $*IN  = IO::Handle.new: :path('-'.IO);
        $*OUT = IO::Handle.new: :path('-'.IO);
        my $w̲ = '-'.IO.open: :w;
        my $с = '-'.IO.open;
        $с.get.say;
        $*IN.slurp(:close).say;
        $w̲.put: 'meow $w';
        $*OUT.put: 'meow $*OUT';
    ｣, "foo\nbar\nber", {
        :out("foo\nbar\nber\nmeow \$w̲\nmeow \$*OUT\n"), :err(''), :0status
    }, ｢can use unopened handle with path '-'.IO｣;
  }
}

# https://github.com/Raku/old-issue-tracker/issues/6320
is_run ｢use v6.c; '-'.IO.slurp.print｣, 'meows', {:out<meows>, :err(''), :0status},
    'can .slurp from "-".IO path';

{
  group-of 7 => 'now-deprecated subst-mutate' => {
    # coverage; 2016-09-27
    subtest 'Cool.subst-mutate works same as on .Str' => {
        my @中e̲ò中ò = # args | returned stringified Match objects | result
        [ \('', ''), '', "aabbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('', '', :g),    ('' xx 20), "aabbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('', '', :global), ('' xx 20), "aabbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('a', ''), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('a', '', :g), ('a', 'a'), "bbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('a', '', :global), ('a', 'a'), "bbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('b', ''), 'b', "aabb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('b', '', :g), ('b', 'b'), "aab\x[308]b\x[308]cc \t  xz \t  y",  ],
        [ \('b', '', :global), ('b', 'b'), "aab\x[308]b\x[308]cc \t  xz \t  y",  ],
        [ \(/<[abc]>/, ''), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :g), ('a', 'a', 'b', 'b', 'c', 'c' ), "b\x[308]b\x[308] \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :global), ('a', 'a', 'b', 'b', 'c', 'c' ), "b\x[308]b\x[308] \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :1st), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :st{1;}), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :2nd), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :nd{2;}), 'a', "abbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :3rd), 'b', "aabb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :rd{3;}), 'b', "aabb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :4th), 'b', "aabb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :th{4;}), 'b', "aabb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :5nth), 'c', "aabbb\x[308]b\x[308]c \t  xz \t  y", ],
        [ \(/<[abc]>/, '', :nth{5;}), 'c', "aabbb\x[308]b\x[308]c \t  xz \t  y", ],
        # https://github.com/Raku/old-issue-tracker/issues/5702
        [ \(/<[abc]>/, '', :5x), ('a', 'a', 'b', 'b', 'c'), "b\x[308]b\x[308]c \t  xz \t  y", ],
        # https://github.com/Raku/old-issue-tracker/issues/5702
        [ \(/<[abc]>/, '', :x(1..5)), ('a', 'a', 'b', 'b', 'c'), "b\x[308]b\x[308]c \t  xz \t  y", ],
        [ \(/<[cz]> \s+ <[xy]>/, 'Z P', :ss), "c \t  x", "aabbb\x[308]b\x[308]cZ \t  Pz \t  y", ],
        [ \(/<[cz]> \s+ <[xy]>/, 'Z P', :ss, :global), ( "c \t  x", "z \t  y" ), "aabbb\x[308]b\x[308]cZ \t  PZ \t  P", ],
        [ \('a', 'Z', :ii), 'a', "zabbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \('a', 'Z', :ii, :global), ( 'a', 'a' ), "zzbbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[b]+[b\x[308]]>/, 'Z', :mm), 'b', "aaZbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[b]+[b\x[308]]>/, 'Z', :mm, :global), ( 'b', 'b', "b\x[308]", "b\x[308]" ), "aaZZZ\x[308]Z\x[308]cc \t  xz \t  y", ],
        [ \(/<[b]+[b\x[308]]>/, 'Z', :ii, :mm), 'b', "aazbb\x[308]b\x[308]cc \t  xz \t  y", ],
        [ \(/<[b]+[b\x[308]]>/, 'Z', :ii, :mm, :global), ( 'b', 'b', "b\x[308]", "b\x[308]" ), "aazzz\x[308]z\x[308]cc \t  xz \t  y", ],
        ;

        plan 2*@中e̲ò中ò;
        for @中e̲ò中ò -> $t {
            # use IO::Path as our Cool object
            my $갨丛𝐣 = "aabbb\x[308]b\x[308]cc \t  xz \t  y".IO;
            my $сe̲中 = $갨丛𝐣.subst-mutate(|$t[0]);
            is-deeply ( $сe̲中 ~~ Iterable ?? $сe̲中».Str !! $сe̲中.Str ), $t[1],
                "correct return value when using $t[0].gist()";
            is-deeply $갨丛𝐣, $t[2], "correct modification when using $t[0].gist()";
        }
    }

    subtest '.subst-mutate returns a List for things .match return a List for' => {
        plan 17 × 2 × my @ìà中개両e̲сò := /b/, 'b';
        for @ìà中개両e̲сò -> \mt {
            for "a", 123 -> $s is copy {
                isa-ok $s.subst-mutate(:g, mt, ''), List,
                    ":g with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:x(3), mt, ''), List,
                    ":x with {mt.^name} matcher on {$s.^name}";

                isa-ok $s.subst-mutate(:nth(1, 2, 3), mt, ''), List,
                    ":nth(List) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:nth(1…3), mt, ''), List,
                    ":nth(Seq) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:nth(1..3), mt, ''), List,
                    ":nth(Range) with {mt.^name} matcher on {$s.^name}";

                isa-ok $s.subst-mutate(:th(1, 2, 3), mt, ''), List,
                    ":th(List) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:th(1…3), mt, ''), List,
                    ":th(Seq) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:th(1..3), mt, ''), List,
                    ":th(Range) with {mt.^name} matcher on {$s.^name}";

                isa-ok $s.subst-mutate(:st(1, 2, 3), mt, ''), List,
                    ":st(List) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:st(1…3), mt, ''), List,
                    ":st(Seq) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:st(1..3), mt, ''), List,
                    ":st(Range) with {mt.^name} matcher on {$s.^name}";

                isa-ok $s.subst-mutate(:nd(1, 2, 3), mt, ''), List,
                    ":nd(List) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:nd(1…3), mt, ''), List,
                    ":nd(Seq) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:nd(1..3), mt, ''), List,
                    ":nd(Range) with {mt.^name} matcher on {$s.^name}";

                isa-ok $s.subst-mutate(:rd(1, 2, 3), mt, ''), List,
                    ":rd(List) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:rd(1…3), mt, ''), List,
                    ":rd(Seq) with {mt.^name} matcher on {$s.^name}";
                isa-ok $s.subst-mutate(:rd(1..3), mt, ''), List,
                    ":rd(Range) with {mt.^name} matcher on {$s.^name}";
            }
        }
    }

    # https://github.com/rakudo/rakudo/issues/1523#issuecomment-365447388
    subtest 'no-matches .subst-mutate: with multi-match opts = empty List' => {
        plan 17 × 2 × my @ìà中개両e̲сò := /b/, 'b';
        for @ìà中개両e̲сò -> \mt {
            for "a", 123 -> $s is copy {
                is-deeply $s.subst-mutate(:g, mt, ''), (),
                    ":g with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:x(3), mt, ''), (),
                    ":x with {mt.^name} matcher on {$s.^name}";

                is-deeply $s.subst-mutate(:nth(1, 2, 3), mt, ''), (),
                    ":nth(List) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:nth(1…3), mt, ''), (),
                    ":nth(Seq) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:nth(1..3), mt, ''), (),
                    ":nth(Range) with {mt.^name} matcher on {$s.^name}";

                is-deeply $s.subst-mutate(:th(1, 2, 3), mt, ''), (),
                    ":th(List) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:th(1…3), mt, ''), (),
                    ":th(Seq) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:th(1..3), mt, ''), (),
                    ":th(Range) with {mt.^name} matcher on {$s.^name}";

                is-deeply $s.subst-mutate(:st(1, 2, 3), mt, ''), (),
                    ":st(List) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:st(1…3), mt, ''), (),
                    ":st(Seq) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:st(1..3), mt, ''), (),
                    ":st(Range) with {mt.^name} matcher on {$s.^name}";

                is-deeply $s.subst-mutate(:nd(1, 2, 3), mt, ''), (),
                    ":nd(List) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:nd(1…3), mt, ''), (),
                    ":nd(Seq) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:nd(1..3), mt, ''), (),
                    ":nd(Range) with {mt.^name} matcher on {$s.^name}";

                is-deeply $s.subst-mutate(:rd(1, 2, 3), mt, ''), (),
                    ":rd(List) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:rd(1…3), mt, ''), (),
                    ":rd(Seq) with {mt.^name} matcher on {$s.^name}";
                is-deeply $s.subst-mutate(:rd(1..3), mt, ''), (),
                    ":rd(Range) with {mt.^name} matcher on {$s.^name}";
            }
        }
    }

    # https://github.com/Raku/old-issue-tracker/issues/6043
    subtest '.subst-mutate with multi-match args set $/ to a List of matches' => {
        plan 2*(2+5);
        for 1234567, '1234567' -> $type {
            group-of 4 => "$type.^name().subst-mutate: :g" => {
              ($ = $type).subst-mutate(:g, /../, 'XX');
              isa-ok $/, List, '$/ is a List…';
              cmp-ok +$/, '==', 3, '…with 3 items…';
              is-deeply $/.map({.WHAT}).unique, (Match,).Seq, '…all are Match…';
              is-deeply $/.map(~*), <12 34 56>.map(*.Str), '…all have right values';
            }
            group-of 4 => ".subst-mutate: :x" => {
              ($ = $type).subst-mutate(:2x, /../, 'XX');
              isa-ok $/, List, '$/ is a List…';
              cmp-ok +$/, '==', 2, '…with 2 items…';
              is-deeply $/.map({.WHAT}).unique, (Match,).Seq, '…all are Match…';
              is-deeply $/.map(~*), <12 34>.map(*.Str), '…all have right values';
            }
            for <nth st nd rd th> -> $suffix {
              group-of 4 => ".subst-mutate: :$suffix" => {
                  ($ = $type).subst-mutate(|($suffix => 1..3), /../, 'XX');
                  isa-ok $/, List, '$/ is a List…';
                  cmp-ok +$/, '==', 3, '…with 3 items…';
                  is-deeply $/.map({.WHAT}).unique, (Match,).Seq, '…all are Match…';
                  is-deeply $/.map(~*), <12 34 56>.map(*.Str),
                      '…all have right values';
              }
            }
        }
    }

    throws-like { ($ = "").subst-mutate: /\w/, "",
        :x(my class Ò갨ìe̲갈丧𝐯àл갢𝐝Ч𝐏àсàì {}.new) },
    X::Str::Match::x, 'giving .subst-mutate invalid args throws';

    # https://github.com/Raku/old-issue-tracker/issues/4984
    try { ($ = 42).subst-mutate: Str, Str }; pass "Cool.subst-mutate with wrong args does not hang";

    group-of 2 => '$/ is set when matching in a loop' => {
        for $="a" { if .subst-mutate: /./, 'x' { is ~$/, 'a', 'Str.subst-mutate'  }}
        for $=4   { if .subst-mutate: /./, 'x' { is ~$/, '4', 'Cool.subst-mutate' }}
    }
  }
}

group-of 7 => 'Pair.freeze' => {
    {
        my $𝐩 = Pair.new("foo",my Int $);
        isa-ok $𝐩.value, Int;
        is ($𝐩.value = 42), 42, 'can assign integer value and return that';
        is $𝐩.value, 42, 'the expected Int value was set';
        throws-like { $𝐩.value = "bar" },
          X::TypeCheck::Assignment,
          'cannot assign a Str to an Int';

        $𝐩.freeze;
        throws-like { $𝐩.value = 666 },
          X::Assignment::RO,
          'cannot assign an Int to a frozen';
        is $𝐩.value, 42, 'did not change integer value';
    }

    # https://github.com/Raku/old-issue-tracker/issues/6442
    {
        my $𝐯àл갮e̲ = 17;
        my $𝐩à갢с = number => $𝐯àл갮e̲;
        my $갨丛𝐣-à中1 = $𝐩à갢с.WHICH;
        $𝐩à갢с.freeze;
        is-deeply $갨丛𝐣-à中1, $𝐩à갢с.WHICH,
            "Pair.freeze doesn't change object identity";
    }
}

group-of 2 => ':count arg on &lines/Str.lines' => {
    is lines("a\nb\nc\n",:count), 3, 'lines(Str, :count)';
    is "a\nb\nc\n".lines(:count), 3, 'Str.lines(:count)';
}

# https://github.com/rakudo/rakudo/issues/2433
group-of 5 => 'language switching' => {
    group-of 4 => 'version as first thing' => {
        sub 𝐯e̲сò갢еù ($ver?) {
            ("use v6.$ver; " with $ver) ~ 'print $*RAKU.version'
        }

        is_run 𝐯e̲сò갢еù(),            {:err(''), :0status, :out<6.d> },
            'no version pragma';
        is_run 𝐯e̲сò갢еù('c'),         {:err(''), :0status, :out<6.c> },
            '6.c version pragma';
        is_run 𝐯e̲сò갢еù('d'),         {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
        is_run 𝐯e̲сò갢еù('d'), {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
    }

    group-of 4 => 'version after comments' => {
        sub 𝐯e̲сò갢еù ($ver?) {
            "# meow meow\n"
              ~ ("use v6.$ver; " with $ver) ~ 'print $*RAKU.version'
        }

        is_run 𝐯e̲сò갢еù(),            {:err(''), :0status, :out<6.d> },
            'no version pragma';
        is_run 𝐯e̲сò갢еù('c'),         {:err(''), :0status, :out<6.c> },
            '6.c version pragma';
        is_run 𝐯e̲сò갢еù('d'),         {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
        is_run 𝐯e̲сò갢еù('d'), {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
    }

    group-of 4 => 'version after POD' => {
        sub 𝐯e̲сò갢еù ($ver?) {
            "=begin pod\n\nZE POD\n\n=end pod\n\n"
              ~ ("use v6.$ver; " with $ver) ~ 'print $*RAKU.version'
        }

        is_run 𝐯e̲сò갢еù(),            {:err(''), :0status, :out<6.d> },
            'no version pragma';
        is_run 𝐯e̲сò갢еù('c'),         {:err(''), :0status, :out<6.c> },
            '6.c version pragma';
        is_run 𝐯e̲сò갢еù('d'),         {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
        is_run 𝐯e̲сò갢еù('d'), {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
    }

    group-of 3 => 'error out when trying to switch version too late' => {
        my %àсæò = :out(''), :1exitcode,
            :err{ $^v.contains: 'Too late to switch language version' };
        is_run "use Test; use v6.c;", %àсæò, '6.c version pragma';
        is_run "use Test; use v6.d;", %àсæò, '6.d version pragma';
        is_run "use Test; use v6.d;", %àсæò,
            '6.d version pragma';
    }

    group-of 4 => 'versions without dot' => {
        sub 𝐯e̲сò갢еù ($ver?) { ("use v6$ver; " with $ver) ~ 'print $*RAKU.version' }

        is_run 𝐯e̲сò갢еù(),            {:err(''), :0status, :out<6.d> },
            'no version pragma';
        is_run 𝐯e̲сò갢еù('c'),         {:err(''), :0status, :out<6.c> },
            '6.c version pragma';
        is_run 𝐯e̲сò갢еù('d'),         {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
        is_run 𝐯e̲сò갢еù('d'), {:err(''), :0status, :out<6.d> },
            '6.d version pragma';
    }
}

group-of 1 => 'IO::Handle.new can take a bunch of options' => {
    # No final decision has been rendered yet, but it's likely we'll want
    # to limit what IO::Handle.new can take, so keep those tests here
    # https://github.com/rakudo/rakudo/issues/2039
    # https://irclogs.raku.org/perl6-dev/2018-07-11.html#13:45
    group-of 4 => '.print-nl method' => {
        my $е갢лe̲ = make-temp-file;
        with $е갢лe̲.open: :w { .print-nl; .close }
        is-deeply $е갢лe̲.slurp, "\n", 'defaults';

        with $е갢лe̲.open: :w, :nl-out<♥> { .print-nl; .close }
        is-deeply $е갢лe̲.slurp, "♥", ':nl-out set to ♥';

        with IO::Handle.new(:nl-out("foo\n\n\nbar"), :path($е갢лe̲)).open: :w {
            .print-nl; .close
        }
        is-deeply $е갢лe̲.slurp, "foo\n\n\nbar", ':nl-out set to a string (via .new)';

        with IO::Handle.new: :nl-out<foo>, :path($е갢лe̲) {
            .open: :w;                  .print-nl; .close;
            .open: :a, :nl-out<bar>;    .print-nl; .close;
            .open: :a; .nl-out = 'ber'; .print-nl; .close;
        }
        is-deeply $е갢лe̲.slurp, "foobarber",
            ':nl-out set via .new, then via .open, then via attribute assignment';
    }
}

group-of 12 => '$CALLER::_' => {
    sub 개àллe̲с갮丧𝐝e̲сò개갨сe̲ ($foo = $CALLER::_) {
        return "-" ~ $foo ~ "-"
    }

    # These tests all work when using CALLER::CALLER but we should
    # not need to do that.  Minus that fact, 123660 has actually been
    # fixed since it was reported.

    is(개àллe̲с갮丧𝐝e̲сò개갨сe̲("foo"), "-foo-", 'CALLER:: string arg');
    is(개àллe̲с갮丧𝐝e̲сò개갨сe̲(1), "-1-", 'CALLER:: number arg');
    $_ = "foo";
    todo("NYI"); is(개àллe̲с갮丧𝐝e̲сò개갨сe̲(), "-foo-", 'CALLER:: $_ set once');
    $_ = "bar";
    todo("NYI"); is(개àллe̲с갮丧𝐝e̲сò개갨сe̲(), "-bar-", 'CALLER:: $_ set twice');
    for ("quux") {
        # https://github.com/Raku/old-issue-tracker/issues/3651
        todo("NYI"); is(개àллe̲с갮丧𝐝e̲сò개갨сe̲(), '-quux-', 'CALLER:: $_ set by for');
    }
    given 'hirgel' {
        # https://github.com/Raku/old-issue-tracker/issues/3651
        todo("NYI"); is 개àллe̲с갮丧𝐝e̲сò개갨сe̲, '-hirgel-', '$CALLER::_ set by given';
    }
    todo("NYI"); is(개àллe̲с갮丧𝐝e̲сò개갨сe̲(), '-bar-', 'CALLER:: $_ reset after for');


    # L<S02/Names/The CALLER package refers to the lexical scope>
    {
      # $_ is always implicitly declared "is dynamic".
      my sub е갨갨 () { $CALLER::_ }
      my sub 丛àс () {
        $_ = 42;
        е갨갨();
      }

      $_ = 23;
      is 丛àс(), 42, '$_ is implicitly declared "is dynamic" (1)';
    } #1

    {
      # $_ is always implicitly declared "is dynamic".
      # (And, BTW, $_ is lexical.)
      my sub е갨갨 () { $_ = 17; $CALLER::_ }
      my sub 丛àс () {
        $_ = 42;
        е갨갨();
      }

      $_ = 23;
      is 丛àс(), 42, '$_ is implicitly declared "is dynamic" (2)';
    } #1

    {
      my sub ì갨𝐝갢еù { $CALLER::_++ }
      $_ = 42;
      ì갨𝐝갢еù();
      is $_, 43,             '$_ is implicitly rw (2)';
    } #1

    # R#2058
    {
        multi sub à($a) { $a + $a }
        multi sub à() { à CALLERS::<$_> }

        is à(42), 84, 'can we call the sub with a parameter';
        given 42 {
            is à(), 84, 'can we call the sub without a parameter';
        }
    }
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
