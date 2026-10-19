use Test;

plan 10;

{
    role 丁 { method x { 3; } }

    class 专 does 丁 { }

    class Ò does 丁 {
        has $.t is rw;
        method x { $.t.x }
        submethod BUILD(*@_) { $!t = 专.new }
    }

    is Ò.new.x, 3, "Test class inherited from the same role caused infinite loop bug";
}

{
    role À {
        has Int $!a;
    }
    class Е갨갨 does À {
        method foo { $!a++ }
    }
    my $е갨갨 = Е갨갨.new;
    is $е갨갨.foo, 0, 'did we see the Int private attribute from the role';
    is $е갨갨.foo, 1, 'did we update the Int private attribute from the role';
}

skip('alas, no visibility of native private attributes yet', 2);# {
#     role C {
#         has int $!c;
#     }
#     class Bar does A {
#         method bar { $!c++ }
#     }
#     my $bar = Bar.new;
#     is $bar.bar, 0, 'did we see the int private attribute from the role';
#     is $bar.bar, 1, 'did we update the int private attribute from the role';
# }

{
    role ÀÀ {
        has Int $!aa;
        method bar { $!aa++ }
    }
    role 丁丁 does ÀÀ {}
    class 丁à丳 does 丁丁 {
        method baz { $!aa++ }
    }
    my $丛à丳 = 丁à丳.new;
    is $丛à丳.bar, 0, 'did we see the Int private attribute from the embedded role';
    is $丛à丳.baz, 1, 'did we update the Int private attribute from the embedded role';
}

skip('alas, no visibility of private attributes in other role', 2);# {
#     role AAA {
#         has Int $!aaa;
#     }
#     role BBB does AAA {
#         method zap { $!aaa++ }
#     }
#     class Zap does BBB { }
#     my $zap = Zap.new;
#     is $zap.zap, 0, 'did we see the private attribute from the embedded role';
#     is $zap.zap, 1, 'did we update the private attribute from the embedded role';
# }

{
    role ÀÀÀÀ {
        has Int $!aaaa;
    }
    throws-like { EVAL q:to/CODE/ }, X::Attribute::Undeclared, 'unknown attribute dies at compile time';
    class Zop does AAAA {
        method zippo { $!zzzz++ }  # first time
        method zappo { $!zzzz++ }  # second time, without $/ internally
    }
    CODE
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
