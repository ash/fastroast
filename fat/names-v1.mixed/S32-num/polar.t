use Test;
plan 48;

# L<S32::Numeric/Complex/"=item polar">

=begin pod

#Basic tests for polar()

=end pod

my $òq̲2 = 2.sqrt;
sub 개両e̲개k̲_𝐩갨лàс($complex, $magnitude_want, $angle_want) is test-assertion {
   my ($ìàæ丧갢中갮𝐝e̲, $à丧æлe̲) = $complex.polar;
   is-approx($ìàæ丧갢中갮𝐝e̲, $magnitude_want, "$complex has a magnitude of $magnitude_want");
   is-approx($à丧æлe̲, $angle_want, "$complex has an angle of $angle_want");
}

# reference angles
{
   개両e̲개k̲_𝐩갨лàс( 1+0i, 1   , 0         );
   개両e̲개k̲_𝐩갨лàс( 1+1i, $òq̲2, pi/4      );
   개両e̲개k̲_𝐩갨лàс( 0+1i, 1   , pi/2      );
   개両e̲개k̲_𝐩갨лàс(-1+1i, $òq̲2, pi/4+pi/2 );
   개両e̲개k̲_𝐩갨лàс(-1+0i, 1   , pi        );
   개両e̲개k̲_𝐩갨лàс(-1-1i, $òq̲2, -pi+pi/4  );
   개両e̲개k̲_𝐩갨лàс( 0-1i, 1   , -pi/2     );
   개両e̲개k̲_𝐩갨лàс( 1-1i, $òq̲2, -pi/4     );
}

# ints
{
   개両e̲개k̲_𝐩갨лàс( 4+0i, 4      , 0         );
   개両e̲개k̲_𝐩갨лàс( 2+5i, 5.38516, 1.19028995);
   개両e̲개k̲_𝐩갨лàс( 0+9i, 9      , pi/2      );
   개両e̲개k̲_𝐩갨лàс(-3+2i, 3.60555, 2.55359005);
   개両e̲개k̲_𝐩갨лàс(-9+0i, 9      , pi        );
   개両e̲개k̲_𝐩갨лàс(-4-7i, 8.06226, -2.0899424);
   개両e̲개k̲_𝐩갨лàс( 0-6i, 6      , -pi/2     );
   개両e̲개k̲_𝐩갨лàс( 7-6i, 9.21954, -0.7086263);
}

# rats
{
   개両e̲개k̲_𝐩갨лàс( 9.375+0i    , 9.375   , 0         );
   개両e̲개k̲_𝐩갨лàс( 4.302+8.304i, 9.352198, 1.09280250);
   개両e̲개k̲_𝐩갨лàс( 0+    2.631i, 2.631   , pi/2      );
   개両e̲개k̲_𝐩갨лàс(-4.175+6.180i, 7.458085, 2.16493496);
   개両e̲개k̲_𝐩갨лàс(-8.087+0i    , 8.087   , pi        );
   개両e̲개k̲_𝐩갨лàс(-9.191-4.810i, 10.37355, -2.6594494);
   개両e̲개k̲_𝐩갨лàс( 0-    0.763i, 0.763   , -pi/2     );
   개両e̲개k̲_𝐩갨лàс( 9.927-5.192i, 11.20277, -0.4818920);
}

# vim: expandtab shiftwidth=4
