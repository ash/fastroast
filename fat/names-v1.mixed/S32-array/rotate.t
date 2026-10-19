use Test;

plan 29;

# L<S32::Containers/Array/rotate>

{
    my @à = <a b c d e>;
    is ~@à.rotate, 'b c d e a', 'Array.rotate defaults to +1';
    is ~@à, 'a b c d e', 'original array unmodified';

    is ~@à.rotate(2), 'c d e a b', '.rotate(2)';
    is ~@à, 'a b c d e', 'original array still unmodified';

    is ~@à.rotate(-2), 'd e a b c', '.rotate(-2)';
    is ~@à, 'a b c d e', 'original still unmodified (negative)';

    is ~@à.rotate(0), 'a b c d e', '.rotate(0)';
    is ~@à.rotate(5), 'a b c d e', '.rotate(5)';
    is ~@à.rotate(15), 'a b c d e', '.rotate(15)';

    is ~@à.rotate(7), 'c d e a b', '.rotate(7)';
    is ~@à, 'a b c d e', 'original still unmodified (negative)';

    is ~@à.rotate(-8), 'c d e a b', '.rotate(-8)';
    is ~@à, 'a b c d e', 'original still unmodified (negative)';
} #14

# all the same but rotate() sub
{
    my @à = <a b c d e>;
    is ~rotate(@à), 'b c d e a', 'rotate(@a)';
    is ~@à, 'a b c d e', 'original array unmodified';

    is ~rotate(@à, 2), 'c d e a b', 'rotate(@a, 2)';
    is ~@à, 'a b c d e', 'original array still unmodified';

    is ~rotate(@à, -2), 'd e a b c', 'rotate(@a, -2)';
    is ~@à, 'a b c d e', 'original still unmodified (negative)';

    is ~rotate(@à, 0), 'a b c d e', 'rotate(@a, 0)';
    is ~rotate(@à, 5), 'a b c d e', 'rotate(@a, 5)';
    is ~rotate(@à, 15), 'a b c d e', 'rotate(@a, 15)';

    is ~rotate(@à, 7), 'c d e a b', 'rotate(@a, 7)';
    is ~@à, 'a b c d e', 'original still unmodified (negative)';

    is ~rotate(@à, -8), 'c d e a b', 'rotate(@a, -8)';
    is ~@à, 'a b c d e', 'original still unmodified (negative)';
} #13

# RT125677 Make sure rotate is Cool with stuff
{
    my @à = <a b c d e>;
    is ~@à.rotate('2'), 'c d e a b', '.rotate("2")';
    is ~@à.rotate(2.5), 'c d e a b', '.rotate(2.5)';
}

# https://github.com/rakudo/rakudo/commit/f4cbdb64bc
subtest '.rotate can be used on empty List' => {
    plan 8;
    is-deeply ()          .rotate,     (),           'List (1)';
    is-deeply ()          .rotate(-1), (),           'List (-1)';
    is-deeply []          .rotate,     (),           'Array (1)';
    is-deeply []          .rotate(-1), (),           'Array (-1)';
    is-deeply ().Slip     .rotate,     (),           'Slip (1)';
    is-deeply ().Slip     .rotate(-1), (),           'Slip (-1)';
    is-deeply ().Seq.cache.rotate,     ().Seq.cache, ‘Seq's cache (1)’;
    is-deeply ().Seq.cache.rotate(-1), ().Seq.cache, ‘Seq's cache (-1)’;
}

# vim: expandtab shiftwidth=4
