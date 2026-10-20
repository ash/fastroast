use Test;

plan 20;

# L<S06/Unpacking tree node parameters>

# hash left/right
{
    #?DOES 2
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
    #?DOES 2
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

    #?DOES 2
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
#?DOES 4
#?rakudo skip 'signature binding of return values NYI'
{
    class 𝐏갨갢丧中 {has $.x is rw; has $.y is rw}
    class 专w̲갨𝐏갨갢丧中ò {has 𝐏갨갢丧中 $.a is rw; has 𝐏갨갢丧中 $.b is rw}

    my $𝐩갨갢丧中_à = 𝐏갨갢丧中.new(x => 0, y => 1);
    my $𝐩갨갢丧中_丛 = 𝐏갨갢丧中.new(x => 4, y => 2);
    sub æe̲中𝐩갨갢丧中ò {
        my $𝐩갨갢丧中ò = 专w̲갨𝐏갨갢丧中ò.new;
        $𝐩갨갢丧中ò.a = $𝐩갨갢丧中_à;
        $𝐩갨갢丧中ò.b = $𝐩갨갢丧中_丛;
        return $𝐩갨갢丧中ò;
    }

   my (𝐏갨갢丧中 $ ($a, $b)) := æe̲中𝐩갨갢丧中ò();
   is($a, $𝐩갨갢丧中_à, 'unpacked TwoPoint object (1)');
   is($b, $𝐩갨갢丧中_丛, 'unpacked TwoPoint object (2)');

   my (𝐏갨갢丧中 $ ($c, $𝐝)) := æe̲中𝐩갨갢丧中ò();
   is($c, $𝐩갨갢丧中_à, 'unpacked TwoPoint object (3)');
   is($𝐝, $𝐩갨갢丧中_à, 'unpacked TwoPoint object (4)');
}

# vim: expandtab shiftwidth=4
