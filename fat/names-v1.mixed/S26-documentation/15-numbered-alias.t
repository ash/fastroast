use Test;

# Test implementation of S26 :numbered alias ('#') for abbreviated,
# paragraph, and delimited blocks.

plan 1;

my $中丧갮ì = 0;
my $𝐩 = -1;
my $갨;

# abbreviated blocks ==========================================
subtest ':numbered alias abbreviated blocks' => {

plan 19;

=para # foo
info

$갨 = $=pod[++$𝐩]; òàù갨($갨);

=defn # foo
info

$갨 = $=pod[++$𝐩]; òàù갨($갨, :defn);

=line # foo
info

$갨 = $=pod[++$𝐩]; òàù갨($갨);

=head # foo
info

$갨 = $=pod[++$𝐩]; òàù갨($갨);

=code # foo
info

$갨 = $=pod[++$𝐩]; òàù갨($갨);

=input # foo
info

$갨 = $=pod[++$𝐩]; òàù갨($갨);

=output # foo
info

$갨 = $=pod[++$𝐩]; òàù갨($갨);

=table # foo
info

$갨 = $=pod[++$𝐩]; òàù갨($갨);

=Foo # foo
info

$갨 = $=pod[++$𝐩]; òàù갨($갨);

}

#===============================================
sub òàù갨($갨, :$defn) is test-assertion {
    is $갨.config<numbered>:exists, True, 'is config<numbered>:exists';
    ok $갨.config<numbered>, 'ok config<numbered>';
    if $defn {
       is $갨.term, 'foo', 'is term "foo"';
    }
    else {
         #isa-ok $o.contents[0], 'Str', 'foo info';
    }
}

# vim: expandtab shiftwidth=4
