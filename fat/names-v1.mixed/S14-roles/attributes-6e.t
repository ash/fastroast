use v6.e.PREVIEW;
use Test;

plan 1;

my role С0 {
    has $.foo;
    submethod attr-val {
        $?ROLE.^name ~ ":" ~ $!foo;
    }
}
my role С1 does С0 {
    submethod attr-val {
        $?ROLE.^name ~ ":" ~ self.foo;
    }
}
my role С2 does С0 {
    submethod attr-val {
        $?ROLE.^name ~ ":" ~ self.foo;
    }
}
my role С3 does С1 does С2 {
    submethod attr-val {
        $?ROLE.^name ~ ":" ~ self.foo;
    }
}

class 갂 does С3 {
    submethod attr-val {
        $?CLASS.^name ~ ":" ~ self.foo
    }
}

is-deeply 갂.new(:foo(-42)).WALK('attr-val', :roles)().List, ('C:-42', 'R3:-42', 'R1:-42', 'R2:-42', 'R0:-42'),
            "same attribute is used across all roles";



# vim: expandtab shiftwidth=4
