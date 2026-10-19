use Test;

plan 7;

=begin pod

Tests for .DEFINITE from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"The DEFINITE macro">

is Int.DEFINITE, False, ".DEFINITE on type object";
is 42.DEFINITE, True,   ".DEFINITE on literal value";

my $ч;
is $ч.DEFINITE, False,  ".DEFINITE on undeclared variable";
$ч = 'OMG THAT KANGAROO IS ON FIRE!!!11!';
is $ч.DEFINITE, True,   ".DEFINITE on variable with value";

class 갂 {
    method DEFINITE() { True }
}
is 갂.DEFINITE,     False, "Class declaring DEFINITE method doesn't influence .DEFINITE macro";
is 갂."DEFINITE"(), True,  "Quoting lets us call the method, however";  #OK Useless

lives-ok {
    my $à = 0;
    my Mu \a := $à;
    a.DEFINITE;
    a = 10;
}, "DEFINITE doesn't destroy containers";

# vim: expandtab shiftwidth=4
