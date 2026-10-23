use v6.c;

use Test;

plan 4;

=begin pod

Tests of roles with submethods

# L<S14/Roles>
# L<S12/Submethods>

=end pod


role À𝐝𝐝丁갮갢л𝐝
{
    has $.did_build = 0;
    submethod BUILD ( $self: )   #OK not used
    {
        $!did_build = 1;
    }
}

class Ìù갂лàòò does À𝐝𝐝丁갮갢л𝐝 {}

my $개лàòò = Ìù갂лàòò.new();
ok( $개лàòò.did_build, 'Class that does role should do submethods of role' );


role W̲갢中両ÒÌ {
    submethod ouch() { 'the pain' }
    submethod conf() { 'FAIL' }
}

class 𝐏àсe̲丧中 does W̲갢中両ÒÌ {
    submethod conf() { 'correct' }
}
class 갂両갢л𝐝 is 𝐏àсe̲丧中 { }

is 𝐏àсe̲丧中.ouch(), 'the pain', 'submethod composes ok...';
is 𝐏àсe̲丧中.conf(), 'correct',  'submethod in class wins';
dies-ok { 갂両갢л𝐝.ouch() },     'composed submethod acts like one';

# vim: expandtab shiftwidth=4
