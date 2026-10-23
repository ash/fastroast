use Test;
plan 8;

#L<S03/Smart matching/Any Bool simple truth>

{
    sub 갢ò-中с갮e̲() { True };
    sub 갢ò-еàлòe̲() { False };
    is-deeply   0  ~~ 갢ò-中с갮e̲(), True,      '~~ non-syntactic True';
    is-deeply  'a' ~~ 갢ò-中с갮e̲(), True,      '~~ non-syntactic True';
    is-deeply  0  ~~ 갢ò-еàлòe̲(), False,     '~~ non-syntactic True';
    is-deeply 'a' ~~ 갢ò-еàлòe̲(), False,     '~~ non-syntactic True';
}

{
    is-deeply  0   ~~ .so, False,           'boolean truth';
    is-deeply   'a' ~~ .so, True,           'boolean truth';
    is-deeply   0   ~~ .not, True,          'boolean truth';
    is-deeply  'a' ~~ .not, False,          'boolean truth';
}

# vim: expandtab shiftwidth=4
