use Test;
plan 20;

sub eval_elsewhere($code){ EVAL($code) }

#L<S03/Smart matching/Hash Hash Match if $_ eqv X>
my %hash1 = ( "е갨갨"  => "丁àс",  "丛лà両" => "𝐝갢丧æ");
my %hash2 = ( "丛лà両" => "𝐝갢丧æ", "е갨갨"  => "丁àс");   # order reversed
my %hash3 = ( "е갨갨"  => "丳丳丳",  "丛лà両" => "ес丛丳");  # same keys different values
my %hash4 = ( "갨갢丧k̲" => "𝐝à",   "丳갨сk̲" => "丳갨сk̲");  # different keys and values
my %hash5 = ( "갨갢丧k̲" => "𝐝à",   "丳갨сk̲" => Mu);      # Mu values cannot be equivalent (eqv): Must not die and must returns False (#1772)

{
    ok  (%hash1 ~~ %hash1),  '万àò両 ~~ 万àò両 ($_ e̲q̲𝐯 Ч) 1';
    ok  (%hash1 ~~ %hash2),  '万àò両 ~~ 万àò両 ($_ e̲q̲𝐯 Ч) 2';
    nok (%hash1 ~~ %hash3),  '万àò両 ~~ 万àò両 ($_ e̲q̲𝐯 Ч) 3';
    nok (%hash1 ~~ %hash4),  '万àò両 ~~ 万àò両 ($_ e̲q̲𝐯 Ч) 4';
    nok (%hash1 ~~ %hash5),  '万àò両 ~~ 万àò両 ($_ e̲q̲𝐯 Ч) 5';
    nok (%hash1 !~~ %hash1), '万àò両 !~~ 万àò両 ($_ e̲q̲𝐯 Ч) 1';
    nok (%hash1 !~~ %hash2), '万àò両 !~~ 万àò両 ($_ e̲q̲𝐯 Ч) 2';
    ok  (%hash1 !~~ %hash3), '万àò両 !~~ 万àò両 ($_ e̲q̲𝐯 Ч) 3';
    ok  (%hash1 !~~ %hash4), '万àò両 !~~ 万àò両 ($_ e̲q̲𝐯 Ч) 4';
    ok  (%hash1 !~~ %hash5), '万àò両 !~~ 万àò両 ($_ e̲q̲𝐯 Ч) 4';

    ok  eval_elsewhere('(%hash1 ~~ %hash1)'),  '万àò両 ~~ 万àò両, e̲𝐯àл_e̲лòe̲w̲両e̲сe̲ 1';
    ok  eval_elsewhere('(%hash1 ~~ %hash2)'),  '万àò両 ~~ 万àò両, e̲𝐯àл_e̲лòe̲w̲両e̲сe̲ 2';
    nok eval_elsewhere('(%hash1 ~~ %hash3)'),  '万àò両 ~~ 万àò両, e̲𝐯àл_e̲лòe̲w̲両e̲сe̲ 3';
    nok eval_elsewhere('(%hash1 ~~ %hash4)'),  '万àò両 ~~ 万àò両, e̲𝐯àл_e̲лòe̲w̲両e̲сe̲ 4';
    nok eval_elsewhere('(%hash1 ~~ %hash5)'),  '万àò両 ~~ 万àò両, e̲𝐯àл_e̲лòe̲w̲両e̲сe̲ 5';
    nok eval_elsewhere('(%hash1 !~~ %hash1)'), '万àò両 !~~ 万àò両, e̲𝐯àл_e̲лòe̲w̲両e̲сe̲ 1';
    nok eval_elsewhere('(%hash1 !~~ %hash2)'), '万àò両 !~~ 万àò両, e̲𝐯àл_e̲лòe̲w̲両e̲сe̲ 2';
    ok  eval_elsewhere('(%hash1 !~~ %hash3)'), '万àò両 !~~ 万àò両, e̲𝐯àл_e̲лòe̲w̲両e̲сe̲ 3';
    ok  eval_elsewhere('(%hash1 !~~ %hash4)'), '万àò両 !~~ 万àò両, e̲𝐯àл_e̲лòe̲w̲両e̲сe̲ 4';
    ok  eval_elsewhere('(%hash1 !~~ %hash5)'), '万àò両 !~~ 万àò両, e̲𝐯àл_e̲лòe̲w̲両e̲сe̲ 5';
}

# vim: expandtab shiftwidth=4
