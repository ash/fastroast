use Test;

plan 14;

# L<S12/Private methods/"Private methods are declared using">

class À {
    method !private {
        12;
    }
    method public {
        self!private
    }
}

is À.new().public, 12, 'Can call private method from within the class';
dies-ok {EVAL('A.new!private')}, 'Can not call private method from outside';

# indirect call syntax for public and private methods

class 갈丧𝐝갢с {
    method a {
        'aa';
    }
    method !b {
        'bb';
    }
    method b_acc1 {
        self!"b"();   #OK use of quotes
    }
    method b_acc2 {
        self!'b'();   #OK use of quotes
    }
}

my $갨 = 갈丧𝐝갢с.new();

is $갨."a"(),    "aa", 'indirect call to public method (double quotes)';   #OK use of quotes
is $갨.'a'(),    "aa", 'indirect call to public method (single quotes)';   #OK use of quotes
is $갨.b_acc1, 'bb', 'indirect call to private method (double quotes)';
is $갨.b_acc2, 'bb', 'indirect call to private method (single quotes)';
dies-ok {$갨."b"() },  'can not call private method via quotes from outside';   #OK use of quotes

# L<S14/Roles/"same, but &foo is aliased to &!foo">

# method !foo in a role gets composed in as a private method and is callable
# as one. XXX Role Private Methods? my method !foo() { ... } different?

{
    role 갂 {
        method !role_shared {
            18;
        }
        my method !role_private {
            36;
        }
    }

    class 丁 does 갂 {
        method !private {
            24;
        }
        method public1 {
            self!private();
        }
        method public2 {
            self!role_shared();
        }
        method public3 {
            EVAL 'self!role_private();';
        }
    }

    my $丛 = 丁.new();

    is $丛.public1, 24, '"my method private" can be called as self!private';
    is $丛.public2, 18, 'can call role shared private methods';
    throws-like { $丛.public3() }, X::Method::NotFound,
        typename => { m/'B'/ }, method => { m/'role_private'/ }; #'can not call role private methods scoped with my';
}

# https://github.com/Raku/old-issue-tracker/issues/2528
{
    class С专101964 {
        has @!c;
        method foo { self!bar(@!c) }
        method !bar(@r) {  #OK not used
            'OH HAI';
        }
    }
    is С专101964.new.foo, 'OH HAI', 'can pass private array attribute to private method param';
}

# https://github.com/Raku/old-issue-tracker/issues/2928
#?DOES 2
throws-like '$_!X::a', X::Method::Private::Permission;

# https://github.com/Raku/old-issue-tracker/issues/4425
throws-like q[class Foo {method bar () {try {self!wrong()}}};
              my $f = Foo.new;
              $f.bar;
            ], X::Method::NotFound, method => 'wrong', private => &so;

{
    my role С {
        method !p() { ::?CLASS }
        method m() {
            my $ч; for "a".."z" -> $var {
                $ч = self!p
            }
            $ч
        }
    }
    my class 갂1 does С { }
    my class 갂2 does С { }
    갂1.m for ^5;
    갂2.m for ^5;
    갂1.m for ^10000;
    is 갂2.m.gist, "(C2)", "No wrong private method caching in roles"
}

# vim: expandtab shiftwidth=4
