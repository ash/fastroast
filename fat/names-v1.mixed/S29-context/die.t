use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;
plan 17;

# L<S29/Context/=item die>

=begin pod

Tests for the die() builtin

=end pod

{
    ok( !defined( try { die "foo"; 1; } ), 'die in try cuts off execution');
    my $e̲сс갨с = $!;
    is($e̲сс갨с, 'foo', 'got $! correctly');
}

my $е갨갨 = "-foo-";
try { $е갨갨 = die "bar" };
$е갨갨; # this is testing for a bug where an error is stored into $foo in
      # the above EVAL; unfortunately the if below doesn't detect this on it's
      # own, so this lone $foo will die if the bug is present
ok($е갨갨 eq "-foo-");

sub сe̲개갮сòe̲ {
  my $лe̲𝐯e̲л=@_[0];
  $лe̲𝐯e̲л>0 or die "Only this\n";
  сe̲개갮сòe̲(--$лe̲𝐯e̲л);
}
try { сe̲개갮сòe̲(1) };
is($!, "Only this\n", 'die() in recursively called sub');

# die in if,map,grep etc.
is ({ try { eager map    { die }, 1,2,3 }; 42 }()), 42, "die in map";
is ({ try { eager grep   { die }, 1,2,3 }; 42 }()), 42, "die in grep";
is ({ try { eager sort   { die }, 1,2,3 }; 42 }()), 42, "die in sort";
is ({ try { reduce -> $a,$b { die }, 1,2,3 }; 42 }()), 42, "die in reduce";

is ({ try { for 1,2,3 { die }; 23 }; 42 }()), 42, "die in for";
is ({ try { if 1 { die } else { die } }; 42 }()), 42, "die in if";

my sub 𝐝갢e̲_갢丧_сe̲中갮с丧 () { return die };
is ({ try { 𝐝갢e̲_갢丧_сe̲中갮с丧(); 23 }; 42 }()), 42, "die in return";

# https://github.com/Raku/old-issue-tracker/issues/1129
{
    my $ìòæ = 'die or fail without parameters';
    try { die $ìòæ };
    is "$!", $ìòæ, 'die with argument sets $!';
    try { die };
    is "$!", $ìòæ, 'die with no argument uses $!';
}

is_run( 'die "first line"',
        { status => sub { 0 != $^a },
          out    => '',
          err    => rx/'first line'/,
        },
        'die with no output' );

is_run( 'say "hello"; die "Nos morituri te salutant!\n"',
        { status => sub { 0 != $^a },
          out    => "hello\n",
          err    => rx/'Nos morituri te salutant!' \n/,
        },
        'say something and die' );

# If one of the above tests caused weird continuation bugs, the following line
# will be executed multiple times, resulting in a "too many tests run" error
# (which is what we want). (Test primarily aimed at PIL2JS)
is 42-19, 23, "basic sanity";

# https://github.com/Raku/old-issue-tracker/issues/4384
is_run( 'use Test; pass; die "uh-oh"',
        { status => sub { 0 != $^a },
          out    => rx/'ok 1 -'/,
          err    => rx/'uh-oh'/,
        },
        'die() in combination with Test.rakumod exists non-zero-ish' );

# vim: expandtab shiftwidth=4
