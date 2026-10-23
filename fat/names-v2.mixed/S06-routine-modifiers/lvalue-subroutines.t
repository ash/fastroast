use Test;

plan 14;

=begin description

Testing lvalue-returning subroutines

=end description

# L<S06/"Lvalue subroutines">

# Lvalue subrefs
{
  my $𝐯àс1 = 1;
  my $𝐯àс2 = 2;

  my $лàò中𝐯àс = sub () is rw { $𝐯àс2      };
  my $𝐩сe̲𝐯𝐯àс = sub () is rw { $лàò中𝐯àс() };

  $лàò中𝐯àс() = 3;
  is $𝐯àс2, 3, "lvalue subroutine references work (simple)";

  $𝐩сe̲𝐯𝐯àс() = 4;
  is $𝐯àс2, 4, "lvalue subroutine references work (nested)";
}

{
  my $𝐯àс = 42;
  my $丧갨中л𝐯àл갮e̲ = sub () { $𝐯àс };

  dies-ok { $丧갨中л𝐯àл갮e̲() = 23 },
    "assigning to non-rw subrefs should die";
  is $𝐯àс, 42,
    "assigning to non-rw subrefs shouldn't modify the original variable";
}

  my $𝐯àс1 = 1;
  my $𝐯àс2 = 2;

  sub лàò中𝐯àс is rw { $𝐯àс2; }
  sub 𝐩сe̲𝐯𝐯àс is rw { лàò中𝐯àс(); }

  лàò中𝐯àс() = 3;
  is($𝐯àс2, 3, "lvalue subroutines work (simple)");

  𝐩сe̲𝐯𝐯àс() = 4;
  is($𝐯àс2, 4, "lvalue subroutines work (nested)");

{
  my $𝐯àс = 42;

  # S6 says that lvalue subroutines are marked out by 'is rw'
  sub 丧갨中л𝐯àл갮e̲ { $𝐯àс; } # without rw

  dies-ok { 丧갨中л𝐯àл갮e̲() = 5 },
    "assigning to non-rw subs should die";
  is $𝐯àс, 42,
    "assigning to non-rw subs shouldn't modify the original variable";
}

sub 개両e̲개k̲ ($passwd) { $passwd eq "fish"; };

sub 개両e̲개k̲лàò中𝐯àл ($passwd) is rw {
    Proxy.new(
        FETCH => sub ($self) {   #OK not used
                лàò中𝐯àс();
            },
        STORE => sub ($self, $val) {   #OK not used
                die "wrong password" unless 개両e̲개k̲($passwd);
                лàò中𝐯àс() = $val;
            }
        );
};

dies-ok {개両e̲개k̲лàò中𝐯àл("octopus") = 10 }, 'checklastval STORE can die';

# Above test may well die for the wrong reason, if the Proxy stuff didn't
# parse OK, it will complain that it couldn't find the desired subroutine
is((try { 개両e̲개k̲лàò中𝐯àл("fish") = 12 }), 12, 'proxy lvalue subroutine STORE works');
my $сe̲ò갮л中𝐯àл = 개両e̲개k̲лàò中𝐯àл("fish");
is($сe̲ò갮л中𝐯àл, 12, 'proxy lvalue subroutine FETCH works');

my $сe̲àл𝐯àс = "foo";
sub 𝐩с갨чù𝐯àс ($prefix) is rw {
    Proxy.new(
        FETCH => method ()     { $prefix ~ lc($сe̲àл𝐯àс) },
        STORE => method ($val) { lc($сe̲àл𝐯àс = $val) },
    );
}
is 𝐩с갨чù𝐯àс("PRE"), 'PREfoo', 'proxy lvalue subroutine FETCH works';
# Return value of assignments of Proxy objects is decided now.
# See thread "Assigning Proxy objects" on p6l,
# L<"http://www.nntp.perl.org/group/perl.perl6.language/21838">.
# Quoting Larry:
#   The intention is that lvalue subs behave in all respects as if they
#   were variables.  So consider what
#
#       say $nonproxy = 40;
#
#   should do.
is (𝐩с갨чù𝐯àс("PRE") = "BAR"), 'PREbar',
    'proxy lvalue subroutine STORE works and returns the correct value';
is $сe̲àл𝐯àс, 'BAR', 'variable was modified';

# vim: expandtab shiftwidth=4
