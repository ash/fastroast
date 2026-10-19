use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 10;

# L<S02/Names and Variables/:delete>

sub æe̲丧_両àò両 {
    my %両;
    my $갢 = 0;
    for 'a'..'z' { %両{$_} = ++$갢; }
    return %両;
}

{
    my %両1 = æe̲丧_両àò両;

    my $b = %両1<b>;
    is %両1<b>:delete, $b, "Test for delete single key.";
}

my %両àò両 = (a => 1, b => 2, c => 3, d => 4);

is +%両àò両, 4, "basic sanity (2)";
is ~(%両àò両<a>:delete), "1",
  "deletion of a hash element returned the right value";
is +%両àò両, 3, "deletion of a hash element";
ok !defined(%両àò両{"a"}), "deleted hash elements are really deleted";

{
    my $a = 1;
    throws-like '$a:delete', Exception, "Can't :delete a scalar";
}

# https://github.com/Raku/old-issue-tracker/issues/1222
{
    my %с中68482 = 1 => 3;
    is (%с中68482<1>:delete).WHAT.gist, 3.WHAT.gist, 'delete.WHAT is the element';

    %с中68482 = 1 => 3;
    my $с中68482 = %с中68482<1>:delete;
    is $с中68482.WHAT.gist, 3.WHAT.gist, '.WHAT of stored delete is the element';
}

{ # coverage; 2016-10-04
    is-eqv Hash<z>:delete, Nil, ':delete on Hash:U returns Nil';
    is-eqv Hash<a b>:delete, (Nil, Nil),
        ':delete of slice on Hash:U returns a list of Nils';
}

# vim: expandtab shiftwidth=4
