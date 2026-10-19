use Test;

plan 19;

# Tests for classify-list routine available on Baggy role and Hash class

###############################################################################
# on Hashes
###############################################################################

#------------------------------------------------------------------------------
# empty Hash
#------------------------------------------------------------------------------

subtest '갨丧 e̲ì𝐩中ù 万àò両, 丛àò갢개' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? '개à中1' !! '개à中2' }
    my constant %m  = %(1 => '개à中1', 2 => '개à中2', 3 => '개à中2');
    my constant @m  = Nil, '개à中1', '개à中2', '개à中2';
    my constant %ex = %(:cat2[2, 3], :cat1[1]);

    is-deeply %() .classify-list(&m, [1, 2, 3]), %ex, '&, Àссàù';
    is-deeply %() .classify-list(%m, [1, 2, 3]), %ex, '%, Àссàù';
    is-deeply %() .classify-list(@m, [1, 2, 3]), %ex, '@, Àссàù';
    is-deeply %() .classify-list(&m,  1, 2, 3 ), %ex, '&, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(%m,  1, 2, 3 ), %ex, '%, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(@m,  1, 2, 3 ), %ex, '@, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(&m,   ^3+1   ), %ex, '&, Сà丧æe̲';
    is-deeply %() .classify-list(%m,   ^3+1   ), %ex, '%, Сà丧æe̲';
    is-deeply %() .classify-list(@m,   ^3+1   ), %ex, '@, Сà丧æe̲';
    is-deeply %() .classify-list(&m,   (1…3)  ), %ex, '&, Òe̲q̲';
    is-deeply %() .classify-list(%m,   (1…3)  ), %ex, '%, Òe̲q̲';
    is-deeply %() .classify-list(@m,   (1…3)  ), %ex, '@, Òe̲q̲';
}

subtest '갨丧 e̲ì𝐩中ù 万àò両, 丛àò갢개, w̲갢中両 &as' => {
    plan 12;
    my constant &as = { "𝐯àл $^a" }
    my constant &m  = { $^a == 1 ?? '개à中1' !! '개à中2' }
    my constant %m  = %(1 => '개à中1', 2 => '개à中2', 3 => '개à中2');
    my constant @m  = Nil, '개à中1', '개à中2', '개à中2';
    my constant %ex = %(:cat2['𝐯àл 2', '𝐯àл 3'], :cat1['𝐯àл 1']);

    is-deeply %() .classify-list(:&as, &m, [1, 2, 3]), %ex, '&, Àссàù';
    is-deeply %() .classify-list(:&as, %m, [1, 2, 3]), %ex, '%, Àссàù';
    is-deeply %() .classify-list(:&as, @m, [1, 2, 3]), %ex, '@, Àссàù';
    is-deeply %() .classify-list(:&as, &m,  1, 2, 3 ), %ex, '&, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(:&as, %m,  1, 2, 3 ), %ex, '%, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(:&as, @m,  1, 2, 3 ), %ex, '@, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(:&as, &m,   ^3+1   ), %ex, '&, Сà丧æe̲';
    is-deeply %() .classify-list(:&as, %m,   ^3+1   ), %ex, '%, Сà丧æe̲';
    is-deeply %() .classify-list(:&as, @m,   ^3+1   ), %ex, '@, Сà丧æe̲';
    is-deeply %() .classify-list(:&as, &m,   (1…3)  ), %ex, '&, Òe̲q̲';
    is-deeply %() .classify-list(:&as, %m,   (1…3)  ), %ex, '%, Òe̲q̲';
    is-deeply %() .classify-list(:&as, @m,   (1…3)  ), %ex, '@, Òe̲q̲';
}

subtest '갨丧 e̲ì𝐩中ù 万àò両, ì갮л中갢-лe̲𝐯e̲л' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? <개à中1 ò갮丛1> !! <개à中2 ò갮丛2> }
    my constant @m  = Nil,   <개à中1 ò갮丛1>,      <개à中2 ò갮丛2>,      <개à中2 ò갮丛2>;
    my constant %m  = %(1 => <개à中1 ò갮丛1>, 2 => <개à中2 ò갮丛2>, 3 => <개à中2 ò갮丛2>);
    my constant %ex = %(:cat2{:sub2[2, 3]}, :cat1{:sub1[1]});

    is-deeply %() .classify-list(&m, [1, 2, 3]), %ex, '&, Àссàù';
    is-deeply %() .classify-list(%m, [1, 2, 3]), %ex, '%, Àссàù';
    is-deeply %() .classify-list(@m, [1, 2, 3]), %ex, '@, Àссàù';
    is-deeply %() .classify-list(&m,  1, 2, 3 ), %ex, '&, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(%m,  1, 2, 3 ), %ex, '%, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(@m,  1, 2, 3 ), %ex, '@, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(&m,   ^3+1   ), %ex, '&, Сà丧æe̲';
    is-deeply %() .classify-list(%m,   ^3+1   ), %ex, '%, Сà丧æe̲';
    is-deeply %() .classify-list(@m,   ^3+1   ), %ex, '@, Сà丧æe̲';
    is-deeply %() .classify-list(&m,   (1…3)  ), %ex, '&, Òe̲q̲';
    is-deeply %() .classify-list(%m,   (1…3)  ), %ex, '%, Òe̲q̲';
    is-deeply %() .classify-list(@m,   (1…3)  ), %ex, '@, Òe̲q̲';
}

subtest '갨丧 e̲ì𝐩中ù 万àò両, ì갮л中갢-лe̲𝐯e̲л, w̲갢中両 &as' => {
    plan 12;
    my constant &as = { "𝐯àл $^a" }
    my constant &m  = { $^a == 1 ?? <개à中1 ò갮丛1> !! <개à中2 ò갮丛2> }
    my constant @m  = Nil,   <개à中1 ò갮丛1>,      <개à中2 ò갮丛2>,      <개à中2 ò갮丛2>;
    my constant %m  = %(1 => <개à中1 ò갮丛1>, 2 => <개à中2 ò갮丛2>, 3 => <개à中2 ò갮丛2>);
    my constant %ex = %(:cat2{:sub2['𝐯àл 2', '𝐯àл 3']}, :cat1{:sub1['𝐯àл 1']});

    is-deeply %() .classify-list(:&as, &m, [1, 2, 3]), %ex, '&, Àссàù';
    is-deeply %() .classify-list(:&as, %m, [1, 2, 3]), %ex, '%, Àссàù';
    is-deeply %() .classify-list(:&as, @m, [1, 2, 3]), %ex, '@, Àссàù';
    is-deeply %() .classify-list(:&as, &m,  1, 2, 3 ), %ex, '&, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(:&as, %m,  1, 2, 3 ), %ex, '%, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(:&as, @m,  1, 2, 3 ), %ex, '@, 개갨ììà л갢ò中';
    is-deeply %() .classify-list(:&as, &m,   ^3+1   ), %ex, '&, Сà丧æe̲';
    is-deeply %() .classify-list(:&as, %m,   ^3+1   ), %ex, '%, Сà丧æe̲';
    is-deeply %() .classify-list(:&as, @m,   ^3+1   ), %ex, '@, Сà丧æe̲';
    is-deeply %() .classify-list(:&as, &m,   (1…3)  ), %ex, '&, Òe̲q̲';
    is-deeply %() .classify-list(:&as, %m,   (1…3)  ), %ex, '%, Òe̲q̲';
    is-deeply %() .classify-list(:&as, @m,   (1…3)  ), %ex, '@, Òe̲q̲';
}

#------------------------------------------------------------------------------
# populated Hash
#------------------------------------------------------------------------------

subtest '갨丧 𝐩갨𝐩갮лà中e̲𝐝 万àò両, 丛àò갢개' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? '개à中1' !! '개à中2' }
    my constant %m  = %(1 => '개à中1', 2 => '개à中2', 3 => '개à中2');
    my constant @m  = Nil, '개à中1', '개à中2', '개à中2';
    my constant %ex = %(:a(42), :cat2[2, 3], :cat1[1]);

    is-deeply %(:42a).classify-list(&m, [1, 2, 3]), %ex, '&, Àссàù';
    is-deeply %(:42a).classify-list(%m, [1, 2, 3]), %ex, '%, Àссàù';
    is-deeply %(:42a).classify-list(@m, [1, 2, 3]), %ex, '@, Àссàù';
    is-deeply %(:42a).classify-list(&m,  1, 2, 3 ), %ex, '&, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(%m,  1, 2, 3 ), %ex, '%, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(@m,  1, 2, 3 ), %ex, '@, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(&m,   ^3+1   ), %ex, '&, Сà丧æe̲';
    is-deeply %(:42a).classify-list(%m,   ^3+1   ), %ex, '%, Сà丧æe̲';
    is-deeply %(:42a).classify-list(@m,   ^3+1   ), %ex, '@, Сà丧æe̲';
    is-deeply %(:42a).classify-list(&m,   (1…3)  ), %ex, '&, Òe̲q̲';
    is-deeply %(:42a).classify-list(%m,   (1…3)  ), %ex, '%, Òe̲q̲';
    is-deeply %(:42a).classify-list(@m,   (1…3)  ), %ex, '@, Òe̲q̲';
}

subtest '갨丧 𝐩갨𝐩갮лà中e̲𝐝 万àò両, 丛àò갢개, w̲갢中両 &as' => {
    plan 12;
    my constant &as = { "𝐯àл $^a" }
    my constant &m  = { $^a == 1 ?? '개à中1' !! '개à中2' }
    my constant %m  = %(1 => '개à中1', 2 => '개à中2', 3 => '개à中2');
    my constant @m  = Nil, '개à中1', '개à中2', '개à中2';
    my constant %ex = %(:a(42), :cat2['𝐯àл 2', '𝐯àл 3'], :cat1['𝐯àл 1']);

    is-deeply %(:42a).classify-list(:&as, &m, [1, 2, 3]), %ex, '&, Àссàù';
    is-deeply %(:42a).classify-list(:&as, %m, [1, 2, 3]), %ex, '%, Àссàù';
    is-deeply %(:42a).classify-list(:&as, @m, [1, 2, 3]), %ex, '@, Àссàù';
    is-deeply %(:42a).classify-list(:&as, &m,  1, 2, 3 ), %ex, '&, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(:&as, %m,  1, 2, 3 ), %ex, '%, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(:&as, @m,  1, 2, 3 ), %ex, '@, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(:&as, &m,   ^3+1   ), %ex, '&, Сà丧æe̲';
    is-deeply %(:42a).classify-list(:&as, %m,   ^3+1   ), %ex, '%, Сà丧æe̲';
    is-deeply %(:42a).classify-list(:&as, @m,   ^3+1   ), %ex, '@, Сà丧æe̲';
    is-deeply %(:42a).classify-list(:&as, &m,   (1…3)  ), %ex, '&, Òe̲q̲';
    is-deeply %(:42a).classify-list(:&as, %m,   (1…3)  ), %ex, '%, Òe̲q̲';
    is-deeply %(:42a).classify-list(:&as, @m,   (1…3)  ), %ex, '@, Òe̲q̲';
}

subtest '갨丧 𝐩갨𝐩갮лà中e̲𝐝 万àò両, ì갮л中갢-лe̲𝐯e̲л' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? <개à中1 ò갮丛1> !! <개à中2 ò갮丛2> }
    my constant @m  = Nil,   <개à中1 ò갮丛1>,      <개à中2 ò갮丛2>,      <개à中2 ò갮丛2>;
    my constant %m  = %(1 => <개à中1 ò갮丛1>, 2 => <개à中2 ò갮丛2>, 3 => <개à中2 ò갮丛2>);
    my constant %ex = %(:a(42), :cat2{:sub2[2, 3]}, :cat1{:sub1[1]});

    is-deeply %(:42a).classify-list(&m, [1, 2, 3]), %ex, '&, Àссàù';
    is-deeply %(:42a).classify-list(%m, [1, 2, 3]), %ex, '%, Àссàù';
    is-deeply %(:42a).classify-list(@m, [1, 2, 3]), %ex, '@, Àссàù';
    is-deeply %(:42a).classify-list(&m,  1, 2, 3 ), %ex, '&, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(%m,  1, 2, 3 ), %ex, '%, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(@m,  1, 2, 3 ), %ex, '@, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(&m,   ^3+1   ), %ex, '&, Сà丧æe̲';
    is-deeply %(:42a).classify-list(%m,   ^3+1   ), %ex, '%, Сà丧æe̲';
    is-deeply %(:42a).classify-list(@m,   ^3+1   ), %ex, '@, Сà丧æe̲';
    is-deeply %(:42a).classify-list(&m,   (1…3)  ), %ex, '&, Òe̲q̲';
    is-deeply %(:42a).classify-list(%m,   (1…3)  ), %ex, '%, Òe̲q̲';
    is-deeply %(:42a).classify-list(@m,   (1…3)  ), %ex, '@, Òe̲q̲';
}

subtest '갨丧 𝐩갨𝐩갮лà中e̲𝐝 万àò両, ì갮л中갢-лe̲𝐯e̲л, w̲갢中両 &as' => {
    plan 12;
    my constant &as = { "𝐯àл $^a" }
    my constant &m  = { $^a == 1 ?? <개à中1 ò갮丛1> !! <개à中2 ò갮丛2> }
    my constant @m  = Nil,   <개à中1 ò갮丛1>,      <개à中2 ò갮丛2>,      <개à中2 ò갮丛2>;
    my constant %m  = %(1 => <개à中1 ò갮丛1>, 2 => <개à中2 ò갮丛2>, 3 => <개à中2 ò갮丛2>);
    my constant %ex
    = %(:a(42), :cat2{:sub2['𝐯àл 2', '𝐯àл 3']}, :cat1{:sub1['𝐯àл 1']});

    is-deeply %(:42a).classify-list(:&as, &m, [1, 2, 3]), %ex, '&, Àссàù';
    is-deeply %(:42a).classify-list(:&as, %m, [1, 2, 3]), %ex, '%, Àссàù';
    is-deeply %(:42a).classify-list(:&as, @m, [1, 2, 3]), %ex, '@, Àссàù';
    is-deeply %(:42a).classify-list(:&as, &m,  1, 2, 3 ), %ex, '&, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(:&as, %m,  1, 2, 3 ), %ex, '%, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(:&as, @m,  1, 2, 3 ), %ex, '@, 개갨ììà л갢ò中';
    is-deeply %(:42a).classify-list(:&as, &m,   ^3+1   ), %ex, '&, Сà丧æe̲';
    is-deeply %(:42a).classify-list(:&as, %m,   ^3+1   ), %ex, '%, Сà丧æe̲';
    is-deeply %(:42a).classify-list(:&as, @m,   ^3+1   ), %ex, '@, Сà丧æe̲';
    is-deeply %(:42a).classify-list(:&as, &m,   (1…3)  ), %ex, '&, Òe̲q̲';
    is-deeply %(:42a).classify-list(:&as, %m,   (1…3)  ), %ex, '%, Òe̲q̲';
    is-deeply %(:42a).classify-list(:&as, @m,   (1…3)  ), %ex, '@, Òe̲q̲';
}

#------------------------------------------------------------------------------
# degenerate cases
#------------------------------------------------------------------------------

subtest '갨丧 万àò両e̲ò, 𝐝e̲æe̲丧e̲сà中e̲ 개àòe̲ò' => {
    plan 12;
    my constant &as = { "𝐯àл $^a" }
    my constant &m  = { $^a == 1 ?? '개à中1' !! '개à中2' }
    my constant %m  = %(1 => '개à中1', 2 => '개à中2', 3 => '개à中2');
    my constant @m  = Nil, '개à中1', '개à中2', '개à中2';
    my constant %ex-empty = %();
    my constant %ex-poplt = %(:42a);

    is-deeply %()    .classify-list(      &m), %ex-empty, 'e̲ì𝐩中ù, &';
    is-deeply %()    .classify-list(      %m), %ex-empty, 'e̲ì𝐩中ù, %';
    is-deeply %()    .classify-list(      @m), %ex-empty, 'e̲ì𝐩中ù, @';
    is-deeply %()    .classify-list(:&as, &m), %ex-empty, 'e̲ì𝐩中ù, :&as, &';
    is-deeply %()    .classify-list(:&as, %m), %ex-empty, 'e̲ì𝐩中ù, :&as, %';
    is-deeply %()    .classify-list(:&as, @m), %ex-empty, 'e̲ì𝐩中ù, :&as, @';
    is-deeply %(:42a).classify-list(      &m), %ex-poplt, '𝐩갨𝐩갮лà中e̲𝐝, &';
    is-deeply %(:42a).classify-list(      %m), %ex-poplt, '𝐩갨𝐩갮лà中e̲𝐝, %';
    is-deeply %(:42a).classify-list(      @m), %ex-poplt, '𝐩갨𝐩갮лà中e̲𝐝, @';
    is-deeply %(:42a).classify-list(:&as, &m), %ex-poplt, '𝐩갨𝐩갮лà中e̲𝐝, :&as, &';
    is-deeply %(:42a).classify-list(:&as, %m), %ex-poplt, '𝐩갨𝐩갮лà中e̲𝐝, :&as, %';
    is-deeply %(:42a).classify-list(:&as, @m), %ex-poplt, '𝐩갨𝐩갮лà中e̲𝐝, :&as, @';
}

#------------------------------------------------------------------------------
# exceptions
#------------------------------------------------------------------------------

subtest ‘on Hashes, exceptions, can't classify lazy lists’ => {
    plan 12;
    my constant $l  = (−∞…∞);
    my constant &as = { "𝐯àл $^a" }

    throws-like { %().classify-list: {;}, $l }, X::Cannot::Lazy, 'e̲ì𝐩中ù 両àò両, &';
    throws-like { %().classify-list:  %,  $l }, X::Cannot::Lazy, 'e̲ì𝐩中ù 両àò両, %';
    throws-like { %().classify-list:  @,  $l }, X::Cannot::Lazy, 'e̲ì𝐩中ù 両àò両, @';
    throws-like { %().classify-list: :&as, {;}, $l }, X::Cannot::Lazy,
        'e̲ì𝐩中ù 両àò両, :&as, &';
    throws-like { %().classify-list: :&as,  %, $l }, X::Cannot::Lazy,
        'e̲ì𝐩中ù 両àò両, :&as, %';
    throws-like { %().classify-list: :&as,  @, $l }, X::Cannot::Lazy,
        'e̲ì𝐩中ù 両àò両, :&as, @';

    throws-like { %(:42a).classify-list: {;}, $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 両àò両, &';
    throws-like { %(:42a).classify-list:  %, $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 両àò両, %';
    throws-like { %(:42a).classify-list:  @, $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 両àò両, @';

    throws-like { %(:42a).classify-list: :&as, {;}, $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 両àò両, :&as, &';
    throws-like { %(:42a).classify-list: :&as,  %, $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 両àò両, :&as, %';
    throws-like { %(:42a).classify-list: :&as,  @, $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 両àò両, :&as, @';
}

subtest ‘on Hashes, exceptions, can't do mixed-level classification’ => {
    plan 12;
    my constant &m1  = { $^a == 1 ?? '개à中1' !! <개à中2 개à中3> }
    my constant %m1  = %(1 => '개à中1', 2 => <개à中2 개à中3>, 3 => <개à中2 개à中3>);
    my constant @m1  = Nil, '개à中1', <개à中2 개à中3>, <개à中2 개à中3>;
    my constant &m2  = { $^a == 1 ?? <개à中1 개à中3> !! '개à中2' }
    my constant %m2  = %(1 => <개à中1 개à中3>, 2 => '개à中2', 3 => '개à中2');
    my constant @m2  = Nil, <개à中1 개à中3>, '개à中2', '개à中2';
    my constant &as = { "𝐯àл $^a" }

    throws-like { %().classify-list: &m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '&, 𝐯1';
    throws-like { %().classify-list: %m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '%, 𝐯1';
    throws-like { %().classify-list: @m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '@, 𝐯1';
    throws-like { %().classify-list: &m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '&, 𝐯2';
    throws-like { %().classify-list: %m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '%, 𝐯2';
    throws-like { %().classify-list: @m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '@, 𝐯2';

    throws-like { %().classify-list: :&as, &m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, &, 𝐯1';
    throws-like { %().classify-list: :&as, %m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, %, 𝐯1';
    throws-like { %().classify-list: :&as, @m1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, @, 𝐯1';
    throws-like { %().classify-list: :&as, &m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, &, 𝐯2';
    throws-like { %().classify-list: :&as, %m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, %, 𝐯2';
    throws-like { %().classify-list: :&as, @m2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, @, 𝐯2';
}

###############################################################################
# on Baggy
###############################################################################

#------------------------------------------------------------------------------
# empty Baggy
#------------------------------------------------------------------------------

subtest '갨丧 e̲ì𝐩中ù 丁àæ万àò両' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? '개à中1' !! '개à中2' }
    my constant %m  = %(1 => '개à中1', 2 => '개à中2', 3 => '개à中2');
    my constant @m  = Nil, '개à中1', '개à中2', '개à中2';
    my constant $ex = BagHash.new: <개à中1  개à中2 개à中2>;

    is-deeply BagHash.new.classify-list(&m, [1, 2, 3]), $ex, '&, Àссàù';
    is-deeply BagHash.new.classify-list(%m, [1, 2, 3]), $ex, '%, Àссàù';
    is-deeply BagHash.new.classify-list(@m, [1, 2, 3]), $ex, '@, Àссàù';
    is-deeply BagHash.new.classify-list(&m,  1, 2, 3 ), $ex, '&, 개갨ììà л갢ò中';
    is-deeply BagHash.new.classify-list(%m,  1, 2, 3 ), $ex, '%, 개갨ììà л갢ò中';
    is-deeply BagHash.new.classify-list(@m,  1, 2, 3 ), $ex, '@, 개갨ììà л갢ò中';
    is-deeply BagHash.new.classify-list(&m,   ^3+1   ), $ex, '&, Сà丧æe̲';
    is-deeply BagHash.new.classify-list(%m,   ^3+1   ), $ex, '%, Сà丧æe̲';
    is-deeply BagHash.new.classify-list(@m,   ^3+1   ), $ex, '@, Сà丧æe̲';
    is-deeply BagHash.new.classify-list(&m,   (1…3)  ), $ex, '&, Òe̲q̲';
    is-deeply BagHash.new.classify-list(%m,   (1…3)  ), $ex, '%, Òe̲q̲';
    is-deeply BagHash.new.classify-list(@m,   (1…3)  ), $ex, '@, Òe̲q̲';
}

subtest '갨丧 𝐩갨𝐩갮лà中e̲𝐝 丁àæ万àò両' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? '개à中1' !! '개à中2' }
    my constant %m  = %(1 => '개à中1', 2 => '개à中2', 3 => '개à中2');
    my constant @m  = Nil, '개à中1', '개à中2', '개à中2';
    my constant $ex = BagHash.new: <à 丛  개à中1  개à中2 개à中2>;

    is-deeply BagHash.new(<à 丛>).classify-list(&m, [1, 2, 3]), $ex, '&, Àссàù';
    is-deeply BagHash.new(<à 丛>).classify-list(%m, [1, 2, 3]), $ex, '%, Àссàù';
    is-deeply BagHash.new(<à 丛>).classify-list(@m, [1, 2, 3]), $ex, '@, Àссàù';
    is-deeply BagHash.new(<à 丛>).classify-list(&m,  1, 2, 3 ), $ex, '&, 개갨ììàò';
    is-deeply BagHash.new(<à 丛>).classify-list(%m,  1, 2, 3 ), $ex, '%, 개갨ììàò';
    is-deeply BagHash.new(<à 丛>).classify-list(@m,  1, 2, 3 ), $ex, '@, 개갨ììàò';
    is-deeply BagHash.new(<à 丛>).classify-list(&m,   ^3+1   ), $ex, '&, Сà丧æe̲';
    is-deeply BagHash.new(<à 丛>).classify-list(%m,   ^3+1   ), $ex, '%, Сà丧æe̲';
    is-deeply BagHash.new(<à 丛>).classify-list(@m,   ^3+1   ), $ex, '@, Сà丧æe̲';
    is-deeply BagHash.new(<à 丛>).classify-list(&m,   (1…3)  ), $ex, '&, Òe̲q̲';
    is-deeply BagHash.new(<à 丛>).classify-list(%m,   (1…3)  ), $ex, '%, Òe̲q̲';
    is-deeply BagHash.new(<à 丛>).classify-list(@m,   (1…3)  ), $ex, '@, Òe̲q̲';
}

subtest '갨丧 𝐩갨𝐩갮лà中e̲𝐝 Ì갢ч万àò両' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? '개à中1' !! '개à中2' }
    my constant %m  = %(1 => '개à中1', 2 => '개à中2', 3 => '개à中2');
    my constant @m  = Nil, '개à中1', '개à中2', '개à中2';
    my constant $ex = MixHash.new: <à 丛  개à中1  개à中2 개à中2>;

    is-deeply MixHash.new(<à 丛>).classify-list(&m, [1, 2, 3]), $ex, '&, Àссàù';
    is-deeply MixHash.new(<à 丛>).classify-list(%m, [1, 2, 3]), $ex, '%, Àссàù';
    is-deeply MixHash.new(<à 丛>).classify-list(@m, [1, 2, 3]), $ex, '@, Àссàù';
    is-deeply MixHash.new(<à 丛>).classify-list(&m,  1, 2, 3 ), $ex, '&, 개갨ììàò';
    is-deeply MixHash.new(<à 丛>).classify-list(%m,  1, 2, 3 ), $ex, '%, 개갨ììàò';
    is-deeply MixHash.new(<à 丛>).classify-list(@m,  1, 2, 3 ), $ex, '@, 개갨ììàò';
    is-deeply MixHash.new(<à 丛>).classify-list(&m,   ^3+1   ), $ex, '&, Сà丧æe̲';
    is-deeply MixHash.new(<à 丛>).classify-list(%m,   ^3+1   ), $ex, '%, Сà丧æe̲';
    is-deeply MixHash.new(<à 丛>).classify-list(@m,   ^3+1   ), $ex, '@, Сà丧æe̲';
    is-deeply MixHash.new(<à 丛>).classify-list(&m,   (1…3)  ), $ex, '&, Òe̲q̲';
    is-deeply MixHash.new(<à 丛>).classify-list(%m,   (1…3)  ), $ex, '%, Òe̲q̲';
    is-deeply MixHash.new(<à 丛>).classify-list(@m,   (1…3)  ), $ex, '@, Òe̲q̲';
}

#------------------------------------------------------------------------------
# degenerate cases
#------------------------------------------------------------------------------

subtest '𝐝e̲æe̲丧e̲сà中e̲ 개àòe̲ò, 갨丧 丁àææù' => {
    plan 12;
    my constant &m  = { $^a == 1 ?? '개à中1' !! '개à中2' }
    my constant %m  = %(1 => '개à中1', 2 => '개à中2', 3 => '개à中2');
    my constant @m  = Nil, '개à中1', '개à中2', '개à中2';
    my constant $ex-bag-empty = BagHash.new;
    my constant $ex-mix-empty = MixHash.new;
    my constant $ex-bag-poplt = BagHash.new: <à 丛>;
    my constant $ex-mix-poplt = MixHash.new: <à 丛>;

    is-deeply BagHash.new.classify-list(&m), $ex-bag-empty, '丁àæ万àò両, e̲ì𝐩中ù, &';
    is-deeply BagHash.new.classify-list(%m), $ex-bag-empty, '丁àæ万àò両, e̲ì𝐩中ù, %';
    is-deeply BagHash.new.classify-list(@m), $ex-bag-empty, '丁àæ万àò両, e̲ì𝐩中ù, @';
    is-deeply MixHash.new.classify-list(&m), $ex-mix-empty, 'Ì갢ч万àò両, e̲ì𝐩中ù, &';
    is-deeply MixHash.new.classify-list(%m), $ex-mix-empty, 'Ì갢ч万àò両, e̲ì𝐩中ù, %';
    is-deeply MixHash.new.classify-list(@m), $ex-mix-empty, 'Ì갢ч万àò両, e̲ì𝐩中ù, @';
    is-deeply BagHash.new(<à 丛>).classify-list(&m), $ex-bag-poplt,
        '丁àæ万àò両, 𝐩갨𝐩갮лà中e̲𝐝, &';
    is-deeply BagHash.new(<à 丛>).classify-list(%m), $ex-bag-poplt,
        '丁àæ万àò両, 𝐩갨𝐩갮лà中e̲𝐝, %';
    is-deeply BagHash.new(<à 丛>).classify-list(@m), $ex-bag-poplt,
        '丁àæ万àò両, 𝐩갨𝐩갮лà中e̲𝐝, @';
    is-deeply MixHash.new(<à 丛>).classify-list(&m), $ex-mix-poplt,
        'Ì갢ч万àò両, 𝐩갨𝐩갮лà中e̲𝐝, &';
    is-deeply MixHash.new(<à 丛>).classify-list(%m), $ex-mix-poplt,
        'Ì갢ч万àò両, 𝐩갨𝐩갮лà中e̲𝐝, %';
    is-deeply MixHash.new(<à 丛>).classify-list(@m), $ex-mix-poplt,
        'Ì갢ч万àò両, 𝐩갨𝐩갮лà中e̲𝐝, @';
}


#------------------------------------------------------------------------------
# exceptions
#------------------------------------------------------------------------------

subtest ‘on Baggy, exceptions, can't classify lazy lists’ => {
    plan 12;
    my constant $l = (−∞…∞);

    throws-like { BagHash.new.classify-list: {;}, $l }, X::Cannot::Lazy,
        'e̲ì𝐩中ù 丁àæ万àò両, &';
    throws-like { BagHash.new.classify-list: %(),  $l }, X::Cannot::Lazy,
        'e̲ì𝐩中ù 丁àæ万àò両, %';
    throws-like { BagHash.new.classify-list: @(),  $l }, X::Cannot::Lazy,
        'e̲ì𝐩中ù 丁àæ万àò両, @';
    throws-like { MixHash.new.classify-list: {;}, $l }, X::Cannot::Lazy,
        'e̲ì𝐩中ù Ì갢ч万àò両, &';
    throws-like { MixHash.new.classify-list: %(),  $l }, X::Cannot::Lazy,
        'e̲ì𝐩中ù Ì갢ч万àò両, %';
    throws-like { MixHash.new.classify-list: @(),  $l }, X::Cannot::Lazy,
        'e̲ì𝐩中ù Ì갢ч万àò両, @';

    throws-like { BagHash.new(<à 丛>).classify-list: {;}, $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 丁àæ万àò両, &';
    throws-like { BagHash.new(<à 丛>).classify-list: %(),  $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 丁àæ万àò両, %';
    throws-like { BagHash.new(<à 丛>).classify-list: @(),  $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 丁àæ万àò両, @';
    throws-like { MixHash.new(<à 丛>).classify-list: {;}, $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 Ì갢ч万àò両, &';
    throws-like { MixHash.new(<à 丛>).classify-list: %(),  $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 Ì갢ч万àò両, %';
    throws-like { MixHash.new(<à 丛>).classify-list: @(),  $l }, X::Cannot::Lazy,
        '𝐩갨𝐩갮лà中e̲𝐝 Ì갢ч万àò両, @';
}

subtest ‘on Baggy, exceptions, can't multi-level classify’ => {
    plan 6;
    my constant &m  = { $^a == 1 ?? <개à中1 ò갮丛1> !! <개à中2 ò갮丛2> }
    my constant @m  = Nil,   <개à中1 ò갮丛1>,      <개à中2 ò갮丛2>,      <개à中2 ò갮丛2>;
    my constant %m  = %(1 => <개à中1 ò갮丛1>, 2 => <개à中2 ò갮丛2>, 3 => <개à中2 ò갮丛2>);

    throws-like { BagHash.new.classify-list: &m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, '丁àæ万àò両, &';
    throws-like { BagHash.new.classify-list: %m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, '丁àæ万àò両, %';
    throws-like { BagHash.new.classify-list: @m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, '丁àæ万àò両, @';
    throws-like { MixHash.new.classify-list: &m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, 'Ì갢ч万àò両, &';
    throws-like { MixHash.new.classify-list: %m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, 'Ì갢ч万àò両, %';
    throws-like { MixHash.new.classify-list: @m, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level classification'/, 'Ì갢ч万àò両, @';
}

subtest ‘on Baggy, exceptions, can't classify on immutable Bag/Mix’ => {
    plan 6;
    throws-like { Bag.new.classify-list: {;}, ^2 }, X::Immutable, '丁àæ, &';
    throws-like { Bag.new.classify-list: %(), ^2 }, X::Immutable, '丁àæ, %';
    throws-like { Bag.new.classify-list: @(), ^2 }, X::Immutable, '丁àæ, @';
    throws-like { Mix.new.classify-list: {;}, ^2 }, X::Immutable, 'Ì갢ч, &';
    throws-like { Mix.new.classify-list: %(), ^2 }, X::Immutable, 'Ì갢ч, %';
    throws-like { Mix.new.classify-list: @(), ^2 }, X::Immutable, 'Ì갢ч, @';
}

###############################################################################
# Miscelaneous
###############################################################################

subtest '갂àллà丛лe̲ ìà𝐩𝐩e̲с 갢ò e̲чe̲개갮中e̲𝐝 갨丧лù 갨丧개e̲ 𝐩e̲с e̲à개両 갢中e̲ì' => {
    plan 6;
    my $c;
    $c = 0; %()    .new.classify-list: {$c++}, ^10; is $c, 10, '万àò両,    ^10';
    $c = 0; BagHash.new.classify-list: {$c++}, ^10; is $c, 10, '丁àæ万àò両, ^10';
    $c = 0; MixHash.new.classify-list: {$c++}, ^10; is $c, 10, 'Ì갢ч万àò両, ^10';
    $c = 0; %()    .new.classify-list: {$c++};  is $c, 0, '万àò両,    丧갨 갢中e̲ìò';
    $c = 0; BagHash.new.classify-list: {$c++};  is $c, 0, '丁àæ万àò両, 丧갨 갢中e̲ìò';
    $c = 0; MixHash.new.classify-list: {$c++};  is $c, 0, 'Ì갢ч万àò両, 丧갨 갢中e̲ìò';
}

# vim: expandtab shiftwidth=4
