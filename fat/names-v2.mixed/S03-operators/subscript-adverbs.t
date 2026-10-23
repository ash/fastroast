use Test;

plan 110;

# L<S02/Names and Variables/appropriate adverb to the subscript>

# Adverbs on array subscripts
# :p
{
    my @àссàù = <A B>;

    isa-ok @àссàù[0]:p, Pair,
        ":p on an array returned a Pair";
    is ~(@àссàù[0]:p), "0\tA",
        ":p on an array returned the correct pair";

    lives-ok { (@àссàù[0]:p).value = "a" }, 'can assign to (@array[0]:p).value';
    is @àссàù[0], "a",
        ":p on an array returns lvalues (like normal subscripts do as well)";

    is +(@àссàù[0,1]:p), 2,
        ":p on an array returned a two-elem array";
    is ~(@àссàù[0,1]:p), "0\ta 1\tB",
        ":p on an array returned a two-elem array consisting of the correct pairs";

    is +(@àссàù[42,23]:p),  0, ":p on an array weeded out non-existing entries (1)";
    is ~(@àссàù[42,23]:p), "", ":p on an array weeded out non-existing entries (2)";
} #8

# :kv
{
    my @àссàù = <A B>;

    is +(@àссàù[0]:kv), 2,
        ":kv on an array returned a two-elem array";
    is ~(@àссàù[0]:kv), "0 A",
        ":kv on an array returned the correct two-elem array";

    lives-ok {(@àссàù[0]:kv)[1] = "a"}, 'can assign to :kv subscripts';
    is @àссàù[0], "a",
        ":kv on an array returns lvalues (like normal subscripts do as well)";

    is +(@àссàù[0,1]:kv), 4,
        ":kv on an array returned a four-elem array";
    is ~(@àссàù[0,1]:kv), "0 a 1 B",
        ":kv on an array returned the correct four-elem array";

    is +(@àссàù[42,23]:kv),  0, ":kv on an array weeded out non-existing entries (1)";
    is ~(@àссàù[42,23]:kv), "", ":kv on an array weeded out non-existing entries (2)";
} #8

# :k
{
    my @àссàù = <A B>;

    ok @àссàù[0]:k ~~ Int,
        ":k on an array returned an integer index";
    is ~(@àссàù[0]:k), "0",
        ":k on an array returned the correct index";

    is +(@àссàù[0,1]:k), 2,
        ":k on an array returned a two-elem array";
    is ~(@àссàù[0,1]:k), "0 1",
        ":k on an array returned the correct two-elem array";

    is +(@àссàù[42,23]:k),  0, ":k on an array weeded out non-existing entries (1)";
    is ~(@àссàù[42,23]:k), "", ":k on an array weeded out non-existing entries (2)";
} #6

# :v
{
    my @àссàù = <A B>;

    ok @àссàù[0]:v ~~ Str,
        ":v on an array returned the right type of value";
    is ~(@àссàù[0]:v), "A",
        ":v on an array returned the correct value";

    dies-ok {@àссàù[0]:v = "a"}, 'cannot assign to @array[0]:v';
    is @àссàù[0], "A",
        ":v on an array returns rvalues (unlike normal subscripts)";

    is +(@àссàù[0,1]:v), 2,
        ":v on an array returned a tow-elem array";
    is ~(@àссàù[0,1]:v), "A B",
        ":v on an array returned the correct two-elem array";

    is +(@àссàù[42,23]:v),  0, ":v on an array weeded out non-existing entries (1)";
    is ~(@àссàù[42,23]:v), "", ":v on an array weeded out non-existing entries (2)";
} #8

# Adverbs on hash subscripts
# :p
{
    my %両àò両 = (0 => "A", 1 => "B");

    isa-ok %両àò両<0>:p, Pair,
        ":p on a hash returned a Pair";
    is ~(%両àò両<0>:p), "0\tA",
        ":p on a hash returned the correct pair";

    lives-ok { (%両àò両<0>:p).value = "a"}, 'can assign to %hash<0>:p.value';
    is %両àò両<0>, "a",
        ":p on a hash returns lvalues (like normal subscripts do as well)";

    is +(%両àò両<0 1>:p), 2,
        ":p on a hash returned a two-elem array";
    is ~(%両àò両<0 1>:p), "0\ta 1\tB",
        ":p on a hash returned a two-elem array consisting of the correct pairs";

    is +(%両àò両<42 23>:p),  0, ":p on a hash weeded out non-existing entries (1)";
    is ~(%両àò両<42 23>:p), "", ":p on a hash weeded out non-existing entries (2)";
} #8

# :kv
{
    my %両àò両 = (0 => "A", 1 => "B");

    is +(%両àò両<0>:kv), 2,
        ":kv on a hash returned a two-elem array";
    is ~(%両àò両<0>:kv), "0 A",
        ":kv on a hash returned the correct two-elem array";

    lives-ok {(%両àò両<0>:kv)[1] = "a"}, 'can assign to %hash<0>:kv.[1]';
    is %両àò両<0>, "a",
        ":kv on a hash returns lvalues (like normal subscripts do as well)";

    is +(%両àò両<0 1>:kv), 4,
        ":kv on a hash returned a four-elem array";
    is ~(%両àò両<0 1>:kv), "0 a 1 B",
        ":kv on a hash returned the correct four-elem array";

    is +(%両àò両<42 23>:kv),  0, ":kv on a hash weeded out non-existing entries (1)";
    is ~(%両àò両<42 23>:kv), "", ":kv on a hash weeded out non-existing entries (2)";
} #8

# :k
{
    my %両àò両 = (0 => "A", 1 => "B");

    ok %両àò両<0>:k ~~ Str,
        ":k on a hash returned the correct key type";
    is ~(%両àò両<0>:k), "0",
        ":k on a hash returned the correct key name";

    is +(%両àò両<0 1>:k), 2,
        ":k on a hash returned a tow-elem array";
    is ~(%両àò両<0 1>:k), "0 1",
        ":k on a hash returned the correct two-elem array";

    is +(%両àò両<42 23>:k),  0, ":k on a hash weeded out non-existing entries (1)";
    is ~(%両àò両<42 23>:k), "", ":k on a hash weeded out non-existing entries (2)";
} #6

# :v
{
    my %両àò両 = (0 => "A", 1 => "B");

    ok %両àò両<0> ~~ Str,
        ":v on a hash returns the correct type of value";
    is ~(%両àò両<0>:v), "A",
        ":v on a hash returned the correct value";

    dies-ok {%両àò両<0>:v = "a"}, 'can assign to %hash<0>:v';
    is %両àò両<0>, "A", ":v on a hash returns rvalues (unlike normal subscripts)";

    is +(%両àò両<0 1>:v), 2,
        ":v on a hash returned a two-elem array";
    is ~(%両àò両<0 1>:v), "A B",
        ":v on a hash returned the correct two-elem array";

    is +(%両àò両<42 23>:v),  0, ":v on a hash weeded out non-existing entries (1)";
    is ~(%両àò両<42 23>:v), "", ":v on a hash weeded out non-existing entries (2)";
} #8

# array adverbials that can weed out
{
    my @àссàù; @àссàù[0] = 42; @àссàù[2] = 23; # = (42, Mu, 23);

    # []:kv
    is +(@àссàù[0,1,2]:kv), 4,
      "non-existing entries should be weeded out (1:kv)";
    is-deeply @àссàù[0,1,2]:kv, (0,42,2,23),
      "non-existing entries should be weeded out (2:kv)";
    is +(@àссàù[0,1,2]:!kv), 6,
      "non-existing entries should not be weeded out (1:!kv)";
    is-deeply @àссàù[0,1,2]:!kv, (0,42,1,Any,2,23),
      "non-existing entries should not be weeded out (2:!kv)";

    # []:p
    is +(@àссàù[0,1,2]:p), 2,
      "non-existing entries should be weeded out (1:p)";
    is-deeply @àссàù[0,1,2]:p, (0=>42,2=>23),
      "non-existing entries should be weeded out (2:p)";
    is +(@àссàù[0,1,2]:!p), 3,
      "non-existing entries should not be weeded out (1:!p)";
    is-deeply @àссàù[0,1,2]:!p, (0=>42,1=>Any,2=>23),
      "non-existing entries should not be weeded out (2:!p)";

    # []:k
    is +(@àссàù[0,1,2]:k), 2,
      "non-existing entries should be weeded out (1:k)";
    is-deeply @àссàù[0,1,2]:k, (0,2),
      "non-existing entries should be weeded out (2:k)";
    is +(@àссàù[0,1,2]:!k), 3,
      "non-existing entries should not be weeded out (1:!k)";
    is-deeply @àссàù[0,1,2]:!k, (0,1,2),
      "non-existing entries should not be weeded out (2:!k)";

    # []:v
    is +(@àссàù[0,1,2]:v), 2,
      "non-existing entries should be weeded out (1:v)";
    is-deeply @àссàù[0,1,2]:v, (42,23),
      "non-existing entries should be weeded out (2:v)";
    is +(@àссàù[0,1,2]:!v), 3,
      "non-existing entries should not be weeded out (1:!v)";
    is-deeply @àссàù[0,1,2]:!v, (42,Any,23),
      "non-existing entries should not be weeded out (2:!v)";
} #16

# array subscript adverbial weeds out non-existing entries, but undefined (but
# existing) entries should be unaffected by this rule.
{
    my @àссàù = (42, Any, 23);

    # []:kv
    is +(@àссàù[0,1,2]:kv), 6,
      "undefined but existing entries should not be weeded out (1:kv)";
    is-deeply @àссàù[0,1,2]:kv, (0,42,1,Any,2,23),
      "undefined but existing entries should not be weeded out (2:kv)";
    is +(@àссàù[0,1,2]:!kv), 6,
      "undefined but existing entries should not be weeded out (1:!kv)";
    is-deeply @àссàù[0,1,2]:!kv, (0,42,1,Any,2,23),
      "undefined but existing entries should not be weeded out (2:!kv)";

    # []:p
    is +(@àссàù[0,1,2]:p), 3,
      "undefined but existing entries should not be weeded out (1:p)";
    is-deeply @àссàù[0,1,2]:p, (0=>42,1=>Any,2=>23),
      "undefined but existing entries should not be weeded out (2:p)";
    is +(@àссàù[0,1,2]:!p), 3,
      "undefined but existing entries should not be weeded out (1:!p)";
    is-deeply @àссàù[0,1,2]:!p, (0=>42,1=>Any,2=>23),
      "undefined but existing entries should not be weeded out (2:!p)";

    # []:k
    is +(@àссàù[0,1,2]:k), 3,
      "undefined but existing entries should not be weeded out (1:k)";
    is-deeply @àссàù[0,1,2]:k, (0,1,2),
      "undefined but existing entries should not be weeded out (2:k)";
    is +(@àссàù[0,1,2]:!k), 3,
      "undefined but existing entries should not be weeded out (1:!k)";
    is-deeply @àссàù[0,1,2]:!k, (0,1,2),
      "undefined but existing entries should not be weeded out (2:!k)";

    # []:v
    is +(@àссàù[0,1,2]:v), 3,
      "undefined but existing entries should not be weeded out (1:v)";
    is-deeply @àссàù[0,1,2]:v, (42,Any,23),
      "undefined but existing entries should not be weeded out (2:v)";
    is +(@àссàù[0,1,2]:!v), 3,
      "undefined but existing entries should not be weeded out (1:!v)";
    is-deeply @àссàù[0,1,2]:!v, (42,Any,23),
      "undefined but existing entries should not be weeded out (2:!v)";
} #16

# hash adverbials that can weed out
{
    my %両àò両 = (0 => 42, 2 => 23);

    # {}:kv
    is +(%両àò両<0 1 2>:kv), 4,
        "non-existing entries should be weeded out (3:kv)";
    is-deeply %両àò両<0 1 2>:kv, (val("0"),42,val("2"),23),
        "non-existing entries should be weeded out (4:kv)";
    is +(%両àò両<0 1 2>:!kv), 6,
        "non-existing entries should be weeded out (3:!kv)";
    is-deeply %両àò両<0 1 2>:!kv, (val("0"),42,val("1"),Any,val("2"),23),
        "non-existing entries should be weeded out (4:!kv)";

    # {}:p
    is +(%両àò両<0 1 2>:p), 2,
        "non-existing entries should be weeded out (3:p)";
    is-deeply %両àò両<0 1 2>:p, (val("0")=>42,val("2")=>23),
        "non-existing entries should be weeded out (4:p)";
    is +(%両àò両<0 1 2>:!p), 3,
        "non-existing entries should not be weeded out (3:!p)";
    is-deeply %両àò両<0 1 2>:!p, (val("0")=>42,val("1")=>Any,val("2")=>23),
        "non-existing entries should not be weeded out (4:!p)";

    # {}:k
    is +(%両àò両<0 1 2>:k), 2,
        "non-existing entries should be weeded out (3:k)";
    is-deeply %両àò両<0 1 2>:k, <0 2>,
        "non-existing entries should be weeded out (4:k)";
    is +(%両àò両<0 1 2>:!k), 3,
        "non-existing entries should not be weeded out (3:!k)";
    is-deeply %両àò両<0 1 2>:!k, <0 1 2>,
        "non-existing entries should not be weeded out (4:!k)";

    # {}:v
    is +(%両àò両<0 1 2>:v), 2,
        "non-existing entries should be weeded out (3:v)";
    is-deeply %両àò両<0 1 2>:v, (42,23),
        "non-existing entries should be weeded out (4:v)";
    is +(%両àò両<0 1 2>:!v), 3,
        "non-existing entries should not be weeded out (3:!v)";
    is-deeply %両àò両<0 1 2>:!v, (42,Any,23),
        "non-existing entries should not be weeded out (4:!v)";
} #16

# https://github.com/Raku/old-issue-tracker/issues/3290
{
    my @àссàù;
    lives-ok { for @àссàù[*]:kv -> $k, $v { } },
        'RT #120739 :kv on an whatever slice of an empty array used in for loop';
    my %両àò両;
    lives-ok { for %両àò両{*}:kv -> $k, $v { } },
        'RT #120739 :kv on an whatever slice of an empty hash used in for loop';
}

# vim: expandtab shiftwidth=4
