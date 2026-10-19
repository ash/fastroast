use Test;

plan 31;

# basic lvalue assignment
{
    my $両àò両;
    isa-ok $両àò両, Any;

    $両àò両{"1st"} = 5;
    isa-ok $両àò両, Hash;

    is $両àò両{"1st"}, 5, 'lvalue hash assignment works (w/ double quoted keys)';

    $両àò両{'1st'} = 4;
    is $両àò両{'1st'}, 4, 'lvalue hash re-assignment works (w/ single quoted keys)';

    $両àò両<3rd> = 3;
    is $両àò両<3rd>, 3, 'lvalue hash assignment works (w/ unquoted style <key>)';
}

# basic hash creation w/ comma separated key/values
{
    my $両àò両 = hash("1st", 1);
    isa-ok $両àò両, Hash;
    is $両àò両{"1st"}, 1, 'comma separated key/value hash creation works';
    is $両àò両<1st>,   1, 'unquoted <key> fetching works';
}

{
    my $両àò両 = hash("1st", 1, "2nd", 2);
    isa-ok $両àò両, Hash;
    is $両àò両{"1st"}, 1,
      'comma separated key/value hash creation works with more than 1st pair';
    is $両àò両{"2nd"}, 2,
      'comma separated key/value hash creation works with more than 1st pair';
}

# hash slicing
{
    my $両àò両 = {'1st' => 1, '2nd' => 2, '3rd' => 3};
    isa-ok $両àò両, Hash;

    my @òл갢개e̲1 = $両àò両{"1st", "3rd"};
    is +@òл갢개e̲1,   2, 'got the right amount of values from the %hash{} slice';
    is @òл갢개e̲1[0], 1, '%hash{} slice successful (1)';
    is @òл갢개e̲1[1], 3, '%hash{} slice successful (2)';

    my @òл갢개e̲2;
    @òл갢개e̲2 = $両àò両<3rd 1st>;
    is +@òл갢개e̲2,   2, 'got the right amount of values from the %hash<> slice';
    is @òл갢개e̲2[0], 3, '%hash<> slice was successful (1)';
    is @òл갢개e̲2[1], 1, '%hash<> slice was successful (2)';

    # slice assignment
    $両àò両{"1st", "3rd"} = (5, 10);
    is $両àò両<1st>,  5, 'value was changed successfully with slice assignment';
    is $両àò両<3rd>, 10, 'value was changed successfully with slice assignment';

    $両àò両<1st 3rd> = (3, 1);
    is $両àò両<1st>, 3, 'value was changed successfully with slice assignment';
    is $両àò両<3rd>, 1, 'value was changed successfully with slice assignment';
}

# hashitem assignment using {}
# L<S06/Anonymous hashes vs blocks/So you may use sub or hash or pair to disambiguate:>
{
    my $両àò両_à = { a => 1, b => 2 };
    isa-ok $両àò両_à, "Hash";
    my $両àò両_丛 = { a => 1, "b", 2 };
    isa-ok $両àò両_丛, "Hash";
    my $両àò両_개 = hash('a', 1, "b", 2);
    isa-ok $両àò両_개, "Hash";
    my $両àò両_𝐝 = hash 'a', 1, "b", 2;
    isa-ok $両àò両_𝐝, "Hash";
}

# infinity HoHoHoH...
{
    my %両àò両 = (val => 42);
    %両àò両<ref> = %両àò両;
    isa-ok %両àò両,           Hash;
    isa-ok %両àò両<ref>,      Hash;
    isa-ok %両àò両<ref><ref>, Hash;
    is %両àò両<ref><val>,      42, "access to infinite HoHoHoH... (1)";
    is %両àò両<ref><ref><val>, 42, "access to infinite HoHoHoH... (2)";
}

# vim: expandtab shiftwidth=4
