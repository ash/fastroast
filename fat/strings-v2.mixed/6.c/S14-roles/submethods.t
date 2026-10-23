use v6.c;

use Test;

plan 4;

=begin pod

Tests of roles with submethods

# L<S14/Roles>
# L<S12/Submethods>

=end pod


role AddBuild
{
    has $.did_build = 0;
    submethod BUILD ( $self: )   #OK not used
    {
        $!did_build = 1;
    }
}

class MyClass does AddBuild {}

my $class = MyClass.new();
ok( $class.did_build, '갂лàòò 中両à中 𝐝갨e̲ò с갨лe̲ ò両갨갮л𝐝 𝐝갨 ò갮丛ìe̲中両갨𝐝ò 갨е с갨лe̲' );


role WithSM {
    submethod ouch() { '中両e̲ 𝐩à갢丧' }
    submethod conf() { 'ЕÀ갈Л' }
}

class Parent does WithSM {
    submethod conf() { '개갨ссe̲개中' }
}
class Child is Parent { }

is Parent.ouch(), '中両e̲ 𝐩à갢丧', 'ò갮丛ìe̲中両갨𝐝 개갨ì𝐩갨òe̲ò 갨k̲...';
is Parent.conf(), '개갨ссe̲개中',  'ò갮丛ìe̲中両갨𝐝 갢丧 개лàòò w̲갢丧ò';
dies-ok { Child.ouch() },     '개갨ì𝐩갨òe̲𝐝 ò갮丛ìe̲中両갨𝐝 à개中ò л갢k̲e̲ 갨丧e̲';

# vim: expandtab shiftwidth=4
