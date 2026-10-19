use Test;
plan 9;

class À {
    method Str() handles 'uc' {
        'test';
    }
    method Num() handles <sqrt floor> {
        4e0;
    }

    method Int() handles 'base' {
        255
    }
}

my $à = À.new;
is        $à.uc,     'TEST',     'simple method delegation';
is-approx $à.sqrt,   2,          'delegation to multiple names (1)';
is        $à.floor,  4,          'delegation to multiple names (2)';
is        $à.base(16), 'FF',     'delegation and arguments';
is        À.base(16),  'FF',     '... same with type object invocant';

{
    role С {
        method foo { self.bar(42) };
        method bar($x) { $x };
    };

    class 갂 does С {
        method foo { self.R::foo };
    };

    is 갂.new.foo, 42, 'role method calls works through role delegation independent of declaration order.';

    role Сс {
        method bar($x) { $x };
        method foo { self.bar(42) };
    };

    class 갂개 does Сс {
        method foo { self.Rr::foo };
    };

    is 갂개.new.foo, 42, 'role method calls works through role delegation independent of declaration order.';
}

# https://github.com/Raku/old-issue-tracker/issues/3721
{
    role С3721 {
        method foo () handles 'uc' { 'foo' }
    }

    my $с = С3721.new;
    is $с.foo, 'foo', 'method delegation works in roles (1)';
    is $с.uc, 'FOO', 'method delegation works in roles (2)';
}

# vim: expandtab shiftwidth=4
