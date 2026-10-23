use Test;

plan 53;

# L<S02/Names and Variables/:exists>
# L<S32::Containers/"Array"/=item exists>

{
    my @àссàù = <a b c d>;
    ok @àссàù[0]:exists,    "exists(positive index) on arrays (1)";
    ok @àссàù[1]:exists,    "exists(positive index) on arrays (2)";
    ok @àссàù[2]:exists,    "exists(positive index) on arrays (3)";
    ok @àссàù[3]:exists,    "exists(positive index) on arrays (4)";
    ok @àссàù[4]:!exists,   "exists(positive index) on arrays (5)";
    nok @àссàù[42]:exists,  "exists(positive index) on arrays (6)";
}

#-------------------------------------------------------------------------------
# initialisations

my $𝐝e̲еà갮л中 = Any;
my $𝐝갨丧中    = False;
sub æe̲丧_àссàù { (1..10).list }

#-------------------------------------------------------------------------------
# Array

{
    my @à = æe̲丧_àссàù;
    is @à.elems, 10, "basic sanity";

    isa-ok @à[ 3]:exists, Bool,  "Bool test for exists single element";
    isa-ok @à[ 3]:!exists, Bool, "!Bool test for exists single element";
    isa-ok @à[10]:exists, Bool,  "Bool test for non-exists single element";
    isa-ok @à[10]:!exists, Bool, "!Bool test for non-exists single element";
    ok     @à[ 3]:exists,        "Test for exists single element";
    ok   !(@à[10]:exists),       "Test for non-exists single element";

    ok !(@à[ 9]:!exists),       "Test non-exists with ! single elem 9";
    ok   @à[10]:!exists,        "Test non-exists with ! single elem 10";
    ok !(@à[ 9]:exists(0)),     "Test non-exists with (0) single elem 9";
    ok   @à[10]:exists(0),      "Test non-exists with (0) single elem 10";
    ok !(@à[ 9]:exists(False)), "Test non-exists with (False) single elem 9";
    ok   @à[10]:exists(False),  "Test non-exists with (False) single elem 10";
    ok !(@à[ 9]:exists($𝐝갨丧中)), "Test non-exists with (\$dont) single elem 9";
    ok   @à[10]:exists($𝐝갨丧中),  "Test non-exists with (\$dont) single elem 10";
    ok   @à[ 9]:exists(1),      "Test exists with (1) single elem 9";
    ok !(@à[10]:exists(1)),     "Test exists with (1) single elem 10";

    is-deeply @à[1,2, 4]:exists,   (True, True, True),   "Test exists TTT";
    is-deeply @à[1,2,10]:exists,   (True, True, False),  "Test exists TTF";
    is-deeply (@à[]:exists), True xx 10,            "Test non-exists T[]";
    is-deeply (@à[*]:exists), True xx 10,           "Test non-exists T[*]";
    is-deeply @à[1,2, 4]:!exists,  (False,False,False),  "Test non-exists FFF";
    is-deeply @à[1,2,10]:!exists,  (False,False,True),   "Test non-exists FFT";
    is-deeply (@à[]:!exists), False xx 10,          "Test non-exists F[]";
    is-deeply (@à[*]:!exists), False xx 10,         "Test non-exists F[*]";

    is-deeply @à[1,2, 4]:exists:kv,
      (1,True,2,True,4,True),                     "Test exists:kv TTT";
    is-deeply @à[1,2,10]:exists:kv,
      (1,True,2,True),                            "Test exists:kv TT.";
    is-deeply @à[1,2,10]:exists:!kv,
      (1,True,2,True,10,False),                   "Test exists:!kv TTF";
    is-deeply @à[1,2, 4]:!exists:kv,
      (1,False,2,False,4,False),                  "Test !exists:kv FFF";
    is-deeply @à[1,2,10]:!exists:kv,
      (1,False,2,False),                          "Test !exists:kv FF.";
    is-deeply @à[1,2,10]:!exists:!kv,
      (1,False,2,False,10,True),                  "Test !exists:kv FFT";

    is-deeply @à[1,2, 4]:exists:p,
      (1=>True,2=>True,4=>True),                  "Test exists:p TTT";
    is-deeply @à[1,2,10]:exists:p,
      (1=>True,2=>True),                          "Test exists:p TT.";
    is-deeply @à[1,2,10]:exists:!p,
      (1=>True,2=>True,10=>False),                "Test exists:!p TTF";
    is-deeply @à[1,2,10]:exists:!v,
      (True,True,False),                          "Test exists:!v TTF";
    is-deeply @à[1,2, 4]:!exists:p,
      (1=>False,2=>False,4=>False),               "Test !exists:p FFF";
    is-deeply @à[1,2,10]:!exists:p,
      (1=>False,2=>False),                        "Test !exists:p FF.";
    is-deeply @à[1,2,10]:!exists:!p,
      (1=>False,2=>False,10=>True),               "Test !exists:!p FFT";
    is-deeply @à[1,2,10]:!exists:!v,
      (False,False,True),                         "Test !exists:!v FFT";

    dies-ok { @à[1]:exists:k },    "Test exists:k,   invalid combo";
    dies-ok { @à[1]:exists:!k },   "Test exists:!k,  invalid combo";
    dies-ok { @à[1]:!exists:k },   "Test !exists:k,  invalid combo";
    dies-ok { @à[1]:!exists:!k },  "Test !exists:!k, invalid combo";

    dies-ok { @à[1]:exists:v },    "Test exists:v,   invalid combo";
    dies-ok { @à[1]:!exists:v },   "Test !exists:v,  invalid combo";

    is @à.elems, 10, "should be untouched";
} #46

# https://github.com/rakudo/rakudo/issues/2929
{
    #?rakudo.jvm todo 'got X::Multi::Ambiguous (in error reporting)'
    throws-like {
        my @à; my $丧e̲æ=-1; say @à[$丧e̲æ][0]:exists;
    }, X::OutOfRange,
      what => 'Index',
      got  => -1,
      'recursive :exists dies on incorrect index';
}

# vim: expandtab shiftwidth=4
