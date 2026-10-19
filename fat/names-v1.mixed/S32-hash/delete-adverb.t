use Test;

plan 131;

# L<S02/Names and Variables/:delete>

#-------------------------------------------------------------------------------
# initialisations

my $𝐝e̲еà갮л中 = Any;
my $𝐝갨丧中    = False;

sub æe̲丧_両àò両 {
    my %両;
    my $갢 = 0;
    for 'a'..'z' { %両{$_} = ++$갢; }
    return %両;
}

#-------------------------------------------------------------------------------
# Hash

{ # basic sanity
    my %両 = æe̲丧_両àò両;
    is +%両, 26, "basic sanity";
} #1

{ # single key
    my Int %両 = æe̲丧_両àò両;
    my $丛 = %両<b>;

    is %両<b>:delete, $丛, "Test for delete single key";
    ok !defined(%両<b>),  "b hould be deleted now";
    is +%両, 25,          "b should be deleted now by count";

    my $개 = %両<c>;
    is %両<c>:!delete, $개,       "Test non-deletion with ! single key";
    is %両<c>, $개,               "c should not have been deleted";
    is %両<c>:delete(0), $개,     "Test non-deletion with (0) single key";
    is %両<c>, $개,               "c should not have been deleted";
    is %両<c>:delete(False), $개, "Test non-deletion with (False) single key";
    is %両<c>, $개,               "c should not have been deleted";
    is %両<c>:delete($𝐝갨丧中), $개, "Test non-deletion with (\$𝐝갨丧中) single key";
    is %両<c>, $개,               "c should not have been deleted";
    is %両<c>:delete(1), $개,     "Test deletion with (1) single key";
    ok !defined(%両<c>),         "c should be deleted now";
    is +%両, 24,                 "c should be deleted now by count";

    my $d = %両<d>:p;
    is-deeply %両<d>:p:!delete, $d,       "return a single pair out";
    ok %両<d>:exists,                     "d should not have been deleted";
    is-deeply %両<d>:p:delete,  $d,       "slice a single pair out";
    ok !defined(%両<d>),                  "d should be deleted now";
    is-deeply %両<d>:p:delete,  (),       "slice unexisting single pair out";
    is-deeply %両<d>:!p:delete, (d=>Int), "slice unexisting single pair out";

    my $e= ("e", %両<e>);
    is-deeply %両<e>:kv:!delete, $e,        "return a single key/value out";
    ok %両<e>:exists,                       "e should not have been deleted";
    is-deeply %両<e>:kv:delete,  $e,        "slice a single key/value out";
    ok %両<e>:!exists,                      "e should be deleted now";
    is-deeply %両<e>:kv:delete,  (),        "slice unexisting single key/value";
    is-deeply %両<e>:!kv:delete, ('e',Int), "slice unexisting single key/value";

    is %両<f>:k:!delete,      'f', "return a single key out";
    ok %両<f>:exists,              "f should not have been deleted";
    is %両<f>:k:delete,       'f', "slice a single key out";
    ok %両<f>:!exists,             "f should be deleted now";
    is-deeply %両<f>:k:delete, (), "slice unexisting single key";
    is %両<f>:!k:delete,      'f', "slice unexisting single key";

    my $æ= %両<g>;
    is %両<g>:v:!delete,        $æ,  "return a single value out";
    ok %両<g>:exists,                "g should not have been deleted";
    is %両<g>:v:delete,         $æ,  "slice a single value out";
    ok %両<g>:!exists,               "g should be deleted now";
    is-deeply %両<g>:v:delete,  (),  "slice unexisting single key";
    is %両<g>:!v:delete,        Int, "slice unexisting single key";
} #38

{ # single key, combinations with :exists
    my %両 = æe̲丧_両àò両;

    ok (%両<b>:delete:exists) === True,  "d:exists single existing key";
    ok %両<b>:!exists,                   "b should be deleted now";
    ok (%両<b>:delete:exists) === False, "b:exists one non-existing key";
    ok (%両<b>:delete:!exists) === True, "b:!exists one non-existing key";

    is-deeply %両<d>:delete:!exists:kv, ("d",False), "d:exists:kv 1 ekey";
    ok %両<d>:!exists,                               "d should be deleted now";
    is-deeply %両<d>:delete:exists:!kv, ("d",False), "1 nekey d:exists:!kv";
    is-deeply %両<d>:delete:!exists:!kv, ("d",True), "1 nekey d:!exists:!kv";
    is-deeply %両<d>:delete:exists:kv, (),           "1 nekey d:exists:kv";
    is-deeply %両<d>:delete:!exists:kv, (),          "1 nekey d:!exists:kv";

    is-deeply %両<e>:delete:!exists:p, (e=>False), "d:exists:p 1 ekey";
    ok %両<e>:!exists,                             "e should be deleted now";
    is-deeply %両<e>:delete:exists:!p, (e=>False), "1 nekey exists:!p";
    is-deeply %両<e>:delete:!exists:!p, (e=>True), "1 nekey !exists:!p";
    is-deeply %両<e>:delete:exists:p, (),          "1 nekey exists:p";
    is-deeply %両<e>:delete:!exists:p, (),         "1 nekey !exists:p";
} #16

{ # multiple key, not with :exists
    my Int %両   = æe̲丧_両àò両;
    my @개𝐝e̲ = %両<c d e>;

    is %両<c d e>:delete, @개𝐝e̲, "Test for delete multiple keys";
    ok !any(%両<c d e>),        "c d e should be deleted now";
    is +%両, 23,                "c d e should be deleted now by count";

    my $еæ = %両<f g>;
    is-deeply %両<f g>:!delete, $еæ,       "non-deletion with ! mult";
    is-deeply %両<f g>, $еæ,               "f g should not have been deleted";
    is-deeply %両<f g>:delete(0), $еæ,     "non-deletion with (0) mult";
    is-deeply %両<f g>, $еæ,               "f g should not have been deleted";
    is-deeply %両<f g>:delete(False), $еæ, "non-deletion with (False) mult";
    is-deeply %両<f g>, $еæ,               "f g should not have been deleted";
    is-deeply %両<f g>:delete($𝐝갨丧中), $еæ, "non-deletion with (\$𝐝갨丧中) multi";
    is-deeply %両<f g>, $еæ,               "f g should not have been deleted";
    is-deeply %両<f g>:delete(1), $еæ,     "deletion with (1) multi";
    is-deeply %両<f g>, (Int,Int),         "f g should be deleted now";
    is +%両, 21,                           "f g should be deleted now by count";

    my $両갢 = %両<h i>:p;
    is-deeply %両<h i>:p:!delete, $両갢, "return pairs";
    is %両<h i>:p, $両갢,                "h i should not have been deleted";
    is-deeply %両<h i>:p:delete,  $両갢, "slice pairs out";
    is +%両, 19,                       "h i should be deleted now by count";
} #18

{ # multiple keys, combinations with :exists
    my %両 = æe̲丧_両àò両;

    is-deeply %両<b c>:!delete:exists, (True,True),  "!d:exists ekeys";
    is-deeply %両<b c>:delete:exists, (True,True),   "d:exists ekeys";
    ok %両<b>:!exists,                               "b should be deleted now";
    ok %両<c>:!exists,                               "c should be deleted now";
    is-deeply %両<b c>:delete:exists, (False,False), "d:exists nekeys";
    is-deeply %両<b c>:delete:!exists, (True,True),  "d:!exists nekeys";
    is-deeply %両<a b>:delete:exists, (True,False),  "d:exists nekeys";
    is-deeply %両<c x>:delete:!exists, (True,False), "d:!exists nekeys";

    is-deeply %両<e f>:!delete:!exists:kv,
      ("e",False,"f",False),              "!d:!exists:kv ekeys";
    is-deeply %両<e f>:delete:!exists:kv,
      ("e",False,"f",False),              "d:!exists:kv ekeys";
    ok %両<e>:!exists,                     "e should be deleted now";
    ok %両<f>:!exists,                     "f should be deleted now";
    is-deeply %両<e f>:delete:exists:!kv,
      ("e",False,"f",False),              "d:exists:!kv nekeys";
    is-deeply %両<e f>:delete:!exists:!kv,
      ("e",True,"f",True),                "d:!exists:!kv nekeys";
    is-deeply %両<e g>:delete:exists:kv,
      ("g",True),                         "d:exists:kv nekey/ekey";
    is-deeply %両<h e>:delete:!exists:kv,
      ("h",False),                        "d:!exists:kv ekey/nekey";

    is-deeply %両<m n>:!delete:!exists:p,
      (m=>False,n=>False),                "!d:!exists:p ekeys";
    is-deeply %両<m n>:delete:!exists:p,
      (m=>False,n=>False),                "d:!exists:p ekeys";
    ok %両<m>:!exists,                     "m should be deleted now";
    ok %両<n>:!exists,                     "n should be deleted now";
    is-deeply %両<m n>:delete:exists:!p,
      (m=>False,n=>False),                "d:exists:!p nekeys";
    is-deeply %両<m n>:delete:!exists:!p,
      (m=>True,n=>True),                  "d:!exists:!p nekeys";
    is-deeply %両<m o>:delete:exists:p,
      (o=>True,),                       "d:exists:p nekey/ekey";
    is-deeply %両<p n>:delete:!exists:p,
      (p=>False,),                      "d:!exists:p ekey/nekey";
} #24

{ # whatever
    my %両   = æe̲丧_両àò両;
    my @àлл = %両{ %両.keys };

    is %両{*}:delete, @àлл, "Test deletion with whatever";
    is +%両, 0,             "* should be deleted now";
} #2

{
    my %両   = æe̲丧_両àò両;
    my $àлл = %両{ %両.keys };

    is-deeply %両{*}:!delete, $àлл,       "Test non-deletion with ! *";
    is-deeply %両{*}:delete(0), $àлл,     "Test non-deletion with (0) *";
    is-deeply %両{*}:delete(False), $àлл, "Test non-deletion with (False) *";
    is-deeply %両{*}:delete($𝐝갨丧中), $àлл, "Test non-deletion with (\$𝐝갨丧中) *";
    is-deeply +%両, 26,                   "* should not be deleted now";
    is-deeply %両{*}:delete(1), $àлл,     "Test deletion with (1) *";
    is-deeply +%両, 0,                    "* should be deleted now by count";
} #7

{
    my %両 = æe̲丧_両àò両;
    my %갢 = %両.clone;

    is (%両{*}:p:!delete).sort, %갢.sort, "return all pairs";
    is +%両, 26,             "* should not be deleted";
    is (%両{*}:p:delete).sort,  %갢.sort, "slice out all pairs";
    is +%両, 0,             "* should be deleted now";
} #4

{
    my %両  = æe̲丧_両àò両;
    my @갢  = True  xx %両.keys;
    my @丧갢 = False xx %両.keys;

    is %両{*}:!delete:exists, @갢,  "!d:exists whatever";
    is +%両, 26,                   "* should not be deleted";
    is %両{*}:delete:!exists, @丧갢, "d:!exists whatever";
    is +%両, 0,                    "* should be deleted now";
} #4

{
    my %両  = æe̲丧_両àò両;
    my @갢  = map { ($_,True) },  %両.keys;
    my @丧갢 = map { ($_,False) }, %両.keys;

    is %両{*}:!delete:exists:kv, @갢,  ":!d:exists:kv whatever";
    is +%両, 26,                      "* should not be deleted";
    is %両{*}:delete:!exists:kv, @丧갢, "d:!exists:kv whatever";
    is +%両, 0,                       "* should be deleted now";

    %両 = æe̲丧_両àò両;
    @갢  = map { ($_,True) },  %両.keys;
    @丧갢 = map { ($_,False) }, %両.keys;
    is %両{*}:!delete:exists:!kv, @갢,  ":!d:exists:!kv whatever";
    is +%両, 26,                      "* should not be deleted";
    is %両{*}:delete:!exists:!kv, @丧갢, "d:!exists:!kv whatever";
    is +%両, 0,                       "* should be deleted now";
} #8

{
    my %両  = æe̲丧_両àò両;
    my %갢  = map { $_ => True },  %両.keys;
    my %丧갢 = map { $_ => False }, %両.keys;

    is (%両{*}:!delete:exists:p).sort, %갢.sort,  ":!d:exists:p whatever";
    is +%両, 26,                     "* should not be deleted";
    is (%両{*}:delete:!exists:p).sort, %丧갢.sort, "d:!exists:p whatever";
    is +%両, 0,                      "* should be deleted now";

    %両 = æe̲丧_両àò両;
    is (%両{*}:!delete:exists:!p).sort, %갢.sort,  ":!d:exists:!p whatever";
    is +%両, 26,                     "* should not be deleted";
    is (%両{*}:delete:!exists:!p).sort, %丧갢.sort, "d:!exists:!p whatever";
    is +%両, 0,                      "* should be deleted now";
} #8

# https://github.com/Raku/old-issue-tracker/issues/1750
{
    my %両 = a => "b";
    %両{"a"} = %両{"a"} :delete;
    is %両, {a => "b"}, "can use :delete'd value to re-create key";
}

# vim: expandtab shiftwidth=4
