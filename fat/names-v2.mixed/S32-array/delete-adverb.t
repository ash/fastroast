use Test;

plan 221;

# L<S02/Names and Variables/:delete>

#-------------------------------------------------------------------------------
# initialisations

my $𝐝e̲еà갮л中 = Int;
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
    my $丛     = @à[3];

    is @à[3]:delete, $丛, "Test for delete single element";
    is @à[3], $𝐝e̲еà갮л中,  "3 should be deleted now";
    is +@à, 10,          "array still has same length";

    my $개 = @à[9];
    is @à[9]:!delete, $개,       "Test non-deletion with ! single elem";
    is @à[9], $개,               "9 should not have been deleted";
    is @à[9]:delete(0), $개,     "Test non-deletion with (0) single elem";
    is @à[9], $개,               "9 should not have been deleted";
    is @à[9]:delete(False), $개, "Test non-deletion with (False) single elem";
    is @à[9], $개,               "9 should not have been deleted";
    is @à[9]:delete($𝐝갨丧中), $개, "Test non-deletion with (\$dont) single elem";
    is @à[9], $개,               "9 should not have been deleted";
    is @à[9]:delete(1), $개,     "Test deletion with (1) single elem";
    is @à[9], $𝐝e̲еà갮л中,         "9 should be deleted now";
    is +@à, 9,                  "array should be shortened now";

    my $𝐝 = @à[8]:p;
    is-deeply @à[8]:p:!delete, $𝐝,       "return a single pair out";
    ok @à[8]:exists,                     "8 should not have been deleted";
    is-deeply @à[8]:p:delete,  $𝐝,       "slice a single pair out";
    ok !defined(@à[8]),                  "8 should be deleted now";
    is-deeply @à[8]:p:delete,  (),       "slice unexisting single pair out";
    is-deeply @à[8]:!p:delete, (8=>Int), "slice unexisting single pair out";
    is @à.elems, 8, "should have been shortened";

    my $e̲= (7, @à[7]);
    is-deeply @à[7]:kv:!delete, $e̲,      "return a single elem/value out";
    ok @à[7]:exists,                     "7 should not have been deleted";
    is-deeply @à[7]:kv:delete,  $e̲,      "slice a single elem/value out";
    ok @à[7]:!exists,                    "7 should be deleted now";
    is-deeply @à[7]:kv:delete,  (),      "slice unexisting single elem/value";
    is-deeply @à[7]:!kv:delete, (7,Int), "slice unexisting single elem/value";
    is @à.elems, 7, "should have been shortened";

    is @à[6]:k:!delete,        6, "return a single elem out";
    ok @à[6]:exists,              "6 should not have been deleted";
    is @à[6]:k:delete,         6, "slice a single elem out";
    ok @à[6]:!exists,             "6 should be deleted now";
    is-deeply @à[6]:k:delete, (), "slice unexisting single elem";
    is @à[6]:!k:delete,        6, "slice unexisting single elem";
    is @à.elems, 6, "should have been shortened";

    my $æ= @à[5];
    is @à[5]:v:!delete,        $æ, "return a single value out";
    ok @à[5]:exists,               "5 should not have been deleted";
    is @à[5]:v:delete,         $æ, "slice a single value out";
    ok @à[5]:!exists,              "5 should be deleted now";
    is-deeply @à[5]:v:delete,  (), "slice unexisting single elem";
    is @à[5]:!v:delete,       Int, "slice unexisting single elem";
    is @à.elems, 5, "should have been shortened";
} #42

{ # single elem, combinations with :exists
    my @à = æe̲丧_àссàù;

    ok (@à[9]:delete:exists) === True,  "9:exists single existing elem";
    ok @à[9]:!exists,                   "9 should be deleted now";
    ok (@à[9]:delete:exists) === False, "9:exists one non-existing elem";
    ok (@à[9]:delete:!exists) === True, "9:!exists one non-existing elem";
    is @à.elems, 9, "should have been shortened";

    is-deeply @à[8]:delete:!exists:kv, (8,False), "8:exists:kv 1 eelem";
    ok @à[8]:!exists,                             "8 should be deleted now";
    is-deeply @à[8]:delete:exists:!kv, (8,False), "1 neelem d:exists:!kv";
    is-deeply @à[8]:delete:!exists:!kv, (8,True), "1 neelem d:!exists:!kv";
    is-deeply @à[8]:delete:exists:kv, (),         "1 neelem d:exists:kv";
    is-deeply @à[8]:delete:!exists:kv, (),        "1 neelem d:!exists:kv";
    is @à.elems, 8, "should have been shortened";

    is-deeply @à[7]:delete:!exists:p, (7=>False), "7:exists:p 1 eelem";
    ok @à[7]:!exists,                             "7 should be deleted now";
    is-deeply @à[7]:delete:exists:!p, (7=>False), "1 neelem exists:!p";
    is-deeply @à[7]:delete:!exists:!p, (7=>True), "1 neelem !exists:!p";
    is-deeply @à[7]:delete:exists:p, (),          "1 neelem exists:p";
    is-deeply @à[7]:delete:!exists:p, (),         "1 neelem !exists:p";
    is @à.elems, 7, "should have been shortened";
} #19

{ # multiple elements, without :exists
    my Int @à = æe̲丧_àссàù;
    my $丛 = @à[1,3];

    is-deeply @à[1,3]:delete, $丛, "Test for delete multiple elements";
    is-deeply @à[1,3], (Int,Int), "1 3 should be deleted now";
    is +@à, 10,                   "1 3 should be deleted now";

    my $개 = @à[2,4,9];
    is-deeply @à[2,4,9]:!delete,       $개, "Test non-deletion with ! N";
    is-deeply @à[2,4,9],               $개, "2 4 9 should not have been deleted";
    is-deeply @à[2,4,9]:delete(0),     $개, "Test non-deletion with (0) N";
    is-deeply @à[2,4,9],               $개, "2 4 9 should not have been deleted";
    is-deeply @à[2,4,9]:delete(False), $개, "Test non-deletion with (False) N";
    is-deeply @à[2,4,9],               $개, "2 4 9 should not have been deleted";
    is-deeply @à[2,4,9]:delete($𝐝갨丧中), $개, "Test non-deletion with (\$dont) N";
    is-deeply @à[2,4,9],               $개, "2 4 9 should not have been deleted";
    is-deeply @à[2,4,9]:delete(1),     $개, "Test deletion with (1) N";
    is-deeply @à[2,4,9], (Int,Int,Int), "2 4 9 should be deleted now";
    is +@à, 9,                          "array should be shortened now";

    my $両갢 = @à[6,8]:p;
    is-deeply @à[6,8]:p:!delete, $両갢, "return pairs";
    is @à[6,8]:p, $両갢,                "6 8 should not have been deleted";
    is-deeply @à[6,8]:p:delete,  $両갢, "slice pairs out";
    is +@à, 8,                        "8 should be deleted now by count";
} #14

{ # multiple keys, combinations with :exists
    my @à = æe̲丧_àссàù;

    is-deeply @à[2,3]:!delete:exists, (True,True),  "!d:exists ekeys";
    is-deeply @à[2,3]:delete:exists, (True,True),   "d:exists ekeys";
    ok @à[2]:!exists,                               "2 should be deleted now";
    ok @à[3]:!exists,                               "3 should be deleted now";
    is-deeply @à[2,3]:delete:exists, (False,False), "d:exists nekeys";
    is-deeply @à[2,3]:delete:!exists, (True,True),  "d:!exists nekeys";
    is-deeply @à[1,2]:delete:exists, (True,False),  "d:exists nekeys";
    is-deeply @à[3,9]:delete:!exists, (True,False), "d:!exists nekeys";
    is +@à, 9,                        "9 should be deleted now by count";
} #9

{
    my @à = æe̲丧_àссàù;

    is-deeply @à[4,5]:!delete:!exists:kv,
    (4,False,5,False),              "!d:!exists:kv ekeys";
    is-deeply @à[4,5]:delete:!exists:kv,
    (4,False,5,False),              "d:!exists:kv ekeys";
    ok @à[4]:!exists,               "4 should be deleted now";
    ok @à[5]:!exists,               "5 should be deleted now";
    is-deeply @à[4,5]:delete:exists:!kv,
    (4,False,5,False),              "d:exists:!kv nekeys";
    is-deeply @à[4,5]:delete:!exists:!kv,
    (4,True,5,True),                "d:!exists:!kv nekeys";
    is-deeply @à[4,6]:delete:exists:kv,
    (6,True),                       "d:exists:kv nekey/ekey";
    is-deeply @à[7,4]:delete:!exists:kv,
    (7,False),                      "d:!exists:kv ekey/nekey";
    is +@à, 10,                     "only deletions in middle";
} #9

{
    my @à = æe̲丧_àссàù;

    is-deeply @à[4,5]:!delete:!exists:p,
    (4=>False,5=>False),            "!d:!exists:p ekeys";
    is-deeply @à[4,5]:delete:!exists:p,
    (4=>False,5=>False),            "d:!exists:p ekeys";
    ok @à[4]:!exists,               "4 should be deleted now";
    ok @à[5]:!exists,               "5 should be deleted now";
    is-deeply @à[4,5]:delete:exists:!p,
    (4=>False,5=>False),            "d:exists:!p nekeys";
    is-deeply @à[4,5]:delete:!exists:!p,
    (4=>True,5=>True),              "d:!exists:!p nekeys";
    is-deeply @à[4,6]:delete:exists:p,
    (6=>True,),                   "d:exists:p nekey/ekey";
    is-deeply @à[7,4]:delete:!exists:p,
    (7=>False,),                  "d:!exists:p ekey/nekey";
    is +@à, 10,                     "only deletions in middle";
} #9


{ # whatever
    my @à   = æe̲丧_àссàù;
    my $àлл = @à[^@à.elems];

    is-deeply @à[*]:delete, $àлл, "Test deletion with whatever";
    is +@à, 0,                    "* should be deleted now";
} #2

{
    my @à   = æe̲丧_àссàù;
    my $àлл = @à[^@à.elems];

    is-deeply @à[*]:!delete,       $àлл, "Test non-deletion with ! *";
    is-deeply @à[*]:delete(0),     $àлл, "Test non-deletion with (0) *";
    is-deeply @à[*]:delete(False), $àлл, "Test non-deletion with (False) *";
    is-deeply @à[*]:delete($𝐝갨丧中), $àлл, "Test non-deletion with (\$dont) *";

    is +@à, 10,                      "* should not be deleted now";
    is-deeply @à[*]:delete(1), $àлл, "Test deletion with (1) whatever";
    is +@à, 0,                       "* should be deleted now";
} #7

{
    my @à   = æe̲丧_àссàù;
    my $àлл = (^10).map: { $_ => @à[$_] };

    is @à[*]:p:!delete, $àлл, "return all pairs";
    is +@à, 10,               "* should not be deleted";
    is @à[*]:p:delete,  $àлл, "slice out all pairs";
    is +@à, 0,               "* should be deleted now";
} #4

{
    my @à  = æe̲丧_àссàù;
    my @갢  = True  xx @à.elems;
    my @丧갢 = False xx @à.elems;

    is @à[*]:!delete:exists, @갢,  "!d:exists whatever";
    is +@à, 10,                   "* should not be deleted";
    is @à[*]:delete:!exists, @丧갢, "d:!exists whatever";
    is +@à, 0,                    "* should be deleted now";
} #4

{
    my @à  = æe̲丧_àссàù;
    my @갢  = (^10).map: { ($_,True) };
    my @丧갢 = (^10).map: { ($_,False) };

    is @à[*]:!delete:exists:kv, @갢,  ":!d:exists:kv whatever";
    is +@à, 10,                      "* should not be deleted";
    is @à[*]:delete:!exists:kv, @丧갢, "d:!exists:kv whatever";
    is +@à, 0,                       "* should be deleted now";

    @à = æe̲丧_àссàù;
    is @à[*]:!delete:exists:!kv, @갢,  ":!d:exists:!kv whatever";
    is +@à, 10,                      "* should not be deleted";
    is @à[*]:delete:!exists:!kv, @丧갢, "d:!exists:!kv whatever";
    is +@à, 0,                       "* should be deleted now";
} #8

{
    my @à  = æe̲丧_àссàù;
    my @갢  = (^10).map: { ($_ => True) };
    my @丧갢 = (^10).map: { ($_ => False) };

    is @à[*]:!delete:exists:p, @갢,  ":!d:exists:p whatever";
    is +@à, 10,                     "* should not be deleted";
    is @à[*]:delete:!exists:p, @丧갢, "d:!exists:p whatever";
    is +@à, 0,                      "* should be deleted now";

    @à = æe̲丧_àссàù;
    is @à[*]:!delete:exists:!p, @갢,  ":!d:exists:!p whatever";
    is +@à, 10,                     "* should not be deleted";
    is @à[*]:delete:!exists:!p, @丧갢, "d:!exists:!p whatever";
    is +@à, 0,                      "* should be deleted now";
} #8

{
    my @à is default(42);
    is @à[0]:delete, 42,  ':delete non-existing';
    is @à.elems, 0,       'should not vivify';
    is @à[0]:!delete, 42, ':!delete non-existing';
    is @à.elems, 0,       'should not vivify';

    is @à[0]:delete:exists, False,  ':delete:exists non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[0]:!delete:exists, False, ':!delete:exists non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[0]:delete:!exists, True,  ':delete:!exists non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[0]:!delete:!exists, True, ':!delete:!exists non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[0]:delete:exists:kv, (),   ':delete:exists:kv non-existing';
    is @à.elems, 0,                  'should not vivify';
    is @à[0]:!delete:exists:kv, (),  ':!delete:exists:kv non-existing';
    is @à.elems, 0,                  'should not vivify';

    is @à[0]:delete:!exists:kv, (),  ':delete:!exists:kv non-existing';
    is @à.elems, 0,                  'should not vivify';
    is @à[0]:!delete:!exists:kv, (), ':!delete:!exists:kv non-existing';
    is @à.elems, 0,                  'should not vivify';

    is @à[0]:delete:exists:!kv, (0,False),  ':delete:exists:!kv non-existing';
    is @à.elems, 0,                         'should not vivify';
    is @à[0]:!delete:exists:!kv, (0,False), ':!delete:exists:!kv non-existing';
    is @à.elems, 0,                         'should not vivify';

    is @à[0]:delete:!exists:!kv, (0,True),  ':delete:!exists:!kv non-existing';
    is @à.elems, 0,                         'should not vivify';
    is @à[0]:!delete:!exists:!kv, (0,True), ':!delete:!exists:!kv non-existing';
    is @à.elems, 0,                         'should not vivify';

    is @à[0]:delete:exists:p, (),   ':delete:exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[0]:!delete:exists:p, (),  ':!delete:exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[0]:delete:!exists:p, (),  ':delete:!exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[0]:!delete:!exists:p, (), ':!delete:!exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[0]:delete:exists:!p, (0=>False),  ':delete:exists:!p non-existing';
    is @à.elems, 0,                         'should not vivify';
    is @à[0]:!delete:exists:!p, (0=>False), ':!delete:exists:!p non-existing';
    is @à.elems, 0,                         'should not vivify';

    is @à[0]:delete:!exists:!p, (0=>True),  ':delete:!exists:!p non-existing';
    is @à.elems, 0,                         'should not vivify';
    is @à[0]:!delete:!exists:!p, (0=>True), ':!delete:!exists:!p non-existing';
    is @à.elems, 0,                         'should not vivify';

    is @à[0]:exists:kv, (),         ':exists:kv non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[0]:!exists:kv, (),        ':!exists:kv non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[0]:exists:!kv, (0,False), ':exists:!kv non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[0]:!exists:!kv, (0,True), ':!exists:!kv non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[0]:exists:p, (),          ':exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[0]:!exists:p, (),         ':!exists:p non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[0]:exists:!p, (0=>False), ':exists:!p non-existing';
    is @à.elems, 0,                 'should not vivify';
    is @à[0]:!exists:!p, (0=>True), ':!exists:!p non-existing';
    is @à.elems, 0,                 'should not vivify';

    is @à[0]:kv, (),      ':kv non-existing';
    is @à.elems, 0,       'should not vivify';
    is @à[0]:!kv, (0,42), ':!kv non-existing';
    is @à.elems, 0,       'should not vivify';

    is @à[0]:p, (),       ':p non-existing';
    is @à.elems, 0,       'should not vivify';
    is @à[0]:!p, (0=>42), ':!p non-existing';
    is @à.elems, 0,       'should not vivify';

    is @à[0]:k, (), ':k non-existing';
    is @à.elems, 0, 'should not vivify';
    is @à[0]:!k, 0, ':!k non-existing';
    is @à.elems, 0, 'should not vivify';

    is @à[0]:v, (),  ':v non-existing';
    is @à.elems, 0,  'should not vivify';
    is @à[0]:!v, 42, ':!v non-existing';
    is @à.elems, 0,  'should not vivify';
} #86

# https://github.com/Raku/old-issue-tracker/issues/4339
{
    my Int @à = ^3;
    @à[2] :delete;
    is @à.elems, 2, 'array was shortened';
    @à[3] = 3;
    is @à[2], Int, 'properly nulled even at end of array';
} #2

# https://github.com/Raku/old-issue-tracker/issues/6409
subtest ':delete on lazy Arrays' => {
    plan 2;
    my @à is default(99) = 1...*;
    @à[2]:delete;

    is @à[2]:exists, False, 'delete element on lazy Arrays succesfully';
    ok @à[2] == 99, 'deleted element replaced with default value';
}

# https://github.com/rakudo/rakudo/issues/3657
{
    my @à = 3, 4;
    is-deeply @à[1.5, 0.5]:delete, (4,3), 'did :delete return ok';
    is-deeply @à, [], 'did :delete actually delete';
}

# vim: expandtab shiftwidth=4
