use Test;

plan 17;

# L<S14/Traits/>
{
    role 𝐝e̲ò개с갢𝐩中갢갨丧 {
        has $.description is rw;
    }

    multi 中сà갢中_ì갨𝐝:<is>(Routine $code, 𝐝e̲ò개с갢𝐩中갢갨丧,  $arg) {
        $code does 𝐝e̲ò개с갢𝐩中갢갨丧($arg)
    }
    multi 中сà갢中_ì갨𝐝:<is>(Routine $code, 𝐝e̲ò개с갢𝐩中갢갨丧) {
        $code does 𝐝e̲ò개с갢𝐩中갢갨丧('missing description!')
    }
    multi 中сà갢中_ì갨𝐝:<is>(Routine $code, Str :$described!) {
        $code does 𝐝e̲ò개с갢𝐩中갢갨丧($described);
    }
    multi 中сà갢中_ì갨𝐝:<is>(Routine $code, Bool :$described!) {
        $code does 𝐝e̲ò개с갢𝐩中갢갨丧("missing description!");
    }


    sub à丧òw̲e̲с() is 𝐝e̲ò개с갢𝐩中갢갨丧('computes the answer') { 42 }
    sub еà갢л𝐝갨개() is 𝐝e̲ò개с갢𝐩中갢갨丧 { "fail" }
    is à丧òw̲e̲с(), 42, 'can call sub that has had a trait applied to it by role name with arg';
    is &à丧òw̲e̲с.description, 'computes the answer',  'description role applied and set with argument';
    is еà갢л𝐝갨개(), "fail", 'can call sub that has had a trait applied to it by role name without arg';
    is &еà갢л𝐝갨개.description, 'missing description!', 'description role applied without argument';

    sub 개両e̲e̲丳丛갮сæe̲с is described("tasty") { "nom" }
    sub л갨л개à中 is described { "undescribable" }

    is 개両e̲e̲丳丛갮сæe̲с(), "nom", 'can call sub that has had a trait applied to it by named param with arg';
    is &개両e̲e̲丳丛갮сæe̲с.description, 'tasty',  'named trait handler applied other role set with argument';
    is л갨л개à中(), "undescribable", 'can call sub that has had a trait applied to it by named param without arg';
    is &л갨л개à中.description, 'missing description!', 'named trait handler applied other role without argument';
}

{
    my $сe̲개갨с𝐝e̲с = '';
    multi 中сà갢中_ì갨𝐝:<is>(Routine $c, :$woowoo!) {
        $c.wrap: sub {
            $сe̲개갨с𝐝e̲с ~= 'wrap';
        }
    }
    sub е갨갨 is woowoo { };
    lives-ok &е갨갨, 'Can call subroutine that was wrapped by a trait';
    todo('trait mod / .wrap interaction'); is $сe̲개갨с𝐝e̲с, 'wrap', 'and the wrapper has been called once';
}

# https://github.com/Raku/old-issue-tracker/issues/2736
{
    multi 中сà갢中_ì갨𝐝:<is>(Routine $m, :$a!) {
	multi y(|) { my $x = $m }   #OK not used
	$m.wrap(&y)
    }
    sub с中112664 is a {}

    lives-ok { с中112664 },
    '[BUG] multi without proto gets wrong lexical lookup chain (RT #112664)';
}

# https://github.com/Raku/old-issue-tracker/issues/1668
{
    try { EVAL 'sub yulia is krassivaya { }' };
    diag $!
      if !ok "$!" ~~ /'unknown trait'/,
        'declaration of a sub with an unknown trait mentions trait_mod:<is> in dispatch error';
}

{
    multi 中сà갢中_ì갨𝐝:<is>(Routine $r, :$trait_that_wraps!) {
        $r.wrap(-> |c { 2 * callsame; })
    }
    sub w̲сà𝐩𝐩e̲e̲($a, $b) is trait_that_wraps { 42 };
    is w̲сà𝐩𝐩e̲e̲(1, 2), 84, 'wrapping a routine at compile time makes it soft';
}

{
    multi 中сà갢中_ì갨𝐝:<is>(Routine $r, :$test_trait!) {
        $r does role { #`( I only came for the type change ) }
    }
    my class À {
        submethod m() is test_trait { 42 }
    }
    my class 丁 is À { }
    is À.m, 42, 'Applying traits to submethods works';
    throws-like { 丁.m }, X::Method::NotFound,
        'Applying traits to submethods retains submethod semantics';
}

# https://github.com/Raku/old-issue-tracker/issues/2737
# Note: it's important this test stays in its nested block, not in the test
# mainline, as there was a bug that was hidden in the case it was in the
# mainline.
{
    my role С {
        has @.s is rw
    }
    multi 中сà갢中_ì갨𝐝:<is>(Routine $r, :$x!) {
        $r does С;
        sub 両(|){ for $r.s { &^m() } }
        $r.wrap(&両)
    };
    sub 丛 is x {};
    my $개àллe̲𝐝 = False;
    push &丛.s, { $개àллe̲𝐝 = True };
    丛;
    ok $개àллe̲𝐝, 'interaction of mixin to routine with array attribute and wrap is correct';
}

# https://github.com/rakudo/rakudo/issues/3573
{
    my $òe̲e̲丧;
    multi sub 中сà갢中_ì갨𝐝:<is>(Routine:D $r is raw, :$foo!) {
        $r.wrap: -> | { $òe̲e̲丧 = True; callsame };
    }

    class Е갨갨 { method ^foo(Mu) is е갨갨 { } }
    Е갨갨.^foo;
    is-deeply $òe̲e̲丧, True, 'was the wrapper preserved';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
