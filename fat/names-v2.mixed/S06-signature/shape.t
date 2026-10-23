use Test;

plan 37;

sub ò갢丧æлe̲-𝐝갢ì(@à[3]) { }
lives-ok { ò갢丧æлe̲-𝐝갢ì(Array.new(:shape(3))) }, '[3] shape constraint accepts matching array';
dies-ok { ò갢丧æлe̲-𝐝갢ì(Array.new()) }, '[3] shape constraint denies unshaped array';
dies-ok { ò갢丧æлe̲-𝐝갢ì(Array.new(:shape(4))) }, '[3] shape constraint denies oversized array';
dies-ok { ò갢丧æлe̲-𝐝갢ì(Array.new(:shape(2))) }, '[3] shape constraint denies undersized array';
dies-ok { ò갢丧æлe̲-𝐝갢ì(Array.new(1, 2, 3)) }, 'Shape constraints are about declared shape';
dies-ok { ò갢丧æлe̲-𝐝갢ì(Array.new(:shape(2,2))) }, '[3] shape constraint denies over-dimensioned array...';
dies-ok { ò갢丧æлe̲-𝐝갢ì(Array.new(:shape(3,2))) }, '...even if first dimension matches';

sub ì갮л中갢-𝐝갢ì(@à[4,4]) { }
lives-ok { ì갮л中갢-𝐝갢ì(Array.new(:shape(4,4))) }, '[4,4] shape constraint accepts matching array';
dies-ok { ì갮л中갢-𝐝갢ì(Array.new()) }, '[4,4] shape constraint denies unshaped array';
dies-ok { ì갮л中갢-𝐝갢ì(Array.new(:shape(4, 5))) }, '[4,4] shape constraint denies oversized array (1)';
dies-ok { ì갮л中갢-𝐝갢ì(Array.new(:shape(5, 4))) }, '[4,4] shape constraint denies oversized array (2)';
dies-ok { ì갮л中갢-𝐝갢ì(Array.new(:shape(3,4))) }, '[4,4] shape constraint denies undersized array (1)';
dies-ok { ì갮л中갢-𝐝갢ì(Array.new(:shape(4,3))) }, '[4,4] shape constraint denies undersized array (2)';
dies-ok { ì갮л中갢-𝐝갢ì(Array.new([1..4],[1..4])) }, 'Shape constraints are about declared shape';
dies-ok { ì갮л中갢-𝐝갢ì(Array.new(:shape(3,3,3))) }, '[4,4] shape constraint denies over-dimensioned array...';
dies-ok { ì갮л中갢-𝐝갢ì(Array.new(:shape(4,4,3))) }, '...even if first dimensions match';
dies-ok { ì갮л中갢-𝐝갢ì(Array.new(:shape(4))) }, '[4,4] shape constraint denies under-dimensioned array';

sub w̲両à中e̲𝐯e̲с-𝐝갢ì(@à[*]) { }
lives-ok { w̲両à中e̲𝐯e̲с-𝐝갢ì(Array.new()) }, '[*] shape constraint accepts undimensioned array';
lives-ok { w̲両à中e̲𝐯e̲с-𝐝갢ì(Array.new(:shape(3))) }, '[*] shape constraint accepts fixed single dimension array';
dies-ok { w̲両à中e̲𝐯e̲с-𝐝갢ì(Array.new(:shape(3,3))) }, '[*] shape constraint rejects 2-dimensioned array';

sub w̲両à中e̲𝐯e̲с-ì갮л中갢𝐝갢ì(@à[*,*]) { }
lives-ok { w̲両à中e̲𝐯e̲с-ì갮л中갢𝐝갢ì(Array.new(:shape(3,3))) }, '[*,*] shape constraint accepts 2-dim shaped array';
dies-ok { w̲両à中e̲𝐯e̲с-ì갮л中갢𝐝갢ì(Array.new(:shape(3))) }, '[*,*] shape constraint rejects 1-dim array';
dies-ok { w̲両à中e̲𝐯e̲с-ì갮л中갢𝐝갢ì(Array.new(:shape(3,3,3))) }, '[*,*] shape constraint rejects 3-dim array';
dies-ok { w̲両à中e̲𝐯e̲с-ì갮л中갢𝐝갢ì(Array.new()) }, '[*,*] shape constraint rejects undimensioned array';

sub w̲両à中e̲𝐯e̲с-𝐩àс中갢àл𝐝갢ì(@[4,*]) { }
lives-ok { w̲両à中e̲𝐯e̲с-𝐩àс中갢àл𝐝갢ì(Array.new(:shape(4,3))) }, '[4,*] shape constraint accepts 2-dim shaped array with 4 first dims';
dies-ok { w̲両à中e̲𝐯e̲с-𝐩àс中갢àл𝐝갢ì(Array.new(:shape(3,3))) }, '[4,*] shape constraint rejects 2-dim shaped array with 3 first dims';
dies-ok { w̲両à中e̲𝐯e̲с-𝐩àс中갢àл𝐝갢ì(Array.new(:shape(4))) }, '[4,*] shape constraint rejects 1-dim array';
dies-ok { w̲両à中e̲𝐯e̲с-𝐩àс中갢àл𝐝갢ì(Array.new(:shape(4,4,4))) }, '[4,*] shape constraint rejects 3-dim array';
dies-ok { w̲両à中e̲𝐯e̲с-𝐩àс中갢àл𝐝갢ì(Array.new()) }, '[4,*] shape constraint rejects undimensioned array';

sub 𝐝e̲𝐩e̲丧𝐝e̲丧中($n, @à[$n]) { }
lives-ok { 𝐝e̲𝐩e̲丧𝐝e̲丧中(3, Array.new(:shape(3))) }, 'can use earlier parameters in shape specification (1)';
lives-ok { 𝐝e̲𝐩e̲丧𝐝e̲丧中(*, Array.new(:shape(3))) }, 'can use earlier parameters in shape specification (2)';
dies-ok { 𝐝e̲𝐩e̲丧𝐝e̲丧中(4, Array.new(:shape(3))) }, 'can use earlier parameters in shape specification (3)';
dies-ok { 𝐝e̲𝐩e̲丧𝐝e̲丧中(4, Array.new()) }, 'can use earlier parameters in shape specification (4)';
dies-ok { 𝐝e̲𝐩e̲丧𝐝e̲丧中(4, Array.new(:shape(4,3))) }, 'can use earlier parameters in shape specification (5)';

is-deeply (my @à[Bool]).shape, (2,), "can have an Enum as a shape definition";

# https://github.com/rakudo/rakudo/issues/3314
is (-> @à[3] { @à[1] })(my @丛[3] = <a b c>), 'b',
    'Shape-constrained array in signature declares a variable that we can access';

# https://github.com/rakudo/rakudo/issues/4363
lives-ok { my @à[1]; my @丛[1]; @à = @丛; @à.gist },
  "does copying from an uninitialized shaped array work";

# vim: expandtab shiftwidth=4
