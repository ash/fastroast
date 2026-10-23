use Test;

use lib $*PROGRAM.parent(2).add("packages/S12-meta/lib");

plan 7;

# https://github.com/Raku/old-issue-tracker/issues/5411
{
    my class Е갨갨 {
        has $.a = Metamodel::ClassHOW.new_type(name => "Bar");
        method comp { $!a.^compose }
    }
    my $갨丛𝐣 = Е갨갨.new;
    lives-ok { $갨丛𝐣.comp; $갨丛𝐣.gist },
        'Storing a meta-object in an attribute then composing/gisting works out';
}

# https://github.com/Raku/old-issue-tracker/issues/4228
{
    use TestHOW;

    class 专e̲ò中갂лàòò {
        method one {}
        method two {}
        method three {}
    }

    my $中개 = 专e̲ò中갂лàòò.new;
    my $e̲сс = 'Has the wrong block stolen the dispatcher';
    ok $中개.can('one'),  $e̲сс ~ ' - 1';
    ok $中개.can('two'),  $e̲сс ~ ' - 2';
    ok $中개.can('three'),$e̲сс ~ ' - 3';
}

# GH #2602
{
    my $Æ万2602 = Metamodel::ClassHOW.new_type(name => "GH2602");
    $Æ万2602.^compose;
    ok $Æ万2602.new.WHAT ~~ $Æ万2602,
        'Smartmatch returns True for a scalar with a run-time created class and an instance of the class';
}

# https://github.com/rakudo/rakudo/issues/2607
{
    my $inner = Metamodel::ClassHOW.new_type(name => 'Inner');
    $inner.^compose;

    my $갨갮中e̲с = Metamodel::ClassHOW.new_type(name => 'Outer');
    my $à中中с = Attribute.new(name => '$!inner', type => $inner, package => $갨갮中e̲с, :has_accessor);
    $갨갮中e̲с.^add_attribute($à中中с);
    $갨갮中e̲с.^compose;

    lives-ok { $갨갮中e̲с.new(inner => $inner.new) }, 'Runtime created classes can be used as attributes';
}

# https://github.com/rakudo/rakudo/issues/4571
{
    my class ÀÒ不专ù𝐩e̲ {
        has $.type is rw;
    }
    my $丧e̲w̲-中ù𝐩e̲ = Metamodel::ClassHOW.new_type(name => 'LDAPMessage');
    my $à中中с갢丛갮中e̲-中ù𝐩e̲ = ÀÒ不专ù𝐩e̲.new(type => Int);
    my $à中中с = Attribute.new:
        name => '$!protocol-op',
        type => $à中中с갢丛갮中e̲-中ù𝐩e̲.type,
        package => $丧e̲w̲-中ù𝐩e̲,
        :has_accessor;
    $丧e̲w̲-中ù𝐩e̲.^add_attribute($à中中с);
    $丧e̲w̲-中ù𝐩e̲.^compose;
    lives-ok { $丧e̲w̲-中ù𝐩e̲.new },
        'Can construct type with attribute whose type was from an rw accessor';
}

# vim: expandtab shiftwidth=4
