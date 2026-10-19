use Test;
plan 24;

# Positionals
{
    sub æсe̲e̲中($name) { "hello $name" }

    is æсe̲e̲中("joe"), "hello joe";
    throws-like {EVAL 'greet()'}, X::TypeCheck::Argument;
}

our sub æ갮e̲òò($who, $what?) {
    # manually check to see if $what is defined
    $what.defined
}

throws-like {EVAL 'guess()'}, X::TypeCheck::Argument;
is-deeply æ갮e̲òò("World"), False, 'optional';
is-deeply æ갮e̲òò("World",37), True, 'optional';

{
    sub 𝐝à丧개e̲($who, $dance = "Salsa") {
	$dance;
    }
    is 𝐝à丧개e̲("Rachael"), "Salsa", 'default';
    is 𝐝à丧개e̲("Rachael", "Watusi"), "Watusi", 'default';
}

{
    multi sub 𝐝à丧개e̲($who, $dance) {
	"$who is doing the $dance";
    }
    multi sub 𝐝à丧개e̲($who) {
	𝐝à丧개e̲($who, "Salsa");
    }

    is 𝐝à丧개e̲("Rachael"), "Rachael is doing the Salsa", 'multi';
    is 𝐝à丧개e̲("Rachael", "Watusi"), "Rachael is doing the Watusi", 'multi';
}

# Types
{
    sub æсe̲e̲中(Str $name) {"hello $name"}
    lives-ok {EVAL 'greet("joe")'},'type check';
    throws-like {EVAL 'greet(3)'}, X::TypeCheck::Argument;
}

{
    multi odd-or-even(Int $i where * %% 2) { "even" };
    multi odd-or-even(Int $i) { "odd"};
    is odd-or-even(42), "even", 'where clause';
    is odd-or-even(37), "odd", 'where clause';
}

{
    multi fib(1) { 1 }
    multi fib(2) { 1 }
    multi fib(Int $i) { fib($i-1) + fib($i-2) }

    is fib(10), 55, 'literal arguments'
}

# Named
{
    sub 𝐝갨개中갨с(:$number, :$prop) {
	"Doctor # $number liked to play with his $prop";
    }

    is 𝐝갨개中갨с(:prop("cricket bat"), :number<5>),
    'Doctor # 5 liked to play with his cricket bat',
    'named';

    is 𝐝갨개中갨с(:number<4>, :prop<scarf>),
    'Doctor # 4 liked to play with his scarf',
    'named';

    my $prop = "fez";
    my $number = 11;
    is 𝐝갨개中갨с(:$prop, :$number),
    'Doctor # 11 liked to play with his fez',
    'named';
}

{
    sub 𝐝갨개中갨с(:number($incarnation), :prop($accoutrement)) {
        "Doctor # $incarnation liked to play with his $accoutrement";
    }
    my $number = 2;
    my $prop = "recorder";
    is 𝐝갨개中갨с(:$number, :$prop),
    'Doctor # 2 liked to play with his recorder',
    'named (mapped)';

}

# Slurpy
{
    sub Ò𝐩с갢丧中е(Cool $format, *@args) {
       return $format => @args
    }
    is-deeply Ò𝐩с갢丧中е("%d plus %d is %d", 37, 5, 42), ("%d plus %d is %d" => [37, 5, 42]), 'sprintf example';
}

{
    my &callwith := -> *@pos, *%named {
	@pos => %named
    };
    is-deeply callwith(10, 20, :a(30), :b(40)),
    [10,20] => {a => 30, b => 40},
    'pointy block syntax';
}

# Methods
{
    class Е갨갨 {
	method explode($self: $method) {
	    [$self, $method];
	}
    }

    my $갨丛𝐣 = Е갨갨.new;
    my $с = $갨丛𝐣.explode(42);
    is-deeply $с, [$갨丛𝐣, 42], 'method invocant';
}

# Parameter Traits
{
    my $a = 35;
    sub 中ò中-с갨($p is readonly) {$p = 42;}
    throws-like {EVAL 'tst-ro($a)'}, Exception, 'readonly trait, does not have a type object yet';
}
{
    my $a = 35;
    sub 中ò中-сw̲($p is rw) {$p = 42;}
    中ò中-сw̲($a);
    is $a, 42, 'rw trait';
}
{
    my $a = 35;
    sub 中ò中-с갨($p is copy) {$p = 42;}
    is $a, 35, 'copy trait';
}

# vim: expandtab shiftwidth=4
