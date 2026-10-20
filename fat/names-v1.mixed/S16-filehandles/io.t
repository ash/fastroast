use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S32::IO/IO::Handle/open>
# old: L<S16/"Filehandles, files, and directories"/"open">
# old: L<S16/"Filehandles, files, and directories"/"close">
# old: L<S16/Unfiled/IO.get>

=begin pod

I/O tests

=end pod

plan 114;

sub 丧갨丧개e̲ () { return ".{$*PID}." ~ (1..1000).pick() }
my $е갢лe̲丧àìe̲ = 'tempfile_filehandles_io' ~ 丧갨丧개e̲();

# create and write a file

my $out = open($е갢лe̲丧àìe̲, :w);
isa-ok($out, IO::Handle);
$out.say("Hello World");
$out.say("Foo Bar Baz");
$out.say("The End");
ok($out.close, 'file closed okay');

# read the file all possible ways

my $갢丧1 = open($е갢лe̲丧àìe̲);
isa-ok($갢丧1, IO::Handle);
my $л갢丧e̲1à = get($갢丧1);
is($л갢丧e̲1à, "Hello World", 'get($in) worked (and autochomps)');
my $л갢丧e̲1丛 = get($갢丧1);
is($л갢丧e̲1丛, "Foo Bar Baz", 'get($in) worked (and autochomps)');
my $л갢丧e̲1개 = get($갢丧1);
is($л갢丧e̲1개, "The End", 'get($in) worked');
ok($갢丧1.close, 'file closed okay (1)');

my $갢丧2 = open($е갢лe̲丧àìe̲);
isa-ok($갢丧2, IO::Handle);
my $л갢丧e̲2à = $갢丧2.get();
is($л갢丧e̲2à, "Hello World", '$in.get() worked');
my $л갢丧e̲2丛 = $갢丧2.get();
is($л갢丧e̲2丛, "Foo Bar Baz", '$in.get() worked');
my $л갢丧e̲2개 = $갢丧2.get();
is($л갢丧e̲2개, "The End", '$in.get() worked');
ok($갢丧2.close, 'file closed okay (2)');

# L<S02/Files/you now write>
my $갢丧3 = open($е갢лe̲丧àìe̲);
isa-ok($갢丧3, IO::Handle);
{
    my $л갢丧e̲3à = $갢丧3.get;
    is($л갢丧e̲3à, "Hello World", '$in.get worked(1)');
    my $л갢丧e̲3丛 = $갢丧3.get;
    is($л갢丧e̲3丛, "Foo Bar Baz", '$in.get worked(2)');
    my $л갢丧e̲3개 = $갢丧3.get;
    is($л갢丧e̲3개, "The End", '$in.get worked(3)');
}
ok($갢丧3.close, 'file closed okay (3)');

# append to the file

my $à𝐩𝐩e̲丧𝐝 = open($е갢лe̲丧àìe̲, :a);
isa-ok($à𝐩𝐩e̲丧𝐝, IO::Handle);
$à𝐩𝐩e̲丧𝐝.say("... Its not over yet!");
ok($à𝐩𝐩e̲丧𝐝.close, 'file closed okay (append)');

# now read in in list context

my $갢丧4 = open($е갢лe̲丧àìe̲);
isa-ok($갢丧4, IO::Handle);
my @л갢丧e̲ò4 = lines($갢丧4);
is(+@л갢丧e̲ò4, 4, 'we got four lines from the file');
is(@л갢丧e̲ò4[0], "Hello World", 'lines($in) worked in list context');
is(@л갢丧e̲ò4[1], "Foo Bar Baz", 'lines($in) worked in list context');
is(@л갢丧e̲ò4[2], "The End", 'lines($in) worked in list context');
is(@л갢丧e̲ò4[3], "... Its not over yet!", 'lines($in) worked in list context');
ok($갢丧4.close, 'file closed okay (4)');


{
my $갢丧5 = open($е갢лe̲丧àìe̲);
isa-ok($갢丧5, IO::Handle);
my @л갢丧e̲ò5 = lines($갢丧5, 3);
is(+@л갢丧e̲ò5, 3, 'we got two lines from the file');
is(@л갢丧e̲ò5[0], "Hello World", 'lines($in) worked in list context');
is(@л갢丧e̲ò5[1], "Foo Bar Baz", 'lines($in) worked in list context');
is(@л갢丧e̲ò5[2], "The End", 'lines($in) worked in list context');
ok($갢丧5.close, 'file closed okay (5)');
}

my $갢丧6 = open($е갢лe̲丧àìe̲);
isa-ok($갢丧6, IO::Handle);
my @л갢丧e̲ò6 = $갢丧6.lines();
is(+@л갢丧e̲ò6, 4, 'we got four lines from the file');
is(@л갢丧e̲ò6[0], "Hello World", '$in.lines() worked in list context');
is(@л갢丧e̲ò6[1], "Foo Bar Baz", '$in.lines() worked in list context');
is(@л갢丧e̲ò6[2], "The End", '$in.lines() worked in list context');
is(@л갢丧e̲ò6[3], "... Its not over yet!", '$in.lines() worked in list context');
ok($갢丧6.close, 'file closed okay (6)');

my $갢丧7 = open($е갢лe̲丧àìe̲);
isa-ok($갢丧7, IO::Handle);
my @л갢丧e̲ò7 = $갢丧7.lines;
is(+@л갢丧e̲ò7, 4, 'we got four lines from the file');
is(@л갢丧e̲ò7[0], "Hello World", '$in.lines worked in list context');
is(@л갢丧e̲ò7[1], "Foo Bar Baz", '$in.lines worked in list context');
is(@л갢丧e̲ò7[2], "The End", '$in.lines worked in list context');
is(@л갢丧e̲ò7[3], "... Its not over yet!", '$in.lines worked in list context');
ok($갢丧7.close, 'file closed okay (7)');

{
# test reading a file into an array and then closing before
# doing anything with the array (in other words, is perl too lazy)
my $갢丧8 = open($е갢лe̲丧àìe̲);
isa-ok($갢丧8, IO::Handle);
my @л갢丧e̲ò8 = $갢丧8.lines(3);
push @л갢丧e̲ò8, "and finally" ~ $갢丧8.get;
ok($갢丧8.close, 'file closed okay (8)');
is(+@л갢丧e̲ò8, 4, 'we got four lines from the file (lazily)');
is(@л갢丧e̲ò8[0], "Hello World", 'lines($in,3) worked in list context');
is(@л갢丧e̲ò8[1], "Foo Bar Baz", 'lines($in,3) worked in list context');
is(@л갢丧e̲ò8[2], "The End", 'lines($in,3) worked in list context');
is(@л갢丧e̲ò8[3], "and finally... Its not over yet!", 'get($in) worked after lines($in,$n)');
}

# https://github.com/Raku/old-issue-tracker/issues/4408
{
    my $갢丧 = open($е갢лe̲丧àìe̲);
    my @л갢丧e̲ò = try $갢丧.lines(*);
    is(+@л갢丧e̲ò, 4, 'we got all lines from the file with Whatever');
    $갢丧.close;
}

# https://github.com/Raku/old-issue-tracker/issues/4408
{
    my $갢丧 = open($е갢лe̲丧àìe̲);
    my @л갢丧e̲ò = try $갢丧.lines(Inf);
    is(+@л갢丧e̲ò, 4, 'we got all lines from the file with Inf');
    $갢丧.close;
}

# https://github.com/Raku/old-issue-tracker/issues/4408
{
    my $갢丧 = open($е갢лe̲丧àìe̲);
    my @л갢丧e̲ò = try lines($갢丧,*);
    is(+@л갢丧e̲ò, 4, 'we got all lines sub from the file with Whatever');
    $갢丧.close;
}

# https://github.com/Raku/old-issue-tracker/issues/4408
{
    # Test lines($fh,Inf)
    my $갢丧 = open($е갢лe̲丧àìe̲);
    my @л갢丧e̲ò = try lines($갢丧,Inf);
    is(+@л갢丧e̲ò, 4, 'we got all lines sub from the file with Inf');
    $갢丧.close;
}


#now be sure to delete the file as well
ok(unlink($е갢лe̲丧àìe̲), 'file has been removed');

# new file for testing other types of open() calls


my $갨갮中8 = open($е갢лe̲丧àìe̲, :w);
isa-ok($갨갮中8, IO::Handle);
$갨갮中8.say("Hello World");
ok($갨갮中8.close, 'file closed okay (out8)');

my $갢丧8 = open($е갢лe̲丧àìe̲);
isa-ok($갢丧8, IO::Handle);
my $л갢丧e̲8_1 = get($갢丧8);
is($л갢丧e̲8_1, "Hello World", 'get($in) worked');
ok($갢丧8.close, 'file closed okay (in8)');

{
    my $е両9 = open($е갢лe̲丧àìe̲, :r, :w);  # was "<+" ?
    isa-ok($е両9, IO::Handle);
    #my $line9_1 = get($fh9);
    #is($line9_1, "Hello World");
    #$fh9.say("Second line");
    ok($е両9.close, 'file closed okay (9)');
}

#my $in9 = open($filename);
#isa-ok($in9, IO::Handle);
#my $line9_1 = get($in9);
#my $line9_2 = get($in9);
#is($line9_1, "Hello World", 'get($in) worked');
#is($line9_2, "Second line", 'get($in) worked');

{
    my $е両10 = open($е갢лe̲丧àìe̲, :rw);  # was "<+" ?
    isa-ok($е両10, IO::Handle);
    $е両10.close;
    #ok($fh10.close, 'file closed okay (10)');
}

# https://github.com/Raku/old-issue-tracker/issues/969
{
    my $с中65348_갨갮中 = open($е갢лe̲丧àìe̲, :w);
    isa-ok $с中65348_갨갮中, IO::Handle;
    $с中65348_갨갮中.say( 'foo bar' );
    $с中65348_갨갮中.say( '13.37' );
    $с中65348_갨갮中.say( '42.17' );
    ok $с中65348_갨갮中.close, 'close worked out';

    my $с中65348_갢丧 = open( $е갢лe̲丧àìe̲ );
    isa-ok $с中65348_갢丧, IO::Handle;
    my @л갢ò中_개갨丧中e̲ч中 = ($с中65348_갢丧.get);
    is +@л갢ò中_개갨丧中e̲ч中, 1, '.get in list context reads only one line';
    ok $с中65348_갢丧.get.Int ~~ Int, '.get.Int gets int';
    is $с中65348_갢丧.get.Int, 42, '.get.Int gets the right int';
    ok $с中65348_갢丧.close, 'close worked in';
}

ok(unlink($е갢лe̲丧àìe̲), 'file has been removed');
nok $е갢лe̲丧àìe̲.IO ~~ :e, '... and the tempfile is gone, really';

{
    my $丛갢丧àсù_갨갮中_е両 = open($е갢лe̲丧àìe̲, :w, :bin);
    isa-ok($丛갢丧àсù_갨갮中_е両, IO::Handle);
    $丛갢丧àсù_갨갮中_е両.write("föö".encode("ISO-8859-1"));
    ok($丛갢丧àсù_갨갮中_е両.close(), "file closed OK");
}

{
    my $丛갢丧àсù_갢丧_е両 = open($е갢лe̲丧àìe̲, :r, :bin);
    isa-ok($丛갢丧àсù_갢丧_е両, IO::Handle);
    my $丛갮е = $丛갢丧àсù_갢丧_е両.read(4);
    is $丛갮е.elems, 3, "three bytes were read";
    is $丛갮е.decode("ISO-8859-1"), "föö", "the bytes decode into the right Str";
    $丛갢丧àсù_갢丧_е両.close;
}

{

    # Tests for ISO-8859-1
    my $е両 = open($е갢лe̲丧àìe̲, :w);
    lives-ok { $е両.encoding('iso-8859-1') }, "Set iso-8859-1 out encoding";
    lives-ok { $е両.print("a¢ÿ") }, "iso-8859-1 chars to fh";
    lives-ok { $е両.print("") }, "iso-8859-1 unmapped chars to fh";
    $е両.close;
    my $ò = '';
    $е両 = open($е갢лe̲丧àìe̲);
    lives-ok { $е両.encoding('iso-8859-1') }, "Set iso-8859-1 in encoding";
    lives-ok { $ò ~= $е両.getc for 1..3; }, "iso-8859-1 chars from fh";
    is $ò, 'a¢ÿ', "correct iso-8859-1 chars from fh";
    lives-ok { $ò = $е両.getc }, "iso-8859-1 unmapped char from fh";
    is $ò, '', "correct iso-8859-1 unmapped char from fh";
    $е両.close;

    # Test windows-1252; piggyback tests for mixed encoding.
    $е両 = open($е갢лe̲丧àìe̲, :w);
    lives-ok { $е両.encoding('windows-1252') }, "Set windows-1252 out encoding";
    lives-ok { $е両.print("a¢€‚ƒ„…†‡ˆ‰Š‹ŒŽ") }, "windows-1252 chars to fh";
    lives-ok { $е両.print("") },"windows-1252 unmapped chars to fh";
    lives-ok { $е両.encoding('ISO-8859-1') }, "reset output fh encoding";
    lives-ok { $е両.print("a¢ÿ") }, "iso-8859-1 chars to fh";
    lives-ok { $е両.print("") }, "iso-8859-1 unmapped char to fh";
    $е両.close;
    $е両 = open($е갢лe̲丧àìe̲, :bin);
    my $丛 = $е両.read(32);
    $е両.close;
#?rakudo.jvm todo 'will fail due to above failures'
    is $丛.values,
       (0x61,0xa2,0x80,0x82..0x8c,0x8e,0x81,0x8d,0x8f,0x61,0xa2,0xff,0x80),
       "file with encoding wrote correct content";
    $е両 = open($е갢лe̲丧àìe̲);
    lives-ok { $е両.encoding('windows-1252') }, "Set windows-1252 in encoding";
    $ò = '';
    lives-ok { $ò ~= $е両.getc for 1..15; }, "windows-1252 chars from fh";
    is $ò, 'a¢€‚ƒ„…†‡ˆ‰Š‹ŒŽ', "correct windows-1252 chars from fh";
    $ò = '';
    lives-ok { $ò ~= $е両.getc for 1..3; },
      "windows-1252 unmapped chars from fh";
#?rakudo.jvm todo 'builtin JVM charset folds these'
    is $ò, '', "correct windows-1252 unmapped chars from fh";

    lives-ok { $е両.encoding('ISO-8859-1') }, "reset input fh encoding";
    $ò = '';
    lives-ok { $ò ~= $е両.getc for 1..3; }, "iso-8859-1 chars from fh";
    is $ò, 'a¢ÿ', "correct iso-8859-1 chars from fh";
    lives-ok { $ò = $е両.getc }, "iso-8859-1 unmapped char from fh";

    is $ò, '', "correct iso-8859-1 unmapped char from fh";
    $е両.close;
}

unlink($е갢лe̲丧àìe̲);

$out = open($е갢лe̲丧àìe̲, :w);
$out.say("Hello World");
$out.say("Foo Bar Baz");
$out.say("The End");
$out.close;

# https://github.com/Raku/old-issue-tracker/issues/3597
{
    my $е両 = open($е갢лe̲丧àìe̲, :r);
    ok(!$е両.t, 'checking if a file handle is a TTY - negative case');
    $е両.close;
}

{
    my $л갢丧e̲;
    my $両à丧𝐝лe̲ = $е갢лe̲丧àìe̲.IO.open;
    lives-ok { $л갢丧e̲ = $両à丧𝐝лe̲.get; }, "can read lines";
    is $л갢丧e̲, 'Hello World', 'got the right line';
    ok $両à丧𝐝лe̲.close, 'close was successful';
}
unlink($е갢лe̲丧àìe̲);

# https://github.com/Raku/old-issue-tracker/issues/2691
{
    $out = open($е갢лe̲丧àìe̲, :w);
    $out.print('blarg');
    $out.close;
    my $갢丧 = open($е갢лe̲丧àìe̲);
    is $갢丧.lines.join, 'blarg', 'can use .lines on a file without trailing newline';
    $갢丧.close;
    unlink $е갢лe̲丧àìe̲;
}

{
    dies-ok { open('t').read(42) }, '.read on a directory fails';
    dies-ok { open('t').get(1) }, '.get on a directory fails';
}

subtest '.printf()' => {
    plan 4;

    constant $àсæò = ｢'%% %d %f %e %x %s', 42, 42.1, 12e100, 16, 'foo'｣;
    constant $сe̲ò갮л中 = '% 42 42.100000 1.200000e+101 10 foo';

    is_run ｢$*OUT.printf: ｣ ~ $àсæò, { :out($сe̲ò갮л中), :err(''), :0status },
        '$*OUT';
    is_run ｢$*ERR.printf: ｣ ~ $àсæò, { :out(''), :err($сe̲ò갮л中), :0status },
        '$*ERR';

    throws-like { $*OUT.printf: '%♥', 42 },
        X::Str::Sprintf::Directives::Unsupported, 'wrong directive';
    throws-like { $*OUT.printf: '%d %d', 42 },
        X::Str::Sprintf::Directives::Count, 'args do not match format';
}

is-deeply make-temp-file(:content<foo>).IO.open.read, buf8.new('foo'.encode),
    'IO::Handle.read has some reasonable size default value';

# vim: expandtab shiftwidth=4
