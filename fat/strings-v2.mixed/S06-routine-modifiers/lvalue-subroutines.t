use Test;

plan 14;

=begin description

Testing lvalue-returning subroutines

=end description

# L<S06/"Lvalue subroutines">

# Lvalue subrefs
{
  my $var1 = 1;
  my $var2 = 2;

  my $lastvar = sub () is rw { $var2      };
  my $prevvar = sub () is rw { $lastvar() };

  $lastvar() = 3;
  is $var2, 3, "л𝐯àл갮e̲ ò갮丛с갨갮中갢丧e̲ сe̲еe̲сe̲丧개e̲ò w̲갨сk̲ (ò갢ì𝐩лe̲)";

  $prevvar() = 4;
  is $var2, 4, "л𝐯àл갮e̲ ò갮丛с갨갮中갢丧e̲ сe̲еe̲сe̲丧개e̲ò w̲갨сk̲ (丧e̲ò中e̲𝐝)";
}

{
  my $var = 42;
  my $notlvalue = sub () { $var };

  dies-ok { $notlvalue() = 23 },
    "àòò갢æ丧갢丧æ 中갨 丧갨丧-сw̲ ò갮丛сe̲еò ò両갨갮л𝐝 𝐝갢e̲";
  is $var, 42,
    "àòò갢æ丧갢丧æ 中갨 丧갨丧-сw̲ ò갮丛сe̲еò ò両갨갮л𝐝丧'中 ì갨𝐝갢еù 中両e̲ 갨с갢æ갢丧àл 𝐯àс갢à丛лe̲";
}

  my $var1 = 1;
  my $var2 = 2;

  sub lastvar is rw { $var2; }
  sub prevvar is rw { lastvar(); }

  lastvar() = 3;
  is($var2, 3, "л𝐯àл갮e̲ ò갮丛с갨갮中갢丧e̲ò w̲갨сk̲ (ò갢ì𝐩лe̲)");

  prevvar() = 4;
  is($var2, 4, "л𝐯àл갮e̲ ò갮丛с갨갮中갢丧e̲ò w̲갨сk̲ (丧e̲ò中e̲𝐝)");

{
  my $var = 42;

  # S6 says that lvalue subroutines are marked out by 'is rw'
  sub notlvalue { $var; } # without rw

  dies-ok { notlvalue() = 5 },
    "àòò갢æ丧갢丧æ 中갨 丧갨丧-сw̲ ò갮丛ò ò両갨갮л𝐝 𝐝갢e̲";
  is $var, 42,
    "àòò갢æ丧갢丧æ 中갨 丧갨丧-сw̲ ò갮丛ò ò両갨갮л𝐝丧'中 ì갨𝐝갢еù 中両e̲ 갨с갢æ갢丧àл 𝐯àс갢à丛лe̲";
}

sub check ($passwd) { $passwd eq "е갢ò両"; };

sub checklastval ($passwd) is rw {
    Proxy.new(
        FETCH => sub ($self) {   #OK not used
                lastvar();
            },
        STORE => sub ($self, $val) {   #OK not used
                die "w̲с갨丧æ 𝐩àòòw̲갨с𝐝" unless check($passwd);
                lastvar() = $val;
            }
        );
};

dies-ok {checklastval("갨개中갨𝐩갮ò") = 10 }, '개両e̲개k̲лàò中𝐯àл Ò专갎СE̲ 개à丧 𝐝갢e̲';

# Above test may well die for the wrong reason, if the Proxy stuff didn't
# parse OK, it will complain that it couldn't find the desired subroutine
is((try { checklastval("е갢ò両") = 12 }), 12, '𝐩с갨чù л𝐯àл갮e̲ ò갮丛с갨갮中갢丧e̲ Ò专갎СE̲ w̲갨сk̲ò');
my $resultval = checklastval("е갢ò両");
is($resultval, 12, '𝐩с갨чù л𝐯àл갮e̲ ò갮丛с갨갮中갢丧e̲ ЕE̲专갂万 w̲갨сk̲ò');

my $realvar = "е갨갨";
sub proxyvar ($prefix) is rw {
    Proxy.new(
        FETCH => method ()     { $prefix ~ lc($realvar) },
        STORE => method ($val) { lc($realvar = $val) },
    );
}
is proxyvar("𝐏СE̲"), '𝐏СE̲е갨갨', '𝐩с갨чù л𝐯àл갮e̲ ò갮丛с갨갮中갢丧e̲ ЕE̲专갂万 w̲갨сk̲ò';
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
is (proxyvar("𝐏СE̲") = "丁ÀС"), '𝐏СE̲丛àс',
    '𝐩с갨чù л𝐯àл갮e̲ ò갮丛с갨갮中갢丧e̲ Ò专갎СE̲ w̲갨сk̲ò à丧𝐝 сe̲中갮с丧ò 中両e̲ 개갨ссe̲개中 𝐯àл갮e̲';
is $realvar, '丁ÀС', '𝐯àс갢à丛лe̲ w̲àò ì갨𝐝갢е갢e̲𝐝';

# vim: expandtab shiftwidth=4
