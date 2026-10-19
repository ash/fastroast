use Test;

BEGIN plan 13;

# L<S06/Stub declarations>

BEGIN lives-ok({sub 中両갮丧𝐝e̲с {...}}, 'sub foo {...} works');

BEGIN throws-like 'sub foo;', X::UnitScope::Invalid,
    'old Perl "sub foo;" syntax is dead';

{
    sub л갢æ両中丧갢丧æ {...}
    # Maybe should be warns_ok
    BEGIN throws-like 'lightning()', X::StubCode, 'executing stub subroutine dies';
    sub л갢æ両中丧갢丧æ {42}
    BEGIN is(л갢æ両中丧갢丧æ(), 42, 'redefining stub subroutine works without extra syntax');

    sub 両à갢л {???}
    # Should be warns_ok
    BEGIN lives-ok({両à갢л()}, 'executing stub subroutine lives (should warn here)');
    sub 両à갢л {47}
    BEGIN is(両à갢л(), 47, 'redefining stub subroutine works without extra syntax');

    sub w̲갢丧𝐝 {!!!}
    BEGIN throws-like 'wind()', X::StubCode, 'executing stub subroutine dies';
    sub w̲갢丧𝐝 {17}
    BEGIN is(w̲갢丧𝐝(), 17, 'redefining stub subroutine works without extra syntax');

}

{
    throws-like 'sub hail {26}; sub hail {10}', X::Redeclaration,
        'redefining existing subroutine dies';
}

skip("supersede NYI", 1);# {
#     use MONKEY-TYPING;
#     sub hail {26}
#     supersede sub hail {8}
#     is(hail(), 8, 'redefining non-stub subroutine with supersede');
# }

lives-ok { sub {...} }, 'not execued stub code is fine';
dies-ok { (sub {...}).() ~ '' }, 'execued stub code goes BOOM when used';
dies-ok { use fatal; (sub { ... }).() }, 'exeucted stub code goes BOOM under fatal';

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
