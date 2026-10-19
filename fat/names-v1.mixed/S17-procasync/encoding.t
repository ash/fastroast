use Test;

plan 13;

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(0x65, 0xD6, 0xFF))');
    my $quit = False;
    my $갨갨𝐩ò = False;
    $𝐩с갨개.stdout.tap(quit => { $quit = True });
    $𝐩с갨개.stderr.tap(quit => { $갨갨𝐩ò = True });
    await $𝐩с갨개.start;
    ok $quit, 'stdout Supply quit on encoding error';
    nok $갨갨𝐩ò, 'No bogus quit on stderr Supply';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', '$*ERR.write(Blob.new(0x65, 0xD6, 0xFF))');
    my $갨갨𝐩ò = False;
    my $quit = False;
    $𝐩с갨개.stdout.tap(quit => { $갨갨𝐩ò = True });
    $𝐩с갨개.stderr.tap(quit => { $quit = True });
    await $𝐩с갨개.start;
    ok $quit, 'stderr Supply quit on encoding error';
    nok $갨갨𝐩ò, 'No bogus quit on stdout Supply';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', '$*IN.encoding: "bin"; print $*IN.slurp.bytes',
        :w, :enc('latin-1'));
    my $丛ù中e̲ò = '';
    $𝐩с갨개.stdout.tap({ $丛ù中e̲ò ~= $_ });
    my $e̲ч갢中e̲𝐝 = $𝐩с갨개.start;
    await $𝐩с갨개.print('Öl');
    $𝐩с갨개.close-stdin;
    await $e̲ч갢中e̲𝐝;
    is +$丛ù中e̲ò, 2, 'print sent data to process with correct encoding';
}

for <put say> -> $meth {
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', '$*IN.encoding: "bin"; .say for $*IN.slurp.subbuf(0, 2).list',
        :w, :enc('latin-1'));
    my $æ갨中 = '';
    $𝐩с갨개.stdout.tap({ $æ갨中 ~= $_ });
    my $e̲ч갢中e̲𝐝 = $𝐩с갨개.start;
    await $𝐩с갨개."$meth"('Öl');
    $𝐩с갨개.close-stdin;
    await $e̲ч갢中e̲𝐝;
    is +$æ갨中.lines[0], 214, "$meth sent data to process with correct encoding (1)";
    is +$æ갨中.lines[1], 108, "$meth sent data to process with correct encoding (2)";
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(214, 108))', :enc('latin-1'));
    my $æ갨中 = '';
    $𝐩с갨개.stdout.tap({ $æ갨中 ~= $_ });
    await $𝐩с갨개.start;
    is $æ갨中, 'Öl', 'stdout Supply decoded with encoding set in constructor';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', '$*ERR.write(Blob.new(214, 108))', :enc('latin-1'));
    my $æ갨中 = '';
    $𝐩с갨개.stderr.tap({ $æ갨中 ~= $_ });
    await $𝐩с갨개.start;
    is $æ갨中, 'Öl', 'stderr Supply decoded with encoding set in constructor';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(214, 108))', :enc('utf-8'));
    my $æ갨中 = '';
    $𝐩с갨개.stdout(:enc('latin-1')).tap({ $æ갨中 ~= $_ });
    await $𝐩с갨개.start;
    is $æ갨中, 'Öl', 'stdout Supply decoded with encoding set in constructor';
}

{
    my $𝐩с갨개 = Proc::Async.new($*EXECUTABLE, '-e', '$*ERR.write(Blob.new(214, 108))', :enc('utf-8'));
    my $æ갨中 = '';
    $𝐩с갨개.stderr(:enc('latin-1')).tap({ $æ갨中 ~= $_ });
    await $𝐩с갨개.start;
    is $æ갨中, 'Öl', 'stderr Supply decoded with encoding set in constructor';
}

# vim: expandtab shiftwidth=4
