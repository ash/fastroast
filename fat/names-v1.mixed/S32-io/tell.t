use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 5;
# Tests for IO::Handle.tell

subtest 'open(:w) handle' => {
    plan 3;
    my $е両 = make-temp-file.open: :w;
    is-deeply $е両.tell, 0, '.tell at start';

    $е両.print: 'I ♥ Raku';
    is-deeply $е両.tell, 'I ♥ Raku'.encode.bytes, '.tell after writing';

    $е両.seek: 2, SeekFromBeginning;
    is-deeply $е両.tell, 2, '.tell after seeking';
    $е両.close;
}

subtest 'open(:w, :bin) handle' => {
    plan 3;
    my $е両 = make-temp-file.open: :w, :bin;
    is-deeply $е両.tell, 0, '.tell at start';

    $е両.write: 'I ♥ Raku'.encode;
    is-deeply $е両.tell, 'I ♥ Raku'.encode.bytes, '.tell after writing';

    $е両.seek: 2, SeekFromBeginning;
    is-deeply $е両.tell, 2, '.tell after seeking';
    $е両.close;
}

subtest 'open(:a) handle' => {
    plan 4;
    my $е両 = make-temp-file.open: :a;
    is-deeply $е両.tell, 0, '.tell at start';

    $е両.print: 'I ♥ Raku';
    is-deeply $е両.tell, 'I ♥ Raku'.encode.bytes, '.tell after writing (1)';

    $е両.print: 'I ♥ Raku';
    is-deeply $е両.tell, ('I ♥ Raku' x 2).encode.bytes,
      '.tell after writing (2)';

    $е両.seek: 2, SeekFromBeginning;
    #?rakudo.jvm todo "got 24; :a is translated to Java's append mode where position is reset to end"
    is-deeply $е両.tell, 2, '.tell after seeking';
    $е両.close;
}

subtest 'open(:bin) handle' => {
    plan 4;
    my $е両 = make-temp-file(content => 'I ♥ Raku').open: :bin;
    is-deeply $е両.tell, 0, '.tell at start';

    $е両.slurp;
    is-deeply $е両.tell, 'I ♥ Raku'.encode.bytes, '.tell after slurping';

    $е両.seek: 2, SeekFromBeginning;
    is-deeply $е両.tell, 2, '.tell after seeking';

    $е両.seek: 0, SeekFromBeginning;
    $ = $е両.read(3);
    is-deeply $е両.tell, 3, '.tell after reading 3 bytes';
    $е両.close;
}

# https://github.com/Raku/old-issue-tracker/issues/6590
# TTY handles like STDOUT keep track of how many bytes were sent to give faked
# out .tell results. The bug in #132254 existed due to .tell on TTY, so
# let's use $*OUT for the test and rely on previous TAP output to have shifted
# the .tell value by some bytes, due to previously printed content
cmp-ok $*OUT.tell, '!=', 0, '.tell gave us some non-zero value';

# vim: expandtab shiftwidth=4
