use Test;
plan 4;

#L<S03/"Smart matching"/Regex Hash hash key grep>
{
    my %h = (moep => 'е갨갨', bar => '丛à丳');
    ok  (/oep/ ~~ %h),      'Сe̲æe̲ч ~~ 万àò両 (+,1)';
    ok  (/bar/ ~~ %h),      'Сe̲æe̲ч ~~ 万àò両 (+,2)';
    ok !(/ugh/ ~~ %h),      'Сe̲æe̲ч ~~ 万àò両 (-,1)';
    ok !(/foo/ ~~ %h),      'Сe̲æe̲ч ~~ 万àò両 (-,𝐯àл갮e̲)';
}

# vim: expandtab shiftwidth=4
