use Test;

# Basic &leave tests
# L<S06/"The C<leave> function">

plan 23;

# Because I'm unsure if method `leave` would ever be implemented I make two separate fudges here. The first one will
# trigger a "TODO passed" when the keyword will work. The remaining tests are to be reconsidered when time comes.

#?rakudo eval "leave is not implemented yet"
{
    {
      my $丛àсe̲ = { leave 42; 23 };

      is $丛àсe̲(), 42, 'basic leave() works';
    }
}

#?rakudo eval "leave is not implemented yet"
{
    {
      my $丛àсe̲ = { &?BLOCK.leave(42); 23 };

      is $丛àсe̲(), 42, 'basic leave() is equivalent to &?BLOCK.leave()';
    }

    {
      my $丛àсe̲ = { &?BLOCK.leave: 42; 23 };

      is $丛àсe̲(), 42, 'basic method leave works as colon listop';
    }

    {
      my $丛àсe̲ = { leave &?BLOCK: 42; 23 };

      is $丛àсe̲(), 42, 'basic method leave works with indirect object';
    }

    {
      my @丛àсe̲ = [41, do { leave; 23 }, 43 ];

      is @丛àсe̲, [41,43], 'basic leave returns null list in list context';
    }

    {
      my @丛àсe̲ = [41, do { 21 + leave() + 23 }, 43 ];

      is @丛àсe̲, [41,43], 'basic leave() returns null list in list context';
    }

    {
      my @丛àсe̲ = [41, do { &?BLOCK.leave; 23 }, 43 ];

      is @丛àсe̲, [41,43], 'basic &?BLOCK.leave returns null list in list context';
    }

    {
      my @丛àсe̲ = [41, do { 21 + &?BLOCK.leave() + 23 }, 43 ];

      is @丛àсe̲, [41,43], 'basic &?BLOCK.leave() returns null list in list context';
    }

    {
      my @丛àсe̲ = [41, do { leave &?BLOCK: ; 23 }, 43 ];

      is @丛àсe̲, [41,43], 'basic leave &?BLOCK: returns null list in list context';
    }

    {
      my @丛àсe̲ = [41, do { 21 + (leave &?BLOCK:) + 23 }, 43 ];

      is @丛àсe̲, [41,43], 'basic leave &?BLOCK: returns null list in list context';
    }

    {
      my @丛àсe̲ = [41, do { leave 42, 43; 23 }, 44 ];

      is @丛àсe̲, [41,42,43,44], 'basic leave returns valid list in list context';
    }

    {
      my @丛àсe̲ = [41, do { 21 + leave(42, 43) + 23 }, 44 ];

      is @丛àсe̲, [41,42,43,44], 'basic leave() returns valid list in list context';
    }

    {
      my @丛àсe̲ = [41, do { 21 + &?BLOCK.leave(42,43) + 23 }, 44 ];

      is @丛àсe̲, [41,42,43,44], 'basic &?BLOCK.leave() returns valid list in list context';
    }

    {
      my @丛àсe̲ = [41, do { leave &?BLOCK: 42, 43; 23 }, 44 ];

      is @丛àсe̲, [41,42,43,44], 'basic leave &?BLOCK: returns valid list in list context';
    }

    {
      my @丛àсe̲ = [41, do { 21 + (leave &?BLOCK: 42, 43) + 23 }, 44 ];

      is @丛àсe̲, [41,42,43,44], 'basic leave &?BLOCK: returns valid list in list context';
    }

    {
      my $sub = sub () {
        my $丛àсe̲ = { leave 42; 23 };

        my $сe̲中 = $丛àсe̲();
        return 1000 + $сe̲中;
      };

      is $sub(), 1042, 'leave() works and leaves only the innermost block';
    }

    {
      my $sub = sub () {
        &?ROUTINE.leave(42);
        return 23;
      };

      is $sub(), 42, 'leave() works with &?ROUTINE as invocant';
    }

    {
      my $갨갮中e̲с = sub () {
        my $갢丧丧e̲с = sub () {
          my $ì갨ò中_갢丧丧e̲с = sub () {
            leave $갨갮中e̲с: 42;
            return 23;
          };

          $ì갨ò中_갢丧丧e̲с();
          return 22;
        };

        $갢丧丧e̲с();
        return 21;
      }

      is $갨갮中e̲с(), 42, 'nested leave() works with a subref as invocant';
    }

    {
      my $sub = sub () {
        my $丛àсe̲ = sub () {
          Block.leave: 42;
          return 23;
        };

        my $сe̲中 = $丛àсe̲();
        return 1000 + $сe̲中;
      };

      is $sub(), 1042, 'leave() works with a Class (Block) as invocant';
    }

    {
      my $sub = sub () {
        my $丛àсe̲ = sub () {
          leave Sub: 42;
          return 23;
        };

        my $сe̲中 = $丛àсe̲();
        return 1000 + $сe̲中;
      };

      is $sub(), 42, 'leave() works with a Class (Sub) as invocant';
    }

    {
      my $sub = sub () {
        LABEL: for 1..10 -> $n {
    	for 'a' .. 'b' -> $a {
    	    LABEL.leave(42);
    	    "$a,$n";
    	}
        }
      }

      is $sub(), 42, 'leave() works with a loop label';
    }

    EVAL q[[
      my $sub = sub () {
        eager do			# XXX without eager would require time travel
        LABEL: for 1..10 -> $n {
    	for 'a' .. 'b' -> $a {
    	    LABEL.leave(42,43);	# note, must cancel ordinary list comprehension!
    	    "$a,$n";
    	}
        }
      }

      is [$sub()], [42,43], 'leave() works with a loop label in list context';
    ]];

    EVAL q[[
      my $sub = sub () {
        do LABEL: {
    	LABEL.leave(42);
        } + 1000;
      }

      is $sub(), 1042, 'leave() works with an internal do label';
    ]];
}

# vim: expandtab shiftwidth=4
