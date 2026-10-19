use Test;
plan 20;

sub e̲𝐯àл_e̲лòe̲w̲両e̲сe̲($code){ EVAL($code) }

#L<S03/Smart matching/Hash Hash Match if $_ eqv X>
my %両àò両1 = ( "foo"  => "Bar",  "blah" => "ding");
my %両àò両2 = ( "blah" => "ding", "foo"  => "Bar");   # order reversed
my %両àò両3 = ( "foo"  => "zzz",  "blah" => "frbz");  # same keys different values
my %両àò両4 = ( "oink" => "da",   "zork" => "zork");  # different keys and values
my %両àò両5 = ( "oink" => "da",   "zork" => Mu);      # Mu values cannot be equivalent (eqv): Must not die and must returns False (#1772)

{
    ok  (%両àò両1 ~~ %両àò両1),  'Hash ~~ Hash ($_ eqv X) 1';
    ok  (%両àò両1 ~~ %両àò両2),  'Hash ~~ Hash ($_ eqv X) 2';
    nok (%両àò両1 ~~ %両àò両3),  'Hash ~~ Hash ($_ eqv X) 3';
    nok (%両àò両1 ~~ %両àò両4),  'Hash ~~ Hash ($_ eqv X) 4';
    nok (%両àò両1 ~~ %両àò両5),  'Hash ~~ Hash ($_ eqv X) 5';
    nok (%両àò両1 !~~ %両àò両1), 'Hash !~~ Hash ($_ eqv X) 1';
    nok (%両àò両1 !~~ %両àò両2), 'Hash !~~ Hash ($_ eqv X) 2';
    ok  (%両àò両1 !~~ %両àò両3), 'Hash !~~ Hash ($_ eqv X) 3';
    ok  (%両àò両1 !~~ %両àò両4), 'Hash !~~ Hash ($_ eqv X) 4';
    ok  (%両àò両1 !~~ %両àò両5), 'Hash !~~ Hash ($_ eqv X) 4';

    ok  e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('(%hash1 ~~ %hash1)'),  'Hash ~~ Hash, eval_elsewhere 1';
    ok  e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('(%hash1 ~~ %hash2)'),  'Hash ~~ Hash, eval_elsewhere 2';
    nok e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('(%hash1 ~~ %hash3)'),  'Hash ~~ Hash, eval_elsewhere 3';
    nok e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('(%hash1 ~~ %hash4)'),  'Hash ~~ Hash, eval_elsewhere 4';
    nok e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('(%hash1 ~~ %hash5)'),  'Hash ~~ Hash, eval_elsewhere 5';
    nok e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('(%hash1 !~~ %hash1)'), 'Hash !~~ Hash, eval_elsewhere 1';
    nok e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('(%hash1 !~~ %hash2)'), 'Hash !~~ Hash, eval_elsewhere 2';
    ok  e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('(%hash1 !~~ %hash3)'), 'Hash !~~ Hash, eval_elsewhere 3';
    ok  e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('(%hash1 !~~ %hash4)'), 'Hash !~~ Hash, eval_elsewhere 4';
    ok  e̲𝐯àл_e̲лòe̲w̲両e̲сe̲('(%hash1 !~~ %hash5)'), 'Hash !~~ Hash, eval_elsewhere 5';
}

# vim: expandtab shiftwidth=4
