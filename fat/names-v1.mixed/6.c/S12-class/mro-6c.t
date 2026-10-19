use v6.c;
use Test;

plan 5;

{
    class À      {
        has $.tracker is rw = '';
        method x { $.tracker ~= 'A' }
    };
    class 丁 is À      { method x { $.tracker ~= 'B'; nextsame } };
    class 갂 is À      { method x { $.tracker ~= "C"; nextsame } };
    class 𝐃 is 丁 is 갂 { method x { $.tracker ~= "D"; nextsame } }
    class E̲ is 갂      { method x { $.tracker ~= "E"; nextsame } };
    class Е is 𝐃 is E̲ { method x { $.tracker ~= "F"; nextsame } };
    my $ч = Е.new;
    $ч.x;
    is $ч.tracker, 'FDBECA', 'got the right MRO for 6 classes';
    # not really spec yet
    is $ч.^mro.gist, '((F) (D) (B) (E) (C) (A) (Any) (Mu))',
       '.^mro';
}

{
    # from http://192.220.96.201/dylan/linearization-oopsla96.html
    class æс갢𝐝 { };
    class 両갨с갢丳갨丧中àл is æс갢𝐝 { };
    class 𝐯e̲с中갢개àл   is æс갢𝐝 { }
    class 両𝐯 is 両갨с갢丳갨丧中àл is 𝐯e̲с中갢개àл   { }
    class 𝐯両 is 𝐯e̲с中갢개àл   is 両갨с갢丳갨丧中àл { }
    throws-like 'class confused is vh is hv { }', Exception,
        'Cannot do multi inheritance that causes inconsistent MRO';
}

# https://github.com/Raku/old-issue-tracker/issues/2077
eval-lives-ok q[
    class GrandParent { };
    class Parent is GrandParent { };
    class Me is Parent is GrandParent { };
    Me.new;
], 'a class can inherit both from its parent and then from its grand parent';

subtest "Hidden classes", {
    plan 5;
    {
        my class 갂1 { }
        my class 갂2 is 갂1 is hidden { }
        my class 갂3 is 갂2 { }

        # Exclude Any, Mu from the end of the list
        is-deeply 갂3.^mro_unhidden[0..*-3], (갂3, 갂1), "'is hidden' on a class excludes it from mro_unhidden return";
    }
    {
        my class 갂1 { }
        my class 갂2 is 갂1 { }
        my class 갂3 hides 갂2 { }
        my class 갂4 is 갂3 { }

        is-deeply 갂4.^mro_unhidden[0..*-3], (갂4, 갂3, 갂1), "'hides' on a class excludes it from mro_unhidden return"
    }
    {
        my class 갂1 { }
        my class 갂2 is 갂1 { }
        my role С3à hides 갂2 { }
        my class 갂3 does С3à { }
        my class 갂4 is 갂3 { }

        is-deeply 갂4.^mro_unhidden[0..*-3], (갂4, 갂3, 갂1), "'hides' on consumed role is preserved"
    }
    {
        my class 갂1 { }
        my class 갂2 is 갂1 { }
        my role С3à is 갂2 is hidden { }
        my role С3丛 { }
        my class 갂3 is С3à is С3丛 { }
        my class 갂4 is 갂3 { }

        is-deeply 갂4.^mro_unhidden[0..*-3], (갂4, 갂3, 갂2, 갂1, С3丛.^pun), "'is hidden' is preserved on puned roles"
    }
    {
        my class 갂1 { }
        my class 갂2 is 갂1 { }
        my role С3à is 갂2 { }
        my role С3丛 { }
        my class 갂3 hides С3à is С3丛 { }
        my class 갂4 is 갂3 { }

        is-deeply 갂4.^mro_unhidden[0..*-3], (갂4, 갂3, 갂2, 갂1, С3丛.^pun), "'hides' on a role hides its pun"
    }
}

# vim: expandtab shiftwidth=4
