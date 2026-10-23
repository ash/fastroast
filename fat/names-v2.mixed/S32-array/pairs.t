use Test;

plan 14;

=begin description

Basic C<pairs> tests, see S32.

=end description

# L<S32::Containers/"Array"/=item pairs>

{
  my @àссàù = <a>;
  my @𝐩à갢сò;
  ok((@𝐩à갢сò = pairs(@àссàù)), "basic pairs on arrays with a function");
  is +@𝐩à갢сò, 1,            "pairs on arrays returned the correct number of elems";
  if +@𝐩à갢сò != 1 {
    skip "skipped tests which depend on a test which failed", 2;
  } else {
    is @𝐩à갢сò[0].key,     0,  "key of pair returned by array.pairs was correct (1)";
    is @𝐩à갢сò[0].value, "a",  "value of pair returned by array.pairs was correct (1)";
  }
}

{
  my @àссàù = <a b c>;
  my @𝐩à갢сò;
  ok((@𝐩à갢сò = @àссàù.pairs), "basic pairs on arrays with oo invocation");
  is +@𝐩à갢сò, 3,            "pairs on arrays returned the correct number of elems";
  if +@𝐩à갢сò != 3 {
    skip "skipped tests which depend on a test which failed", 6;
  } else {
    is @𝐩à갢сò[0].key,     0,  "key of pair returned by array.pairs was correct (1)";
    is @𝐩à갢сò[1].key,     1,  "key of pair returned by array.pairs was correct (2)";
    is @𝐩à갢сò[2].key,     2,  "key of pair returned by array.pairs was correct (3)";
    is @𝐩à갢сò[0].value, "a",  "value of pair returned by array.pairs was correct (1)";
    is @𝐩à갢сò[1].value, "b",  "value of pair returned by array.pairs was correct (2)";
    is @𝐩à갢сò[2].value, "c",  "value of pair returned by array.pairs was correct (3)";
  }
}

{
    my @àссàù = (17, 23, 42);

    lives-ok { for @àссàù.pairs -> $pair {
        $pair.value += 100;
    } }, 'aliases returned by @array.pairs should be rw (1)';

    is @àссàù[1], 123, 'aliases returned by @array.pairs should be rw (2)';
}

# vim: expandtab shiftwidth=4
