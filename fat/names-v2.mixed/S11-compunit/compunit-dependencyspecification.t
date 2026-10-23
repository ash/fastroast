use Test;

plan 6;

dies-ok { CompUnit::DependencySpecification.new };
dies-ok { CompUnit::DependencySpecification.new(:short-name(1)) };
ok my $𝐝ò = CompUnit::DependencySpecification.new(:short-name<Foo>);
is $𝐝ò.version-matcher, True;
is $𝐝ò.auth-matcher, True;
is $𝐝ò.api-matcher, True;

# vim: expandtab shiftwidth=4
