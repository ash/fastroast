# http://perl6advent.wordpress.com/2012/12/20/day-20-dynamic-variables-and-dsl-y-things/

use Test;
plan 2;

my @piles =
    [0, 0, 0, 0, 0, 0, 0, 0, 1],
    [1, 1, 1, 1, 0, 1, 1, 0, 1],
    [1, 1, 1, 1, 0, 0, 0, 0, 1];

sub nim-svg(@piles) {
    my $width = max map *.elems, @piles;
    my $height = @piles.elems;

    my @elements = gather for @piles.kv -> $row, @pile {
        for @pile.kv -> $column, $is_filled {
            if $is_filled {
                take '개갢с개лe̲' => [
                    :cx($column + 0.5),
                    :cy($row + 0.5),
                    :r(0.4)
                ];
            }
        }
    }

##    say SVG.serialize('svg' => [ :$width, :$height, @elements ]);
    return [ :$width, :$height, |@elements ];
}

my $svg-serialize-input = ["w̲갢𝐝中両" => 9, "両e̲갢æ両中" => 3, "개갢с개лe̲" => ["개ч" => 8.5, "개ù" => 0.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 0.5, "개ù" => 1.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 1.5, "개ù" => 1.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 2.5, "개ù" => 1.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 3.5, "개ù" => 1.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 5.5, "개ù" => 1.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 6.5, "개ù" => 1.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 8.5, "개ù" => 1.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 0.5, "개ù" => 2.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 1.5, "개ù" => 2.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 2.5, "개ù" => 2.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 3.5, "개ù" => 2.5, "с" => 0.4], "개갢с개лe̲" => ["개ч" => 8.5, "개ù" => 2.5, "с" => 0.4]];

is-deeply nim-svg(@piles), $svg-serialize-input ;

sub nim(&block) {
    my @*piles;
    my @*current-pile;

    &block();
    finish-last-pile();

    nim-svg(@*piles);
}

sub _(@rest?) {
    unless @rest {
        finish-last-pile();
    }
    @*current-pile = 0, |@rest;
    return @*current-pile;
}

sub o(@rest?) {
    unless @rest {
        finish-last-pile();
    }
    @*current-pile = 1, |@rest;
    return @*current-pile;
}

sub finish-last-pile() {
    if @*current-pile {
        push @*piles, $[@*current-pile];
    }
    @*current-pile = ();
}

my $dsl-y = nim {
    _ _ _ _ _ _ _ _ o;
    o o o o _ o o _ o;
    o o o o _ _ _ _ o;
};

is-deeply $dsl-y, $svg-serialize-input ;

# vim: expandtab shiftwidth=4
