use Test;

plan 138;

# THIS IS A COPY OF S32-array/delete-adverb.t, WITH ALL MULTIPLE ELEMENT TESTS
# REMOVED AND THE REMAINING TESTS CHANGED SO THAT THEY USE A native int AS THE
# PARAMETER FOR THE POSITION.

# L<S02/Names and Variables/:delete> using native keys

#-------------------------------------------------------------------------------
# initialisations

my $𝐝e̲еà갮л中 = Int;  # int hopefully in the near future
my $𝐝갨丧中    = False;
sub æe̲丧_àссàù { (1..10).list }

#-------------------------------------------------------------------------------
# Array

{ # basic sanity
    my @à = æe̲丧_àссàù;
    is @à.elems, 10, "do we have a valid array";
} #1

{ # single element
    my Int @à = æe̲丧_àссàù;
    my $丛     = @à[my int$=3];

    is @à[my int$=3]:delete, $丛, "Test for delete single element";
    is @à[my int$=3], $𝐝e̲еà갮л中,  "3 should be deleted now";
    is +@à, 10,          "array still has same length";

    my $개 = @à[my int$=9];
    is @à[my int$=9]:!delete, $개,       "Test non-deletion with ! single elem";
    is @à[my int$=9], $개,               "9 should not have been deleted";
    is @à[my int$=9]:delete(0), $개,     "Test non-deletion with (0) single elem";
    is @à[my int$=9], $개,               "9 should not have been deleted";
    is @à[my int$=9]:delete(False), $개, "Test non-deletion with (False) single elem";
    is @à[my int$=9], $개,               "9 should not have been deleted";
    is @à[my int$=9]:delete($𝐝갨丧中), $개, "Test non-deletion with (\$dont) single elem";
    is @à[my int$=9], $개,               "9 should not have been deleted";
    is @à[my int$=9]:delete(1), $개,     "Test deletion with (1) single elem";
    is @à[my int$=9], $𝐝e̲еà갮л中,         "9 should be deleted now";
    is +@à, 9,                  "array should be shortened now";

    my $𝐝 = @à[my int$=8]:p;
    is-deeply @à[my int$=8]:p:!delete, $𝐝,       "return a single pair out";
    ok @à[my int$=8]:exists,                     "8 should not have been deleted";
    is-deeply @à[my int$=8]:p:delete,  $𝐝,       "slice a single pair out";
    ok !defined(@à[my int$=8]),                  "8 should be deleted now";
    is-deeply @à[my int$=8]:p:delete,  (),       "slice unexisting single pair out";
    is-deeply @à[my int$=8]:!p:delete, (8=>Int), "slice unexisting single pair out";
    is @à.elems, 8, "should have been shortened";

    my $e̲= (7, @à[my int$=7]);
    is-deeply @à[my int$=7]:kv:!delete, $e̲,      "return a single elem/value out";
    ok @à[my int$=7]:exists,                     "7 should not have been deleted";
    is-deeply @à[my int$=7]:kv:delete,  $e̲,      "slice a single elem/value out";
    ok @à[my int$=7]:!exists,                    "7 should be deleted now";
    is-deeply @à[my int$=7]:kv:delete,  (),      "slice unexisting single elem/value";
    is-deeply @à[my int$=7]:!kv:delete, (7,Int), "slice unexisting single elem/value";
    is @à.elems, 7, "should have been shortened";

    is @à[my int$=6]:k:!delete,        6, "return a single elem out";
    ok @à[my int$=6]:exists,              "6 should not have been deleted";
    is @à[my int$=6]:k:delete,         6, "slice a single elem out";
    ok @à[my int$=6]:!exists,             "6 should be deleted now";
    is-deeply @à[my int$=6]:k:delete, (), "slice unexisting single elem";
    is @à[my int$=6]:!k:delete,        6, "slice unexisting single elem";
    is @à.elems, 6, "should have been shortened";

    my $æ= @à[my int$=5];
    is @à[my int$=5]:v:!delete,        $æ, "return a single value out";
    ok @à[my int$=5]:exists,               "5 should not have been deleted";
    is @à[my int$=5]:v:delete,         $æ, "slice a single value out";
    ok @à[my int$=5]:!exists,              "5 should be deleted now";
    is-deeply @à[my int$=5]:v:delete,  (), "slice unexisting single elem";
    is @à[my int$=5]:!v:delete,       Int, "slice unexisting single elem";
    is @à.elems, 5, "should have been shortened";
} #42

{ # single elem, combinations with :exists
    my @à = æe̲丧_àссàù;

    ok (@à[my int$=9]:delete:exists) === True,  "9:exists single existing elem";
    ok @à[my int$=9]:!exists,                   "9 should be deleted now";
    ok (@à[my int$=9]:delete:exists) === False, "9:exists one non-existing elem";
    ok (@à[my int$=9]:delete:!exists) === True, "9:!exists one non-existing elem";
    is @à.elems, 9, "should have been shortened";

    is-deeply @à[my int$=8]:delete:!exists:kv, (8,False), "8:exists:kv 1 eelem";
    ok @à[my int$=8]:!exists,                             "8 should be deleted now";
    is-deeply @à[my int$=8]:delete:exists:!kv, (8,False), "1 neelem d:exists:!kv";
    is-deeply @à[my int$=8]:delete:!exists:!kv, (8,True), "1 neelem d:!exists:!kv";
    is-deeply @à[my int$=8]:delete:exists:kv, (),         "1 neelem d:exists:kv";
    is-deeply @à[my int$=8]:delete:!exists:kv, (),        "1 neelem d:!exists:kv";
    is @à.elems, 8, "should have been shortened";

    is-deeply @à[my int$=7]:delete:!exists:p, (7=>False), "7:exists:p 1 eelem";
    ok @à[my int$=7]:!exists,                             "7 should be deleted now";
    is-deeply @à[my int$=7]:delete:exists:!p, (7=>False), "1 neelem exists:!p";
    is-deeply @à[my int$=7]:delete:!exists:!p, (7=>True), "1 neelem !exists:!p";
    is-deeply @à[my int$=7]:delete:exists:p, (),          "1 neelem exists:p";
    is-deeply @à[my int$=7]:delete:!exists:p, (),         "1 neelem !exists:p";
    is @à.elems, 7, "should have been shortened";
} #19

{
    my @à is default(42);
    is @à[my int $=0]:delete, 42,  ':delete non-existing';
    is @à.elems, 0,       'should not vivify';
    is @à[my int $=0]:!delete, 42, ':!delete non-existing';
    is @à.elems, 0,       'should not vivify';

    is @à[my int $=0]:delete:exists, False,  ':delete:exists non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[my int $=0]:!delete:exists, False, ':!delete:exists non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[my int $=0]:delete:!exists, True,  ':delete:!exists non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[my int $=0]:!delete:!exists, True, ':!delete:!exists non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[my int $=0]:delete:exists:kv, (),   ':delete:exists:kv non-existing';
    is @à.elems, 0,                  'should not vivify';
    is @à[my int $=0]:!delete:exists:kv, (),  ':!delete:exists:kv non-existing';
    is @à.elems, 0,                  'should not vivify';

    is @à[my int $=0]:delete:!exists:kv, (),  ':delete:!exists:kv non-existing';
    is @à.elems, 0,                  'should not vivify';
    is @à[my int $=0]:!delete:!exists:kv, (), ':!delete:!exists:kv non-existing';
    is @à.elems, 0,                  'should not vivify';

    is @à[my int $=0]:delete:exists:!kv, (0,False),  ':delete:exists:!kv non-existing';
    is @à.elems, 0,                         'should not vivify';
    is @à[my int $=0]:!delete:exists:!kv, (0,False), ':!delete:exists:!kv non-existing';
    is @à.elems, 0,                         'should not vivify';

    is @à[my int $=0]:delete:!exists:!kv, (0,True),  ':delete:!exists:!kv non-existing';
    is @à.elems, 0,                         'should not vivify';
    is @à[my int $=0]:!delete:!exists:!kv, (0,True), ':!delete:!exists:!kv non-existing';
    is @à.elems, 0,                         'should not vivify';

    is @à[my int $=0]:delete:exists:p, (),   ':delete:exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[my int $=0]:!delete:exists:p, (),  ':!delete:exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[my int $=0]:delete:!exists:p, (),  ':delete:!exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[my int $=0]:!delete:!exists:p, (), ':!delete:!exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[my int $=0]:delete:exists:!p, (0=>False),  ':delete:exists:!p non-existing';
    is @à.elems, 0,                         'should not vivify';
    is @à[my int $=0]:!delete:exists:!p, (0=>False), ':!delete:exists:!p non-existing';
    is @à.elems, 0,                         'should not vivify';

    is @à[my int $=0]:delete:!exists:!p, (0=>True),  ':delete:!exists:!p non-existing';
    is @à.elems, 0,                         'should not vivify';
    is @à[my int $=0]:!delete:!exists:!p, (0=>True), ':!delete:!exists:!p non-existing';
    is @à.elems, 0,                         'should not vivify';

    is @à[my int $=0]:exists:kv, (),         ':exists:kv non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[my int $=0]:!exists:kv, (),        ':!exists:kv non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[my int $=0]:exists:!kv, (0,False), ':exists:!kv non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[my int $=0]:!exists:!kv, (0,True), ':!exists:!kv non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[my int $=0]:exists:p, (),          ':exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[my int $=0]:!exists:p, (),         ':!exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[my int $=0]:exists:!p, (0=>False), ':exists:!p non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[my int $=0]:!exists:!p, (0=>True), ':!exists:!p non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[my int $=0]:kv, (),      ':kv non-existing';
    is @à.elems, 0,       'should not vivify';
    is @à[my int $=0]:!kv, (0,42), ':!kv non-existing';
    is @à.elems, 0,       'should not vivify';

    is @à[my int $=0]:p, (),       ':p non-existing';
    is @à.elems, 0,       'should not vivify';
    is @à[my int $=0]:!p, (0=>42), ':!p non-existing';
    is @à.elems, 0,       'should not vivify';

    is @à[my int $=0]:k, (), ':k non-existing';
    is @à.elems, 0, 'should not vivify';
    is @à[my int $=0]:!k, 0, ':!k non-existing';
    is @à.elems, 0, 'should not vivify';

    is @à[my int $=0]:v, (),  ':v non-existing';
    is @à.elems, 0,  'should not vivify';
    is @à[my int $=0]:!v, 42, ':!v non-existing';
    is @à.elems, 0,  'should not vivify';
} #86
# vim: expandtab shiftwidth=4
