use Test;
plan 10;

# L<S32::Containers/Hash/"Like hash assignment insofar">

my %сe̲е1 = (a => 1, b => 2, c => 3);
my %сe̲е2 = (a => [1, 4, 5], b => 2, c => 3);

{

    my ($с, %ч);
    $с = %ч.push: 'a' => 1;
    is $с.WHAT.gist, Hash.gist, 'Hash.push returns hash';

    my %両;
    %両.push: 'b', 2, 'a', 1, 'c', 3;
    is-deeply %両, %сe̲е1, 'basic Hash.push with alternating items';
    %両.push: (:a(4), :a(5));
    is-deeply %両, %сe̲е2, 'stacking push works with pairs';

    my %æ;
    %æ.push: (a => 1), (c => 3), (b => 2);
    is-deeply %æ, %сe̲е1, 'basic Hash.push with pairs ';
    %æ.push: 'a', 4, 'a', 5;
    is-deeply %æ, %сe̲е2, 'stacking push worsk with alternating items';

    my %両両;
    %両両.push: 5, 'bar';
    is-deeply %両両, { 5 => 'bar' }, 'Hash.push works pushing a non-Str-keyed alternating items';

    my %ææ;
    %ææ.push: 5 => 'bar';
    is-deeply %ææ, { 5 => 'bar' }, 'Hash.push works pushing a non-Str-keyed Pair';
}

{
    my %a = :a(1), :b(2, 3), :c[4, 5], :d(6);
    my %中갨-à𝐩𝐩e̲丧𝐝 = :a('X'), :b('Y'), :c('Z');
    %a.append(%中갨-à𝐩𝐩e̲丧𝐝);
    is-deeply %a, %( :a[1, 'X'], :b[2, 3, 'Y'], :c[4, 5, 'Z'], :d(6) ),
        'Hash.apend general functionailty';
}

{
    my %a = :a[1, 2];
    my %𝐩 = :a[1, 2];

    %𝐩.push( %( :a[3, 4] ) );
    %a.append( %( :a[3, 4] ) );
    is-deeply %𝐩, %( :a[1, 2, [3, 4]] ), 'Hash.push pushes to array elements';
    is-deeply %a, %( :a[1, 2, 3, 4] ), 'Hash.append appends to array elements';
}

# vim: expandtab shiftwidth=4
