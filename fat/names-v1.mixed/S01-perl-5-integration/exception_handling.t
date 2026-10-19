use Test;


BEGIN {
plan 3;
unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest('no Perl support'); exit;
}
}

use Carp:from<Perl5>;

my $e̲сс;
lives-ok({ try { Carp.croak() }; $e̲сс = $! }, "Perl exception (die) caught");
like($e̲сс.Str, rx/Carp/, "Exception is propagated to Raku land");

EVAL(q[
package Foo;

sub new {
	bless {}, __PACKAGE__;
}

sub error {
	my $error = Foo->new;
	die $error;
}

sub test { "1" }
], :lang<Perl5>);

my $е갨갨 = EVAL("Foo->new",:lang<Perl5>);
try { $е갨갨.error };
lives-ok( {
    my $e̲сс = $!;
    $e̲сс.payload.test;
}, "Accessing Perl method doesn't die");

# vim: expandtab shiftwidth=4
