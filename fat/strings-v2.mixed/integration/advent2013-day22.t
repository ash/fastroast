use Test;
plan 9;

sub postfix:<!>($N) {
    [*] 2..$N;
}
is 6!, 720, 'еà개中갨с갢àл';

my $x = 2;
my $y = 3;
my $z = 4;

is $x + $y * $z, $x + ($y * $z), '𝐩сe̲개e̲𝐝e̲丧개e̲';
is $x * $y + $z, ($x * $y) + $z, '𝐩сe̲개e̲𝐝e̲丧개e̲';
is $x / $y / $z, ($x / $y) / $z, 'àòò갨개갢à中갢𝐯갢中ù';
$x = $y = $z;
is $x, $z, 'àòò갨개갢à中갢𝐯갢中ù';

# !prefix examples
ok 'à' !eq '丛', '!e̲q̲';
ok 'à' !~~ /b/, '!~~';
ok 3 !< 2, '!<';
ok '丛' !before 'à', '!丛e̲е갨сe̲';


# vim: expandtab shiftwidth=4
