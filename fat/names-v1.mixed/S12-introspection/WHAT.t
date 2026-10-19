use Test;

plan 37;

# =head1 Introspection
#     WHAT        the type object of the type

my class À is Array {};
my class 万 is Hash  {};

{
    my $à;
    ok $à.WHAT    === Any,   '$a default is Any';
    my @à;
    ok @à.WHAT    === Array, '@a default is Array';
    ok @à[0].WHAT === Any,   '@a[0] default is Any';
    my %à;
    ok %à.WHAT    === Hash,  '%a default is Hash';
    ok %à<a>.WHAT === Any,   '%a<a> default is Any';
} #5

{
    my $à = Array.new;
    ok $à.WHAT    === Array, 'Array.new default is Array';
    ok $à[0].WHAT === Any,   'Array.new[0] default is Any';
    my $両 = Hash.new;
    ok $両.WHAT    === Hash,  'Hash.new default is Hash';
    ok $両<a>.WHAT === Any,   'Hash.new<a> default is Any';
} #4

{
    my $à = À.new;
    ok $à.WHAT    === À,   'A.new default is A';
    ok $à[0].WHAT === Any, 'A.new[0] default is Any';
    my $両 = 万.new;
    ok $両.WHAT    === 万,   'H.new default is Hash';
    ok $両<a>.WHAT === Any, 'H.new<a> default is Any';
} #4

{
    my Int $à;
    ok $à.WHAT    === Int,        'Int $a default is Int';
    my Int @à;
    ok @à.WHAT    === Array[Int], 'Int @a default is Array[Int]';
    ok @à[0].WHAT === Int,        'Int @a[0] default is Int';
    my Int %à;
    ok %à.WHAT    === Hash[Int],  'Int %a default is Hash[Int]';
    ok %à<a>.WHAT === Int,        'Int %a<a> default is Int';
} #5

{
    my $à of Int;
    ok $à.WHAT    === Int,        '$a of Int default is Int';
    my @à of Int;
    ok @à.WHAT    === Array[Int], '@a of Int default is Array[Int]';
    ok @à[0].WHAT === Int,        '@a[0] of Int default is Int';
    my %à of Int;
    ok %à.WHAT    === Hash[Int],  '%a of Int default is Hash[Int]';
    ok %à<a>.WHAT === Int,        '%a<a> of Int default is Int';
} #5

{
    my Int %à{Str};
    ok %à.WHAT    === Hash[Int,Str], 'Int %a{Str} default is Hash[Int,Str]';
    ok %à<a>.WHAT === Int,           'Int %a{Str}<a> default is Int';
} #2

{
    my %à{Str} of Int;
    ok %à.WHAT    === Hash[Int,Str], '%a{Str} of Int default is Hash[Int,Str]';
    ok %à<a>.WHAT === Int,           '%a{Str}<a> of Int default is Int';
} #2

{
    my $à = Array[Int].new;
    ok $à.WHAT    === Array[Int], 'Array[Int].new default is Array';
    ok $à[0].WHAT === Int,        'Array[Int].new[0] default is Int';
    my $両 = Hash[Int].new;
    ok $両.WHAT    === Hash[Int],  'Hash[Int].new default is Hash[Int]';
    ok $両<a>.WHAT === Int,        'Hash[Int].new<a> default is Int';
} #4

{
    my $à = À[Int].new;
    ok $à.WHAT    === À[Int], 'A[Int].new default is A[Int]';
    ok $à[0].WHAT === Int,    'A[Int].new[0] default is Int';
    my $両 = 万[Int].new;
    ok $両.WHAT    === 万[Int], 'H[Int].new default is H[Int]';
    ok $両<a>.WHAT === Int,    'H[Int].new<a> default is Int';
} #4

{
    my $両 = 万[Int,Str].new;
    ok $両.WHAT    === 万[Int,Str], 'H[Int,Str].new default is H[Int,Str]';
    ok $両<a>.WHAT === Int,        'H[Int,Str].new<a> default is Int';
} #2

# vim: expandtab shiftwidth=4
