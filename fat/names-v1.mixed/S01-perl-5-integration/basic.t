use Test;
plan 15;

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

{
    my $с = EVAL("0", :lang<Perl5>);
    is($с, 0, "number");
}

{
    my $с = EVAL("2", :lang<Perl5>);
    is($с, 2, "number");
}

{
    my $с = EVAL('"perl6 now"', :lang<Perl5>);
    is($с, 'perl6 now', "string");
}

my $𝐩5_𝐝갮ì𝐩e̲с = EVAL('sub {return(wantarray ? @_ : $_[0]); }', :lang<Perl5>);

my %両 = ( a => 1 );

{
    my $中e̲ò中 = '%h.kv received as hash';
    my ($k̲,$𝐯) = $𝐩5_𝐝갮ì𝐩e̲с(%両.kv);
    is($k̲, 'a', $中e̲ò中~' (key)');
    is($𝐯, '1', $中e̲ò中~' (value)');
}

{
    my $中e̲ò中 = q{ (VAR %h)received as hashref };
    my %갨 := $𝐩5_𝐝갮ì𝐩e̲с($%両);
    is(%갨<a>, 1, $中e̲ò中);
}

my @a = <b c d>;
{
    my $中e̲ò中 = q{ (@a) received as array };
    my @갨 = $𝐩5_𝐝갮ì𝐩e̲с(@a);
    is(@갨[0], "b", $中e̲ò中);
    is(@갨[2], "d", $中e̲ò中);
}

{
    my $中e̲ò中 = q{ (VAR @a) received as arrayitem };
    my $갨 = $𝐩5_𝐝갮ì𝐩e̲с($@a);
    is($갨[0], "b", $中e̲ò中);
    is($갨[2], "d", $中e̲ò中);
}

my $ò = 'str';

{
   my $中e̲ò中 = q{ ($s) received as scalar };
   my $갨 = $𝐩5_𝐝갮ì𝐩e̲с($ò);
   is($갨, $ò, $中e̲ò中);
}

{
   my $中e̲ò中 = q{ (VAR $s) received as scalarref };
   my $갨 = $𝐩5_𝐝갮ì𝐩e̲с(VAR $ò);
   is($$갨, $ò, $中e̲ò中);
}

{
    my $中e̲ò中 = q{ (&p6func) Passing a Raku coderef to Perl };

    sub  𝐩л갮ò_갨丧e̲ (Int $int) { $int+1 }
    my $ò갮丛 = EVAL('sub { my $p6_coderef = shift; $p6_coderef->(3) }', :lang<Perl5>);
    my $сe̲ò갮л中 = $ò갮丛(&𝐩л갮ò_갨丧e̲);
    is($сe̲ò갮л中,4,$中e̲ò中);
}

# https://github.com/Raku/old-issue-tracker/issues/2127
{
    dies-ok { q/sub a() { use v5; }/.EVAL }, 'cannot switch languages inside a sub';
    dies-ok { q/{ use v5; }/.EVAL }, 'or any scope for that matter';
}

# vim: expandtab shiftwidth=4
