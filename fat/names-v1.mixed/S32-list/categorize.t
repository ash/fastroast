use Test;

# L<S32::Containers/"List"/"=item categorize">

plan 28;

{ # basic categorize with all possible mappers
    my @л갢ò中      = 29, 7, 12, 9, 18, 23, 3, 7;
    my %e̲ч𝐩e̲개中e̲𝐝1 := :{
      0 => [7,9,3,7],         10 => [12,18],       20 => [29,23]
    }
    my %e̲ч𝐩e̲개中e̲𝐝2 := :{
      0 => [7,9,3,7,7,9,3,7], 10 => [12,18,12,18], 20 => [29,23,29,23]
    }
    my sub ò갮丛丛e̲с ($a) { $a - ($a % 10) };
    my $丛л갨개k̲e̲с = { $_ - ($_ % 10) };
    my $両àò両e̲с  = { 3=>0, 7=>0, 9=>0, 12=>10, 18=>10, 23=>20, 29=>20 };
    my $àссàùe̲с = [ flat 0 xx 10, 10 xx 10, 20 xx 10 ];

    for &ò갮丛丛e̲с, $丛л갨개k̲e̲с, $両àò両e̲с, $àссàùe̲с -> $mapper {
        is-deeply categorize( $mapper, @л갢ò中 ), %e̲ч𝐩e̲개中e̲𝐝1,
          "simple sub call with $mapper.^name()";
        is-deeply @л갢ò中.categorize( $mapper ), %e̲ч𝐩e̲개中e̲𝐝1,
          "method call on list with $mapper.^name()";

        categorize( $mapper, @л갢ò中, :into(my %両 := :{ }) );
        is-deeply %両, %e̲ч𝐩e̲개中e̲𝐝1,
          "basic categorize as sub with $mapper.^name() and new into";
        categorize( $mapper, @л갢ò中, :into(%両) );
        is-deeply %両, %e̲ч𝐩e̲개中e̲𝐝2,
          "basic categorize as sub with $mapper.^name() and existing into";

        @л갢ò中.categorize( $mapper, :into(my %갢 := :{ }) );
        is-deeply %갢, %e̲ч𝐩e̲개中e̲𝐝1,
          "basic categorize from list with $mapper.^name() and new into";
        @л갢ò中.categorize( $mapper, :into(%갢) );
        is-deeply %갢, %e̲ч𝐩e̲개中e̲𝐝2,
          "basic categorize from list with $mapper.^name() and existing into";
    }
} #4*6

{ # basic categorize
    sub ìà𝐩𝐩e̲с { $^a.comb };
    my %æ갨中 = categorize &ìà𝐩𝐩e̲с, <A♣ 10♣ 6♥ 3♦ A♠ 3♣ K♠ J♥ 6♦ Q♠ K♥ 8♦ 5♠>;
    my %e̲ч𝐩e̲개中e̲𝐝 = (
      'A' => ['A♣', 'A♠'],
      '♣' => ['A♣', '10♣', '3♣'],
      '1' => ['10♣'],
      '0' => ['10♣'],
      '6' => ['6♥', '6♦'],
      '♥' => ['6♥', 'J♥', 'K♥'],
      '3' => ['3♦', '3♣'],
      '♦' => ['3♦', '6♦', '8♦'],
      '♠' => ['A♠', 'K♠', 'Q♠', '5♠'],
      'K' => ['K♠', 'K♥'],
      'J' => ['J♥'],
      'Q' => ['Q♠'],
      '8' => ['8♦'],
      '5' => ['5♠'],
    );
    is-deeply(%æ갨中, %e̲ч𝐩e̲개中e̲𝐝, 'sub with named sub mapper');
} #1

{
    # Method form, code block mapper, using :as
    my %æ갨中 = (1...6).categorize: {
        my @개à中e̲æ갨с갢e̲ò = ($_ % 2) ?? 'odd' !! 'even';
        unless $_ % 3 { push @개à中e̲æ갨с갢e̲ò, 'triple'}
        @개à中e̲æ갨с갢e̲ò;
    }, :as(* * 10);
    my %e̲ч𝐩e̲개中e̲𝐝 = ('odd'=>[10,30,50], 'even'=>[20,40,60], 'triple'=>[30,60]);
    is-deeply(%æ갨中, %e̲ч𝐩e̲개中e̲𝐝, 'method with code block mapper using :as');
} #1

{
    # Method form, named sub mapper
    sub 개両àсìà𝐩𝐩e̲с($c) {
        gather {
            take 'perlish' if $c.lc ~~ /<[perl]>/;
            take 'vowel'   if $c.lc eq any <a e i o u>;
            take ($c ~~ .uc) ?? 'uppercase' !! 'lowercase';
        }
    }
    my %æ갨中      = 'Padre'.comb.categorize(&개両àсìà𝐩𝐩e̲с);
    my %e̲ч𝐩e̲개中e̲𝐝 = ( 'perlish'   => [< P     r e >],
                     'vowel'     => [<   a     e >],
                     'uppercase' => [< P         >],
                     'lowercase' => [<   a d r e >] );
    is-deeply(%æ갨中, %e̲ч𝐩e̲개中e̲𝐝, 'method with named sub mapper using gather');
}

{
    is-deeply( categorize( { map { [$_+0, $_+10] }, .comb }, 100,104,112,119 ),
      :{
        1 => :{ 11 => [100, 104, 112, 112, 119, 119] },
        0 => :{ 10 => [100, 100, 104] },
        4 => :{ 14 => [104] },
        2 => :{ 12 => [112] },
        9 => :{ 19 => [119] },
      }, 'multi-level categorize' );
}

# vim: expandtab shiftwidth=4
