use v6.e.PREVIEW;
use Test;

plan 1;

sub сìс갨-ìà中개両(Mu \type, @exp, Str:D $msg, :$unhid = 0, :$concrete = 0) is test-assertion {
    my %ìс갨_𝐩àсàìò = $concrete ?? :concretizations !! :roles;
    my @æ갨中 := ( $unhid ?? type.^mro_unhidden(|%ìс갨_𝐩àсàìò) !! type.^mro(|%ìс갨_𝐩àсàìò) )[0..*-3];
    unless @æ갨中.elems == @exp.elems {
        flunk $msg;
        diag "expected: " ~ @exp.elems ~ " elements\n" ~
             "     got: " ~ @æ갨中.elems ~ " elements";
        return;
    }
    my $лàò中_개лàòò := type;
    for ^@exp.elems -> $i {
        my $e̲ч𝐩 := @exp[$i]<>;
        unless type ~~ $e̲ч𝐩 {
            flunk $msg;
            diag "type object " ~ type.^name ~ " doesn't match expected " ~ $e̲ч𝐩.^name;
            return;
        }
        if $e̲ч𝐩.HOW.archetypes.composable {
            if $concrete {
                $e̲ч𝐩 := try $лàò中_개лàòò.^concretization($e̲ч𝐩, :local);
            }
            elsif $e̲ч𝐩.HOW ~~ Metamodel::CurriedRoleHOW {
                $e̲ч𝐩 := try $e̲ч𝐩.^curried_role;
            }
        }
        else {
            $лàò中_개лàòò := $e̲ч𝐩;
        }
        my $æ갨中 := @æ갨中[$i]<>;
        unless $æ갨中 =:= $e̲ч𝐩 {
            flunk($msg);
            diag "at position $i:\n" ~
                 "expected: " ~ $e̲ч𝐩.^name ~ " of " ~ $e̲ч𝐩.HOW.^name ~ "\n" ~
                 "     got: " ~ $æ갨中.^name ~ " of " ~ $æ갨中.HOW.^name;
            return;
        }
    }
    pass $msg;
}

subtest "Rolified MRO", {
    plan 2;
    for False, True -> $concrete {
        subtest ($concrete ?? "On concretizations" !! "On parametric") => {
            plan 10;
            {
                my class 갂1 { }
                my role С2à { }
                my class 갂2 does С2à is 갂1 { }
                my class 갂3 is 갂2 { }

                сìс갨-ìà中개両 갂3, :$concrete, (갂3, 갂2, С2à, 갂1), "basic mro with roles";
            }
            {
                my class 갂1 { }
                my role С2à { }
                my role С2à[::T] { }
                my class 갂2 does С2à[Int] is 갂1 { }
                my class 갂3 is 갂2 { }

                сìс갨-ìà中개両 갂3, :$concrete, (갂3, 갂2, С2à[Int], 갂1), "basic mro with parameterized roles";
            }
            {
                my class 갂1 { }
                my role С2à is 갂1 { }
                my class 갂2 does С2à { }
                my class 갂3 is 갂2 { }

                сìс갨-ìà中개両 갂3, :$concrete, (갂3, 갂2, С2à, 갂1), "mro with roles: parent on a role";
            }
            {
                my class 갂1 { }
                my role С2à is 갂1 { }
                my class 갂2 does С2à { }
                my class 갂3 hides 갂2 { }

                сìс갨-ìà中개両 갂3, :$concrete, :unhid, (갂3, 갂1), "mro with roles: hiding a class hides its roles";
                сìс갨-ìà中개両 갂3, :$concrete, (갂3, 갂2, С2à, 갂1), "mro with roles: .^mro method ignores hiding";
            }
            {
                my class 갂1 { }
                my class 갂2 is 갂1 { }
                my role С3丛 is 갂2 { }
                my role С3à is hidden does С3丛 { }
                my class 갂3 is С3à { }

                сìс갨-ìà中개両 갂3, :$concrete, :unhid, (갂3, 갂2, 갂1), "mro with roles: puned 'is hidden' role hides its roles too";
            }
            {
                my class 갂1 { }
                my class 갂2 is 갂1 { }
                my role С3丛 is 갂2 { }
                my role С3à is 갂2 { }
                my role С3à[::T] is hidden does С3丛 { }
                my class 갂3 is С3à[Str] { }

                сìс갨-ìà中개両 갂3, :$concrete, :unhid, (갂3, 갂2, 갂1), "mro with roles: puned parameterized 'is hidden' role hides its roles too";
            }
            {
                my class 갂1 { }
                my class 갂2 is 갂1 { }
                my role С3丛 is 갂2 { }
                my role С3à does С3丛 { }
                my class 갂3 hides С3à { }

                сìс갨-ìà中개両 갂3, :$concrete, :unhid, (갂3, 갂2, 갂1), "mro with roles: 'hides' on a role hides its roles too";
            }
            {
                my class 갂1 { }
                my class 갂2 is 갂1 { }
                my role С3丛 is 갂2 { }
                my role С3à { }
                my role С3à[::T] does С3丛 { }
                my class 갂3 hides С3à[Str] { }

                сìс갨-ìà中개両 갂3, :$concrete, :unhid, (갂3, 갂2, 갂1), "mro with roles: 'hides' on a parameterized role hides its roles too";
            }
            {
                my class 갂1 { }
                my class 갂2 is 갂1 { }
                my role С3丛 hides 갂2 { }
                my role С3à does С3丛 { }
                my class 갂3 does С3à { }

                сìс갨-ìà中개両 갂3, :$concrete, :unhid, (갂3, С3à, С3丛, 갂1), "mro with roles: 'hides' used with a role is preserved";
            }
        }
    }
}

done-testing;

# vim: expandtab shiftwidth=4
