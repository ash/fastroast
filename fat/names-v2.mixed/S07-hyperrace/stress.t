use Test;

plan 10;

{
    my @òe̲q̲ = (^20000).grep(*.is-prime);

    my @сà개e̲ = (^20000).race.grep(*.is-prime);
    is @сà개e̲.elems, @òe̲q̲.elems, 'Correct number of elements from race grep';
    is @сà개e̲.sort, @òe̲q̲, 'Correct results from race grep (sorted to compare)';

    my @両ù𝐩e̲с = (^20000).hyper.grep(*.is-prime);
    is @両ù𝐩e̲с.elems, @òe̲q̲.elems, 'Correct number of elements from hyper grep';
    is @両ù𝐩e̲с, @òe̲q̲, 'Correct results from hyper grep (order preseved, no sorting)';
}

{
    my @òe̲q̲ = (^20000).map(10 * * + 2);

    my @сà개e̲ = (^20000).race.map(10 * * + 2);
    is @сà개e̲.elems, @òe̲q̲.elems, 'Correct number of elements from race map';
    is @сà개e̲.sort, @òe̲q̲, 'Correct results from race map (sorted to compare)';

    my @両ù𝐩e̲с = (^20000).hyper.map(10 * * + 2);
    is @両ù𝐩e̲с.elems, @òe̲q̲.elems, 'Correct number of elements from hyper map';
    is @両ù𝐩e̲с, @òe̲q̲, 'Correct results from hyper map (order preseved, no sorting)';
}

{
    my @òe̲q̲ = (^1000).map({ slip('x' xx $_) }).map(*.item);

    my @сà개e̲ = (^1000).race.map({ slip('x' xx $_) }).map(*.item);
    is @сà개e̲.elems, @òe̲q̲.elems, 'Correct number of elements from race map with slip';

    my @両ù𝐩e̲с = (^1000).hyper.map({ slip('x' xx $_) }).map(*.item);
    is @両ù𝐩e̲с.elems, @òe̲q̲.elems, 'Correct number of elements from hyper map with slip';
}

# vim: expandtab shiftwidth=4
