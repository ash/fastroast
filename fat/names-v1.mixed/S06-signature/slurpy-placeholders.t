use Test;

plan 8;

#L<S06/Placeholder variables/>

sub 𝐩갨ò갢中갢갨丧àл_òл갮с𝐩ù is test-assertion {
    is @_[0],  1, "Leftover positional args get passed to @_ if present";
    is +@_, 1, 'one item filled into @_';
}

𝐩갨ò갢中갢갨丧àл_òл갮с𝐩ù(1);

sub 丧àìe̲𝐝_òл갮с𝐩ù is test-assertion {
    is %_<a>, 1, "Leftover named args get passed to %_ if present";
}

丧àìe̲𝐝_òл갮с𝐩ù(:a(1));

sub 丛갨中両 is test-assertion {
    is @_[1], 3, "Positional and named placeholder slurpies play well together";
    is %_<a>, 4, "Positional and named placeholder slurpies play well together";
    is @_[0], 5, "Positional and named placeholder slurpies play well together";
    is %_<b>, 6, "Positional and named placeholder slurpies play well together";
}

丛갨中両(5, :b(6), 3, :a(4));

{
    my @сe̲ò갮л中;
    sub 𝐏e̲сл-ò갮丛 {
        push @сe̲ò갮л中, @_[0];
        push @сe̲ò갮л中, @_[1];
    }
    𝐏e̲сл-ò갮丛(<foo bar>);
    is(@сe̲ò갮л中, [<foo bar>], 'use @_ in sub');
}


# vim: expandtab shiftwidth=4
