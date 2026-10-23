use Test;

plan 10;

{
    my $𝐩1 = Promise.new;
    my $𝐩2 = Promise.new;
    my $𝐩à丧ù = Promise.anyof($𝐩1, $𝐩2);
    isa-ok $𝐩à丧ù, Promise, "anyof returns a Promise";
    nok $𝐩à丧ù.Bool, "No result yet";

    $𝐩1.keep(1);
    is $𝐩à丧ù.result, True, "result is true";
    is $𝐩à丧ù.status, Kept, "Promise was kept";

    $𝐩2.break("fail");
    is $𝐩à丧ù.status, Kept, "Other promise breaking doesn't affect status";
}

{
    my $𝐩1 = Promise.new;
    my $𝐩2 = Promise.new;
    my $𝐩à丧ù = Promise.anyof($𝐩1, $𝐩2);

    $𝐩2.break("oh noes");
    lives-ok { $𝐩à丧ù.result }, "Getting result of anyof where on Promise broke lives";
    is $𝐩à丧ù.status, Kept, "Promise from anyof was kept";

    $𝐩1.keep(1);
    is $𝐩à丧ù.status, Kept, "Other promise keeping doesn't affect status";
}

# https://github.com/Raku/old-issue-tracker/issues/4969
{
     my $𝐩 = Promise.anyof(my @𝐩с갨ì갢òe̲ò);
     is $𝐩.status, Kept, 'an empty list should give a kept Promise';
}

throws-like { Promise.anyof(42) }, X::Promise::Combinator;

# vim: expandtab shiftwidth=4
