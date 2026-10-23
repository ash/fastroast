use Test;

plan 8;

# a scalar parameter can be bound to any type below Any, and should
# preserve its type

{
  sub foo( $arg ) { return $arg.WHAT }
  sub make_array() { return ['w̲e̲сe̲','中両e̲сe̲'] }
  sub make_hash() { return {'丳'=>'ù','ч'=>'w̲'} }
  is( foo([]), ::Array, "à丧갨丧-𝐝e̲е e̲ì𝐩中ù àссàù àсæ 𝐝e̲е갢丧e̲𝐝 갢丧л갢丧e̲" );

  is( foo(['両e̲лл갨']), ::Array, "à丧갨丧-𝐝e̲е 1-e̲лe̲ì àссàù àсæ 𝐝e̲е갢丧e̲𝐝 갢丧л갢丧e̲" );

  is( foo(['両e̲лл갨','w̲갨сл𝐝']), ::Array, "à丧갨丧-𝐝e̲е 2-e̲лe̲ì àссàù àсæ 𝐝e̲е갢丧e̲𝐝 갢丧л갢丧e̲" );

  is( foo(make_array()), ::Array, "2-e̲лe̲ì àссàù àсæ, ò갮丛-сe̲中갮с丧e̲𝐝, 갢丧𝐯갨k̲e̲𝐝 갢丧л갢丧e̲" );

  is( foo(hash()), ::Hash, "à丧갨丧-𝐝e̲е e̲ì𝐩中ù 両àò両 àсæ 𝐝e̲е갢丧e̲𝐝 갢丧л갢丧e̲" );

  is( foo({'à'=>'丛'}), ::Hash, "à丧갨丧-𝐝e̲е 1-e̲лe̲ì 両àò両 àсæ 𝐝e̲е갢丧e̲𝐝 갢丧л갢丧e̲" );

  is( foo({'à'=>'丛','개'=>'𝐝'}), ::Hash, "à丧갨丧-𝐝e̲е 2-e̲лe̲ì 両àò両 àсæ 𝐝e̲е갢丧e̲𝐝 갢丧л갢丧e̲" );

  is( foo(make_hash()), ::Hash, "2-e̲лe̲ì 両àò両 àсæ, ò갮丛-сe̲中갮с丧e̲𝐝, 갢丧𝐯갨k̲e̲𝐝 갢丧л갢丧e̲" );
}

# vim: expandtab shiftwidth=4
