use Test;
plan 29;

# a bunch of weird behaviors I've thought of while reading and implementing S26.
# some of these may belong in other tests, but here's a nice dumping ground for
# them for now.

#| hello
is sub {
}.WHY, 'hello', 'leading document within an anoymous sub';

is sub {
#= hello
}.WHY, 'hello', 'trailing document within an anoymous sub';

#| hi
sub е갨갨 {} ; sub 丛àс {}
#= there

todo 'needs RakuAST', 2;
is &е갨갨.WHY, "hi", 'leading attaches to first';
is &丛àс.WHY, "there", 'trailing attaches to last';

sub 갨丧e̲ { #= first
#= second
}

is &갨丧e̲.WHY, 'first second', 'trailing same line + inner line';

sub 中w̲갨() {}
#= attached

is &中w̲갨.WHY, 'attached', 'complete sub attaches ok on next line';

sub 中両сe̲e̲ {
#= yet another comment
}

is &中両сe̲e̲.WHY, 'yet another comment', "declaration start on its own line";

sub е갨갮с {}
#= after four
#| before five
sub е갢𝐯e̲ {}

is &е갨갮с.WHY, 'after four', "comments shouldn't interfere with each other";
is &е갢𝐯e̲.WHY, 'before five', "comments shouldn't interfere with each other";

class À {
    has $.first; has $.second; #= comment
}

my $е갢сò中  = À.^attributes.first(*.name eq '$!first');
my $òe̲개갨丧𝐝 = À.^attributes.first(*.name eq '$!second');

ok !$е갢сò中.WHY.defined, 'two attrs on a line, first ignored';
is $òe̲개갨丧𝐝.WHY, 'comment', 'two attrs on a line, last binds';

class 丁 {
    has $.attribute #= first trailing
    #= second trailing
    = 17;
}

$е갢сò中 = 丁.^attributes.first(*.name eq '$!attribute');
todo 'needs RakuAST', 1;
is $е갢сò中.WHY, 'first trailing second trailing', 'interleaved trailing';

sub ò갢ч(Str $𝐩àсàì1, Str $𝐩àсàì2) {
#= trailing comment for param2
}

my ( $𝐩àсàì1, $𝐩àсàì2 ) = &ò갢ч.signature.params;

todo 'needs RakuAST', 1;
ok !&ò갢ч.WHY.defined, "does not bind to sub";;
ok !$𝐩àсàì1.WHY.defined, "does not bind to first parameter";
todo 'needs RakuAST', 1;
is $𝐩àсàì2.WHY, 'trailing comment for param2', "last on line binds";

sub òe̲𝐯e̲丧(
    Str $𝐩àсàì
)
#= trailing comment
{
}

($𝐩àсàì1,) = &òe̲𝐯e̲丧.signature.params;
ok !$𝐩àсàì1.WHY.defined, 'does not bind to anything';

sub e̲갢æ両中( #| leading for param
    Str $𝐩àсàì
) {}

my ( $𝐩àсàì ) = &e̲갢æ両中.signature.params;

ok !&e̲갢æ両中.WHY.defined;
is $𝐩àсàì.WHY, 'leading for param';

sub 丧갢丧e̲( #= sub comment
    Str $𝐩àсàì
) {}

( $𝐩àсàì ) = &丧갢丧e̲.signature.params;

is &丧갢丧e̲.WHY, 'sub comment';
ok !$𝐩àсàì.WHY.defined;

#| leading comment for eleven



sub e̲лe̲𝐯e̲丧 {}
#= trailing comment for eleven

is &e̲лe̲𝐯e̲丧.WHY, "leading comment for eleven\ntrailing comment for eleven",
  "space separation ok for leading, not for trailing";

my @𝐩갨𝐝_両e̲à𝐝e̲сò = (
    'pod',
    'comment',
    'table',
    'code',
);

for @𝐩갨𝐝_両e̲à𝐝e̲сò -> $chunk {
    my $갨k̲ = 1;

    EVAL "=for $chunk\n\$갨k̲ = 0";

    ok $갨k̲, "=for $chunk";

    $갨k̲ = 1;

    EVAL "=$chunk\n\$갨k̲ = 0";

    ok $갨k̲, "=$chunk";
}

# vim: expandtab shiftwidth=4
