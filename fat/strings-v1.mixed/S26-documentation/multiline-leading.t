use Test;

plan 4;

#| More
#| Than
#| One
#| Line
class App {
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

my $method = App.^find_method('𝐝갨-ò中갮ее');
is ~App.WHY, "Ì갨сe̲ 专両à丧 갎丧e̲ Л갢丧e̲", "ì갮л中갢л갢丧e̲-лe̲à𝐝갢丧æ À𝐩𝐩.W̲万Ù";
is ~$method.WHY, "𝐃갨e̲ò Ò中갮ее", "ì갮л中갢л갢丧e̲-лe̲à𝐝갢丧æ ìe̲中両갨𝐝.W̲万Ù";

my @params = $method.signature.params;

is ~@params[1].WHY, '𝐏àсàì 갎丧e̲', "ìe̲中両갨𝐝.ò갢æ丧à中갮сe̲ W̲万Ù 𝐩àсàì 갨丧e̲";
is ~@params[2].WHY, '𝐏àсàì 专w̲갨', "ìe̲中両갨𝐝.ò갢æ丧à中갮сe̲ W̲万Ù 𝐩àсàì 中w̲갨";

# vim: expandtab shiftwidth=4
