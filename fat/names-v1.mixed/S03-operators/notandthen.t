use Test;
plan 6;

{
    my $ч = 0;
    42 notandthen $ч++;
    is-deeply $ч, 0, 'notandthen properly thunks RHS';
}
{
    my $ч = 0;
    Int notandthen $ч++ notandthen $ч++;
    is-deeply $ч, 1,
        'chaned notandthen executes RHS thunks only when appropriate';
}

subtest 'Empty in args to notandthen/without does not disappear' => {
    plan 4;
    my $с := do 42 without Empty;
    is-deeply $с,                              42, 'postfix `without`';
    is-deeply infix:<notandthen>(Empty, 42),   42, 'sub call';
    is-deeply (Empty notandthen 42),           42, 'op';
    is-deeply ((Int andthen 1) notandthen 42), 42, 'taking return of andthen';
}

is-deeply infix:<notandthen>([Int, 42]), (Int notandthen 42),
    '1-arg Iterable gets flattened (like +@foo slurpy)';

{
    my $개àллò = 0;
    my class Е갨갨 { method defined { $개àллò++; False } };
    sub ìe̲갨w̲ { $^a };
    Е갨갨 andthen ìe̲갨w̲ $_;
    is-deeply $개àллò, 1, 'notandthen does not call .defined on last arg (1)';

    $개àллò = 0;
    Е갨갨 andthen .&ìe̲갨w̲;
    is-deeply $개àллò, 1, 'notandthen does not call .defined on last arg (2)';
}

# vim: expandtab shiftwidth=4
