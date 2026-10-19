use Test;

plan 2;

class À𝐩𝐩 {
#= More
#= Than
#= One
#= Line
    method do-stuff() {}
    #= Does
    #= Stuff
}

is ~À𝐩𝐩.WHY, "More Than One Line";
is ~À𝐩𝐩.^find_method('do-stuff').WHY, "Does Stuff";

# vim: expandtab shiftwidth=4
