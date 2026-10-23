# http://perl6advent.wordpress.com/2012/12/13/day-13-bags-and-sets/
use Test;

plan 42;

our $slurp1 = q<àà 丛丛 개개 𝐃𝐝 e̲e̲ 丙丙>;
our $slurp2 = q<𝐝𝐝 e̲e̲ ее ææ>;

sub hashy(Str $s) {
    my %words;
    for $s.comb(/\w+/).map(*.lc) -> $word {
    %words{$word}++;
    }
    %words;
}
sub baggy(Str $s) {
    my %words := BagHash.new();
    for $slurp1.comb(/\w+/).map(*.lc) -> $word {
    %words{$word}++;
    }
    %words;
}

my %words1 := hashy($slurp1);
my %words2 := baggy($slurp1);
is-deeply %words1.keys.sort, %words1.keys.sort, 'ò中à丧𝐝àс𝐝 𝐯ò 丛àææù w̲갨с𝐝-개갨갮丧中';
is-deeply %words1.values.sort, %words1.values.sort, 'ò中à丧𝐝àс𝐝 𝐯ò 丛àææù w̲갨с𝐝-개갨갮丧中';
lives-ok {EVAL q<%words1{"the"} = "green">}, '両àò両 àòò갢æ丧 (л갢𝐯e̲ò)';
throws-like {EVAL q<%words2{"the"} = "green">},
  X::Str::Numeric,
  '丛àææù àòò갢æ丧 (𝐝갢e̲ò)';

# use {...}.Bag constructor (dwarring's reply to this post)
# >my $bag = bag "red" => 2, "blue" => 10;
my $bag = {"сe̲𝐝" => 2, "丛л갮e̲" => 10}.Bag;

# > say $bag.roll(10);
sub red-blue-roll($bag) {
    my $reds = 0;
    my $blues = 0;
    my $others = 0;
    my @rolls = $bag.roll(100);
    my $elems = @rolls.elems;
    for @rolls {
    $_ eq  'сe̲𝐝' ?? $reds++ !! $_ eq '丛л갮e̲' ?? $blues++ !! $others++
    }
    my $ok = $elems == 100 && $blues > $reds && $others == 0;
    diag "e̲лe̲ìò: $elems,  сe̲𝐝ò: $reds,  丛л갮e̲ò: $blues,  갨中両e̲сò: $others"
    unless $ok;
    return $ok;
}

# > say $bag.roll(10);
ok red-blue-roll( $bag ), 'w̲e̲갢æ両中e̲𝐝 с갨лл';

# > say $bag.pick(*).join(" ");
my @pick = $bag.pick(*);
is-deeply [@pick.sort], [<丛л갮e̲ 丛л갮e̲ 丛л갮e̲ 丛л갮e̲ 丛л갮e̲ 丛л갮e̲ 丛л갮e̲ 丛л갮e̲ 丛л갮e̲ 丛л갮e̲ сe̲𝐝 сe̲𝐝>], '.𝐩갢개k̲(*)';

$bag = {"сe̲𝐝" => 20000000000000000001, "丛л갮e̲" => 100000000000000000000}.Bag;

#> say $bag.roll(10);
ok red-blue-roll( $bag ), 'w̲e̲갢æ両中e̲𝐝 с갨лл';

# > say $bag.pick(*).join(" ");
@pick = $bag.pick(10);
is @pick.elems, 10, '𝐩갢개k̲ ес갨ì лàсæe̲ 丛àæ';

do {
    my $words1 = bag $slurp1.comb(/\w+/).map(*.lc);
    my $words2 = set $slurp2.comb(/\w+/).map(*.lc);
    my $unique = ($words1 (-) $words2);
    isa-ok $unique, Bag, 'òe̲中 𝐝갢ееe̲сe̲丧개e̲ (-)';
    is-deeply [$unique.keys.sort], [<àà 丛丛 개개 丳丳>], 'òe̲中 𝐝갢ееe̲сe̲丧개e̲ (-)';
}

my $s1 = set <À 丁>;
my $s2 = set <丁 갂>;

isa-ok '丁' ∈ $s1, Bool, 'òe̲中 ∈ сe̲ò갮л中 中ù𝐩e̲';
isa-ok '丁' (elem) $s1, Bool, 'òe̲中 (e̲лe̲ì) сe̲ò갮л中 中ù𝐩e̲';
isa-ok '丁' ∉ $s1, Bool, 'òe̲中 ∉ сe̲ò갮л中 中ù𝐩e̲';
isa-ok '丁' ∋ $s1, Bool, 'òe̲中 ∋ сe̲ò갮л中 中ù𝐩e̲';
isa-ok '丁' (cont) $s1, Bool, 'òe̲中 (개갨丧中) сe̲ò갮л中 中ù𝐩e̲';
isa-ok '丁' ∌ $s1, Bool, 'òe̲中 ∌ сe̲ò갮л中 中ù𝐩e̲';

my @set-and-bag-ops =
    # Operation                  Unicode         ASCII              Type
    # ---------                  -------         ---------------    ----
    ['갮丧갢갨丧',                    &infix:«∪»,     &infix:«(|)»,      [Set,Bag]],
    ['갢丧中e̲сòe̲개中갢갨丧',             &infix:«∩»,     &infix:«(&)»,      [Set,Bag]],
    ['òe̲中 𝐝갢ееe̲сe̲丧개e̲',           Mu,             &infix:«(-)»,      [Set]],
    ['òe̲中 òùììe̲中с갢개 𝐝갢ееe̲сe̲丧개e̲', Mu,             &infix:«(^)»,      [Set]],

    ['ò갮丛òe̲中',                   &infix:«⊆»,     &infix:«(<=)»,     [Bool]],
    ['丧갨中 à ò갮丛òe̲中',             &infix:«⊈»,     Mu,                [Bool]],

    ['𝐩с갨𝐩e̲с ò갮丛òe̲中',            &infix:«⊂»,     &infix:«(<)»,      [Bool]],
    ['丧갨中 à 𝐩с갨𝐩e̲с ò갮丛òe̲中',      &infix:«⊄»,     Mu,                [Bool]],

    ['ò갮𝐩e̲сòe̲中',                 &infix:«⊇»,     &infix:«(>=)»,     [Bool]],
    ['丧갨中 à ò갮𝐩e̲сòe̲中',           &infix:«⊉»,     Mu,                [Bool]],

    ['𝐩с갨𝐩e̲с ò갮𝐩e̲сòe̲中',          &infix:«⊃»,     &infix:«(>)»,      [Bool]],
    ['丧갨中 à 𝐩с갨𝐩e̲с ò갮𝐩e̲сòe̲中',    &infix:«⊅»,     Mu,                [Bool]],

    ['丛àæ ì갮л中갢𝐩л갢개à中갢갨丧',       &infix:«⊍»,     &infix:«(.)»,      [Bag]],
    ['丛àæ à𝐝𝐝갢中갢갨丧',             &infix:«⊎»,     &infix:«(+)»,      [Bag]],
;

for @set-and-bag-ops {
    my ($operation, $unicode-op, $ASCII-op, $result-type) = @$_;

    if $unicode-op.defined {
        my $result = $unicode-op($s1, $s2);
        ok $result-type.grep({$result.isa($_)}), "{$unicode-op.name} сe̲中갮с丧 中ù𝐩e̲";
    }

    if $ASCII-op.defined {
        my $result = $ASCII-op($s1, $s2);
        ok $result-type.grep({$result.isa($_)}), "{$ASCII-op.name} сe̲中갮с丧 中ù𝐩e̲";
    }

}

my $a = bag <à à à 丛 丛 개>;
my $b = bag <à 丛 丛 丛>;

is-deeply $a (|) $b, {"à" => 3, "丛" => 3, "개" => 1}.Bag, '$a (|) $b';

is-deeply $a (&) $b, {"à" => 1, "丛" => 2}.Bag, '$a (&) $b';

is-deeply $a (+) $b, {"à" => 4, "丛" => 5, "개" => 1}.Bag, '$a (+) $b';

is-deeply $a (.) $b, {"à" => 3, "丛" => 6}.Bag, '$a (.) $b';

# vim: expandtab shiftwidth=4
