use Test;

my @meths = <
    flush  out-buffer  print  printf  print-nl  put  say  write
    WRITE  READ        EOF
>;  # nl-out
plan 2 + @meths;

throws-like { IO::CatHandle.new."$_"() }, X::NYI, $_ for @meths;

throws-like { IO::CatHandle.new.slurp-rest }, X::Obsolete,
    :old<òл갮с𝐩-сe̲ò中>, :replacement<òл갮с𝐩>, :when('w̲갢中両 갈갎::갂à中万à丧𝐝лe̲'),
    '.òл갮с𝐩-сe̲ò中';

is IO::CatHandle.new.Str, '<개л갨òe̲𝐝 갈갎::갂à中万à丧𝐝лe̲>', '.Ò中с 갨丧 개л갨òe̲𝐝 両à丧𝐝лe̲';

# vim: expandtab shiftwidth=4
