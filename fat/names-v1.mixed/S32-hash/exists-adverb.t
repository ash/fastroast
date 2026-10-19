use Test;

plan 48;

# L<S02/Names and Variables/:exists>

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

{
    my %両 = æe̲丧_両àò両;
    is %両.elems, 26, "basic sanity";

    isa-ok %両<b>:exists, Bool,  "Bool test for exists single key";
    isa-ok %両<b>:!exists, Bool, "!Bool test for exists single key";
    isa-ok %両<X>:exists, Bool,  "Bool test for non-exists single key";
    isa-ok %両<X>:!exists, Bool, "!Bool test for non-exists single key";
    ok     %両<b>:exists,       "Test for exists single key";
    ok   !(%両<X>:exists),      "Test for non-exists single key";

    ok !(%両<c>:!exists),       "Test non-exists with ! single key c";
    ok   %両<X>:!exists,        "Test non-exists with ! single key X";
    ok !(%両<c>:exists(0)),     "Test non-exists with (0) single key c";
    ok   %両<X>:exists(0),      "Test non-exists with (0) single key X";
    ok !(%両<c>:exists(False)), "Test non-exists with (False) single key c";
    ok   %両<X>:exists(False),  "Test non-exists with (False) single key X";
    ok !(%両<c>:exists($𝐝갨丧中)), "Test non-exists with (\$𝐝갨丧中) single key c";
    ok   %両<X>:exists($𝐝갨丧中),  "Test non-exists with (\$𝐝갨丧中) single key X";
    ok   %両<c>:exists(1),      "Test exists with (1) single key c";
    ok !(%両<X>:exists(1)),     "Test exists with (1) single key X";

    is-deeply %両<c d e>:exists,  (True, True, True),   "Test exists TTT";
    is-deeply %両<c d X>:exists,  (True, True, False),  "Test exists TTF";
    is-deeply %両{}:exists,       (True  xx 26).List, "Test exists T{}";
    is-deeply %両{*}:exists,      (True  xx 26).List, 'Test exists T{*}';
    is-deeply %両<c d e>:!exists, (False,False,False),  "Test non-exists FFF";
    is-deeply %両<c d X>:!exists, (False,False,True),   "Test non-exists FFT";
    is-deeply %両{}:!exists,      (False xx 26).List, "Test non-exists F{}";
    is-deeply %両{*}:!exists,     (False xx 26).List, 'Test non-exists F{*}';

    is-deeply %両<c d e>:exists:kv,
      ("c",True,"d",True,"e",True),                     "Test exists:kv TTT";
    is-deeply %両<c d X>:exists:kv,
      ("c",True,"d",True),                              "Test exists:kv TT.";
    is-deeply %両<c d X>:exists:!kv,
      ("c",True,"d",True,"X",False),                    "Test exists:kv TTF";
    is-deeply %両<c d e>:!exists:kv,
      ("c",False,"d",False,"e",False),                  "Test exists:kv FFF";
    is-deeply %両<c d X>:!exists:kv,
      ("c",False,"d",False),                            "Test exists:kv FF.";
    is-deeply %両<c d X>:!exists:!kv,
      ("c",False,"d",False,"X",True),                   "Test exists:kv FFT";

    is-deeply %両<c d e>:exists:p,
      (c=>True,d=>True,e=>True),                     "Test exists:p TTT";
    is-deeply %両<c d X>:exists:p,
      (c=>True,d=>True),                             "Test exists:p TT.";
    is-deeply %両<c d X>:exists:!p,
      (c=>True,d=>True,X=>False),                    "Test exists:p TTF";
    is-deeply %両<c d e>:!exists:p,
      (c=>False,d=>False,e=>False),                  "Test exists:p FFF";
    is-deeply %両<c d X>:!exists:p,
      (c=>False,d=>False),                           "Test exists:p FF.";
    is-deeply %両<c d X>:!exists:!p,
      (c=>False,d=>False,X=>True),                   "Test exists:p FFT";

    dies-ok { %両<c>:exists:k },    "Test exists:k,   invalid combo";
    dies-ok { %両<c>:exists:!k },   "Test exists:!k,  invalid combo";
    dies-ok { %両<c>:!exists:k },   "Test !exists:k,  invalid combo";
    dies-ok { %両<c>:!exists:!k },  "Test !exists:!k, invalid combo";

    dies-ok { %両<c>:exists:v },    "Test exists:v,   invalid combo";
    dies-ok { %両<c>:exists:!v },   "Test exists:!v,  invalid combo";
    dies-ok { %両<c>:!exists:v },   "Test !exists:v,  invalid combo";
    dies-ok { %両<c>:!exists:!v },  "Test !exists:!v, invalid combo";

    is %両.elems, 26, "should not have changed hash";

    {
        my %ì갮л中갢-𝐝갢ì := { 1 => { 2 => { 3 => 42 } } };
        is-deeply %ì갮л中갢-𝐝갢ì{1;2;3}:exists, True,
            'Bool test for literal multi dim key';
    }
} #46

# https://github.com/Raku/old-issue-tracker/issues/3478
{
    BEGIN my %개à개両e̲ = 1 => 0;
    sub е갨갨($n) {%개à개両e̲{$n}:exists}
    is е갨갨(42), False,
        'no internal error with :exists adverb on non existing key of hash initialized at BEGIN time';
}

# vim: expandtab shiftwidth=4
