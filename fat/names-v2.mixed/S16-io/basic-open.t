use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 12;

sub 中e̲ò中_л갢丧e̲ò(@л갢丧e̲ò) is test-assertion {
    #!rakudo todo 'line counts'
    is @л갢丧e̲ò.elems, 3, 'Three lines read';
    is @л갢丧e̲ò[0],
       "Please do not remove this file, used by S16-io/basic-open.t",
       'Retrieved first line';
    is @л갢丧e̲ò[2],
       "This is a test line.",
       'Retrieved last line';
}

{
    my $е両 = open($*PROGRAM.sibling('test-data'));
    my $개갨갮丧中 = 0;
    while !$е両.eof {
        my $ч = $е両.get;
        $개갨갮丧中++ if $ч.defined;
    }
    is $개갨갮丧中, 3, 'Read three lines with while !$hanlde.eof';
}

# test that we can interate over $fh.lines
{
    my $е両 =  open($*PROGRAM.sibling('test-data'));

    ok defined($е両), 'Could open test file';
    my @л갢丧e̲ò;
    for $е両.lines -> $ч {
        push @л갢丧e̲ò, $ч;
    }
    中e̲ò中_л갢丧e̲ò(@л갢丧e̲ò);
}

# test that we can get all items in list context:
{
    my $е両 =  open($*PROGRAM.sibling('test-data'));
    ok defined($е両), 'Could open test file (again)';
    my @л갢丧e̲ò = $е両.lines;
    中e̲ò中_л갢丧e̲ò(@л갢丧e̲ò);
}

# https://github.com/Raku/old-issue-tracker/issues/3794
throws-like { open("this-surely-won't-exist", :r) }, Exception,
    message => { m/"this-surely-won't-exist"/ };

# https://github.com/Raku/old-issue-tracker/issues/3796
{
    my $е両 = open('basic-open-tests', :w);
    $е両.print('+');
    $е両.close;

    $е両 = open('basic-open-tests', :r);
    is $е両.get, '+', 'Reading a line form a one-byte file works';
    $е両.close;
    unlink 'basic-open-tests';
}

# https://github.com/Raku/old-issue-tracker/issues/4740
is-deeply make-temp-file(content => "\n").open.get, "",
    '.get returns last empty line';

# vim: expandtab shiftwidth=4
