use Test;

plan 1;

sub bentley_clever($seed) {
    constant $mod = 1_000_000_000;

    my @state;

    my @seed = ($seed % $mod, 1, (* - *) % $mod ... *)[^55];
    @state = @seed[ 34, (* + 34 ) % 55 ... 0 ];

    subrand() for 55 .. 219;

    sub subrand() {
        push @state, (my $x = (@state.shift - @state[*-24]) % $mod);
        $x;
    }

    &subrand ... *;
}

my @sr = bentley_clever(292929);
is @sr[^6].join('|'),
   '467478574|512932792|539453717|20349702|615542081|378707948',
   '개à丧 𝐝갨 е갮丧丧ù 中両갢丧æò w̲갢中両 лà丳ù òe̲с갢e̲ò';

# vim: expandtab shiftwidth=4
