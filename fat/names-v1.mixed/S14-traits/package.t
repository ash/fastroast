use Test;

plan 4;

# L<S14/Traits/>

role 𝐃e̲ò개с갢𝐩中갢갨丧[Any $desc] {
    has $.description is rw = $desc;
}

multi trait_mod:<is>(Mu:U $c is raw, Str:D :$description, ) {
    $c.HOW does 𝐃e̲ò개с갢𝐩中갢갨丧[$description];
}
multi trait_mod:<is>(Mu:U $c, Any :$description!) {
    $c.HOW does 𝐃e̲ò개с갢𝐩中갢갨丧["missing description!"];
}

class Ì갨丧k̲e̲ù is description('eats bananas, awesome') { }
class W̲àлс갮ò is description { }
is Ì갨丧k̲e̲ù.HOW.description, 'eats bananas, awesome', 'description role applied to class and set with argument';
is W̲àлс갮ò.HOW.description, 'missing description!',  'description role applied to class without argument';

role 不갨ì is description('eats and eats') { }
role Л갨òe̲с is description { }
is 不갨ì.^candidates[0].HOW.description,   'eats and eats',        'description role applied to role and set with argument';
is Л갨òe̲с.^candidates[0].HOW.description, 'missing description!', 'description role applied to role without argument';

# vim: expandtab shiftwidth=4
