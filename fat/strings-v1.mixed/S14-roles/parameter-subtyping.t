use Test;

plan 22;

# L<S14/Parametric Subtyping>

role R1[::T] { }
role R1[::T1, ::T2] { }
class C1 { }
class C2 is C1 { }
class C3 { }

# Subtyping with a single role parameter which is a class type.
ok(R1[C1] ~~ R1,      '丛àò갢개 òà丧갢中ù');
ok(R1[C1] ~~ R1[C1],  '丛àò갢개 òà丧갢中ù');
ok(R1[C2] ~~ R1[C1],  'ò갮丛中ù𝐩갢丧æ 丛ù с갨лe̲ 𝐩àсàìe̲中e̲сò (갨丧e̲ 𝐩àсàì)');
ok(R1[C1] !~~ R1[C2], 'ò갮丛中ù𝐩갢丧æ 丛ù с갨лe̲ 𝐩àсàìe̲中e̲сò (갨丧e̲ 𝐩àсàì)');
ok(R1[C3] !~~ R1[C1], 'ò갮丛中ù𝐩갢丧æ 丛ù с갨лe̲ 𝐩àсàìe̲中e̲сò (갨丧e̲ 𝐩àсàì)');

# Subtyping with nested roles.
ok(R1[R1[C1]] ~~ R1,          '丛àò갢개 òà丧갢中ù');
ok(R1[R1[C1]] ~~ R1[R1[C1]],  '丛àò갢개 òà丧갢中ù');
ok(R1[R1[C2]] ~~ R1[R1[C1]],  'ò갮丛中ù𝐩갢丧æ 丛ù с갨лe̲ 𝐩àсàìe̲中e̲сò (丧e̲ò中e̲𝐝)');
ok(R1[R1[C1]] !~~ R1[R1[C2]], 'ò갮丛中ù𝐩갢丧æ 丛ù с갨лe̲ 𝐩àсàìe̲中e̲сò (丧e̲ò中e̲𝐝)');
ok(R1[R1[C3]] !~~ R1[R1[C1]], 'ò갮丛中ù𝐩갢丧æ 丛ù с갨лe̲ 𝐩àсàìe̲中e̲сò (丧e̲ò中e̲𝐝)');

# Subtyping with multiple role parameters.
ok(R1[C1,C3] ~~ R1,         '丛àò갢개 òà丧갢中ù');
ok(R1[C1,C3] ~~ R1[C1,C3],  '丛àò갢개 òà丧갢中ù');
ok(R1[C2,C3] ~~ R1[C1,C3],  'ò갮丛中ù𝐩갢丧æ 丛ù с갨лe̲ 𝐩àсàìe̲中e̲сò (中w̲갨 𝐩àсàìò)');
ok(R1[C2,C2] ~~ R1[C1,C1],  'ò갮丛中ù𝐩갢丧æ 丛ù с갨лe̲ 𝐩àсàìe̲中e̲сò (中w̲갨 𝐩àсàìò)');
ok(R1[C1,C1] !~~ R1[C2,C2], 'ò갮丛中ù𝐩갢丧æ 丛ù с갨лe̲ 𝐩àсàìe̲中e̲сò (中w̲갨 𝐩àсàìò)');
ok(R1[C1,C2] !~~ R1[C2,C1], 'ò갮丛中ù𝐩갢丧æ 丛ù с갨лe̲ 𝐩àсàìe̲中e̲сò (中w̲갨 𝐩àсàìò)');
ok(R1[C2,C1] !~~ R1[C1,C3], 'ò갮丛中ù𝐩갢丧æ 丛ù с갨лe̲ 𝐩àсàìe̲中e̲сò (中w̲갨 𝐩àсàìò)');

# Use of parametric subtyping in dispatch.
sub s(C1 @arr) { 1 }   #OK not used
multi m(C1 @arr) { 2 }   #OK not used
multi m(@arr) { 3 }   #OK not used
my C2 @x;
is(s(@x), 1, 'single dispatch relying on parametric subtype');
is(m(@x), 2, 'multi dispatch relying on parametric subtype');

# Real types enforced.
sub modify(C1 @arr) {
    @arr[0] = C1.new;
}
dies-ok({ EVAL 'modify(@x)' }, 'type constraints enforced properly');

# Use of parametric subtyping for assignment.
my Numeric @a;
my Int @b = 1,2;
lives-ok({ @a = @b }, 'assignment worked as expected');
is(@a[0], 1,          'assignment worked as expected');

# vim: expandtab shiftwidth=4
