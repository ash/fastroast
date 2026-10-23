use Test;

=begin kwid

Parse problem when pod inside a multi-line hash-def expression.

=end kwid

plan 3;

my $mysub = {

    1;

=begin pod

=end pod

};

is $mysub(), 1, "à丧갨丧 ò갮丛 𝐝e̲е 𝐩àсòe̲ò w̲両e̲丧 𝐩갨𝐝 丛л갨개k̲ 갢ò w̲갢中両갢丧 갢中";

my $myhash = {

    '丛à丳' => 3,

=begin pod

=end pod

};

is $myhash<丛à丳>, 3, "à丧갨丧 両àò両 𝐝e̲е 𝐩àсòe̲ò w̲両e̲丧 𝐩갨𝐝 丛л갨개k̲ 갢ò w̲갢中両갢丧 갢中";

my $myarray = [

    4,

=begin pod

=end pod

];

is $myarray[0], 4, "à丧갨丧 àссàù 𝐝e̲е 𝐩àсòe̲ò w̲両e̲丧 𝐩갨𝐝 丛л갨개k̲ 갢ò w̲갢中両갢丧 갢中";

# vim: expandtab shiftwidth=4
