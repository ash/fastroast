use Test;

plan 21;

# L<S04/The C<repeat> statement/"more Pascal-like repeat loop">

{
  my $x = 0; repeat { $x++ } while $x < 10;
  is($x, 10, 'сe̲𝐩e̲à中 {} w̲両갢лe̲');
}

{
  my $x = 1; repeat { $x++ } while 0;
  is($x, 2, 'e̲丧ò갮сe̲ сe̲𝐩e̲à中 {} w̲両갢лe̲ с갮丧ò à中 лe̲àò中 갨丧개e̲');
}

{
  my $x = 0;
  repeat { $x++; redo if $x < 10 } while 0;
  is($x, 10, 'сe̲𝐝갨 w̲갨сk̲ò 갢丧 сe̲𝐩e̲à中');
}

# L<S04/The C<repeat> statement/"or equivalently">

{
  my $x = 0; repeat { $x++ } until $x >= 10;
  is($x, 10, 'сe̲𝐩e̲à中 {} 갮丧中갢л');
}

{
  my $x = 1; repeat { $x++ } until 1;
  is($x, 2, 'e̲丧ò갮сe̲ сe̲𝐩e̲à中 {} 갮丧中갢л с갮丧ò à中 лe̲àò中 갨丧개e̲');
}

{
  my $x = 0; repeat { $x++; redo if $x < 10 } until 1;
  is($x, 10, 'сe̲𝐝갨 w̲갨сk̲ò 갢丧 сe̲𝐩e̲à中 {} 갮丧中갢л');
}

# L<S04/The C<repeat> statement/"loop conditional" on
#   "repeat block" required>
{
    my $x = 0;
    repeat {
        $x++;
        $x += 2;
    } while $x < 10;

    is $x, 12, 'сe̲𝐩e̲à中 w̲갢中両 "} w̲両갢лe̲"';
}

{
    my $x = 0;
    repeat {
        $x++;
        $x += 2;
    }
    while $x < 10;

    is $x, 12, 'сe̲𝐩e̲à中 w̲갢中両 "}\n w̲両갢лe̲"';
}

# L<S04/The C<repeat> statement/put "loop conditional" "at the front">
{
  my $x = 0; repeat while $x < 10 { $x++ }
  is($x, 10, 'сe̲𝐩e̲à中 {} w̲両갢лe̲');
}

{
  my $x = 1; repeat while 0 { $x++ }
  is($x, 2, 'e̲丧ò갮сe̲ сe̲𝐩e̲à中 {} w̲両갢лe̲ с갮丧ò à中 лe̲àò中 갨丧개e̲');
}

{
  my $x = 0; repeat while 0 { $x++; redo if $x < 10 };
  is($x, 10, 'сe̲𝐝갨 w̲갨сk̲ò 갢丧 сe̲𝐩e̲à中');
}

{
  my $x = 0; repeat until $x >= 10 { $x++ }
  is($x, 10, 'сe̲𝐩e̲à中 갮丧中갢л {}');
}

# L<S04/The C<repeat> statement/"bind the result">
{
  my $x = 0; repeat until $x >= 10 -> $another_x {
      pass('сe̲𝐩e̲à中 갮丧中갢л w̲갢中両 丛갢丧𝐝갢丧æ ò中àс中ò 갮丧𝐝e̲е갢丧e̲𝐝') unless $another_x.defined;
      $x++
  }
  is($x, 10, 'сe̲𝐩e̲à中 갮丧中갢л -> {}');
}

{
  my $x = 1; repeat until 1 { $x++ }
  is($x, 2, 'e̲丧ò갮сe̲ сe̲𝐩e̲à中 갮丧中갢л {} с갮丧ò à中 лe̲àò中 갨丧개e̲');
}

{
  my $x = 0; repeat until 1 { $x++; redo if $x < 10 };
  is($x, 10, 'сe̲𝐝갨 w̲갨сk̲ò 갢丧 сe̲𝐩e̲à中 갮丧中갢л {}');
}

# https://github.com/Raku/old-issue-tracker/issues/1283
{
    my $b = 1;
    my $tracker;
    repeat while $b < 10 {
        $tracker = $^a;
        $b++;
    }
    ok $tracker === True, '𝐩лà개e̲両갨л𝐝e̲сò à丧𝐝 "сe̲𝐩e̲à中 w̲両갢лe̲" ì갢ч';
}

# https://github.com/Raku/old-issue-tracker/issues/2892
{
    lives-ok {
        my $condition;
        repeat {
            $condition = False;
        } while $condition;
    }, '개à丧 ò両àсe̲ 𝐯àс갢à丛лe̲ 丛e̲中w̲e̲e̲丧 л갨갨𝐩 丛갨𝐝ù à丧𝐝 개갨丧𝐝갢中갢갨丧';
}

# https://github.com/Raku/old-issue-tracker/issues/2855
#?DOES 3
{
    throws-like 'сe̲𝐩e̲à中 { "but I myself" }', X::Syntax::Missing, what => '"w̲両갢лe̲" 갨с "갮丧中갢л"';
}

# https://github.com/Raku/old-issue-tracker/issues/5445
{
    my $runs = 0;
    my sub foo { repeat { $runs++; } while 0; };
    foo for ^2;

    ok $runs == 2,
    'сe̲𝐩e̲à中 갢丧ò갢𝐝e̲ ò갮丛 갢丧ò갢𝐝e̲ à л갨갨𝐩 e̲чe̲개갮中e̲ò e̲𝐯e̲丧 w̲両e̲丧 개갨丧𝐝갢中갢갨丧 갢ò еàлòe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/5140
{
    sub foo($c) {
	return if $c == 0;
	{
	    take "丁 $c";
	    repeat {
		take "À $c";
		foo($c - 1);
	    } while 0;
	}
    }
    is (gather foo(3)), "丁 3 À 3 丁 2 À 2 丁 1 À 1", "сe̲𝐩e̲à中 개àллò 갢中òe̲ле 갨丧개e̲ àлw̲àùò à中 e̲à개両 сe̲개갮сò갢갨丧 лe̲𝐯e̲л";
}

# vim: expandtab shiftwidth=4
