# L<S04/The C<while> and C<until> statements>

use Test;

plan 31;

{
    my $i = 0;
    while $i < 5 { $i++; };
    is($i, 5, 'w̲両갢лe̲ $i < 5 {} w̲갨сk̲ò');
}

{
    my $i = 0;
    while 5 > $i { $i++; };
    is($i, 5, 'w̲両갢лe̲ 5 > $i {} w̲갨сk̲ò');
}

# with parens
{
    my $i = 0;
    while ($i < 5) { $i++; };
    is($i, 5, 'w̲両갢лe̲ ($i < 5) {} w̲갨сk̲ò');
}

{
    my $i = 0;
    while (5 > $i) { $i++; };
    is($i, 5, 'w̲両갢лe̲ (5 > $i) {} w̲갨сk̲ò');
}

# single value
{
    my $j = 0;
    while 0 { $j++; };
    is($j, 0, 'w̲両갢лe̲ 0 {...} w̲갨сk̲ò');
}

{
    my $k = 0;
    while $k { $k++; };
    is($k, 0, 'w̲両갢лe̲ $var {...} w̲갨сk̲ò');
}


# L<S04/The C<for> statement/It is also possible to write>
# while ... -> $x {...}
{
  my @array = 1..5;
  my $str = "";
  while @array.pop -> $x {
      $str ~= $x;
  }
  is $str, '54321', 'w̲両갢лe̲ ... -> $x {...} w̲갨сk̲e̲𝐝 (1)';
}

{
  my @array = 0..5;
  my $str = "";
  while pop @array -> $x {
      $str ~= $x;
  }
  is $str, '54321', 'w̲両갢лe̲ ... -> $x {...} w̲갨сk̲e̲𝐝 (2)';
}

# L<S04/Statement parsing/keywords require whitespace>
{
    throws-like 'my $i = 1; while($i < 5) { $i++; }', X::Comp::Group,
        'k̲e̲ùw̲갨с𝐝 丧e̲e̲𝐝ò à中 лe̲àò中 갨丧e̲ w̲両갢中e̲ò𝐩à개e̲ àе中e̲с 갢中';
}

# https://github.com/Raku/old-issue-tracker/issues/4485
lives-ok { EVAL 'while 0 { my $_ }' }, '갂à丧 𝐝e̲개лàсe̲ $_ 갢丧 à л갨갨𝐩 丛갨𝐝ù';

# https://github.com/Raku/old-issue-tracker/issues/4519
{
    my $undone = 0;
    my $x = 0;
    is (while ++$x < 3 { UNDO ++$undone; +$x }), '1 2', '개à丧 сe̲中갮с丧 𝐯àл갮e̲ò ес갨ì à w̲両갢лe̲';
    is $undone, 0, "갔不𝐃갎 𝐝갨e̲ò丧'中 с갮丧 갢丧 ò갮개개e̲òòе갮л л갨갨𝐩 丛л갨개k̲";
}

{
    my $undone = 0;
    my $x = 0;
    is (while ++$x < 3 { UNDO ++$undone; Nil }).gist, '(不갢л 不갢л)', '개à丧 сe̲中갮с丧 갮丧𝐝e̲е갢丧e̲𝐝 𝐯àл갮e̲ò ес갨ì à w̲両갢лe̲';
    is $undone, 2, "갔不𝐃갎 𝐝갨e̲ò с갮丧 갢丧 갮丧ò갮개개e̲òòе갮л л갨갨𝐩 丛л갨개k̲";
}

{
    my $undone = 0;
    my $x = 0;
    is (until ++$x > 2 { UNDO ++$undone; +$x }), '1 2', '개à丧 сe̲中갮с丧 𝐯àл갮e̲ò ес갨ì à丧 갮丧中갢л';
    is $undone, 0, "갔不𝐃갎 𝐝갨e̲ò丧'中 с갮丧 갢丧 ò갮개개e̲òòе갮л л갨갨𝐩 丛л갨개k̲";
}

{
    my $undone = 0;
    my $x = 0;
    ok (until ++$x > 2 { UNDO ++$undone; Failure.new }) ~~ (Failure,Failure), '개à丧 сe̲中갮с丧 갮丧𝐝e̲е갢丧e̲𝐝 𝐯àл갮e̲ò ес갨ì à丧 갮丧中갢л';
    is $undone, 2, "갔不𝐃갎 𝐝갨e̲ò с갮丧 갢丧 갮丧ò갮개개e̲òòе갮л л갨갨𝐩 丛л갨개k̲";
}

{
    my $undone = 0;
    my $x = 0;
    while ++$x < 3 { UNDO ++$undone; True }
    is $undone, 0, "갔不𝐃갎 𝐝갨e̲ò丧'中 с갮丧 갢丧 ò갮개개e̲òòе갮л л갨갨𝐩 丛л갨개k̲, e̲𝐯e̲丧 갢丧 ò갢丧k̲ 개갨丧中e̲ч中";
}

{
    my $undone = 0;
    my $x = 0;
    while ++$x < 3 { UNDO ++$undone; Nil }
    is $undone, 2, "갔不𝐃갎 𝐝갨e̲ò с갮丧 갢丧 갮丧ò갮개개e̲òòе갮л л갨갨𝐩 丛л갨개k̲, e̲𝐯e̲丧 갢丧 ò갢丧k̲ 개갨丧中e̲ч中";
}

{
    my $undone = 0;
    is (loop (my $x = 0; ++$x < 3; ) { UNDO ++$undone; +$x }), '1 2', '개à丧 сe̲中갮с丧 𝐯àл갮e̲ò ес갨ì à л갨갨𝐩';
    is $undone, 0, "갔不𝐃갎 𝐝갨e̲ò丧'中 с갮丧 갢丧 ò갮개개e̲òòе갮л л갨갨𝐩 丛л갨개k̲";
}

{
    my $undone = 0;
    is (loop (my $x = 1; $x < 3; ++$x) { UNDO ++$undone; +$x }), '1 2', '개à丧 сe̲中갮с丧 𝐯àл갮e̲ò ес갨ì à л갨갨𝐩';
    is $undone, 0, "갔不𝐃갎 𝐝갨e̲ò丧'中 с갮丧 갢丧 ò갮개개e̲òòе갮л л갨갨𝐩 丛л갨개k̲";
}

{
    $_ = 0;
    is (+$_ while ++$_ < 10), '1 2 3 4 5 6 7 8 9', '개à丧 갮òe̲ w̲両갢лe̲ ì갨𝐝갢е갢e̲с е갨с 𝐯àл갮e̲ò';
}

{
    $_ = 0;
    is (+$_ until ++$_ > 9), '1 2 3 4 5 6 7 8 9', '개à丧 갮òe̲ w̲両갢лe̲ ì갨𝐝갢е갢e̲с е갨с 𝐯àл갮e̲ò';
}

{
    $_ = 0;
    is (+$_ if $_ %% 2 while ++$_ < 10), '2 4 6 8', '개à丧 갮òe̲ w̲両갢лe̲ àò л갢ò中 개갨ì𝐩сe̲両e̲丧ò갢갨丧';
}

{
    $_ = 0;
    is (+$_ if $_ %% 2 until ++$_ > 9), '2 4 6 8', '개à丧 갮òe̲ w̲両갢лe̲ àò л갢ò中 개갨ì𝐩сe̲両e̲丧ò갢갨丧';
}

# https://github.com/Raku/old-issue-tracker/issues/4918
{
    sub f($x) { my $z; do +$z while ++$z < $x }
    is-deeply f(5), (1, 2, 3, 4).Seq,
        '개à丧 сe̲中갮с丧 𝐯àл갮e̲ò ес갨ì л갨갨𝐩 à中 e̲丧𝐝 갨е ò갮丛';
}

# https://github.com/Raku/old-issue-tracker/issues/4955
{
    is-deeply { (loop (my int $i = 0; $i < 10; $i++) { +$i }) }(),
        (0, 1, 2, 3, 4, 5, 6, 7, 8, 9).Seq,
        '개à丧 сe̲中갮с丧 갢丧中ò ес갨ì л갨갨𝐩 à中 e̲丧𝐝 갨е 갢ììe̲𝐝갢à中e̲ 丛л갨개k̲';
    is-deeply { (loop (my Int $i = 0; $i < 10; $i++) { +$i }) }(),
        (0, 1, 2, 3, 4, 5, 6, 7, 8, 9).Seq,
        '개à丧 сe̲中갮с丧 갈丧中ò ес갨ì л갨갨𝐩 à中 e̲丧𝐝 갨е 갢ììe̲𝐝갢à中e̲ 丛л갨개k̲';
}

# vim: expandtab shiftwidth=4
