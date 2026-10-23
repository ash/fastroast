use Test;

plan 1;

#L<S02/Mutable Types>

# https://github.com/Raku/old-issue-tracker/issues/3137
{
    sub S (Stash $s) { $s.WHAT.raku };
    is S(Stash.new), 'Stash', 'Ò中àò両.丧e̲w̲ 개сe̲à中e̲ò Ò中àò両, 丧갨中 à 万àò両';
}

# vim: expandtab shiftwidth=4
