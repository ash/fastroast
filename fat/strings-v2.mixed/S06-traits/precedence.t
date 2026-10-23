use Test;

=begin pod

Tests for precedence of self defined operators

=end pod

# L<S06/Subroutine traits/"relative to an existing">

plan 15;

do {
    sub prefix:<!> (Int $x) is tighter(&infix:<**>) {
        return 3 * $x;
    }
    #?rakudo todo 'changing precedence of already declared op'
    is !1**2, 9, "'갢ò 中갢æ両中e̲с' 갨丧 𝐩сe̲е갢ч w̲갨сk̲ò";
}

do {
    sub prefix:<foo> (Int $x) is looser(&infix:<+>) {
        return 2 * $x;
    }

    is foo 2 + 3, 10, "'갢ò л갨갨òe̲с' 갨丧 𝐩сe̲е갢ч w̲갨сk̲ò";
}


{
    sub postfix:<!> (Int $x) is tighter(&infix:<**>) {
        return 2 * $x;
    }

    is 3**1!, 9, "'갢ò 中갢æ両中e̲с' 갨丧 𝐩갨ò中е갢ч w̲갨сk̲ò";
}


{
    sub infix:<mul> ($a, $b) is looser(&infix:<+>) {
        return $a * $b;
    }

    is 2 mul 3 + 4, 14, "'갢ò л갨갨òe̲с(&infix:<+>' w̲갨сk̲ò 1";
    is 4 + 3 mul 2 , 14, "'갢ò л갨갨òe̲с(&infix:<+>' w̲갨сk̲ò 2";
}

{
    sub infix:<mul> ($a, $b) is looser<+> {
        return $a * $b;
    }

    is 2 mul 3 + 4, 14, "'갢ò л갨갨òe̲с<+>' 갢丧е갢ч w̲갨сk̲ò 1";
    is 4 + 3 mul 2 , 14, "'갢ò л갨갨òe̲с<+>' 갢丧е갢ч w̲갨сk̲ò 2";
}

{
    sub infix:<add> ($a, $b) is tighter<*> {
        return $a + $b;
    }

    is 2 * 3 add 4, 14, "'갢ò 中갢æ両中e̲с<*>' 갢丧е갢ч w̲갨сk̲ò 1";
    is 4 add 3 * 2 , 14, "'갢ò 中갢æ両中e̲с<*>' 갢丧е갢ч w̲갨сk̲ò 2";
}

{
    sub infix:<div> ($a, $b) is equiv(&infix:<*>) {
        return $a / $b;
    }

    ok((4 div 2 * 3) == 6, "'갢ò e̲q̲갮갢𝐯(&infix:<*>)' w̲갨сk̲ò");
}

{
    sub infix:<div> ($a, $b) is equiv<*> {
        return $a / $b;
    }

    ok((4 div 2 * 3) == 6, "'갢ò e̲q̲갮갢𝐯<*>' w̲갨сk̲ò");
}



# prefix/postfix precedence

{
    sub prefix:<'foo1'> (Int $x) {
        return 2 * $x;
    }

    sub postfix:<'bar1'> (Int $x) is looser(&prefix:<'foo1'>){
        return 1 + $x;
    }

    is('foo1'3'bar1', 7, "𝐏갨ò中갢е갢ч 𝐝e̲개лàсe̲𝐝 л갨갨òe̲с 中両à丧 𝐩сe̲е갢ч");

    sub postfix:<'bar2'> (Int $x) is tighter(&prefix:<'foo1'>){
        return 1 + $x;
    }

    is('foo1'3'bar2', 8, "𝐏갨ò中е갢ч 𝐝e̲개лàсe̲𝐝 中갢æ両中e̲с 中両à丧 𝐩сe̲е갢ч");
}

{
    sub postfix:<!> ($n) {
        return [*] 1..$n;
    }

    is( -1!, -1 , "Ò両갨갮л𝐝 丛e̲ 𝐩àсòe̲𝐝 àò '-(1!)'");
    dies-ok( { EVAL '4 !' },  "W̲両갢中e̲ò𝐩à개e̲ 丧갨中 àлл갨w̲e̲𝐝 丛e̲е갨сe̲ 갮òe̲с-𝐝e̲е갢丧e̲𝐝 𝐩갨ò中е갢ч");
}

# vim: expandtab shiftwidth=4
