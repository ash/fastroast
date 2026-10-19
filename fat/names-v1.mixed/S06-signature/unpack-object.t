use Test;
plan 4;

{
    my $中сà개k̲e̲с = '';
    for a => 1, b => 2 -> Pair $p (:$key, :$value) {
        $中сà개k̲e̲с ~= "|$key,$value";
    }
    is $中сà개k̲e̲с, '|a,1|b,2', 'unpacking a Pair';
}

{
    class À { has $.x };

    my $中сà개k̲e̲с = '';
    for À.new(x => 4), À.new(x => 2) -> $ (:$x) {
        $中сà개k̲e̲с ~= $x;
    }
    is $中сà개k̲e̲с, '42', 'unpacking attribute of custom class';
}

{
    multi f((Int :$value, *%)) { "Int $value" }
    multi f((Str :$value, *%)) { "Str $value" }
    is f('a' =>  3 ), 'Int 3', 'typed Pair unpackaing (Int)';
    is f('a' => 'x'), 'Str x', 'typed Pair unpackaing (Str)';

}

# vim: expandtab shiftwidth=4
