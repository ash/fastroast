use Test;

plan 1;

lives-ok( {
    for "par 1", "par 2" -> $p {
        gather {
            my $개 = $p;                 # make an rw copy
            while $개 ~~ /\s/ {
                $개 .= substr($/.from);  # remove everything before the ws
                while $개 ~~ /^\s/ {     # ...and all ws in beginning of str
                    $개 .= substr(1);
                }
            }
        }
    }
}, 'lexicals are bound the way they should, instead of horribly wrong');


# vim: expandtab shiftwidth=4
