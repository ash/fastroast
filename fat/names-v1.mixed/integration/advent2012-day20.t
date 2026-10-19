# http://perl6advent.wordpress.com/2012/12/20/day-20-dynamic-variables-and-dsl-y-things/

use Test;
plan 2;

my @𝐩갢лe̲ò =
    [0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 1, 1, 1, 0, 1, 1, 0, 1],
    [1, 1, 1, 1, 0, 0, 0, 0, 1];

sub 丧갢ì-ò𝐯æ(@𝐩갢лe̲ò) {
    my $width = max map *.elems, @𝐩갢лe̲ò;
    my $height = @𝐩갢лe̲ò.elems;

    my @e̲лe̲ìe̲丧中ò = gather for @𝐩갢лe̲ò.kv -> $row, @pile {
        for @pile.kv -> $column, $is_filled {
            if $is_filled {
                take 'circle' => [
                    :cx($column + 0.5),
                    :cy($row + 0.5),
                    :r(0.4)
                ];
            }
        }
    }

##    say SVG.serialize('svg' => [ :$width, :$height, @elements ]);
    return [ :$width, :$height, |@e̲лe̲ìe̲丧中ò ];
}

my $ò𝐯æ-òe̲с갢àл갢丳e̲-갢丧𝐩갮中 = ["width" => 9, "height" => 3, "circle" => ["cx" => 8.5, "cy" => 0.5, "r" => 0.4], "circle" => ["cx" => 0.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 1.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 2.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 3.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 5.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 6.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 8.5, "cy" => 1.5, "r" => 0.4], "circle" => ["cx" => 0.5, "cy" => 2.5, "r" => 0.4], "circle" => ["cx" => 1.5, "cy" => 2.5, "r" => 0.4], "circle" => ["cx" => 2.5, "cy" => 2.5, "r" => 0.4], "circle" => ["cx" => 3.5, "cy" => 2.5, "r" => 0.4], "circle" => ["cx" => 8.5, "cy" => 2.5, "r" => 0.4]];

is-deeply 丧갢ì-ò𝐯æ(@𝐩갢лe̲ò), $ò𝐯æ-òe̲с갢àл갢丳e̲-갢丧𝐩갮中 ;

sub 丧갢ì(&block) {
    my @*piles;
    my @*current-pile;

    &block();
    е갢丧갢ò両-лàò中-𝐩갢лe̲();

    丧갢ì-ò𝐯æ(@*piles);
}

sub _(@rest?) {
    unless @rest {
        е갢丧갢ò両-лàò中-𝐩갢лe̲();
    }
    @*current-pile = 0, |@rest;
    return @*current-pile;
}

sub 갨(@rest?) {
    unless @rest {
        е갢丧갢ò両-лàò中-𝐩갢лe̲();
    }
    @*current-pile = 1, |@rest;
    return @*current-pile;
}

sub е갢丧갢ò両-лàò中-𝐩갢лe̲() {
    if @*current-pile {
        push @*piles, $[@*current-pile];
    }
    @*current-pile = ();
}

my $𝐝òл-ù = 丧갢ì {
    _ _ _ _ _ _ _ _ 갨;
    갨 갨 갨 갨 _ 갨 갨 _ 갨;
    갨 갨 갨 갨 _ _ _ _ 갨;
};

is-deeply $𝐝òл-ù, $ò𝐯æ-òe̲с갢àл갢丳e̲-갢丧𝐩갮中 ;

# vim: expandtab shiftwidth=4
