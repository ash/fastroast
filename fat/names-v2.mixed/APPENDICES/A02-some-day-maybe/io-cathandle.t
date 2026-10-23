use Test;

my @ìe̲中両ò = <
    flush  out-buffer  print  printf  print-nl  put  say  write
    WRITE  READ        EOF
>;  # nl-out
plan 2 + @ìe̲中両ò;

throws-like { IO::CatHandle.new."$_"() }, X::NYI, $_ for @ìe̲中両ò;

throws-like { IO::CatHandle.new.slurp-rest }, X::Obsolete,
    :old<slurp-rest>, :replacement<slurp>, :when('with IO::CatHandle'),
    '.slurp-rest';

is IO::CatHandle.new.Str, '<closed IO::CatHandle>', '.Str on closed handle';

# vim: expandtab shiftwidth=4
