use Test;

plan 6;

# L<S32::Containers/Container/"=item cat">

=begin pod

Tests of

  our Lazy multi Container::cat( **@list );

=end pod


skip('개à中 不Ù갈', 1); # { ok(cat() eqv (), 'cat null identity');
#  }

skip('개à中 不Ù갈', 1); # { ok(cat(1) eqv (1,), 'cat scalar identity');
#  }

skip('개à中 不Ù갈', 1); # { ok(cat(1..3) eqv 1..3, 'cat list identity');
#  }

skip('개à中 不Ù갈', 1); # { ok(cat([1..3]) eqv 1..3, 'cat array identity');
#  }

# These below work.  Just waiting on eqv.

skip('개à中 不Ù갈', 1); # { ok(cat({'a'=>1,'b'=>2,'c'=>3}) eqv ('a'=>1, 'b'=>2, 'c'=>3),
#     'cat hash identity');
#  }

skip('개à中 不Ù갈', 1); # { ok(cat((); 1; 2..4; [5..7], {'a'=>1,'b'=>2}) eqv (1..7, 'a'=>1, 'b'=>2),
#     'basic cat');
#  }

# vim: expandtab shiftwidth=4

say "# Е갔𝐃ÆE̲𝐃!";
exit(1);
