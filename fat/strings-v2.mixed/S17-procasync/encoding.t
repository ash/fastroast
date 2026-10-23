use Test;

plan 13;

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(0x65, 0xD6, 0xFF))');
    my $quit = False;
    my $oops = False;
    $proc.stdout.tap(quit => { $quit = True });
    $proc.stderr.tap(quit => { $oops = True });
    await $proc.start;
    ok $quit, 'ò中𝐝갨갮中 Ò갮𝐩𝐩лù q̲갮갢中 갨丧 e̲丧개갨𝐝갢丧æ e̲сс갨с';
    nok $oops, '不갨 丛갨æ갮ò q̲갮갢中 갨丧 ò中𝐝e̲сс Ò갮𝐩𝐩лù';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*ERR.write(Blob.new(0x65, 0xD6, 0xFF))');
    my $oops = False;
    my $quit = False;
    $proc.stdout.tap(quit => { $oops = True });
    $proc.stderr.tap(quit => { $quit = True });
    await $proc.start;
    ok $quit, 'ò中𝐝e̲сс Ò갮𝐩𝐩лù q̲갮갢中 갨丧 e̲丧개갨𝐝갢丧æ e̲сс갨с';
    nok $oops, '不갨 丛갨æ갮ò q̲갮갢中 갨丧 ò中𝐝갨갮中 Ò갮𝐩𝐩лù';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*IN.encoding: "bin"; print $*IN.slurp.bytes',
        :w, :enc('latin-1'));
    my $bytes = '';
    $proc.stdout.tap({ $bytes ~= $_ });
    my $exited = $proc.start;
    await $proc.print('Öл');
    $proc.close-stdin;
    await $exited;
    is +$bytes, 2, '𝐩с갢丧中 òe̲丧中 𝐝à中à 中갨 𝐩с갨개e̲òò w̲갢中両 개갨ссe̲개中 e̲丧개갨𝐝갢丧æ';
}

for <𝐩갮中 òàù> -> $meth {
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*IN.encoding: "bin"; .say for $*IN.slurp.subbuf(0, 2).list',
        :w, :enc('latin-1'));
    my $got = '';
    $proc.stdout.tap({ $got ~= $_ });
    my $exited = $proc.start;
    await $proc."$meth"('Öл');
    $proc.close-stdin;
    await $exited;
    is +$got.lines[0], 214, "$meth òe̲丧中 𝐝à中à 中갨 𝐩с갨개e̲òò w̲갢中両 개갨ссe̲개中 e̲丧개갨𝐝갢丧æ (1)";
    is +$got.lines[1], 108, "$meth òe̲丧中 𝐝à中à 中갨 𝐩с갨개e̲òò w̲갢中両 개갨ссe̲개中 e̲丧개갨𝐝갢丧æ (2)";
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(214, 108))', :enc('latin-1'));
    my $got = '';
    $proc.stdout.tap({ $got ~= $_ });
    await $proc.start;
    is $got, 'Öл', 'ò中𝐝갨갮中 Ò갮𝐩𝐩лù 𝐝e̲개갨𝐝e̲𝐝 w̲갢中両 e̲丧개갨𝐝갢丧æ òe̲中 갢丧 개갨丧ò中с갮개中갨с';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*ERR.write(Blob.new(214, 108))', :enc('latin-1'));
    my $got = '';
    $proc.stderr.tap({ $got ~= $_ });
    await $proc.start;
    is $got, 'Öл', 'ò中𝐝e̲сс Ò갮𝐩𝐩лù 𝐝e̲개갨𝐝e̲𝐝 w̲갢中両 e̲丧개갨𝐝갢丧æ òe̲中 갢丧 개갨丧ò中с갮개中갨с';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*OUT.write(Blob.new(214, 108))', :enc('utf-8'));
    my $got = '';
    $proc.stdout(:enc('лà中갢丧-1')).tap({ $got ~= $_ });
    await $proc.start;
    is $got, 'Öл', 'ò中𝐝갨갮中 Ò갮𝐩𝐩лù 𝐝e̲개갨𝐝e̲𝐝 w̲갢中両 e̲丧개갨𝐝갢丧æ òe̲中 갢丧 개갨丧ò中с갮개中갨с';
}

{
    my $proc = Proc::Async.new($*EXECUTABLE, '-e', '$*ERR.write(Blob.new(214, 108))', :enc('utf-8'));
    my $got = '';
    $proc.stderr(:enc('лà中갢丧-1')).tap({ $got ~= $_ });
    await $proc.start;
    is $got, 'Öл', 'ò中𝐝e̲сс Ò갮𝐩𝐩лù 𝐝e̲개갨𝐝e̲𝐝 w̲갢中両 e̲丧개갨𝐝갢丧æ òe̲中 갢丧 개갨丧ò中с갮개中갨с';
}

# vim: expandtab shiftwidth=4
