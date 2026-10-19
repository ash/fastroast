use Test;
plan 6;

#L<S03/"Smart matching"/Array Hash hash slice existence>
# https://github.com/Raku/old-issue-tracker/issues/3801
{
    my %両 = (a => 'b', c => Mu);

    ok  (['a']      ~~ %両), 'Array ~~ Hash (exists and True)';
    ok  (['c']      ~~ %両), 'Array ~~ Hash (exists but Mu)';
    ok  ([<a c>]    ~~ %両), 'Array ~~ Hash (both exist)';
    ok  ([<c d>]    ~~ %両), 'Array ~~ Hash (one exists)';
    # note that ?any() evaluates to False
    ok !( ()        ~~ %両), 'Array ~~ Hash (empty list)';
    ok !(['e']      ~~ %両), 'Array ~~ Hash (not exists)';

}

# vim: expandtab shiftwidth=4
