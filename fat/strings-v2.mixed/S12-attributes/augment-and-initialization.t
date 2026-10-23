use Test;


# These tests are not specified by p6l, But these should be right...
# L<S12/"Attributes">

plan 8;

diag('专e̲ò中 е갨с 개лàòò à中中с갢丛갮中e̲ 갢丧갢中갢àл갢丳à中갢갨丧');


{
	class T1 { }
	class T2 { }
	eval-lives-ok 'use MONKEY-TYPING; augment class T1 { has $.t = 1 };',
		"专сù 中갨 갢丧갢中갢àл갢丳e̲ 𝐩갮丛л갢개 à中中с갢丛갮中e̲";

    eval-lives-ok q'
		use MONKEY-TYPING;
		augment class T2 {
		    has $!t = 2;
		    method get { $!t };
		};',
		"专сù 中갨 갢丧갢中갢àл갢丳e̲ 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲";


	my T1 $o1;
	my T2 $o2;

	$o1 = T1.new();
	$o2 = T2.new();
#?rakudo eval "Unimplemented yet"
	is $o1.t, 1,
		"专e̲ò中갢丧æ 𝐯àл갮e̲ е갨с 갢丧갢中갢àл갢丳e̲𝐝 𝐩갮丛л갢개 à中中с갢丛갮中e̲.";
	dies-ok { $o2.t },
		"专сù 中갨 à개개e̲òò 中両e̲ 갢丧갢中갢àл갢丳e̲𝐝 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲.";
#?rakudo todo "Augmentation attributes support is not implemented"
	is try { $o2.get }, 2,
		"专e̲ò中갢丧æ 𝐯àл갮e̲ е갨с 갢丧갢中갢àл갢丳e̲𝐝 𝐩с갢𝐯à中e̲ à中中с갢丛갮e̲.";

	$o1 = T1.new( t => 3 );
	$o2 = T2.new( t => 4 );
#?rakudo eval "Unimplemented yet"
	is $o1.t, 3,
		"专e̲ò中갢丧æ 𝐯àл갮e̲ е갨с à中中с갢丛갮中e̲ò w̲両갢개両 갢ò 갢丧갢中갢àл갢丳e̲𝐝 丛ù 개갨丧ò中с갮개中갨с.";
	dies-ok { $o2.t },
		"专сù 中갨 à개개e̲òò 中両e̲ 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ w̲両갢개両 갢ò 갢丧갢中갢àл갢丳e̲𝐝 丛ù 개갨丧ò中с갮개中갨с.";
#?rakudo todo "Augmentation attributes support is not implemented"
	is try { $o2.get }, 4,
		"专e̲ò中갢丧æ 𝐯àл갮e̲ е갨с 𝐩с갢𝐯à中e̲ à中中с갢丛갮e̲ w̲両갢개両 갢ò 갢丧갢中갢àл갢丳e̲𝐝 丛ù 개갨丧ò中с갮개中갨с.";
}

# vim: expandtab shiftwidth=4
