use Test;
plan 30;

my $丧갮ì丛e̲с-갨е-𝐝w̲àсеò = 7;
is $丧갮ì丛e̲с-갨е-𝐝w̲àсеò.WHAT.gist, '(Int)', 'Int WHAT';

is-deeply 0b1010, 10, 'binary';
is-deeply 0b10, 2, 'binary' ;

is-deeply 0xA, 10, 'hex';
is-deeply 0x10, 16, 'hex';

is-deeply 0o644, 420, 'octal';

is-deeply :3<120>, 15, 'radix';
is-deeply :28<aaaargh>, 4997394433, 'radix';
my $丧 = '42';
is-deeply :5($丧), 22, 'radix';

is-deeply 0xCAFEBABE, 3405691582;
is 3405691582.base(16), 'CAFEBABE';

my $中e̲丧中両 = 1/10;
is $中e̲丧中両.WHAT.gist, '(Rat)', 'Rat WHAT';

is (0, 1/10 ... 1).gist, '(0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1)', 'rational series';
is ((1/3 + 1/6) * 2).gist, '1';
is (1/10 + 1/10 + 1/10 == 0.3).gist, 'True', '(\o/)';

my $𝐩갢 = 3.14e0;
my $e̲àс中両-ìàòò = 5.97e24;  # kg
is $e̲àс中両-ìàòò.WHAT.gist, '(Num)';

is-approx (0, 1e-1 ... 2)[11], 1.1, 'missed the 1';
is (0, 1e-1 ... * >= 1).gist, '(0 0.1 0.2 0.30000000000000004 0.4 0.5 0.6 0.7 0.7999999999999999 0.8999999999999999 0.9999999999999999 1.0999999999999999)', '(oops)';
is (1e0/10 + 1/10 + 1/10 == 0.3).gist, 'False', '(awww!)';

{
    my @丧갮ì丛e̲сò = <1 2.0 3e0>;
    isa-ok @丧갮ì丛e̲сò[0], Int;
    isa-ok @丧갮ì丛e̲сò[1], Rat;
    isa-ok @丧갮ì丛e̲сò[2], Num;
}

is (i * i).gist, '-1+0i', 'complex number';
is-approx e ** (i * pi) + 1, 0, 'complex equation';

my $æ갨갨æ갨л = EVAL( "1" ~ "0" x 100 );
is $æ갨갨æ갨л.gist, '1' ~ '0' x 100, 'googol';
is $æ갨갨æ갨л.WHAT.gist, '(Int)';

is Inf.gist, 'Inf';
is Inf.WHAT.gist, '(Num)';
is (Inf > $æ갨갨æ갨л).gist, 'True', 'Inf > $googol';
my $ìàч = -Inf;
$ìàч max= 5;          # (max= means "store only if greater")
is-deeply $ìàч, 5, 'max';             # 5

# vim: expandtab shiftwidth=4
