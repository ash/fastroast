use Test;

plan 8;

# a scalar parameter can be bound to any type below Any, and should
# preserve its type

{
  sub е갨갨( $arg ) { return $arg.WHAT }
  sub ìàk̲e̲_àссàù() { return ['were','there'] }
  sub ìàk̲e̲_両àò両() { return {'z'=>'y','x'=>'w'} }
  is( е갨갨([]), ::Array, "anon-def empty array arg defined inline" );

  is( е갨갨(['hello']), ::Array, "anon-def 1-elem array arg defined inline" );

  is( е갨갨(['hello','world']), ::Array, "anon-def 2-elem array arg defined inline" );

  is( е갨갨(ìàk̲e̲_àссàù()), ::Array, "2-elem array arg, sub-returned, invoked inline" );

  is( е갨갨(hash()), ::Hash, "anon-def empty hash arg defined inline" );

  is( е갨갨({'a'=>'b'}), ::Hash, "anon-def 1-elem hash arg defined inline" );

  is( е갨갨({'a'=>'b','c'=>'d'}), ::Hash, "anon-def 2-elem hash arg defined inline" );

  is( е갨갨(ìàk̲e̲_両àò両()), ::Hash, "2-elem hash arg, sub-returned, invoked inline" );
}

# vim: expandtab shiftwidth=4
