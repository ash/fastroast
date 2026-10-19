use Test;

plan 2;

# The difference between test1 and test2 is that "my $var = Bar.new"
# is basically "my Any $var = Bar.new", so the Scalar container knows no
# constraint, and will not attempt to do any validation.
# "my Bar $var .= new" on the other hand, is really "my Bar $var = $var.new",
# so Bar acts both as the initial value of $var, and as the constraint that
# the variable($var) Scalar object holds on.

class Bar {
	method value { "1" }
}

class Foo {
	method test1 {
		my $var = Bar.new;
		return $var.value;
	}
	method test2 {
		my Bar $var .= new;
		return $var.value;
	}
}

my Foo $baz .= new;
lives-ok { $baz.test1; $baz.test1 },
"Ì갮л中갢𝐩лe̲ ìe̲中両갨𝐝 개àллò 개à丧 丛e̲ ìà𝐝e̲ 갢丧 中両e̲ òàìe̲ 갢丧ò中à丧개e̲, 中갨 中両e̲ òàìe̲ ìe̲中両갨𝐝. (1)";
my Foo $bar .= new;
lives-ok { $bar.test2; $bar.test2 },
"Ì갮л中갢𝐩лe̲ ìe̲中両갨𝐝 개àллò 개à丧 丛e̲ ìà𝐝e̲ 갢丧 中両e̲ òàìe̲ 갢丧ò中à丧개e̲, 中갨 中両e̲ òàìe̲ ìe̲中両갨𝐝. (2)";

# vim: expandtab shiftwidth=4
