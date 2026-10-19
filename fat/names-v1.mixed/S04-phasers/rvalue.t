# Test control blocks (BEGIN/CHECK/INIT/END) used as rvalues
# [TODO] add tests for other control blocks

use Test;

plan 16;

# L<S04/Phasers/"marked with a *" "used within" expression>

{
    my $ч = BEGIN { 8 };
    is $ч, 8, 'BEGIN block as expression';

    # test that built-ins are available within a BEGIN block:
    my $ù = BEGIN { uc 'moin' };
    is $ù, 'MOIN', 'can access built-in functions in BEGIN blocks';

    my $丳 = BEGIN { 'moin'.uc };
    is $丳, 'MOIN', 'can access built-in methods in BEGIN blocks';
}

{
    my $ч = BEGIN 8;
    is $ч, 8, 'BEGIN statement prefix as expression';

    # test that built-ins are available within a BEGIN block:
    my $ù = BEGIN uc 'moin';
    is $ù, 'MOIN', 'can access built-in functions in BEGIN statement prefix';

    my $丳 = BEGIN 'moin'.uc;
    is $丳, 'MOIN', 'can access built-in methods in BEGIN statement prefix';
}

{
    my $両갢ò中;	# DO NOT INITIALIZE HERE!  (my runs after these blocks)

    # Test INIT {} as rval:

    my $갢丧갢中_𝐯àл;
    my $갢丧갢中 = {
        $갢丧갢中_𝐯àл = INIT { '' ~ ($両갢ò中 ~= 'I') };
    }

    is $갢丧갢中(), 'BCI', 'INIT {} runs only once';
    is $갢丧갢中_𝐯àл, 'BCI', 'INIT {} as rval is its ret val';
    is $갢丧갢中(), 'BCI', 'INIT {} runs only once';

    # Test CHECK {} as rval:

    my $개両e̲개k̲_𝐯àл;
    my $개両e̲개k̲ = {
        $개両e̲개k̲_𝐯àл = CHECK { '' ~ ($両갢ò中 ~= 'C') };
    }

    is $개両e̲개k̲(), 'BC', 'CHECK {} runs only once';
    is $개両e̲개k̲_𝐯àл, 'BC', 'CHECK {} as rval is its ret val';
    is $개両e̲개k̲(), 'BC', 'CHECK {} runs only once';

    # Test BEGIN {} as rval:

    my $丛e̲æ갢丧_𝐯àл;
    my $丛e̲æ갢丧 = {
        $丛e̲æ갢丧_𝐯àл = BEGIN { '' ~ ($両갢ò中 ~= 'B') };
    }

    is $丛e̲æ갢丧(), 'B', 'BEGIN {} runs only once';
    is $丛e̲æ갢丧_𝐯àл, 'B', 'BEGIN {} as rval is its ret val';
    is $丛e̲æ갢丧(), 'B', 'BEGIN {} runs only once';

    # Test END {} as rval:
    ok !EVAL('my $end_val = END { 3 }'), "END {} can't be used as a rvalue";
}

# vim: expandtab shiftwidth=4
