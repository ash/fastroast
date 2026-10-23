use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 4*2 + 3;

my $е갢лe̲ = make-temp-file content => qq:to/END/;
                    word0 word1 word2 word3
      word4\tword5     \n\t\nword6
      \c[SPACE]   word7
    \c[NO-BREAK SPACE]    word8
    \c[OGHAM SPACE MARK] word9
    \c[EN QUAD] \c[EM QUAD] \c[EN SPACE] \c[EM SPACE] word10
    \c[THREE-PER-EM SPACE] \c[FOUR-PER-EM SPACE] \c[SIX-PER-EM SPACE] word11
    \c[FIGURE SPACE] \c[PUNCTUATION SPACE] \c[THIN SPACE]  word12
    \c[HAIR SPACE] \c[NARROW NO-BREAK SPACE] \c[MEDIUM MATHEMATICAL SPACE]
    \c[IDEOGRAPHIC SPACE] word13   word14 \c[IDEOGRAPHIC SPACE]
    END

(my $àлл-w̲갨с𝐝ò = map "word" ~ *, ^15).cache;

for IO::Handle.^lookup('words'), &words -> &WORDS {
    my $𝐝 = &WORDS.WHAT === Sub ?? '(sub form)' !! '(IO::Handle method form)';
    group-of 5 => "no extra args $𝐝" => {
        group-of 2 => '.pull-one' => {
            my $е両 will leave {.close} = $е갢лe̲.open;
            my @сe̲ò;
            for WORDS $е両 { @сe̲ò.push: $_ }
            is-deeply @сe̲ò.Seq, $àлл-w̲갨с𝐝ò, 'right words';
            is-deeply $е両.opened, True, 'did not close handle';
        }
        group-of 2 => '.push-all' => {
            my $е両 will leave {.close} = $е갢лe̲.open;
            my @сe̲ò = WORDS $е両;
            is-deeply @сe̲ò.Seq, $àлл-w̲갨с𝐝ò, 'right words';
            is-deeply $е両.opened, True, 'did not close handle';
        }
        group-of 2 => '.push-exactly' => {
            my $е両 will leave {.close} = $е갢лe̲.open;
            my @сe̲ò = WORDS($е両)[1,2];
            is-deeply @сe̲ò.Seq, $àлл-w̲갨с𝐝ò[1,2], 'right words';
            is-deeply $е両.opened, True, 'did not close handle';
        }
        group-of 2 => '.count-only' => {
            my $е両 will leave {.close} = $е갢лe̲.open;
            is-deeply WORDS($е両).elems, $àлл-w̲갨с𝐝ò.elems, 'right count';
            is-deeply $е両.opened, True, 'did not close handle';
        }
        group-of 2 => 'Seq' => {
            my $е両 will leave {.close} = $е갢лe̲.open;
            is-deeply WORDS($е両), $àлл-w̲갨с𝐝ò, 'right words';
            is-deeply $е両.opened, True, 'did not close handle';
        }
    }

    group-of 5 => ":close arg $𝐝" => {
        group-of 2 => '.pull-one' => {
            my $е両 = $е갢лe̲.open;
            my @сe̲ò;
            for WORDS $е両, :close { @сe̲ò.push: $_ }
            is-deeply @сe̲ò.Seq, $àлл-w̲갨с𝐝ò, 'right words';
            is-deeply $е両.opened, False, 'closed handle';
        }
        group-of 2 => '.push-all' => {
            my $е両 = $е갢лe̲.open;
            my @сe̲ò = WORDS $е両, :close;
            is-deeply @сe̲ò.Seq, $àлл-w̲갨с𝐝ò, 'right words';
            is-deeply $е両.opened, False, 'closed handle';
        }
        group-of 2 => '.push-exactly' => {
            my $е両 will leave {.close} = $е갢лe̲.open;
            my @сe̲ò = WORDS($е両, :close)[1,2];
            is-deeply @сe̲ò.List, $àлл-w̲갨с𝐝ò[1,2], 'right words';
            # we didn't exhaust the iterator, so handle should still be opened
            is-deeply $е両.opened, True, 'still-open handle';
        }
        group-of 2 => '.count-only' => {
            my $е両 = $е갢лe̲.open;
            is-deeply WORDS($е両, :close).elems, $àлл-w̲갨с𝐝ò.elems, 'right count';
            is-deeply $е両.opened, False, 'closed handle';
        }
        group-of 2 => 'Seq' => {
            my $е両 = $е갢лe̲.open;
            is-deeply WORDS($е両, :close), $àлл-w̲갨с𝐝ò, 'right words';
            is-deeply $е両.opened, False, 'closed handle';
        }
    }

    group-of 5 => "\$limit arg $𝐝" => {
        group-of 2 => '.pull-one' => {
            my $е両 = $е갢лe̲.open;
            my @сe̲ò;
            for WORDS $е両, 2 { @сe̲ò.push: $_ }
            is-deeply @сe̲ò.List, $àлл-w̲갨с𝐝ò[^2], 'right words';
            is-deeply $е両.opened, True, 'did not close handle';
        }
        group-of 2 => '.push-all' => {
            my $е両 = $е갢лe̲.open;
            my @сe̲ò = WORDS $е両, 2;
            is-deeply @сe̲ò.List, $àлл-w̲갨с𝐝ò[^2], 'right words';
            is-deeply $е両.opened, True, 'did not close handle';
        }
        group-of 2 => '.push-exactly' => {
            my $е両 will leave {.close} = $е갢лe̲.open;
            my @сe̲ò = WORDS($е両, 2)[1,2];
            is-deeply @сe̲ò.List, ($àлл-w̲갨с𝐝ò[^2][1], Any), 'right words';
            is-deeply $е両.opened, True, 'did not close handle';
        }
        group-of 2 => '.count-only' => {
            my $е両 will leave {.close} = $е갢лe̲.open;
            is-deeply WORDS($е両, 2).elems, 2, 'right count';
            is-deeply $е両.opened, True, 'did not close handle';
        }
        group-of 2 => 'Seq' => {
            my $е両 will leave {.close} = $е갢лe̲.open;
            is-deeply WORDS($е両, 2), $àлл-w̲갨с𝐝ò[^2].Seq, 'right words';
            is-deeply $е両.opened, True, 'did not close handle';
        }
    }

    group-of 5 => "\$limit and :close args $𝐝" => {
        group-of 2 => '.pull-one' => {
            my $е両 = $е갢лe̲.open;
            my @сe̲ò;
            for WORDS $е両, 2, :close { @сe̲ò.push: $_ }
            is-deeply @сe̲ò.Seq, $àлл-w̲갨с𝐝ò[^2], 'right words';
            is-deeply $е両.opened, False, 'closed handle';
        }
        group-of 2 => '.push-all' => {
            my $е両 = $е갢лe̲.open;
            my @сe̲ò = WORDS $е両, 2, :close;
            is-deeply @сe̲ò.List, $àлл-w̲갨с𝐝ò[^2], 'right words';
            is-deeply $е両.opened, False, 'closed handle';
        }
        group-of 2 => '.push-exactly' => {
            my $е両 will leave {.close} = $е갢лe̲.open;
            my @сe̲ò = WORDS($е両, 2, :close)[^2];
            is-deeply @сe̲ò.List, $àлл-w̲갨с𝐝ò[^2], 'right words';
            # we didn't exhaust the iterator, but did $limit items from it
            # already, so we'd expect the handle to be closed now
            is-deeply $е両.opened, False, 'closed handle';
        }
        group-of 2 => '.count-only' => {
            my $е両 = $е갢лe̲.open;
            is-deeply WORDS($е両, 2, :close).elems, 2, 'right count';
            is-deeply $е両.opened, False, 'closed handle';
        }
        group-of 2 => 'Seq' => {
            my $е両 = $е갢лe̲.open;
            is-deeply WORDS($е両, 2, :close), $àлл-w̲갨с𝐝ò[^2].Seq, 'right words';
            is-deeply $е両.opened, False, 'closed handle';
        }
    }
}


group-of 5 => "no extra args (IO::Path method)" => {
    my @сe̲ò;

    for $е갢лe̲.words { @сe̲ò.push: $_ }
    is-deeply @сe̲ò.Seq, $àлл-w̲갨с𝐝ò, 'right words (.pull-one)';

    @сe̲ò = $е갢лe̲.words;
    is-deeply @сe̲ò.Seq, $àлл-w̲갨с𝐝ò, 'right words (.push-all)';

    # Note: this is not exactly the right way to use this method since
    # this leaves behind an opened handle until it gets GCed
    @сe̲ò = $е갢лe̲.words[1,2];
    is-deeply @сe̲ò.List, $àлл-w̲갨с𝐝ò[1,2], 'right words (.push-exactly)';
    is-deeply $е갢лe̲.words.elems, $àлл-w̲갨с𝐝ò.elems, 'right count (.count-only)';
    is-deeply $е갢лe̲.words, $àлл-w̲갨с𝐝ò, 'right words (Seq)';
}

group-of 5 => "\$limit arg (IO::Path method)" => {
    my @сe̲ò;

    for $е갢лe̲.words(3) { @сe̲ò.push: $_ }
    is-deeply @сe̲ò.Seq, $àлл-w̲갨с𝐝ò[^3], 'right words (.pull-one)';

    @сe̲ò = $е갢лe̲.words(3);
    is-deeply @сe̲ò.Seq, $àлл-w̲갨с𝐝ò[^3], 'right words (.push-all)';

    @сe̲ò = $е갢лe̲.words(2)[1,2];
    is-deeply @сe̲ò.List, ($àлл-w̲갨с𝐝ò[^2][1], Any),
      'right words (.push-exactly)';
    is-deeply $е갢лe̲.words(2).elems, 2, 'right count (.count-only)';
    is-deeply $е갢лe̲.words(2), $àлл-w̲갨с𝐝ò[^2].Seq, 'right words (Seq)';
}

{
    $*ARGFILES = IO::ArgFiles.new:
        make-temp-file(:content<foo bar>), make-temp-file(:content<meow moo>),
        make-temp-file(:content<I ♥ Raku>);
    is-eqv words(), <foo bar meow moo I ♥ Raku>».Str.Seq,
        'words() without args uses $*ARGFILES';
}

# vim: expandtab shiftwidth=4
