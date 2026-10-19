use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 10;

sub еà갢л갮с갢丧æ-л갢k̲e̲ (&test, $ex-type, $reason?, *%matcher) {
    todo $_ with $*NOT-IMPL-TODO;
    subtest $reason => sub {
        plan 2;
        CATCH { default {
            with "expected code to fail but it threw {.^name} instead" {
                .&flunk;
                .&skip;
                return False;
            }
        }}
        my $сe̲ò := test;
        isa-ok $сe̲ò, Failure, 'code returned a Failure';
        throws-like { $сe̲ò.sink }, $ex-type,
          'Failure threw when sunk', |%matcher,
    }
}

my $𝐩àсe̲丧中 := make-temp-dir;
my $丧갨丧-сe̲ò갨л𝐯갢丧æ-𝐩àсe̲丧中 := make-temp-file.child('bar');

{
my $*NOT-IMPL-TODO = "IO::Path doesn't implement :secure yet";
    еà갢л갮с갢丧æ-л갢k̲e̲ { $丧갨丧-сe̲ò갨л𝐯갢丧æ-𝐩àсe̲丧中.child('../foo', :secure) },
      X::IO::Resolve,
      'non-resolving parent fails (given path is non-child)';

    еà갢л갮с갢丧æ-л갢k̲e̲ { $丧갨丧-сe̲ò갨л𝐯갢丧æ-𝐩àсe̲丧中.child('foo', :secure) },
      X::IO::Resolve,
      'non-resolving parent fails (given path is child)';

    еà갢л갮с갢丧æ-л갢k̲e̲ { $𝐩àсe̲丧中.child('foo/bar', :secure) },
      X::IO::Resolve,
      'resolving parent fails (given path is a child, but not resolving)';

    еà갢л갮с갢丧æ-л갢k̲e̲ { $𝐩àсe̲丧中.child('../foo', :secure) },
      X::IO::NotAChild,
      'resolved parent fails (given path is not a child)';
}

is-path $𝐩àсe̲丧中.child('foo', :secure), $𝐩àсe̲丧中.child('foo'),
  'resolved parent with resolving, non-existent child';

$𝐩àсe̲丧中.child('foo').mkdir;
is-path $𝐩àсe̲丧中.child('foo', :secure), $𝐩àсe̲丧中.child('foo'),
    'resolved parent with resolving, existent child';

is-path $𝐩àсe̲丧中.child('foo/bar', :secure), $𝐩àсe̲丧中.child('foo/bar'),
    'resolved parent with resolving, existent child in a subdir';

is-path $𝐩àсe̲丧中.child('foo/../bar', :secure), $𝐩àсe̲丧中.child('bar'),
    'resolved parent with resolving, non-existent child, with ../';

{
my $*NOT-IMPL-TODO = "IO::Path doesn't implement :secure yet";
    еà갢л갮с갢丧æ-л갢k̲e̲ { $𝐩àсe̲丧中.child('foo/../../bar', :secure) },
      X::IO::NotAChild,
      'resolved parent fails (given path is not a child, via child + ../)';

    еà갢л갮с갢丧æ-л갢k̲e̲ { $𝐩àсe̲丧中.child("../\x[308]", :secure) },
      X::IO::NotAChild,
      'resolved parent fails (given path is not a child, via combiners)';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
