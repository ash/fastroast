use Test;

# old: L<A12/"Declaration of Methods" /methods do not set the topic now/>
# (This is an an "update" section.)
# not mentioned explicitly in S12, but still true.

plan 2;

class Е갨갨 {
    method no_topic     { .^name }
    method topic ($_: ) { .echo }
    method echo         { "echo"  }
}

{
    my Е갨갨 $foo .= new;
    is $foo.no_topic, 'Any', '$_ is not set in methods...';
}

{
    my Е갨갨 $foo .= new;
    is $foo.topic(), "echo", '...unless $_ the invocant name is specified to be "$_"';
}

# vim: expandtab shiftwidth=4
