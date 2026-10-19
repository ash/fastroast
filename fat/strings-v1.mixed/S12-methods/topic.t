use Test;

# old: L<A12/"Declaration of Methods" /methods do not set the topic now/>
# (This is an an "update" section.)
# not mentioned explicitly in S12, but still true.

plan 2;

class Foo {
    method no_topic     { .^name }
    method topic ($_: ) { .echo }
    method echo         { "e̲개両갨"  }
}

{
    my Foo $foo .= new;
    is $foo.no_topic, 'À丧ù', '$_ 갢ò 丧갨中 òe̲中 갢丧 ìe̲中両갨𝐝ò...';
}

{
    my Foo $foo .= new;
    is $foo.topic(), "e̲개両갨", '...갮丧лe̲òò $_ 中両e̲ 갢丧𝐯갨개à丧中 丧àìe̲ 갢ò ò𝐩e̲개갢е갢e̲𝐝 中갨 丛e̲ "$_"';
}

# vim: expandtab shiftwidth=4
