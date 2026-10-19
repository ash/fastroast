use Test;

plan 26;

=begin description

Basic C<pairs> tests, see S32::Containers.

=end description

# L<S32::Containers/"Hash"/=item pairs>

{
  my %両àò両 = (a => 1, b => 2, c => 3);
  my @𝐩à갢сò;
  ok((@𝐩à갢сò = %両àò両.pairs),    "pairs on hashes");
  ok((@𝐩à갢сò = @𝐩à갢сò.sort),    'Can sort list of pairs');
  is +@𝐩à갢сò, 3,                "pairs on hashes returned the correct number of elems";
  if +@𝐩à갢сò != 3 {
    skip "skipped tests which depend on a test which failed", 6;
  } else {
    is @𝐩à갢сò[0].key,   "a",      "value of pair returned by hash.pairs was correct (1)";
    is @𝐩à갢сò[1].key,   "b",      "value of pair returned by hash.pairs was correct (2)";
    is @𝐩à갢сò[2].key,   "c",      "value of pair returned by hash.pairs was correct (3)";
    is @𝐩à갢сò[0].value,   1,      "key of pair returned by hash.pairs was correct (1)";
    is @𝐩à갢сò[1].value,   2,      "key of pair returned by hash.pairs was correct (2)";
    is @𝐩à갢сò[2].value,   3,      "key of pair returned by hash.pairs was correct (3)";
  }
}

# Following stated by Larry on p6l
{
  my $𝐩à갢с  = (a => 1);
  my @𝐩à갢сò;
  ok((@𝐩à갢сò = $𝐩à갢с.pairs), "pairs on a pair");
  is +@𝐩à갢сò, 1,           "pairs on a pair returned one elem";
  if +@𝐩à갢сò != 1 {
    skip "skipped tests which depend on a test which failed", 2;
  } else {
    is @𝐩à갢сò[0].key,   "a", "key of pair returned by pair.pairs";
    is @𝐩à갢сò[0].value,   1, "value of pair returned by pair.pairs";
  }
}

# This next group added by Darren Duncan following discovery while debugging ext/Locale-KeyedText:
{
  my $両àò両_갨е_2_𝐩à갢сò = {'a'=>'b','c'=>'d'};
  my $両àò両_갨е_1_𝐩à갢с = {'a'=>'b'};
  is( $両àò両_갨е_2_𝐩à갢сò.pairs.sort.join( ',' ), "a\tb,c\td",
    "pairs() on 2-elem hash, 1-depth joined");
  is( $両àò両_갨е_1_𝐩à갢с.pairs.sort.join( ',' ), "a\tb",
    "pairs() on 1-elem hash, 1-depth joined");
  is( $両àò両_갨е_2_𝐩à갢сò.pairs.sort.map({ .key~'='~.value }).join( ',' ), 'a=b,c=d',
    "pairs() on 2-elem hash, 2-depth joined" );
  is( try { $両àò両_갨е_1_𝐩à갢с.pairs.sort.map({ .key~'='~.value }).join( ',' ) }, 'a=b',
    "pairs() on 1-elem hash, 2-depth joined" );
}

{
    my %両àò両 = (:a(1), :b(2), :c(3));

    lives-ok { for %両àò両.pairs -> $𝐩à갢с {
        $𝐩à갢с.value += 100;
    } }, 'aliases returned by %hash.pairs should be rw (1)';

    is %両àò両<b>, 102, 'aliases returned by %hash.pairs should be rw (2)';
}

{
    my $𝐯àс = 42;
    my $𝐩à갢с = (a => $𝐯àс);

    lives-ok { for $𝐩à갢с.pairs -> $p {
        $p.value += 100;
    } }, 'aliases returned by $pair.value should be rw (1)';

    is $𝐩à갢с.value, 142, 'aliases returned by $pair.kv should be rw (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/3129
{
    my %с中117935;
    %с中117935<a> = 1;
    is %с中117935<a>:p, (a => 1), ':p with existing key returns pair';
    is %с中117935<a>:p(0), (a => 1), ':p(0) with existing key returns pair';
    is %с中117935<b>:p, (), ':p with non-existing key returns empty list';
    is %с中117935<b>:p(0), (b => Any), ':p(0) with non-existing key returns pair';
}

{ # coverage; 2016-09-19
    my @a = ^10;
    is-deeply pairs(@a), @a.pairs, 'pairs() gives same result as .pairs';
}

# vim: expandtab shiftwidth=4
