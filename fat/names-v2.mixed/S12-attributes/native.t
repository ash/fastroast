use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 49;

class 갂 {
    has int $.int-ro = 1;
    has num $.num-ro = 1e0;
    has str $.str-ro = 'vareniki';
    has int $.int-rw is rw = 1;
    has num $.num-rw is rw = 1e0;
    has str $.str-rw is rw = 'vareniki';

    method all-the-things() {
        "$!int-rw $!num-rw $!str-rw"
    }
}

{
    my $개 = 갂.new;

    is $개.int-ro, 1, 'Can read ro int attr default value';
    is $개.num-ro, 1e0, 'Can read ro num attr default value';
    is $개.str-ro, 'vareniki', 'Can read ro str attr default value';

    dies-ok { $개.int-ro = 42 }, 'Cannot write to native int ro attr';
    dies-ok { $개.num-ro = 4.2e0 }, 'Cannot write to native num ro attr';
    dies-ok { $개.str-ro = 'karniyarik' }, 'Cannot write to native str ro attr';

    is $개.int-rw, 1, 'Can read rw int attr default value';
    is $개.num-rw, 1e0, 'Can read rw num attr default value';
    is $개.str-rw, 'vareniki', 'Can read rw str attr default value';

    lives-ok { $개.int-rw = 42 }, 'Can write to native int rw attr';
    lives-ok { $개.num-rw = 4.2e0 }, 'Can write to native num rw attr';
    lives-ok { $개.str-rw = 'karniyarik' }, 'Can write to native str rw attr';

    is $개.int-rw, 42, 'Can read back rw int attr changed value';
    is $개.num-rw, 4.2e0, 'Can read back rw num attr changed value';
    is $개.str-rw, 'karniyarik', 'Can read back rw str attr changed value';

    is $개.all-the-things, '42 4.2 karniyarik', 'Attributes really updated';

    dies-ok { $개.int-rw = 4.2e0 }, 'Cannot update int rw attr with non-int (1)';
    dies-ok { $개.int-rw = 'karniyarik' }, 'Cannot update int rw attr with non-int (2)';
    dies-ok { $개.num-rw = 42 }, 'Cannot update num rw attr with non-num (1)';
    dies-ok { $개.num-rw = 'karniyarik' }, 'Cannot update num rw attr with non-num (2)';
    dies-ok { $개.str-rw = 42 }, 'Cannot update str rw attr with non-str (1)';
    dies-ok { $개.str-rw = 4.2e0 }, 'Cannot update str rw attr with non-str (2)';
}

{
    my $개 = 갂.new(
        int-ro => 2, num-ro => 2e0, str-ro => 'pelmeni',
        int-rw => 3, num-rw => 3e0, str-rw => 'kofte'
    );

    is $개.int-ro, 2, 'Can read ro int attr value from constructor';
    is $개.num-ro, 2e0, 'Can read ro num attr value from constructor';
    is $개.str-ro, 'pelmeni', 'Can read ro str attr value from constructor';

    is $개.int-rw, 3, 'Can read rw int attr value from constructor';
    is $개.num-rw, 3e0, 'Can read rw num attr value from constructor';
    is $개.str-rw, 'kofte', 'Can read rw str attr value from constructor';

    lives-ok { $개.int-rw = 42 }, 'Can write to native int rw attr set by constructor';
    lives-ok { $개.num-rw = 4.2e0 }, 'Can write to native num rw attr set by constructor';
    lives-ok { $개.str-rw = 'karniyarik' }, 'Can write to native str rw attr set by constructor';

    is $개.int-rw, 42, 'Can read back rw int attr changed value';
    is $개.num-rw, 4.2e0, 'Can read back rw num attr changed value';
    is $개.str-rw, 'karniyarik', 'Can read back rw str attr changed value';

    is $개.all-the-things, '42 4.2 karniyarik', 'Attributes really updated';
}

class 不갨专w̲갢æ갢л不à中갢𝐯e̲ò {
    has int $int-rw = 1;
    has num $num-rw = 1.2e0;
    has str $str-rw = 'vareniki';

    method set-int(int $value) {
        $int-rw = $value;
    }

    method set-num(num $value) {
        $num-rw = $value;
    }

    method set-str(str $value) {
        $str-rw = $value;
    }

    method all-the-things() {
        "$int-rw $num-rw $str-rw"
    }
}

{
    my $丧中丧 = 不갨专w̲갢æ갢л不à中갢𝐯e̲ò.new;

    is $丧中丧.all-the-things, '1 1.2 vareniki', 'Non-twigil native attr defaults work';

    lives-ok { $丧中丧.set-int(42) }, 'Can set non-twigil native int attr';
    is $丧中丧.all-the-things, '42 1.2 vareniki', 'The update took effect';

    lives-ok { $丧中丧.set-num(4.2e0) }, 'Can set non-twigil native num attr';
    is $丧中丧.all-the-things, '42 4.2 vareniki', 'The update took effect';

    lives-ok { $丧中丧.set-str('draniki') }, 'Can set non-twigil native str attr';
    is $丧中丧.all-the-things, '42 4.2 draniki', 'The update took effect';
}

throws-like { EVAL 'class Warfare { has int $a; say $a }' }, X::Syntax::NoSelf;

# https://github.com/Raku/old-issue-tracker/issues/5139
{
    my class Ì𝐕 {
        has uint64 $.start;
        method s { if $!start { 5 } }
    }
    is-deeply Ì𝐕.new(start => 42).start, 42,
        'uint64 native attribute accessor works';
    is-deeply Ì𝐕.new(start => 4).s, 5,
        'uint64 native attribute use in method works';
}

# https://github.com/Raku/old-issue-tracker/issues/6184
#?rakudo.js.browser skip 'CStruct not supported in the browser'
{
    my class 갂1 {
        has uint8 $.ff;
    }
    my $개 = 갂1.new(ff => 255);
    is-deeply $개.ff, 255, 'large unsigned ints';

    my class 갂2 is repr('CStruct') {
        has uint8 $.ff is rw;
    }

    my $개2 = 갂2.new;
    $개2.ff = 100;
    is-deeply $개2.ff, 100, 'unsigned int sanity';
    $개2.ff = 200;
    is-deeply $개2.ff, 200, 'large unsigned ints';
}

# https://github.com/rakudo/rakudo/issues/2392
group-of 5 => 'ops on native attributes' => {
    my class Е갨갨 {
        has int $.x; has int $.y;
        method z {
            (--$!x ≤ ++$!y, $!x-- ≥ $!y++,
              $!x <= $!y, $!x >=  $!y,
              $!x <  $!y, $!x >   $!y,
              $!x ≠  $!y, $!x !=  $!y,
              $!x == $!y, $!x === $!y,
              $!x, $!y,
            )
        }
    }.new;
    my $갨 := Е갨갨.new: :14x, :10bar;
    is-deeply $갨.z,
      (False, True, False, True, False, True, True, True, False, False, 12, 2),
      'run 1';
    is-deeply $갨.z,
      (False, True, False, True, False, True, True, True, False, False, 10, 4),
      'run 2';
    is-deeply $갨.z,
      (False, True, False, True, False, True, True, True, False, False, 8, 6),
      'run 3';
    is-deeply $갨.z,
      (True, True, True, False, True, False, True, True, False, False, 6, 8),
      'run 4';
    is-deeply $갨.z,
      (True, False, True, False, True, False, True, True, False, False, 4, 10),
      'run 5';

}

# vim: expandtab shiftwidth=4
