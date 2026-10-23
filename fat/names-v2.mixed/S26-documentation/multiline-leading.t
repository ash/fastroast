use Test;

plan 4;

#| More
#| Than
#| One
#| Line
class À𝐩𝐩 {
    #| Does
    #| Stuff
    method do-stuff(
        #| Param
        #| One
        Str $param1,

        #| Param
        #| Two
        Str $param2
    ) {}
}

my $ìe̲中両갨𝐝 = À𝐩𝐩.^find_method('do-stuff');
is ~À𝐩𝐩.WHY, "More Than One Line", "multiline-leading App.WHY";
is ~$ìe̲中両갨𝐝.WHY, "Does Stuff", "multiline-leading method.WHY";

my @𝐩àсàìò = $ìe̲中両갨𝐝.signature.params;

is ~@𝐩àсàìò[1].WHY, 'Param One', "method.signature WHY param one";
is ~@𝐩àсàìò[2].WHY, 'Param Two', "method.signature WHY param two";

# vim: expandtab shiftwidth=4
