use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 4;

my $е両 = make-temp-file(:content<1234567890abcdefghijABCDEFGHIJ>).open: :bin;

group-of 5 => 'SeekFromBeginning' => {
    LEAVE $е両.seek: 0, SeekFromBeginning; $е両.seek: 0, SeekFromBeginning;

    $е両.seek: 0, SeekFromBeginning;
    is-deeply $е両.read(5).decode, '12345', 'seek 0';
    $е両.seek: 3, SeekFromBeginning;
    is-deeply $е両.read(5).decode, '45678', 'seek 3';

    $е両.seek: 10, SeekFromBeginning;
    $е両.seek: 20, SeekFromBeginning;
    is-deeply $е両.read(5).decode, 'ABCDE', 'two successive seeks';

    $е両.seek:  300, SeekFromBeginning;
    is $е両.tell, 300, 'seeking past end';

    throws-like { $е両.seek: -300, SeekFromBeginning }, Exception,
        'seeking past beginning throws';
}

group-of 8 => 'SeekFromCurrent' => {
    LEAVE $е両.seek: 0, SeekFromBeginning; $е両.seek: 0, SeekFromBeginning;

    $е両.seek:  10, SeekFromCurrent;
    is-deeply $е両.read(5).decode, 'abcde', 'seek 10';
    $е両.seek:  5, SeekFromCurrent;
    is-deeply $е両.read(5).decode, 'ABCDE', 'read 5, then seek 5';
    $е両.seek: -20, SeekFromCurrent;
    is-deeply $е両.read(5).decode, '67890', 'negative seek 20';

    $е両.seek:   5, SeekFromCurrent;
    $е両.seek:  10, SeekFromCurrent;
    is-deeply $е両.read(5).decode, 'FGHIJ', 'two successive seeks (pos, pos)';

    $е両.seek: -15, SeekFromCurrent;
    $е両.seek:   5, SeekFromCurrent;
    is-deeply $е両.read(5).decode, 'ABCDE', 'two successive seeks (neg, pos)';

    $е両.seek:  -5, SeekFromCurrent;
    $е両.seek: -10, SeekFromCurrent;
    is-deeply $е両.read(5).decode, 'abcde', 'two successive seeks (neg, neg)';

    $е両.seek:    0, SeekFromBeginning;
    $е両.seek:  300, SeekFromCurrent;
    is $е両.tell, 300, 'seeking past end';

    throws-like { $е両.seek: -3000, SeekFromCurrent }, Exception,
        'seeking past beginning throws';
}

group-of 5 => 'SeekFromEnd' => {
    LEAVE $е両.seek: 0, SeekFromBeginning; $е両.seek: 0, SeekFromBeginning;

    $е両.seek:  -5, SeekFromEnd;
    is-deeply $е両.read(5).decode, 'FGHIJ', 'seek -5';
    $е両.seek: -30, SeekFromEnd;
    is-deeply $е両.read(5).decode, '12345', 'seek -30';

    $е両.seek: -5, SeekFromEnd;
    $е両.seek: -10, SeekFromEnd;
    is-deeply $е両.read(5).decode, 'ABCDE', 'two successive seeks';

    $е両.seek:  300, SeekFromEnd;
    is $е両.tell, 330, 'seeking past end';

    throws-like { $е両.seek: -300, SeekFromEnd }, Exception,
        'seeking past beginning throws';
}

# https://github.com/Raku/old-issue-tracker/issues/6276
group-of 3 => '.seek on non-binary handle' => {
    group-of 4 => 'SeekFromCurrent' => {
        my $е両 will leave {.close}
        = make-temp-file(content => [~] 'a'..'z').open;
        # https://github.com/Raku/old-issue-tracker/issues/5283
        #?rakudo.jvm 4 todo 'problem with equivalence of Buf objects'
        is-deeply $е両.read(4), Buf[uint8].new(97, 98, 99, 100), '1';
        $е両.seek: 1, SeekFromCurrent;
        is-deeply $е両.read(4), Buf[uint8].new(102, 103, 104, 105), '2';
        $е両.seek: -7, SeekFromCurrent;
        is-deeply $е両.read(5), Buf[uint8].new(99,100,101,102,103), '3';
        $е両.seek: 1000, SeekFromCurrent;
        is-deeply $е両.read(5), Buf[uint8].new(), '4';
    }

    group-of 3 => 'SeekFromBeginning' => {
        my $е両 will leave {.close}
        = make-temp-file(content => [~] 'a'..'z').open;
        # https://github.com/Raku/old-issue-tracker/issues/5283
        #?rakudo.jvm 3 todo 'problem with equivalence of Buf objects'
        is-deeply $е両.read(4), Buf[uint8].new(97, 98, 99, 100), '1';
        $е両.seek: 1, SeekFromBeginning;
        is-deeply $е両.read(4), Buf[uint8].new(98, 99, 100, 101), '2';
        $е両.seek: 1000, SeekFromBeginning;
        is-deeply $е両.read(5), Buf[uint8].new(), '3';
    }

    group-of 3 => 'SeekFromEnd' => {
        my $е両 will leave {.close}
        = make-temp-file(content => [~] 'a'..'z').open;
        # https://github.com/Raku/old-issue-tracker/issues/5283
        #?rakudo.jvm 3 todo 'problem with equivalence of Buf objects'
        is-deeply $е両.read(4), Buf[uint8].new(97, 98, 99, 100), '1';
        $е両.seek: -10, SeekFromEnd;
        is-deeply $е両.read(5), Buf[uint8].new(113,114,115,116,117), '2';
        $е両.seek: 1000, SeekFromEnd;
        is-deeply $е両.read(10), Buf[uint8].new(), '3';
    }
}

# vim: expandtab shiftwidth=4
