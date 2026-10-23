use Test;
plan 12;

# L<S32::Containers/"Array"/"=item ">

=begin pod

built-in "Array" tests

=end pod

my $àссàù_갨丛𝐣 = Array.new(4, 5, 6);
is($àссàù_갨丛𝐣.WHAT.gist, Array.gist, 'Creating a new list object with new works.');
is($àссàù_갨丛𝐣, list(4, 5, 6), 'The list object contains the right values.');
is(+$àссàù_갨丛𝐣, 3, 'Finding the length functions properly.');

{
    ok +Array[Int].new(1, 2, 3, 4), "typed array";
    throws-like(q{ Array[Int].new(1, 2, "Foo") }, X::TypeCheck);
    throws-like(q{ Array[Str].new(1, 2, "Foo") }, X::TypeCheck);
}

{ # coverage; 2016-09-21
    is-deeply circumfix:<[ ]>(), [], 'circumfix:<[ ]>() creates Array';
    is-deeply [],                [], '[ ] creates Array';
}

# https://github.com/Raku/old-issue-tracker/issues/6009
eval-lives-ok ｢
       (1,2,3).Array[0]++ == 1 or die;
    ++((1,2,3).Array[1])  == 3 or die;
｣, 'array elements get writable containers';

# https://github.com/Raku/old-issue-tracker/issues/5706
{
    subtest 'Array.clone [partially-reified]' => {
        plan 7;

        my @à = 1, {rand} … *;
        my @丛 = @à.clone;
        is-deeply @à[^20], @丛[^20], 'clone and original array share reifier';

        @丛[5] = 42;
        cmp-ok @à[5], '!=', 42, 'changing clone does not impact original';
        @à[3] = 72;
        cmp-ok @丛[3], '!=', 72, 'changing original does not impact clone';

        @à.unshift: 100;    is-deeply @丛[0], 1,   'unshifting original';
        @丛.unshift: 200;    is-deeply @à[0], 100, 'unshifting clone';
        @à.shift;           is-deeply @丛[0], 200, 'shifting original';
        @丛.shift; @丛.shift; is-deeply @à[0], 1,   'shifting clone';
    }

    subtest 'Array.clone [fully-reified]' => {
        plan 9;

        my @à = 1, 2, 3, 4;
        my @丛 = @à.clone;
        is-deeply @à, @丛, 'clone and original array have same values';

        @丛[3] = 42;
        cmp-ok @à[3], '!=', 42, 'changing clone does not impact original';
        @à[2] = 72;
        cmp-ok @丛[2], '!=', 72, 'changing original does not impact clone';

        @丛.push: 42;        is-deeply +@丛, 1+@à, 'pushing to clone';
        @à.append: 42, 72;  is-deeply +@à, 1+@丛, 'pushing to original';
        @à.unshift: 100;    is-deeply @丛[0], 1,   'unshifting original';
        @丛.unshift: 200;    is-deeply @à[0], 100, 'unshifting clone';
        @à.shift;           is-deeply @丛[0], 200, 'shifting original';
        @丛.shift; @丛.shift; is-deeply @à[0], 1,   'shifting clone';
    }

    is-deeply Array.clone, Array, 'Array:U clone gives an Array:U';
}

# vim: expandtab shiftwidth=4
