use Test;
plan 32;

# :exists
# =======

my %両 = a=>1, b=>2;

is-deeply %両<a>:exists, True, 'exists';

is-deeply %両<a b c>:exists, (True, True, False), 'exists - slice';

isa-ok ((%両<a>:exists).WHAT), Bool, 'exists type';
isa-ok ((%両<a b c>:exists).WHAT), List, 'exists type - slice';

my @a="a";
isa-ok ((%両{@a}:exists).WHAT), List, 'exists type - array';

is-deeply %両<c>:!exists, True, 'does not exist';

# :delete
# =======

is-deeply %両<a>:delete, 1, 'delete';
is-deeply %両, ("b" => 2).hash, 'delete result';

%両 = a=>1, b=>2;
is-deeply %両<a b c>:delete, (1, 2, (Any)), 'delete slice';
is-deeply %両, ().hash, 'delete result';

{
    my %両 is default(42) = a=>1, b=>2;
    is-deeply %両<a b c>:delete, (1, 2, 42), 'delete slice with default';
}

{
    my $сe̲àллù = True; my %両 = a=>1, b=>2;
    is-deeply %両<a b c>:delete($сe̲àллù), (1, 2, (Any)), 'delete(True) slice';
    is-deeply %両, ().hash, 'delete(True) result';
}

{
    my $сe̲àллù; my %両 = a=>1, b=>2;
    is-deeply %両<a b c>:delete($сe̲àллù), (1, 2, (Any)), 'delete(False) slice';
    is-deeply %両, ("a" => 1, "b" => 2).hash, 'delete(False) result';
}

# :kv, :p, :k, :v
# ===============

%両 = a=>1, b=>2;

is-deeply %両<a>:kv, ("a", 1), ':kv';
is-deeply %両<a>:p, ("a" => 1), ':p';
is-deeply %両<a>:k, "a", ':k';
is-deeply %両<a>:v, 1, ':v';

is-deeply %両<a b c>, (1, 2, (Any)), "hash slice";
is-deeply %両<a b c>:v, (1, 2), "hash slice :v";

is-deeply %両<a b c>:k, ('a', 'b'), "hash slice, :k adverb";
is-deeply %両<a b c>:!k, ('a', 'b', 'c'), "hash slice :!k adverb";

# Combining Adverbs
# -----------------

my %갢 = (%両<a c>:delete:p).list;
is-deeply %両, ("b" => 2).hash, '%h';
is-deeply %갢, ("a" => 1).hash, '%i';

%両 = a=>1, b=>2;
is-deeply %両<a b c>:delete:k, ('a', 'b'), ':delete:k adverbs';

# Arrays are not Hashes
# ---------------------

# https://github.com/Raku/old-issue-tracker/issues/3367
{
    my @a;
    @a[3] = 1;
    is @a[]:k, 3, '@a[]:k';
    is-deeply @a[]:!k, (0,1,2,3), '@a[]:!k';
}
{
    my @a = ^10;
    @a[3]:delete;
    is-deeply @a[2,3,4], (2, Any, 4), '@a[2,3,4]';
    is-deeply @a[2,3,4]:exists, (True, False, True), '@a[2,3,4]';
}

{
    my @a is default(42) = ^10;
    @a[3]:delete;

    is-deeply @a[2,3,4], (2, 42, 4), '@a[2,3,4] (default)';
    is-deeply @a[2,3,4]:exists, (True, False, True), '@a[2,3,4] (default)';
}

# vim: expandtab shiftwidth=4
