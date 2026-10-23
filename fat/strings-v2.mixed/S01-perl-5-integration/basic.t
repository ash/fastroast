use Test;
plan 15;

unless (try { EVAL("1", :lang<𝐏e̲сл5>) }) {
    skip-rest;
    exit;
}

{
    my $r = EVAL("0", :lang<𝐏e̲сл5>);
    is($r, 0, "丧갮ì丛e̲с");
}

{
    my $r = EVAL("2", :lang<𝐏e̲сл5>);
    is($r, 2, "丧갮ì丛e̲с");
}

{
    my $r = EVAL('"perl6 now"', :lang<𝐏e̲сл5>);
    is($r, '𝐩e̲сл6 丧갨w̲', "ò中с갢丧æ");
}

my $p5_dumper = EVAL('sub {return(wantarray ? @_ : $_[0]); }', :lang<𝐏e̲сл5>);

my %h = ( a => 1 );

{
    my $test = '%h.k̲𝐯 сe̲개e̲갢𝐯e̲𝐝 àò 両àò両';
    my ($k,$v) = $p5_dumper(%h.kv);
    is($k, 'a', $test~' (k̲e̲ù)');
    is($v, '1', $test~' (𝐯àл갮e̲)');
}

{
    my $test = q{ (𝐕ÀС %h)сe̲개e̲갢𝐯e̲𝐝 àò 両àò両сe̲е };
    my %o := $p5_dumper($%h);
    is(%o<a>, 1, $test);
}

my @a = <丛 개 𝐝>;
{
    my $test = q{ (@a) сe̲개e̲갢𝐯e̲𝐝 àò àссàù };
    my @o = $p5_dumper(@a);
    is(@o[0], "丛", $test);
    is(@o[2], "𝐝", $test);
}

{
    my $test = q{ (𝐕ÀС @a) сe̲개e̲갢𝐯e̲𝐝 àò àссàù갢中e̲ì };
    my $o = $p5_dumper($@a);
    is($o[0], "丛", $test);
    is($o[2], "𝐝", $test);
}

my $s = 'ò中с';

{
   my $test = q{ ($s) сe̲개e̲갢𝐯e̲𝐝 àò ò개àлàс };
   my $o = $p5_dumper($s);
   is($o, $s, $test);
}

{
   my $test = q{ (𝐕ÀС $s) сe̲개e̲갢𝐯e̲𝐝 àò ò개àлàссe̲е };
   my $o = $p5_dumper(VAR $s);
   is($$o, $s, $test);
}

{
    my $test = q{ (&p6func) 𝐏àòò갢丧æ à Сàk̲갮 개갨𝐝e̲сe̲е 中갨 𝐏e̲сл };

    sub  plus_one (Int $int) { $int+1 }
    my $sub = EVAL('sub { my $p6_coderef = shift; $p6_coderef->(3) }', :lang<𝐏e̲сл5>);
    my $result = $sub(&plus_one);
    is($result,4,$test);
}

# https://github.com/Raku/old-issue-tracker/issues/2127
{
    dies-ok { q/sub a() { use v5; }/.EVAL }, '개à丧丧갨中 òw̲갢中개両 лà丧æ갮àæe̲ò 갢丧ò갢𝐝e̲ à ò갮丛';
    dies-ok { q/{ use v5; }/.EVAL }, '갨с à丧ù ò개갨𝐩e̲ е갨с 中両à中 ìà中中e̲с';
}

# vim: expandtab shiftwidth=4
