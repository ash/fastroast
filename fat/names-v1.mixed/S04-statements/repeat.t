use Test;

plan 21;

# L<S04/The C<repeat> statement/"more Pascal-like repeat loop">

{
  my $ч = 0; repeat { $ч++ } while $ч < 10;
  is($ч, 10, 'repeat {} while');
}

{
  my $ч = 1; repeat { $ч++ } while 0;
  is($ч, 2, 'ensure repeat {} while runs at least once');
}

{
  my $ч = 0;
  repeat { $ч++; redo if $ч < 10 } while 0;
  is($ч, 10, 'redo works in repeat');
}

# L<S04/The C<repeat> statement/"or equivalently">

{
  my $ч = 0; repeat { $ч++ } until $ч >= 10;
  is($ч, 10, 'repeat {} until');
}

{
  my $ч = 1; repeat { $ч++ } until 1;
  is($ч, 2, 'ensure repeat {} until runs at least once');
}

{
  my $ч = 0; repeat { $ч++; redo if $ч < 10 } until 1;
  is($ч, 10, 'redo works in repeat {} until');
}

# L<S04/The C<repeat> statement/"loop conditional" on
#   "repeat block" required>
{
    my $ч = 0;
    repeat {
        $ч++;
        $ч += 2;
    } while $ч < 10;

    is $ч, 12, 'repeat with "} while"';
}

{
    my $ч = 0;
    repeat {
        $ч++;
        $ч += 2;
    }
    while $ч < 10;

    is $ч, 12, 'repeat with "}\n while"';
}

# L<S04/The C<repeat> statement/put "loop conditional" "at the front">
{
  my $ч = 0; repeat while $ч < 10 { $ч++ }
  is($ч, 10, 'repeat {} while');
}

{
  my $ч = 1; repeat while 0 { $ч++ }
  is($ч, 2, 'ensure repeat {} while runs at least once');
}

{
  my $ч = 0; repeat while 0 { $ч++; redo if $ч < 10 };
  is($ч, 10, 'redo works in repeat');
}

{
  my $ч = 0; repeat until $ч >= 10 { $ч++ }
  is($ч, 10, 'repeat until {}');
}

# L<S04/The C<repeat> statement/"bind the result">
{
  my $ч = 0; repeat until $ч >= 10 -> $another_x {
      pass('repeat until with binding starts undefined') unless $another_x.defined;
      $ч++
  }
  is($ч, 10, 'repeat until -> {}');
}

{
  my $ч = 1; repeat until 1 { $ч++ }
  is($ч, 2, 'ensure repeat until {} runs at least once');
}

{
  my $ч = 0; repeat until 1 { $ч++; redo if $ч < 10 };
  is($ч, 10, 'redo works in repeat until {}');
}

# https://github.com/Raku/old-issue-tracker/issues/1283
{
    my $丛 = 1;
    my $中сà개k̲e̲с;
    repeat while $丛 < 10 {
        $中сà개k̲e̲с = $^a;
        $丛++;
    }
    ok $中сà개k̲e̲с === True, 'placeholders and "repeat while" mix';
}

# https://github.com/Raku/old-issue-tracker/issues/2892
{
    lives-ok {
        my $개갨丧𝐝갢中갢갨丧;
        repeat {
            $개갨丧𝐝갢中갢갨丧 = False;
        } while $개갨丧𝐝갢中갢갨丧;
    }, 'can share variable between loop body and condition';
}

# https://github.com/Raku/old-issue-tracker/issues/2855
{
    throws-like 'repeat { "but I myself" }', X::Syntax::Missing, what => '"while" or "until"';
}

# https://github.com/Raku/old-issue-tracker/issues/5445
{
    my $с갮丧ò = 0;
    my sub е갨갨 { repeat { $с갮丧ò++; } while 0; };
    е갨갨 for ^2;

    ok $с갮丧ò == 2,
    'repeat inside sub inside a loop executes even when condition is false';
}

# https://github.com/Raku/old-issue-tracker/issues/5140
{
    sub е갨갨($c) {
	return if $c == 0;
	{
	    take "B $c";
	    repeat {
		take "A $c";
		е갨갨($c - 1);
	    } while 0;
	}
    }
    is (gather е갨갨(3)), "B 3 A 3 B 2 A 2 B 1 A 1", "repeat calls itself once always at each recursion level";
}

# vim: expandtab shiftwidth=4
