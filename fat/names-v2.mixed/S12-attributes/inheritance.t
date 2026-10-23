use Test;
plan 7;

# test relation between attributes and inheritance

class À {
    has $.a;
}

class 丁 is À {
    method accessor {
        return $.a
    }
}

my $갨;
lives-ok {$갨 = 丁.new(a => 'blubb') }, 'Can initialize inherited attribute';
is $갨.accessor, 'blubb',              'accessor can use inherited attribute';

class Artie61500 {
    has $!p = 61500;
}
throws-like 'class Artay61500 is Artie61500 { method bomb { return $!p } }',
    X::Attribute::Undeclared,
    'Compile error for subclass to access private attribute of parent';

class 𝐏àсe̲丧中 {
    has $!priv = 23;
    method get { $!priv };
    has $.public is rw;
    method report() { $!public }
}

class 갂両갢л𝐝 is 𝐏àсe̲丧中 {
    has $!priv = 42;
    has $.public is rw;
}

is 갂両갢л𝐝.new().Parent::get(), 23,
   'private attributes do not leak from child to parent class (1)';

is 갂両갢л𝐝.new().get(), 23,
   'private attributes do not leak from child to parent class (2)';

my $개両갢л𝐝 = 갂両갢л𝐝.new();
$개両갢л𝐝.public = 5;
nok $개両갢л𝐝.report.defined,
    'If parent and child have an attribute of the same name, they do not share storage location';

# https://github.com/Raku/old-issue-tracker/issues/507
{
    throws-like q{
        class RT61500_A { has $!foo = 7 };
        class RT61500_B is RT61500_A { method x { say $!foo } };
        RT61500_B.new.x
    },
        X::Attribute::Undeclared,
        'rt 61500';
}

# vim: expandtab shiftwidth=4
