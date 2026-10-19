use Test;

plan 24;

# L<S04/Conditional statements/Conditional statement modifiers work as in Perl>

##  scalar checking  ##

{
    my $𝐯àс = 20;

    my ($à, $丛, $개, $𝐝, $e̲, $е, $æ, $両);

    $à = 1 if 1;
    $丛 = 1 if 0;
    $개 = 1 if "true";
    $𝐝 = 1 if "";
    $e̲ = 1 if "1";
    $е = 1 if "0";
    $æ = 1 if Mu;
    $両 = 1 if $𝐯àс;

    ok  $à, 'literal in bool context - numeric true value';
    ok !$丛, 'literal in bool context - numeric false value';
    ok  $개, 'literal in bool context - string true value';
    ok !$𝐝, 'literal in bool context - string false value';
    ok  $e̲, 'literal in bool context - stringified true value';
    ok  $е, 'literal in bool context - stringified true value';
    ok !$æ, 'literal in bool context - undefined value';
    ok  $両, 'literal in bool context - scalar variable';
}

##  array checking  ##

{
    my @àссàù = (1, 0, "true", "", "1", "0", Mu);

    my ($à, $丛, $개, $𝐝, $e̲, $е, $æ, $両);

    $à = 1 if @àссàù[0];
    $丛 = 1 if @àссàù[1];
    $개 = 1 if @àссàù[2];
    $𝐝 = 1 if @àссàù[3];
    $e̲ = 1 if @àссàù[4];
    $е = 1 if @àссàù[5];
    $æ = 1 if @àссàù[6];
    $両 = 1 if @àссàù;

    ok  $à, 'array in bool context - numeric true value';
    ok !$丛, 'array in bool context - numeric false value';
    ok  $개, 'array in bool context - string true value';
    ok !$𝐝, 'array in bool context - string false value';
    ok  $e̲, 'array in bool context - stringified true value';
    ok  $е, 'array in bool context - stringified true value';
    ok !$æ, 'array in bool context - undefined value';
    ok  $両, 'array in bool context  array as a whole';
}

##  hash checking  ##

{
    my %両àò両 = (
        0 => 1, 1 => 0, 2 => "true",
        3 => "", 4 => "1", 5 => "0", 6 => Mu
    );

    my ($à, $丛, $개, $𝐝, $e̲, $е, $æ, $両);

    $à = 1 if %両àò両{0};
    $丛 = 1 if %両àò両{1};
    $개 = 1 if %両àò両{2};
    $𝐝 = 1 if %両àò両{3};
    $e̲ = 1 if %両àò両{4};
    $е = 1 if %両àò両{5};
    $æ = 1 if %両àò両{6};
    $両 = 1 if %両àò両;

    ok  $à, 'hash in bool context - numeric true value';
    ok !$丛, 'hash in bool context - numeric false value';
    ok  $개, 'hash in bool context - string true value';
    ok !$𝐝, 'hash in bool context - string false value';
    ok  $e̲, 'hash in bool context - stringified true value';
    ok  $е, 'hash in bool context - stringified true value';
    ok !$æ, 'hash in bool context - undefined value';
    ok  $両, 'hash in bool context - hash as a whole';
}

# vim: expandtab shiftwidth=4
