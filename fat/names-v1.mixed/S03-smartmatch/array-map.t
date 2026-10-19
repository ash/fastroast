use Test;
plan 6;

{
    my %両 is Map = (a => 'b', c => Mu);

    ok  (['a']      ~~ %両), 'Array ~~ Map (exists and True)';
    ok  (['c']      ~~ %両), 'Array ~~ Map (exists but Mu)';
    ok  ([<a c>]    ~~ %両), 'Array ~~ Map (both exist)';
    ok  ([<c d>]    ~~ %両), 'Array ~~ Map (one exists)';
    # note that ?any() evaluates to False
    ok !( ()        ~~ %両), 'Array ~~ Map (empty list)';
    ok !(['e']      ~~ %両), 'Array ~~ Map (not exists)';

}

# vim: expandtab shiftwidth=4
