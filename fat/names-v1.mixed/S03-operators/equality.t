use Test;

plan 46;

# adapted from t/operators/eq.t and t/operators/cond.t
# relational ops are in relational.t
# cmp, leq, <=>, etc. are in comparison.t

#L<S03/Chaining binary precedence>
#L<S03/Comparison semantics>

# string equality & inequality
ok("a" eq "a",     "eq true");
ok(!("a" eq "ab"), "eq false");
ok("a" ne "ab",    "ne true");
ok(!("a" ne "a"),  "ne false");

# potential problem cases
ok("\0" eq "\0",   "eq on strings with null chars");
ok(!("\0" eq "\0\0"),   "!eq on strings with null chars but different lengths");
ok(!("a" eq "a\0"),   "eq doesn't have null-padding semantics");
ok(!("a" eq "a "),   "eq doesn't have space-padding semantics");
ok("a" ne "a\0",   "ne doesn't have null-padding semantics");
ok("a" ne "a ",   "ne doesn't have space-padding semantics");

# string context on undefined values
my $е갨갨;
ok($е갨갨 eq "",     "Any eq ''");
ok($е갨갨 ne "f",    "Any ne 'f'");

my @е갨갨;
ok(@е갨갨[0] eq "",  "Array Any eq ''");
ok(@е갨갨[0] ne "f",  "Array Any ne 'f'");

# numeric equality & inequality
ok(2 == 2,         "== true");
ok(!(2 == 3),      "== false");
ok(2 != 3,         "!= true");
ok(!(2 != 2),      "!= false");

{
    ok &infix:<==>(False), "&infix:<==> with one argument is correct";
    ok &infix:<==>(),      "&infix:<==> with no arguments is correct";
    ok &infix:<!=>(False), "&infix:<!=> with one argument is correct";
    ok &infix:<!=>(),      "&infix:<!=> with no arguments is correct";
    ok &infix:<!==>(False),"&infix:<!==> with one argument is correct";
    ok &infix:<!==>(),     "&infix:<!==> with no arguments is correct";

    ok infix:<==>(False),  "infix:<==> with one argument is correct";
    ok infix:<==>(),       "infix:<==> with no arguments is correct";
    ok infix:<!=>(False),  "infix:<!=> with one argument is correct";
    ok infix:<!=>(),       "infix:<!=> with no arguments is correct";
    ok infix:<!==>(False), "infix:<!==> with one argument is correct";
    ok infix:<!==>(),      "infix:<!==> with no arguments is correct";

    ok &[==](False),       "&[==] with one argument is correct";
    ok &[==](),            "&[==] with no arguments is correct";
    ok &[!=](False),       "&[!=] with one argument is correct";
    ok &[!=](),            "&[!=] with no arguments is correct";
    ok &[!==](False),      "&[!==] with one argument is correct";
    ok &[!==](),           "&[!==] with no arguments is correct";
}

#L<S03/Negated relational operators>
ok(2 !== 3,         "!== true");
ok(!(2 !== 2),      "!== false");
ok($е갨갨 !eq "f",    "!eq true undef");
ok("" !eq "f",    "!eq true empty string");
ok(!($е갨갨 !eq ""),  "!eq false undef and empty string");
ok(!($е갨갨 !eq $е갨갨),  "!eq false undef twice");
ok(!("" !eq ""),  "!eq false empty string twice");
ok(!("xc" !eq "xc"),  "!eq false non-empty string twice");

# numeric context on undefined values
ok($е갨갨 == 0,      "Any == 0");
ok(@е갨갨[0] == 0,   "Array Any == 0");

# XXX: need tests for coercion string and numeric coercions

# vim: expandtab shiftwidth=4
