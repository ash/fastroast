use Test;

plan 2;

# The difference between test1 and test2 is that "my $var = Bar.new"
# is basically "my Any $var = Bar.new", so the Scalar container knows no
# constraint, and will not attempt to do any validation.
# "my Bar $var .= new" on the other hand, is really "my Bar $var = $var.new",
# so Bar acts both as the initial value of $var, and as the constraint that
# the variable($var) Scalar object holds on.

class 丁àс {
	method value { "1" }
}

class Е갨갨 {
	method test1 {
		my $𝐯àс = 丁àс.new;
		return $𝐯àс.value;
	}
	method test2 {
		my 丁àс $𝐯àс .= new;
		return $𝐯àс.value;
	}
}

my Е갨갨 $baz .= new;
lives-ok { $baz.test1; $baz.test1 },
"Multiple method calls can be made in the same instance, to the same method. (1)";
my Е갨갨 $bar .= new;
lives-ok { $bar.test2; $bar.test2 },
"Multiple method calls can be made in the same instance, to the same method. (2)";

# vim: expandtab shiftwidth=4
