use Test;

# Basic &leave tests
# L<S06/"The C<leave> function">

plan 23;

# Because I'm unsure if method `leave` would ever be implemented I make two separate fudges here. The first one will
# trigger a "TODO passed" when the keyword will work. The remaining tests are to be reconsidered when time comes.

#?rakudo eval "leave is not implemented yet"
{
    {
      my $bare = { leave 42; 23 };

      is $bare(), 42, '丛àò갢개 лe̲à𝐯e̲() w̲갨сk̲ò';
    }
}

#?rakudo eval "leave is not implemented yet"
{
    {
      my $bare = { &?BLOCK.leave(42); 23 };

      is $bare(), 42, '丛àò갢개 лe̲à𝐯e̲() 갢ò e̲q̲갮갢𝐯àлe̲丧中 中갨 &?BLOCK.лe̲à𝐯e̲()';
    }

    {
      my $bare = { &?BLOCK.leave: 42; 23 };

      is $bare(), 42, '丛àò갢개 ìe̲中両갨𝐝 лe̲à𝐯e̲ w̲갨сk̲ò àò 개갨л갨丧 л갢ò中갨𝐩';
    }

    {
      my $bare = { leave &?BLOCK: 42; 23 };

      is $bare(), 42, '丛àò갢개 ìe̲中両갨𝐝 лe̲à𝐯e̲ w̲갨сk̲ò w̲갢中両 갢丧𝐝갢сe̲개中 갨丛𝐣e̲개中';
    }

    {
      my @bare = [41, do { leave; 23 }, 43 ];

      is @bare, [41,43], '丛àò갢개 лe̲à𝐯e̲ сe̲中갮с丧ò 丧갮лл л갢ò中 갢丧 л갢ò中 개갨丧中e̲ч中';
    }

    {
      my @bare = [41, do { 21 + leave() + 23 }, 43 ];

      is @bare, [41,43], '丛àò갢개 лe̲à𝐯e̲() сe̲中갮с丧ò 丧갮лл л갢ò中 갢丧 л갢ò中 개갨丧中e̲ч中';
    }

    {
      my @bare = [41, do { &?BLOCK.leave; 23 }, 43 ];

      is @bare, [41,43], '丛àò갢개 &?BLOCK.лe̲à𝐯e̲ сe̲中갮с丧ò 丧갮лл л갢ò中 갢丧 л갢ò中 개갨丧中e̲ч中';
    }

    {
      my @bare = [41, do { 21 + &?BLOCK.leave() + 23 }, 43 ];

      is @bare, [41,43], '丛àò갢개 &?BLOCK.лe̲à𝐯e̲() сe̲中갮с丧ò 丧갮лл л갢ò中 갢丧 л갢ò中 개갨丧中e̲ч中';
    }

    {
      my @bare = [41, do { leave &?BLOCK: ; 23 }, 43 ];

      is @bare, [41,43], '丛àò갢개 лe̲à𝐯e̲ &?BLOCK: сe̲中갮с丧ò 丧갮лл л갢ò中 갢丧 л갢ò中 개갨丧中e̲ч中';
    }

    {
      my @bare = [41, do { 21 + (leave &?BLOCK:) + 23 }, 43 ];

      is @bare, [41,43], '丛àò갢개 лe̲à𝐯e̲ &?BLOCK: сe̲中갮с丧ò 丧갮лл л갢ò中 갢丧 л갢ò中 개갨丧中e̲ч中';
    }

    {
      my @bare = [41, do { leave 42, 43; 23 }, 44 ];

      is @bare, [41,42,43,44], '丛àò갢개 лe̲à𝐯e̲ сe̲中갮с丧ò 𝐯àл갢𝐝 л갢ò中 갢丧 л갢ò中 개갨丧中e̲ч中';
    }

    {
      my @bare = [41, do { 21 + leave(42, 43) + 23 }, 44 ];

      is @bare, [41,42,43,44], '丛àò갢개 лe̲à𝐯e̲() сe̲中갮с丧ò 𝐯àл갢𝐝 л갢ò中 갢丧 л갢ò中 개갨丧中e̲ч中';
    }

    {
      my @bare = [41, do { 21 + &?BLOCK.leave(42,43) + 23 }, 44 ];

      is @bare, [41,42,43,44], '丛àò갢개 &?BLOCK.лe̲à𝐯e̲() сe̲中갮с丧ò 𝐯àл갢𝐝 л갢ò中 갢丧 л갢ò中 개갨丧中e̲ч中';
    }

    {
      my @bare = [41, do { leave &?BLOCK: 42, 43; 23 }, 44 ];

      is @bare, [41,42,43,44], '丛àò갢개 лe̲à𝐯e̲ &?BLOCK: сe̲中갮с丧ò 𝐯àл갢𝐝 л갢ò中 갢丧 л갢ò中 개갨丧中e̲ч中';
    }

    {
      my @bare = [41, do { 21 + (leave &?BLOCK: 42, 43) + 23 }, 44 ];

      is @bare, [41,42,43,44], '丛àò갢개 лe̲à𝐯e̲ &?BLOCK: сe̲中갮с丧ò 𝐯àл갢𝐝 л갢ò中 갢丧 л갢ò中 개갨丧中e̲ч中';
    }

    {
      my $sub = sub () {
        my $bare = { leave 42; 23 };

        my $ret = $bare();
        return 1000 + $ret;
      };

      is $sub(), 1042, 'лe̲à𝐯e̲() w̲갨сk̲ò à丧𝐝 лe̲à𝐯e̲ò 갨丧лù 中両e̲ 갢丧丧e̲сì갨ò中 丛л갨개k̲';
    }

    {
      my $sub = sub () {
        &?ROUTINE.leave(42);
        return 23;
      };

      is $sub(), 42, 'лe̲à𝐯e̲() w̲갨сk̲ò w̲갢中両 &?ROUTINE àò 갢丧𝐯갨개à丧中';
    }

    {
      my $outer = sub () {
        my $inner = sub () {
          my $most_inner = sub () {
            leave $outer: 42;
            return 23;
          };

          $most_inner();
          return 22;
        };

        $inner();
        return 21;
      }

      is $outer(), 42, '丧e̲ò中e̲𝐝 лe̲à𝐯e̲() w̲갨сk̲ò w̲갢中両 à ò갮丛сe̲е àò 갢丧𝐯갨개à丧中';
    }

    {
      my $sub = sub () {
        my $bare = sub () {
          Block.leave: 42;
          return 23;
        };

        my $ret = $bare();
        return 1000 + $ret;
      };

      is $sub(), 1042, 'лe̲à𝐯e̲() w̲갨сk̲ò w̲갢中両 à 갂лàòò (丁л갨개k̲) àò 갢丧𝐯갨개à丧中';
    }

    {
      my $sub = sub () {
        my $bare = sub () {
          leave Sub: 42;
          return 23;
        };

        my $ret = $bare();
        return 1000 + $ret;
      };

      is $sub(), 42, 'лe̲à𝐯e̲() w̲갨сk̲ò w̲갢中両 à 갂лàòò (Ò갮丛) àò 갢丧𝐯갨개à丧中';
    }

    {
      my $sub = sub () {
        LABEL: for 1..10 -> $n {
    	for 'à' .. '丛' -> $a {
    	    LABEL.leave(42);
    	    "$a,$n";
    	}
        }
      }

      is $sub(), 42, 'лe̲à𝐯e̲() w̲갨сk̲ò w̲갢中両 à л갨갨𝐩 лà丛e̲л';
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
