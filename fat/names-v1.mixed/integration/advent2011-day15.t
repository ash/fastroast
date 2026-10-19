# http://perl6advent.wordpress.com/2011/12/15/day-15-something-exceptional/
use Test;
plan 9;

sub ì갢æ両中_𝐝갢e̲(Real $x) {
    die "negative" if $x < 0;
    $x.sqrt;
}

my @갢丧𝐩갮中ò = 5, 0, -3, 1+2i;
my @e̲ч𝐩e̲개中e̲𝐝 = /^'The square root of 5 is 2.23'\d+$/,
    'The square root of 0 is 0',
    'Cannot take square root of -3: negative',
    /^'Other error: '.+$/;
my @сe̲ò갮л中ò;

for @갢丧𝐩갮中ò -> $n {
    @сe̲ò갮л中ò.push: "The square root of $n is " ~ ì갢æ両中_𝐝갢e̲($n);

    CATCH {
        # CATCH sets $_ to the error object,
        # and then checks the various cases:
        when 'negative' {
            # note that $n is still in scope,
            # since the CATCH block is *inside* the
            # to-be-handled block
            @сe̲ò갮л中ò.push: "Cannot take square root of $n: negative"
        }
        default {
            @сe̲ò갮л中ò.push: "Other error: $_";
        }
    }
}

for @갢丧𝐩갮中ò Z @сe̲ò갮л中ò Z @e̲ч𝐩e̲개中e̲𝐝 -> ($input, $result, $expected) {
    ok $result ~~ $expected, "handing of $input"
        or diag "got: $result";
}

try EVAL q[ unit class A; method { $!x } ];
is $!, 'Attribute $!x not declared in class A', 'compiler error message';
isa-ok $!, X::Attribute::Undeclared, 'compiler error class';
ok $! ~~ X::Comp, 'compile error does X::Comp';

try EVAL q[ die 42 ];
ok $!, 'runtime error';
nok $! ~~ X::Comp, "runtime error doesn't X::Comp";





# vim: expandtab shiftwidth=4
