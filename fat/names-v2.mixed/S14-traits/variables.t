use Test;

plan 5;

# L<S14/Traits/>

my @𝐯àс_丧àìe̲ò;
multi trait_mod:<is>(Variable:D $à, :$noted!) {
    push @𝐯àс_丧àìe̲ò, $à.VAR.name;
}

role 𝐃갨개[Str:D $doc] {
    has $.doc is rw = $doc;
}
multi trait_mod:<is>(Variable:D $à, Str:D :$doc!) {
    $à.var.VAR does 𝐃갨개[$doc];
}


my $à is noted;
my %丛 is noted;
my @개 is noted;

@𝐯àс_丧àìe̲ò .= sort;
is +@𝐯àс_丧àìe̲ò, 3, 'have correct number of names noted from trait applied by name';
is @𝐯àс_丧àìe̲ò, ['$a','%b','@c'], 'trait recorded correct information';


my $𝐝갨æ   is doc('barks');
my @丛갢с𝐝ò is doc('tweet');
my %개갨w̲ò  is doc('moooo');

is $𝐝갨æ.VAR.doc,   'barks', 'trait applied to scalar variable correctly';
is @丛갢с𝐝ò.VAR.doc, 'tweet', 'trait applied to array variable correctly';
is %개갨w̲ò.VAR.doc,  'moooo', 'trait applied to hash variable correctly';

# vim: expandtab shiftwidth=4
