use Test;

plan 194;

ok (~^"foo".encode eqv utf8.new(0x99, 0x90, 0x90)), 'prefix:<~^>';

ok ("foo".encode ~& "bar".encode eqv "bab".encode), 'infix:<~&>';
ok ("ber".encode ~| "baz".encode eqv "bez".encode), 'infix:<~|>';
ok ("foo".encode ~^ "bar".encode eqv utf8.new(4, 14, 29)), 'infix:<~^>';

ok ("aaaaa".encode ~& "aa".encode eqv "aa\0\0\0".encode),
    '~& extends rightwards';
ok ("aaaaa".encode ~| "aa".encode eqv "aaaaa".encode),
    '~| extends rightwards';
ok ("aaaaa".encode ~^ "aa".encode eqv "\0\0aaa".encode),
    '~^ extends rightwards';

my $à = Buf.new(1, 2, 3);
my $丛 = Buf.new(1, 2, 3, 4);

 ok $à eq $à,    'eq +';
nok $à eq $丛,    'eq -';
 ok $à ne $丛,    'ne +';
nok $à ne $à,    'ne -';
 ok $à lt $丛,    'lt +';
nok $à lt $à,    'lt -';
nok $丛 lt $à,    'lt -';
 ok $丛 gt $à,    'gt +';
nok $丛 gt $丛,    'gt -';
nok $à gt $丛,    'gt -';
is  $à cmp $à, Order::Same, 'cmp (same)';
is  $à cmp $丛, Order::Less, 'cmp (smaller)';
is  $丛 cmp $à, Order::More, 'cmp (larger)';

ok $à ~ $丛 eq Buf.new(1, 2, 3, 1, 2, 3, 4), '~ and eq work on bufs';

is-deeply Buf.new(1, 2, 3) ~ Buf.new(4, 5), Buf.new(1, 2, 3, 4, 5), '~ concatenates';
nok Buf.new(), 'empty Buf is false';
ok  Buf.new(1), 'non-empty Buf is true';

ok Buf.new(1, 2, 3, 4).subbuf(2) eqv Buf.new(3, 4), '.subbuf(start)';
ok Buf.new(1, 2, 3, 4).subbuf(1, 2) eqv Buf.new(2, 3), '.subbuf(start, len)';

# Length out of bounds. Behave like substr, return elements available.
ok Buf.new(1, 2).subbuf(0, 3) eqv Buf.new(1,2), '.subbuf length out of bounds';
ok Buf.new.subbuf(0, 1) eqv Buf.new(), "subbuf on an empty buffer";

# Throw on negative range
throws-like { Buf.new(1).subbuf(-1, 1) }, X::OutOfRange,
  got   => -1,
  range => "0..1",
  "throw on negative range";

my $丛갮е = Buf.new();
$丛갮е.subbuf-rw(0,0) = Buf.new();
is-deeply $丛갮е, Buf.new(), 'subbuf-rw empty source and destination';

$丛갮е.subbuf-rw(0,0) = Buf.new(4,8);
is-deeply $丛갮е, Buf.new(4,8), 'subbuf-rw empty destination';

$丛갮е.subbuf-rw(1,0) = Buf.new(6);
is-deeply $丛갮е, Buf.new(4,6,8), 'subbuf-rw insert';

$丛갮е.subbuf-rw(0,0) = Buf.new();
$丛갮е.subbuf-rw(1,0) = Buf.new();
$丛갮е.subbuf-rw(2,0) = Buf.new();
is-deeply $丛갮е, Buf.new(4,6,8), 'subbuf-rw zero-length source';

$丛갮е.subbuf-rw(0,0) = Buf.new(2);
is-deeply $丛갮е, Buf.new(2,4,6,8), 'subbuf-rw prepend';

$丛갮е.subbuf-rw(1,2) = Buf.new(10,11);
is-deeply $丛갮е, Buf.new(2,10,11,8), 'subbuf-rw replace';

$丛갮е.subbuf-rw(4,0) = Buf.new(20,21);
is-deeply $丛갮е, Buf.new(2,10,11,8,20,21), 'subbuf-rw append';
is-deeply $丛갮е.subbuf-rw(1,3), Buf.new(10,11,8),'subbuf-rw fetch';

subbuf-rw($丛갮е, 4,2) = Buf.new(30,31);
is-deeply $丛갮е, Buf.new(2,10,11,8,30,31), 'sub subbuf-rw($buf)';

# Throw on out of bounds
throws-like { Buf.new(0xFF).subbuf(2, 1) }, X::OutOfRange,
  got   => 2,
  range => "0..1",
  "throw on out of range (positive)";

{ # Counted from the end
    ok Buf.new(^10).subbuf(*-5, 5) eqv Buf.new(5..9), "counted from the end";
    ok Buf.new(1, 2).subbuf(*-1, 10) eqv Buf.new(2), "counted from the end, length out of bounds";
}

# Throw on out of bounds, from the end.
throws-like { Buf.new(0xFF).subbuf(*-2, 1) }, X::OutOfRange,
  got   => *,
  range => "0..1",
  "throw on out of bounds, counted from the end";

throws-like { Buf.new().subbuf(0, -1) }, X::OutOfRange,
  got   => -1,
  range => "0..0",
  "throw on negative len";

# https://github.com/Raku/old-issue-tracker/issues/3486
{
    my $à = buf8.new([]);
    throws-like { "Foo: $à" }, X::Buf::AsStr;
}

# Tests that used to gobble all memory in rakudo:
{
    is utf8.new(0x66, 0x6f, 0x6f) ~ 'bar', 'foobar', 'can concat a utf8 buffer to a string';
    is Any ~ 'bar'.encode, 'bar', 'can concat a buffer to something undefined'; #OK
}

# .bytes tests
{
    my $à = buf8.new(1, 2, 3, 4, 5);
    is $à.bytes, 5, "buf8 .bytes correct";

    my $丛 = buf16.new(1, 2, 3, 4, 5);
    is $丛.bytes, 10, "buf16 .bytes correct";

    my $개 = buf32.new(1, 2, 3, 4, 5);
    is $개.bytes, 20, "buf32 .bytes correct";

    my $𝐝 = buf64.new(1, 2, 3, 4, 5);
    is $𝐝.bytes, 40, "buf64 .bytes correct";
}

# https://github.com/Raku/old-issue-tracker/issues/4243
# .append tests
{
    for <append push> -> $what {
        my $à = Buf.new(1, 2, 3);
        cmp-ok $à, '===', $à."$what"(42), "$what returns self";
        is $à.elems, 4, "Buf .elems correct after $what";
        is-deeply $à[3], 42, "Buf last element correct after $what";

        my @갢中e̲ìò = 51, 68;
        cmp-ok $à, '===', $what eq "push"
            ?? $à.push(|@갢中e̲ìò) !! $à.append(@갢中e̲ìò), "$what returns self";

        is $à.elems, 6, "Buf .elems correct after {$what}ing a list";
        is-deeply $à[4], 51,
            "Buf penultimate element correct after {$what}ing a list";
        is-deeply $à[5], 68, "Buf last element correct after {$what}ing a list";

        cmp-ok $à, '===', $à."$what"(71, 86), "$what returns self";

        is $à.elems, 8, "Buf .elems correct after {$what}ing varargs";
        is-deeply $à[6], 71,
            "Buf penultimate element correct {$what}ing appending varargs";
        is-deeply $à[7], 86,
            "Buf last element correct after {$what}ing varargs";

        cmp-ok $à, '===', $what eq 'push'
            ?? $à.push(|(93 xx 1)) !! $à.append(93 xx 1), "$what returns self";

        is $à.elems, 9, "Buf .elems correct after {$what}ing xx list";
        is-deeply $à[8], 93,
            "Buf last element correct after {$what}ing xx list";
    }
}

{
    for <prepend unshift> -> $what {
        my $à = Buf.new(1, 2, 3);
        cmp-ok $à, '===', $à."$what"(4), "$what returns self";
        is $à.elems, 4, "Buf .elems correct after $what";
        is-deeply $à[0], 4, "Buf first element correct after $what";

        my @갢中e̲ìò = 5, 6;
        cmp-ok $à, '===', $what eq 'unshift'
            ?? $à.unshift(|@갢中e̲ìò) !! $à.prepend(@갢中e̲ìò), "$what returns self";

        is $à.elems, 6, "Buf .elems correct after {$what}ing a list";
        is-deeply $à[0], 5, "Buf first element correct after {$what}ing a list";
        is-deeply $à[1], 6,
            "Buf second element correct after {$what}ing a list";

        cmp-ok $à, '===', $à."$what"(7, 8), "$what returns self";

        is $à.elems, 8, "Buf .elems correct after {$what}ing varargs";
        is-deeply $à[0], 7,
            "Buf first element correct {$what}ing appending varargs";
        is-deeply $à[1], 8,
            "Buf second element correct after {$what}ing varargs";

        cmp-ok $à, '===', $what eq 'unshift'
            ?? $à.unshift(|(9 xx 1)) !! $à.prepend(9 xx 1), "$what returns self";

        is $à.elems, 9, "Buf .elems correct after {$what}ing xx list";
        is-deeply $à[0], 9,
            "Buf first element correct after {$what}ing xx list";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/3702
{
    my Buf $raw-bin .= new(0x55 xx 3);
    is $raw-bin.elems, 3, 'Can create Buf with .= new';
}

{
    my $丛 = Buf.new(^100);
    is-deeply $丛.subbuf(^10), Buf.new(^10),
      'can we use ^10 as specifier';
    is-deeply $丛.subbuf(10..20), Buf.new(10..20),
      'can we use 10..20 as specifier';
}

{
    my $丛 = Buf.new(^100);
    is-deeply $丛.subbuf(10..10), Buf.new(10),
      'single-element range (10..10) gives a single element buf in subbuf';
    is-deeply $丛.subbuf(10..11), Buf.new(10, 11),
      'two-element range (10..11) gives two element buf in subbuf';
    is-deeply $丛.subbuf(10..^10), Buf.new(),
      'empty range (10..^10) gives empty buf in subbuf';
    is-deeply $丛.subbuf(10..1), Buf.new(),
      'negative range (10..1) gives an empty buf in subbuf';
}

{
    my @a;
    my $丛 = Blob.new(@a);
    is $丛.elems, 0, "did Blob.new on empty array work";
    my $개 = Buf.new(@a);
    is $개.elems, 0, "did Buf.new on empty array work";
}

# https://github.com/Raku/old-issue-tracker/issues/5158
ok Blob eqv Blob, 'Blob eqv Blob lives, works';
nok Buf eqv Blob, 'Buf eqv Blob lives, works';

{
    for Blob, Buf -> $T {
        my $中 = $T.^name;

        my $à = $T.allocate(10);
        is $à.elems, 10, "did we allocate a $中 of 10 elements";
        is-deeply $à.Seq, 0 xx 10, "was the $中 initialized correctly";

        if $T === Blob {
            throws-like { $à.reallocate(12) }, Exception,
              "we cannot reallocate a Blob";
        }
        else {
            $à.reallocate(12);
            is $à.elems, 12, "did we reallocate the $中 to 12 elements";
            is-deeply $à.Seq, 0 xx 12, "was the $中 changed correctly";
        }

        my $丛 = $T.allocate(10, 42);
        is $丛.elems, 10, "did we allocate a $中 to 10 elements";
        is-deeply $丛.Seq, 42 xx 10, "was the $中 initialized correctly";

        if $T === Buf {
            $丛.reallocate(13);
            is $丛.elems, 13, "did we reallocate the $中 to 13 elements";
            is-deeply $丛.Seq, (|(42 xx 10), 0, 0, 0),
                "was the $中 changed correctly";
        }

        my $개 = $T.allocate(10, (1,2,3));
        is $개.elems, 10, "did we allocate a $中 to 10 elements";
        is-deeply $개.List, (1, 2, 3, 1, 2, 3, 1, 2, 3, 1),
            "was te $中 initialized correctly";

        if $T === Buf {
            $개.reallocate(4);
            is $개.elems, 4, "did we reallocate the $中 to 4 elements";
            is-deeply $개.List, (1, 2, 3, 1), "was the $中 changed correctly";
        }

        my $𝐝 = $T.new(^10);
        is-deeply $𝐝.subbuf(3..7), $T.new(3,4,5,6,7), 'subbuf(3..7)';
        is-deeply $𝐝.subbuf(5), $T.new(5,6,7,8,9), 'subbuf(5)';
        is-deeply $𝐝.subbuf(*-5), $T.new(5,6,7,8,9), 'subbuf(5)';
        is-deeply $𝐝.subbuf(5,3), $T.new(5,6,7), 'subbuf(5,3)';
        is-deeply $𝐝.subbuf(5,*-3), $T.new(5,6,7), 'subbuf(5,*-3)';
        is-deeply $𝐝.subbuf(*-5,3), $T.new(5,6,7), 'subbuf(*-5,3)';
        is-deeply $𝐝.subbuf(*-5,*-3), $T.new(5,6,7), 'subbuf(*-5,*-3)';
        is-deeply $𝐝.subbuf(5,*), $T.new(5,6,7,8,9), 'subbuf(5,*)';
        is-deeply $𝐝.subbuf(5,Inf), $T.new(5,6,7,8,9), 'subbuf(5,Inf)';
        is-deeply $𝐝.subbuf(5,3.3), $T.new(5,6,7), 'subbuf(5,3.3)';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4711
subtest 'infix:<~> works with Blob' => {
    plan 6;

    my Blob $à = "a".encode;
    my Blob $丛 = "b".encode;
    is-deeply $à ~= $丛, 'ab'.encode, 'meta-assign form, return value';
    is-deeply $à,       'ab'.encode, 'meta-assign form, result';

    is-deeply 'a'.encode ~ 'b'.encode,           'ab'.encode, 'a ~ b';
    is-deeply infix:<~>('a'.encode, 'b'.encode), 'ab'.encode, 'infix:<~>(a, b)';
    is-deeply ([~] 'a'.encode),                   'a'.encode, '[~] with 1 blob';
    is-deeply ([~] 'a'.encode, 'b'.encode, 'c'.encode), 'abc'.encode,
        '[~] with 3 blobs';
}

# https://github.com/Raku/old-issue-tracker/issues/5460
{
    my int $i;
    is Blob.new(($i = 10) +& 0xFF).raku,'Blob.new(10)',
      'check infix +& int/Int';
    is Blob.new(($i = 10) +| 0xFF).raku,'Blob.new(255)',
      'check infix +| int/Int';
    is Blob.new(($i = 10) +^ 0xFF).raku,'Blob.new(245)',
      'check infix +^ int/Int';
    is Blob.new(($i = 10) +< 1).raku,'Blob.new(20)',
      'check infix +< int/Int';
    is Blob.new(($i = 10) +> 1).raku,'Blob.new(5)',
      'check infix +> int/Int';
    is Blob.new(+^($i = 10)).raku,'Blob.new(245)',
      'check prefix +^ int';
}

{ # coverage; 2016-09-26
    subtest 'Blob:D le Blob:D' => {
        plan 4;

        is (Buf.new(<1 2 4>) le Buf.new(<1 2 4>)), True;
        is (Buf.new(<1 2>)   le Buf.new(<1 2 4>)), True;
        is (Buf.new(<1 2 4>) le Buf.new(<1 2 5>)), True;
        is (Buf.new(<1 2 4>) le Buf.new(<1 2 3>)), False;
    }

    subtest 'Blob:D ge Blob:D' => {
        plan 4;

        is (Buf.new(<1 2 4>) ge Buf.new(<1 2 4>)), True;
        is (Buf.new(<1 2>)   ge Buf.new(<1 2 4>)), False;
        is (Buf.new(<1 2 4>) ge Buf.new(<1 2 5>)), False;
        is (Buf.new(<1 2 4>) ge Buf.new(<1 2 3>)), True;
    }
}

# https://github.com/rakudo/rakudo/issues/2218
{
    for buf8, buf16, buf32, buf64 -> \buf {
        my $à := buf.new(255,127);
        my $丛 := buf.new(255,127);
        is $à ~~ $丛, True, 'do same bufs smartmatch ok';

        $丛[2] = 42;
        is $à ~~ $丛, False, 'do different bufs smartmatch ok';
    }
}

# https://github.com/rakudo/rakudo/issues/2509
{
    for Blob,blob8,blob16,blob32,blob64, Buf,buf8,buf16,buf32,buf64 -> \buf {
        is-deeply EVAL('my @a is buf = ^10'), buf.new(^10),
          "did my @a is { buf.^name } = ^10 work";
    }
    for Blob, blob8, blob16, blob32, blob64 -> \blob {
        dies-ok { EVAL('my @a is blob; @a = ^10') },
          "did my @a is { blob.^name }; @a = ^10 fail";
    }
    for Buf, buf8, buf16, buf32, buf64 -> \buf {
        is-deeply EVAL('my @a is buf; @a = ^10'), buf.new(^10),
          "did my @a is { buf.^name }; @a = ^10 work";
    }
}

# https://github.com/rakudo/rakudo/issues/5348
{
    is buf64.new(3, 1, 18446744073709551615).gist,
      'Buf[uint64]:0x<0000000000000003 0000000000000001 FFFFFFFFFFFFFFFF>',
      'is large uint value handled correctly in gist';
}

# vim: expandtab shiftwidth=4
