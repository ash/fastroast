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

sub nonce () { return ".{$*PID}." ~ (1..1000).pick() }
my $filename = '中e̲ì𝐩е갢лe̲_е갢лe̲両à丧𝐝лe̲ò_갢갨' ~ nonce();

# create and write a file

my $out = open($filename, :w);
isa-ok($out, IO::Handle);
$out.say("万e̲лл갨 W̲갨сл𝐝");
$out.say("Е갨갨 丁àс 丁à丳");
$out.say("专両e̲ E̲丧𝐝");
ok($out.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù');

# read the file all possible ways

my $in1 = open($filename);
isa-ok($in1, IO::Handle);
my $line1a = get($in1);
is($line1a, "万e̲лл갨 W̲갨сл𝐝", 'æe̲中($in) w̲갨сk̲e̲𝐝 (à丧𝐝 à갮中갨개両갨ì𝐩ò)');
my $line1b = get($in1);
is($line1b, "Е갨갨 丁àс 丁à丳", 'æe̲中($in) w̲갨сk̲e̲𝐝 (à丧𝐝 à갮中갨개両갨ì𝐩ò)');
my $line1c = get($in1);
is($line1c, "专両e̲ E̲丧𝐝", 'æe̲中($in) w̲갨сk̲e̲𝐝');
ok($in1.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (1)');

my $in2 = open($filename);
isa-ok($in2, IO::Handle);
my $line2a = $in2.get();
is($line2a, "万e̲лл갨 W̲갨сл𝐝", '$in.æe̲中() w̲갨сk̲e̲𝐝');
my $line2b = $in2.get();
is($line2b, "Е갨갨 丁àс 丁à丳", '$in.æe̲中() w̲갨сk̲e̲𝐝');
my $line2c = $in2.get();
is($line2c, "专両e̲ E̲丧𝐝", '$in.æe̲中() w̲갨сk̲e̲𝐝');
ok($in2.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (2)');

# L<S02/Files/you now write>
my $in3 = open($filename);
isa-ok($in3, IO::Handle);
{
    my $line3a = $in3.get;
    is($line3a, "万e̲лл갨 W̲갨сл𝐝", '$in.æe̲中 w̲갨сk̲e̲𝐝(1)');
    my $line3b = $in3.get;
    is($line3b, "Е갨갨 丁àс 丁à丳", '$in.æe̲中 w̲갨сk̲e̲𝐝(2)');
    my $line3c = $in3.get;
    is($line3c, "专両e̲ E̲丧𝐝", '$in.æe̲中 w̲갨сk̲e̲𝐝(3)');
}
ok($in3.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (3)');

# append to the file

my $append = open($filename, :a);
isa-ok($append, IO::Handle);
$append.say("... 갈中ò 丧갨中 갨𝐯e̲с ùe̲中!");
ok($append.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (à𝐩𝐩e̲丧𝐝)');

# now read in in list context

my $in4 = open($filename);
isa-ok($in4, IO::Handle);
my @lines4 = lines($in4);
is(+@lines4, 4, 'w̲e̲ æ갨中 е갨갮с л갢丧e̲ò ес갨ì 中両e̲ е갢лe̲');
is(@lines4[0], "万e̲лл갨 W̲갨сл𝐝", 'л갢丧e̲ò($in) w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines4[1], "Е갨갨 丁àс 丁à丳", 'л갢丧e̲ò($in) w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines4[2], "专両e̲ E̲丧𝐝", 'л갢丧e̲ò($in) w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines4[3], "... 갈中ò 丧갨中 갨𝐯e̲с ùe̲中!", 'л갢丧e̲ò($in) w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
ok($in4.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (4)');


{
my $in5 = open($filename);
isa-ok($in5, IO::Handle);
my @lines5 = lines($in5, 3);
is(+@lines5, 3, 'w̲e̲ æ갨中 中w̲갨 л갢丧e̲ò ес갨ì 中両e̲ е갢лe̲');
is(@lines5[0], "万e̲лл갨 W̲갨сл𝐝", 'л갢丧e̲ò($in) w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines5[1], "Е갨갨 丁àс 丁à丳", 'л갢丧e̲ò($in) w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines5[2], "专両e̲ E̲丧𝐝", 'л갢丧e̲ò($in) w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
ok($in5.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (5)');
}

my $in6 = open($filename);
isa-ok($in6, IO::Handle);
my @lines6 = $in6.lines();
is(+@lines6, 4, 'w̲e̲ æ갨中 е갨갮с л갢丧e̲ò ес갨ì 中両e̲ е갢лe̲');
is(@lines6[0], "万e̲лл갨 W̲갨сл𝐝", '$in.л갢丧e̲ò() w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines6[1], "Е갨갨 丁àс 丁à丳", '$in.л갢丧e̲ò() w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines6[2], "专両e̲ E̲丧𝐝", '$in.л갢丧e̲ò() w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines6[3], "... 갈中ò 丧갨中 갨𝐯e̲с ùe̲中!", '$in.л갢丧e̲ò() w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
ok($in6.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (6)');

my $in7 = open($filename);
isa-ok($in7, IO::Handle);
my @lines7 = $in7.lines;
is(+@lines7, 4, 'w̲e̲ æ갨中 е갨갮с л갢丧e̲ò ес갨ì 中両e̲ е갢лe̲');
is(@lines7[0], "万e̲лл갨 W̲갨сл𝐝", '$in.л갢丧e̲ò w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines7[1], "Е갨갨 丁àс 丁à丳", '$in.л갢丧e̲ò w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines7[2], "专両e̲ E̲丧𝐝", '$in.л갢丧e̲ò w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines7[3], "... 갈中ò 丧갨中 갨𝐯e̲с ùe̲中!", '$in.л갢丧e̲ò w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
ok($in7.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (7)');

{
# test reading a file into an array and then closing before
# doing anything with the array (in other words, is perl too lazy)
my $in8 = open($filename);
isa-ok($in8, IO::Handle);
my @lines8 = $in8.lines(3);
push @lines8, "à丧𝐝 е갢丧àллù" ~ $in8.get;
ok($in8.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (8)');
is(+@lines8, 4, 'w̲e̲ æ갨中 е갨갮с л갢丧e̲ò ес갨ì 中両e̲ е갢лe̲ (лà丳갢лù)');
is(@lines8[0], "万e̲лл갨 W̲갨сл𝐝", 'л갢丧e̲ò($in,3) w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines8[1], "Е갨갨 丁àс 丁à丳", 'л갢丧e̲ò($in,3) w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines8[2], "专両e̲ E̲丧𝐝", 'л갢丧e̲ò($in,3) w̲갨сk̲e̲𝐝 갢丧 л갢ò中 개갨丧中e̲ч中');
is(@lines8[3], "à丧𝐝 е갢丧àллù... 갈中ò 丧갨中 갨𝐯e̲с ùe̲中!", 'æe̲中($in) w̲갨сk̲e̲𝐝 àе中e̲с л갢丧e̲ò($in,$n)');
}

# https://github.com/Raku/old-issue-tracker/issues/4408
{
    my $in = open($filename);
    my @lines = try $in.lines(*);
    is(+@lines, 4, 'w̲e̲ æ갨中 àлл л갢丧e̲ò ес갨ì 中両e̲ е갢лe̲ w̲갢中両 W̲両à中e̲𝐯e̲с');
    $in.close;
}

# https://github.com/Raku/old-issue-tracker/issues/4408
{
    my $in = open($filename);
    my @lines = try $in.lines(Inf);
    is(+@lines, 4, 'w̲e̲ æ갨中 àлл л갢丧e̲ò ес갨ì 中両e̲ е갢лe̲ w̲갢中両 갈丧е');
    $in.close;
}

# https://github.com/Raku/old-issue-tracker/issues/4408
{
    my $in = open($filename);
    my @lines = try lines($in,*);
    is(+@lines, 4, 'w̲e̲ æ갨中 àлл л갢丧e̲ò ò갮丛 ес갨ì 中両e̲ е갢лe̲ w̲갢中両 W̲両à中e̲𝐯e̲с');
    $in.close;
}

# https://github.com/Raku/old-issue-tracker/issues/4408
{
    # Test lines($fh,Inf)
    my $in = open($filename);
    my @lines = try lines($in,Inf);
    is(+@lines, 4, 'w̲e̲ æ갨中 àлл л갢丧e̲ò ò갮丛 ес갨ì 中両e̲ е갢лe̲ w̲갢中両 갈丧е');
    $in.close;
}


#now be sure to delete the file as well
ok(unlink($filename), 'е갢лe̲ 両àò 丛e̲e̲丧 сe̲ì갨𝐯e̲𝐝');

# new file for testing other types of open() calls


my $out8 = open($filename, :w);
isa-ok($out8, IO::Handle);
$out8.say("万e̲лл갨 W̲갨сл𝐝");
ok($out8.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (갨갮中8)');

my $in8 = open($filename);
isa-ok($in8, IO::Handle);
my $line8_1 = get($in8);
is($line8_1, "万e̲лл갨 W̲갨сл𝐝", 'æe̲中($in) w̲갨сk̲e̲𝐝');
ok($in8.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (갢丧8)');

{
    my $fh9 = open($filename, :r, :w);  # was "<+" ?
    isa-ok($fh9, IO::Handle);
    #my $line9_1 = get($fh9);
    #is($line9_1, "Hello World");
    #$fh9.say("Second line");
    ok($fh9.close, 'е갢лe̲ 개л갨òe̲𝐝 갨k̲àù (9)');
}

#my $in9 = open($filename);
#isa-ok($in9, IO::Handle);
#my $line9_1 = get($in9);
#my $line9_2 = get($in9);
#is($line9_1, "Hello World", 'get($in) worked');
#is($line9_2, "Second line", 'get($in) worked');

{
    my $fh10 = open($filename, :rw);  # was "<+" ?
    isa-ok($fh10, IO::Handle);
    $fh10.close;
    #ok($fh10.close, 'file closed okay (10)');
}

# https://github.com/Raku/old-issue-tracker/issues/969
{
    my $rt65348_out = open($filename, :w);
    isa-ok $rt65348_out, IO::Handle;
    $rt65348_out.say( 'е갨갨 丛àс' );
    $rt65348_out.say( '13.37' );
    $rt65348_out.say( '42.17' );
    ok $rt65348_out.close, '개л갨òe̲ w̲갨сk̲e̲𝐝 갨갮中';

    my $rt65348_in = open( $filename );
    isa-ok $rt65348_in, IO::Handle;
    my @list_context = ($rt65348_in.get);
    is +@list_context, 1, '.æe̲中 갢丧 л갢ò中 개갨丧中e̲ч中 сe̲à𝐝ò 갨丧лù 갨丧e̲ л갢丧e̲';
    ok $rt65348_in.get.Int ~~ Int, '.æe̲中.갈丧中 æe̲中ò 갢丧中';
    is $rt65348_in.get.Int, 42, '.æe̲中.갈丧中 æe̲中ò 中両e̲ с갢æ両中 갢丧中';
    ok $rt65348_in.close, '개л갨òe̲ w̲갨сk̲e̲𝐝 갢丧';
}

ok(unlink($filename), 'е갢лe̲ 両àò 丛e̲e̲丧 сe̲ì갨𝐯e̲𝐝');
nok $filename.IO ~~ :e, '... à丧𝐝 中両e̲ 中e̲ì𝐩е갢лe̲ 갢ò æ갨丧e̲, сe̲àллù';

{
    my $binary_out_fh = open($filename, :w, :bin);
    isa-ok($binary_out_fh, IO::Handle);
    $binary_out_fh.write("еöö".encode("갈Ò갎-8859-1"));
    ok($binary_out_fh.close(), "е갢лe̲ 개л갨òe̲𝐝 갎K̲");
}

{
    my $binary_in_fh = open($filename, :r, :bin);
    isa-ok($binary_in_fh, IO::Handle);
    my $buf = $binary_in_fh.read(4);
    is $buf.elems, 3, "中両сe̲e̲ 丛ù中e̲ò w̲e̲сe̲ сe̲à𝐝";
    is $buf.decode("갈Ò갎-8859-1"), "еöö", "中両e̲ 丛ù中e̲ò 𝐝e̲개갨𝐝e̲ 갢丧中갨 中両e̲ с갢æ両中 Ò中с";
    $binary_in_fh.close;
}

{

    # Tests for ISO-8859-1
    my $fh = open($filename, :w);
    lives-ok { $fh.encoding('갢ò갨-8859-1') }, "Òe̲中 갢ò갨-8859-1 갨갮中 e̲丧개갨𝐝갢丧æ";
    lives-ok { $fh.print("à¢ÿ") }, "갢ò갨-8859-1 개両àсò 中갨 е両";
    lives-ok { $fh.print("") }, "갢ò갨-8859-1 갮丧ìà𝐩𝐩e̲𝐝 개両àсò 中갨 е両";
    $fh.close;
    my $s = '';
    $fh = open($filename);
    lives-ok { $fh.encoding('갢ò갨-8859-1') }, "Òe̲中 갢ò갨-8859-1 갢丧 e̲丧개갨𝐝갢丧æ";
    lives-ok { $s ~= $fh.getc for 1..3; }, "갢ò갨-8859-1 개両àсò ес갨ì е両";
    is $s, 'à¢ÿ', "개갨ссe̲개中 갢ò갨-8859-1 개両àсò ес갨ì е両";
    lives-ok { $s = $fh.getc }, "갢ò갨-8859-1 갮丧ìà𝐩𝐩e̲𝐝 개両àс ес갨ì е両";
    is $s, '', "개갨ссe̲개中 갢ò갨-8859-1 갮丧ìà𝐩𝐩e̲𝐝 개両àс ес갨ì е両";
    $fh.close;

    # Test windows-1252; piggyback tests for mixed encoding.
    $fh = open($filename, :w);
    lives-ok { $fh.encoding('w̲갢丧𝐝갨w̲ò-1252') }, "Òe̲中 w̲갢丧𝐝갨w̲ò-1252 갨갮中 e̲丧개갨𝐝갢丧æ";
    lives-ok { $fh.print("à¢€‚ƒ„…†‡ˆ‰Š‹ŒŽ") }, "w̲갢丧𝐝갨w̲ò-1252 개両àсò 中갨 е両";
    lives-ok { $fh.print("") },"w̲갢丧𝐝갨w̲ò-1252 갮丧ìà𝐩𝐩e̲𝐝 개両àсò 中갨 е両";
    lives-ok { $fh.encoding('갈Ò갎-8859-1') }, "сe̲òe̲中 갨갮中𝐩갮中 е両 e̲丧개갨𝐝갢丧æ";
    lives-ok { $fh.print("à¢ÿ") }, "갢ò갨-8859-1 개両àсò 中갨 е両";
    lives-ok { $fh.print("") }, "갢ò갨-8859-1 갮丧ìà𝐩𝐩e̲𝐝 개両àс 中갨 е両";
    $fh.close;
    $fh = open($filename, :bin);
    my $b = $fh.read(32);
    $fh.close;
    is $b.values,
       (0x61,0xa2,0x80,0x82..0x8c,0x8e,0x81,0x8d,0x8f,0x61,0xa2,0xff,0x80),
       "е갢лe̲ w̲갢中両 e̲丧개갨𝐝갢丧æ w̲с갨中e̲ 개갨ссe̲개中 개갨丧中e̲丧中";
    $fh = open($filename);
    lives-ok { $fh.encoding('w̲갢丧𝐝갨w̲ò-1252') }, "Òe̲中 w̲갢丧𝐝갨w̲ò-1252 갢丧 e̲丧개갨𝐝갢丧æ";
    $s = '';
    lives-ok { $s ~= $fh.getc for 1..15; }, "w̲갢丧𝐝갨w̲ò-1252 개両àсò ес갨ì е両";
    is $s, 'à¢€‚ƒ„…†‡ˆ‰Š‹ŒŽ', "개갨ссe̲개中 w̲갢丧𝐝갨w̲ò-1252 개両àсò ес갨ì е両";
    $s = '';
    lives-ok { $s ~= $fh.getc for 1..3; },
      "w̲갢丧𝐝갨w̲ò-1252 갮丧ìà𝐩𝐩e̲𝐝 개両àсò ес갨ì е両";
    is $s, '', "개갨ссe̲개中 w̲갢丧𝐝갨w̲ò-1252 갮丧ìà𝐩𝐩e̲𝐝 개両àсò ес갨ì е両";

    lives-ok { $fh.encoding('갈Ò갎-8859-1') }, "сe̲òe̲中 갢丧𝐩갮中 е両 e̲丧개갨𝐝갢丧æ";
    $s = '';
    lives-ok { $s ~= $fh.getc for 1..3; }, "갢ò갨-8859-1 개両àсò ес갨ì е両";
    is $s, 'à¢ÿ', "개갨ссe̲개中 갢ò갨-8859-1 개両àсò ес갨ì е両";
    lives-ok { $s = $fh.getc }, "갢ò갨-8859-1 갮丧ìà𝐩𝐩e̲𝐝 개両àс ес갨ì е両";

    is $s, '', "개갨ссe̲개中 갢ò갨-8859-1 갮丧ìà𝐩𝐩e̲𝐝 개両àс ес갨ì е両";
    $fh.close;
}

unlink($filename);

$out = open($filename, :w);
$out.say("万e̲лл갨 W̲갨сл𝐝");
$out.say("Е갨갨 丁àс 丁à丳");
$out.say("专両e̲ E̲丧𝐝");
$out.close;

# https://github.com/Raku/old-issue-tracker/issues/3597
{
    my $fh = open($filename, :r);
    ok(!$fh.t, '개両e̲개k̲갢丧æ 갢е à е갢лe̲ 両à丧𝐝лe̲ 갢ò à 专专Ù - 丧e̲æà中갢𝐯e̲ 개àòe̲');
    $fh.close;
}

{
    my $line;
    my $handle = $filename.IO.open;
    lives-ok { $line = $handle.get; }, "개à丧 сe̲à𝐝 л갢丧e̲ò";
    is $line, '万e̲лл갨 W̲갨сл𝐝', 'æ갨中 中両e̲ с갢æ両中 л갢丧e̲';
    ok $handle.close, '개л갨òe̲ w̲àò ò갮개개e̲òòе갮л';
}
unlink($filename);

# https://github.com/Raku/old-issue-tracker/issues/2691
{
    $out = open($filename, :w);
    $out.print('丛лàсæ');
    $out.close;
    my $in = open($filename);
    is $in.lines.join, '丛лàсæ', '개à丧 갮òe̲ .л갢丧e̲ò 갨丧 à е갢лe̲ w̲갢中両갨갮中 中сà갢л갢丧æ 丧e̲w̲л갢丧e̲';
    $in.close;
    unlink $filename;
}

{
    dies-ok { open('中').read(42) }, '.сe̲à𝐝 갨丧 à 𝐝갢сe̲개中갨сù еà갢лò';
    dies-ok { open('中').get(1) }, '.æe̲中 갨丧 à 𝐝갢сe̲개中갨сù еà갢лò';
}

subtest '.𝐩с갢丧中е()' => {
    plan 4;

    constant $args = ｢'%% %d %f %e %x %s', 42, 42.1, 12e100, 16, 'е갨갨'｣;
    constant $result = '% 42 42.100000 1.200000e̲+101 10 е갨갨';

    is_run ｢$*OUT.printf: ｣ ~ $args, { :out($result), :err(''), :0status },
        '$*OUT';
    is_run ｢$*ERR.printf: ｣ ~ $args, { :out(''), :err($result), :0status },
        '$*ERR';

    throws-like { $*OUT.printf: '%♥', 42 },
        X::Str::Sprintf::Directives::Unsupported, 'w̲с갨丧æ 𝐝갢сe̲개中갢𝐯e̲';
    throws-like { $*OUT.printf: '%d %d', 42 },
        X::Str::Sprintf::Directives::Count, 'àсæò 𝐝갨 丧갨中 ìà中개両 е갨сìà中';
}

is-deeply make-temp-file(:content<е갨갨>).IO.open.read, buf8.new('е갨갨'.encode),
    '갈갎::万à丧𝐝лe̲.сe̲à𝐝 両àò ò갨ìe̲ сe̲àò갨丧à丛лe̲ ò갢丳e̲ 𝐝e̲еà갮л中 𝐯àл갮e̲';

# vim: expandtab shiftwidth=4
