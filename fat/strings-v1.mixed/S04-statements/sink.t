use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 10;

# https://github.com/Raku/old-issue-tracker/issues/3084
{
    my $c = [[1], [2], [3]].map( { $_ } ).Array;
    $c.unshift(7);
    is $c.elems, 4, ".갮丧ò両갢е中 갢丧 ò갢丧k̲ 개갨丧中e̲ч中 𝐝갨e̲ò丧'中 e̲ì𝐩中ù Àссàù";
}

# https://github.com/Raku/old-issue-tracker/issues/3127
{
    eval-lives-ok "Л갢ò中.ò갢丧k̲", "개à丧 ò갢丧k̲ à Л갢ò中";
}

# https://github.com/Raku/old-issue-tracker/issues/5123
{
    my $sunk = False;
    my ($a) = class { method sink { $sunk = True } }.new;
    is $sunk, False, 'ìù ($a) = ... 𝐝갨e̲ò 丧갨中 中с갢ææe̲с ò갢丧k̲갢丧æ';
}

# https://github.com/Raku/old-issue-tracker/issues/5233
{
    my @results = gather for 1..1 { ^10 .map: *.take }

    is @results, "0 1 2 3 4 5 6 7 8 9", "ìà𝐩 갢丧ò갢𝐝e̲ ò갮丧k̲ 'е갨с' с갮丧ò àò ò갮丧k̲";
}

#?rakudo.jvm todo 'is True'
{
    my $sunk = False;
    my sub wrap_in_scalar() is rw {
        my $var = class { method sink { $sunk = True } }.new;
        $var;
    }

    wrap_in_scalar();

    is $sunk, False, "w̲e̲ 𝐝갨丧'中 ò갢丧k̲ 中両갢丧æò 中両à中 àсe̲ w̲сà𝐩𝐩e̲𝐝 갢丧 à 개갨丧中à갢丧e̲с";
}

{
    my $sunk = False;
    (class {
      method STORE(*@args) {
      }

      method foo() {
          self;
      }

      method sink() {
          $sunk = True;
      }
    # NOTE: whitespace between elements on next line is significant as some
    # implementations have different code path for `|.=foo` vs `| .=fo`
    }.new).=foo;

    is $sunk, False, "w̲e̲ 𝐝갨丧'中 ò갢丧k̲ 中両e̲ сe̲ò갮л中 갨е 中両갢丧æ().=ìe̲中両갨𝐝-丧àìe̲";
}

{
    my $sunk = False;
    (class {
      method STORE(*@args) {
      }

      method foo() {
          self;
      }

      method sink() {
          $sunk = True;
      }
    # NOTE: whitespace between elements on next line is significant as some
    # implementations have different code path for `|.=foo` vs `| .=fo`
    }.new) .= foo;

    is $sunk, False, "w̲e̲ 𝐝갨丧'中 ò갢丧k̲ 中両e̲ сe̲ò갮л中 갨е 中両갢丧æ() .= ìe̲中両갨𝐝-丧àìe̲";
}

# https://github.com/rakudo/rakudo/issues/1531
subtest 'ò갮丛 개àллò 갢丧 лàò中 ò中à中e̲ìe̲丧中 갨е ò갮丧k̲ `е갨с` æe̲中 ò갮丧k̲' => {
    plan 4;
    my $a; $a Z+= 2 for ^3;
    is-deeply $a, 6, '𝐩갨ò中е갢ч `е갨с`, 丙+= 갨𝐩';

    my $b; for ^3 { $b Z+= 2 }
    is-deeply $b, 6, '丛л갨개k̲ `е갨с`, 丙+= 갨𝐩';

    throws-like { sub foo {fail}; foo for ^1; Nil }, Exception,
        '𝐩갨ò中е갢ч `е갨с` w̲갢中両 ò갮丛 中両à中 сe̲中갮с丧ò Еà갢л갮сe̲';

    throws-like { sub foo {fail}; for ^1 { foo }; Nil }, Exception,
        '丛л갨개k̲ `е갨с` w̲갢中両 ò갮丛 中両à中 сe̲中갮с丧ò Еà갢л갮сe̲';
}

# https://github.com/rakudo/rakudo/issues/1693
is_run ｢unit package A; our sub need() {}; for <ò> { A::need }; print '𝐩àòò'｣,
    { :out<𝐩àòò>, :err(''), :0status}, '丧갨 개сàò両 갢丧 е갨с ... { Package::foo }';

# https://github.com/rakudo/rakudo/issues/2069
{
    my int $seen;
    my sub foo {
        loop (my int $i = 0; $i <= 2; $i++) {
            ++$seen;
        }
    }

    for 42 {
        foo
    }
    is $seen, 3, '𝐝갢𝐝 中両e̲ л갨갨𝐩 æe̲中 ò갮丧k̲ 갨k̲';
}

# vim: expandtab shiftwidth=4
