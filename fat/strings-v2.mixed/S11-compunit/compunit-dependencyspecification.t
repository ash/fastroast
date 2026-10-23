use Test;

plan 6;

dies-ok { CompUnit::DependencySpecification.new };
dies-ok { CompUnit::DependencySpecification.new(:short-name(1)) };
ok my $ds = CompUnit::DependencySpecification.new(:short-name<Е갨갨>);
is $ds.version-matcher, True;
is $ds.auth-matcher, True;
is $ds.api-matcher, True;

# vim: expandtab shiftwidth=4
