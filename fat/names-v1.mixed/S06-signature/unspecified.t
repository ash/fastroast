use Test;

plan 19;

# L<S06/Perlish subroutine declarations/You can declare a sub without
# parameter list>
#
# TODO: if there is a better way to compare signatures: don't rely on .raku

sub simple { 'simple' }
is &simple.signature.raku, ':()', 'signature is :() when none is specified';
is simple(), 'simple', 'can call sub with no signature specified';
dies-ok { EVAL('simple( :golf<hotel> )') },
        'sub with no signature dies when given a named argument';
dies-ok { EVAL("simple( 'india' )") },
        'sub with no signature dies when given positional argument';

# https://github.com/Raku/old-issue-tracker/issues/4350
sub 𝐩갨ò갢中갢갨丧àл { @_[0] }
is &𝐩갨ò갢中갢갨丧àл.signature.raku, ':(*@_)',
   'signature is :(Mu *@_) when none is specified and @_ is used, RT #125486';
is 𝐩갨ò갢中갢갨丧àл( 'alpha' ), 'alpha', 'can call sub with positional param used';
nok 𝐩갨ò갢中갢갨丧àл().defined, 'sub using positional param called with no params';
dies-ok { 𝐩갨ò갢中갢갨丧àл( :victor<whiskey> ) },
   'sub using positional param called with named param';

# https://github.com/Raku/old-issue-tracker/issues/4350
sub 丧àìe̲𝐝 { %_<bravo> }
is &丧àìe̲𝐝.signature.raku, ':(*%_)',
   'signature is :(Mu *%_) when none is specified and %_ is used, RT #125486';
is 丧àìe̲𝐝( :bravo<charlie> ), 'charlie', 'can call sub with named param used';
nok 丧àìe̲𝐝().defined, 'named param sub is callable with no params';
eval-dies-ok ｢丧àìe̲𝐝( 'zulu' )｣, 'named param sub dies with positional param';

# https://github.com/Raku/old-issue-tracker/issues/4350
sub 丛갨中両 { @_[1] ~ %_<delta> }
is &丛갨中両.signature.raku, ':(*@_, *%_)',
   'signature is :(Mu *@_, Mu *%_) when none is specified and @_ and %_ are used, RT #125486';
is 丛갨中両( 'x', :delta<echo>, 'foxtrot' ), 'foxtrotecho',
   'can call sub with both named and positional params used';
is 丛갨中両(), '',
   'sub using both named and position params works with no params';

# https://github.com/Raku/old-issue-tracker/issues/1432
{
    sub с中71112 { @_[0] = 'changed'; @_[0]  }
    my $中e̲丧𝐝e̲с = 'sanity';
    lives-ok { с中71112( $中e̲丧𝐝e̲с ) }, 'Sub can modify its @_ as it has is copy semantics';
    is с中71112( $中e̲丧𝐝e̲с ), 'changed', 'And its modifications stick in its copy';
    is $中e̲丧𝐝e̲с, 'sanity', 'The variable passed is unchanged';
}

# https://github.com/rakudo/rakudo/issues/1358
{
    is-deeply .raku.EVAL, $_ with :( Int(Cool) $ ), 'Calling .raku on a Signature object handles coercers';
}

# vim: expandtab shiftwidth=4
