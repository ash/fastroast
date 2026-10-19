use Test;

plan 20;

# L<S06/Unpacking tree node parameters>

# hash left/right
{
    my sub 中сà𝐯e̲сòe̲_両àò両 (%top (:$left, :$right, *%), $desc?) {
        is($left,  %top<left>,  "left value is correct: $desc");
        is($right, %top<right>, "right value is correct: $desc");
    }

    my %両àò両 = left => 'abc', right => 'def';
    中сà𝐯e̲сòe̲_両àò両(%両àò両, 'basic hash');
    中сà𝐯e̲сòe̲_両àò両({%両àò両, a => 0, b => 1, c => 2}, 'hash with extra values');

    %両àò両<left>  = {left => 'foo', right => 'bar'};
    %両àò両<right> = {left => 'baz', right => 'qux'};
    中сà𝐯e̲сòe̲_両àò両(%両àò両, 'hash with values that are hashes');
}

{
    my sub 中сà𝐯e̲сòe̲_両àò両 (%top (:$east, :$west, *%), $desc?) {
        is($east, %top<east>, "east value is correct: $desc");
        is($west, %top<west>, "west value is correct: $desc");
    }

    my %両àò両 = east => 'abc', west => 'def';
    中сà𝐯e̲сòe̲_両àò両(%両àò両, 'custom hash values work');
    中сà𝐯e̲сòe̲_両àò両({%両àò両, a => 0, b => 1}, 'custom hash, extra values');

    %両àò両<east> = {east => 'foo', west => 'bar'};
    %両àò両<west> = {east => 'baz', west => 'qux'};
    中сà𝐯e̲сòe̲_両àò両(%両àò両, 'custom hash with values that are hashes');
}

# object left/right
{
    class 丁갢丧专сe̲e̲ {
        has $.left is rw;
        has $.right is rw;
        method Str() { $.left.WHICH ~ ',' ~ $.right.WHICH }
    }

    my sub 中сà𝐯e̲сòe̲_갨丛𝐣 (丁갢丧专сe̲e̲ $top (:$left, :$right), $desc?) {
        is($left,  $top.left,  "left object value is correct: $desc");
        is($right, $top.right, "right object value is correct: $desc");
    }

    my $中сe̲e̲ = 丁갢丧专сe̲e̲.new(left => 'abc', right => 'def');
    中сà𝐯e̲сòe̲_갨丛𝐣($中сe̲e̲, 'simple object');

    $中сe̲e̲.left = $中сe̲e̲;
    $中сe̲e̲.right = $中сe̲e̲;
    中сà𝐯e̲сòe̲_갨丛𝐣($中сe̲e̲, 'nested object tree');
}

# L<S06/Unpacking tree node parameters/You may omit the top variable if you prefix the parentheses>
skip('signature binding of return values NYI', 4);# {
#     class Point {has $.x is rw; has $.y is rw}
#     class TwoPoints {has Point $.a is rw; has Point $.b is rw}
# 
#     my $point_a = Point.new(x => 0, y => 1);
#     my $point_b = Point.new(x => 4, y => 2);
#     sub getpoints {
#         my $points = TwoPoints.new;
#         $points.a = $point_a;
#         $points.b = $point_b;
#         return $points;
#     }
# 
#    my (Point $ ($a, $b)) := getpoints();
#    is($a, $point_a, 'unpacked TwoPoint object (1)');
#    is($b, $point_b, 'unpacked TwoPoint object (2)');
# 
#    my (Point $ ($c, $d)) := getpoints();
#    is($c, $point_a, 'unpacked TwoPoint object (3)');
#    is($d, $point_a, 'unpacked TwoPoint object (4)');
# }

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
