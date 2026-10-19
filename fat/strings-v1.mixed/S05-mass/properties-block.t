use Test;

=begin pod

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/properties_slow_to_compile.t.

XXX needs more clarification on the case of the rules,
ie letter vs. Letter vs isLetter

=end pod

plan 670;

# InAlphabeticPresentationForms

ok(!( "\x[531A]"  ~~ m/^<:InAlphabeticPresentationForms>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Àл𝐩両à丛e̲中갢개𝐏сe̲òe̲丧中à中갢갨丧Е갨сìò>} );
ok("\x[531A]"  ~~ m/^<:!InAlphabeticPresentationForms>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Àл𝐩両à丛e̲中갢개𝐏сe̲òe̲丧中à中갢갨丧Е갨сìò>} );
ok("\x[531A]"  ~~ m/^<-:InAlphabeticPresentationForms>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Àл𝐩両à丛e̲中갢개𝐏сe̲òe̲丧中à中갢갨丧Е갨сìò>} );

# InArabic


ok("\c[ARABIC NUMBER SIGN]" ~~ m/^<:InArabic>$/, q{Ìà中개両 <:갈丧Àсà丛갢개>} );
ok(!( "\c[ARABIC NUMBER SIGN]" ~~ m/^<:!InArabic>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Àсà丛갢개>} );
ok(!( "\c[ARABIC NUMBER SIGN]" ~~ m/^<-:InArabic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Àсà丛갢개>} );
ok(!( "\x[7315]"  ~~ m/^<:InArabic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Àсà丛갢개>} );
ok("\x[7315]"  ~~ m/^<:!InArabic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Àсà丛갢개>} );
ok("\x[7315]"  ~~ m/^<-:InArabic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Àсà丛갢개>} );
ok("\x[7315]\c[ARABIC NUMBER SIGN]" ~~ m/<:InArabic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Àсà丛갢개>} );

# InArabicPresentationFormsA


ok(!( "\x[8340]"  ~~ m/^<:InArabicPresentationFormsA>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Àсà丛갢개𝐏сe̲òe̲丧中à中갢갨丧Е갨сìòÀ>} );
ok("\x[8340]"  ~~ m/^<:!InArabicPresentationFormsA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Àсà丛갢개𝐏сe̲òe̲丧中à中갢갨丧Е갨сìòÀ>} );
ok("\x[8340]"  ~~ m/^<-:InArabicPresentationFormsA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Àсà丛갢개𝐏сe̲òe̲丧中à中갢갨丧Е갨сìòÀ>} );

# InArabicPresentationFormsB


ok(!( "\x[BEEC]"  ~~ m/^<:InArabicPresentationFormsB>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Àсà丛갢개𝐏сe̲òe̲丧中à中갢갨丧Е갨сìò丁>} );
ok("\x[BEEC]"  ~~ m/^<:!InArabicPresentationFormsB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Àсà丛갢개𝐏сe̲òe̲丧中à中갢갨丧Е갨сìò丁>} );
ok("\x[BEEC]"  ~~ m/^<-:InArabicPresentationFormsB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Àсà丛갢개𝐏сe̲òe̲丧中à中갢갨丧Е갨сìò丁>} );

# InArmenian


ok("\x[0530]" ~~ m/^<:InArmenian>$/, q{Ìà中개両 <:갈丧Àсìe̲丧갢à丧>} );
ok(!( "\x[0530]" ~~ m/^<:!InArmenian>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Àсìe̲丧갢à丧>} );
ok(!( "\x[0530]" ~~ m/^<-:InArmenian>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Àсìe̲丧갢à丧>} );
ok(!( "\x[3B0D]"  ~~ m/^<:InArmenian>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Àсìe̲丧갢à丧>} );
ok("\x[3B0D]"  ~~ m/^<:!InArmenian>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Àсìe̲丧갢à丧>} );
ok("\x[3B0D]"  ~~ m/^<-:InArmenian>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Àсìe̲丧갢à丧>} );
ok("\x[3B0D]\x[0530]" ~~ m/<:InArmenian>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Àсìe̲丧갢à丧>} );

# InArrows


ok("\c[LEFTWARDS ARROW]" ~~ m/^<:InArrows>$/, q{Ìà中개両 <:갈丧Àсс갨w̲ò>} );
ok(!( "\c[LEFTWARDS ARROW]" ~~ m/^<:!InArrows>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Àсс갨w̲ò>} );
ok(!( "\c[LEFTWARDS ARROW]" ~~ m/^<-:InArrows>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Àсс갨w̲ò>} );
ok(!( "\x[C401]"  ~~ m/^<:InArrows>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Àсс갨w̲ò>} );
ok("\x[C401]"  ~~ m/^<:!InArrows>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Àсс갨w̲ò>} );
ok("\x[C401]"  ~~ m/^<-:InArrows>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Àсс갨w̲ò>} );
ok("\x[C401]\c[LEFTWARDS ARROW]" ~~ m/<:InArrows>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Àсс갨w̲ò>} );


# InBasicLatin


ok("\c[NULL]" ~~ m/^<:InBasicLatin>$/, q{Ìà中개両 <:갈丧丁àò갢개Лà中갢丧>} );
ok(!( "\c[NULL]" ~~ m/^<:!InBasicLatin>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧丁àò갢개Лà中갢丧>} );
ok(!( "\c[NULL]" ~~ m/^<-:InBasicLatin>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧丁àò갢개Лà中갢丧>} );
ok(!( "\x[46EA]"  ~~ m/^<:InBasicLatin>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧丁àò갢개Лà中갢丧>} );
ok("\x[46EA]"  ~~ m/^<:!InBasicLatin>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧丁àò갢개Лà中갢丧>} );
ok("\x[46EA]"  ~~ m/^<-:InBasicLatin>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧丁àò갢개Лà中갢丧>} );
ok("\x[46EA]\c[NULL]" ~~ m/<:InBasicLatin>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧丁àò갢개Лà中갢丧>} );

# InBengali


ok("\x[0980]" ~~ m/^<:InBengali>$/, q{Ìà中개両 <:갈丧丁e̲丧æàл갢>} );
ok(!( "\x[0980]" ~~ m/^<:!InBengali>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧丁e̲丧æàл갢>} );
ok(!( "\x[0980]" ~~ m/^<-:InBengali>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧丁e̲丧æàл갢>} );
ok(!( "\c[YI SYLLABLE HMY]"  ~~ m/^<:InBengali>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧丁e̲丧æàл갢>} );
ok("\c[YI SYLLABLE HMY]"  ~~ m/^<:!InBengali>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧丁e̲丧æàл갢>} );
ok("\c[YI SYLLABLE HMY]"  ~~ m/^<-:InBengali>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧丁e̲丧æàл갢>} );
ok("\c[YI SYLLABLE HMY]\x[0980]" ~~ m/<:InBengali>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧丁e̲丧æàл갢>} );

# InBlockElements


ok("\c[UPPER HALF BLOCK]" ~~ m/^<:InBlockElements>$/, q{Ìà中개両 <:갈丧丁л갨개k̲E̲лe̲ìe̲丧中ò>} );
ok(!( "\c[UPPER HALF BLOCK]" ~~ m/^<:!InBlockElements>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧丁л갨개k̲E̲лe̲ìe̲丧中ò>} );
ok(!( "\c[UPPER HALF BLOCK]" ~~ m/^<-:InBlockElements>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧丁л갨개k̲E̲лe̲ìe̲丧中ò>} );
ok(!( "\x[5F41]"  ~~ m/^<:InBlockElements>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧丁л갨개k̲E̲лe̲ìe̲丧中ò>} );
ok("\x[5F41]"  ~~ m/^<:!InBlockElements>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧丁л갨개k̲E̲лe̲ìe̲丧中ò>} );
ok("\x[5F41]"  ~~ m/^<-:InBlockElements>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧丁л갨개k̲E̲лe̲ìe̲丧中ò>} );
ok("\x[5F41]\c[UPPER HALF BLOCK]" ~~ m/<:InBlockElements>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧丁л갨개k̲E̲лe̲ìe̲丧中ò>} );

# InBopomofo


ok("\x[3100]" ~~ m/^<:InBopomofo>$/, q{Ìà中개両 <:갈丧丁갨𝐩갨ì갨е갨>} );
ok(!( "\x[3100]" ~~ m/^<:!InBopomofo>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧丁갨𝐩갨ì갨е갨>} );
ok(!( "\x[3100]" ~~ m/^<-:InBopomofo>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧丁갨𝐩갨ì갨е갨>} );
ok(!( "\x[9F8E]"  ~~ m/^<:InBopomofo>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧丁갨𝐩갨ì갨е갨>} );
ok("\x[9F8E]"  ~~ m/^<:!InBopomofo>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧丁갨𝐩갨ì갨е갨>} );
ok("\x[9F8E]"  ~~ m/^<-:InBopomofo>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧丁갨𝐩갨ì갨е갨>} );
ok("\x[9F8E]\x[3100]" ~~ m/<:InBopomofo>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧丁갨𝐩갨ì갨е갨>} );

# InBopomofoExtended


ok("\c[BOPOMOFO LETTER BU]" ~~ m/^<:InBopomofoExtended>$/, q{Ìà中개両 <:갈丧丁갨𝐩갨ì갨е갨E̲ч中e̲丧𝐝e̲𝐝>} );
ok(!( "\c[BOPOMOFO LETTER BU]" ~~ m/^<:!InBopomofoExtended>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧丁갨𝐩갨ì갨е갨E̲ч中e̲丧𝐝e̲𝐝>} );
ok(!( "\c[BOPOMOFO LETTER BU]" ~~ m/^<-:InBopomofoExtended>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧丁갨𝐩갨ì갨е갨E̲ч中e̲丧𝐝e̲𝐝>} );
ok(!( "\x[43A6]"  ~~ m/^<:InBopomofoExtended>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧丁갨𝐩갨ì갨е갨E̲ч中e̲丧𝐝e̲𝐝>} );
ok("\x[43A6]"  ~~ m/^<:!InBopomofoExtended>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧丁갨𝐩갨ì갨е갨E̲ч中e̲丧𝐝e̲𝐝>} );
ok("\x[43A6]"  ~~ m/^<-:InBopomofoExtended>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧丁갨𝐩갨ì갨е갨E̲ч中e̲丧𝐝e̲𝐝>} );
ok("\x[43A6]\c[BOPOMOFO LETTER BU]" ~~ m/<:InBopomofoExtended>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧丁갨𝐩갨ì갨е갨E̲ч中e̲丧𝐝e̲𝐝>} );

# InBoxDrawing


ok("\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<:InBoxDrawing>$/, q{Ìà中개両 <:갈丧丁갨ч𝐃сàw̲갢丧æ>} );
ok(!( "\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<:!InBoxDrawing>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧丁갨ч𝐃сàw̲갢丧æ>} );
ok(!( "\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/^<-:InBoxDrawing>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧丁갨ч𝐃сàw̲갢丧æ>} );
ok(!( "\x[7865]"  ~~ m/^<:InBoxDrawing>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧丁갨ч𝐃сàw̲갢丧æ>} );
ok("\x[7865]"  ~~ m/^<:!InBoxDrawing>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧丁갨ч𝐃сàw̲갢丧æ>} );
ok("\x[7865]"  ~~ m/^<-:InBoxDrawing>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧丁갨ч𝐃сàw̲갢丧æ>} );
ok("\x[7865]\c[BOX DRAWINGS LIGHT HORIZONTAL]" ~~ m/<:InBoxDrawing>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧丁갨ч𝐃сàw̲갢丧æ>} );

# InBraillePatterns


ok("\c[BRAILLE PATTERN BLANK]" ~~ m/^<:InBraillePatterns>$/, q{Ìà中개両 <:갈丧丁сà갢ллe̲𝐏à中中e̲с丧ò>} );
ok(!( "\c[BRAILLE PATTERN BLANK]" ~~ m/^<:!InBraillePatterns>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧丁сà갢ллe̲𝐏à中中e̲с丧ò>} );
ok(!( "\c[BRAILLE PATTERN BLANK]" ~~ m/^<-:InBraillePatterns>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧丁сà갢ллe̲𝐏à中中e̲с丧ò>} );
ok(!( "\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<:InBraillePatterns>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧丁сà갢ллe̲𝐏à中中e̲с丧ò>} );
ok("\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<:!InBraillePatterns>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧丁сà갢ллe̲𝐏à中中e̲с丧ò>} );
ok("\c[THAI CHARACTER KHO KHAI]"  ~~ m/^<-:InBraillePatterns>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧丁сà갢ллe̲𝐏à中中e̲с丧ò>} );
ok("\c[THAI CHARACTER KHO KHAI]\c[BRAILLE PATTERN BLANK]" ~~ m/<:InBraillePatterns>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧丁сà갢ллe̲𝐏à中中e̲с丧ò>} );

# InBuhid


ok("\c[BUHID LETTER A]" ~~ m/^<:InBuhid>$/, q{Ìà中개両 <:갈丧丁갮両갢𝐝>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<:!InBuhid>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧丁갮両갢𝐝>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<-:InBuhid>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧丁갮両갢𝐝>} );
ok(!( "\x[D208]"  ~~ m/^<:InBuhid>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧丁갮両갢𝐝>} );
ok("\x[D208]"  ~~ m/^<:!InBuhid>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧丁갮両갢𝐝>} );
ok("\x[D208]"  ~~ m/^<-:InBuhid>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧丁갮両갢𝐝>} );
ok("\x[D208]\c[BUHID LETTER A]" ~~ m/<:InBuhid>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧丁갮両갢𝐝>} );

# InByzantineMusicalSymbols


ok(!( "\x[9B1D]"  ~~ m/^<:InByzantineMusicalSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧丁ù丳à丧中갢丧e̲Ì갮ò갢개àлÒùì丛갨лò>} );
ok("\x[9B1D]"  ~~ m/^<:!InByzantineMusicalSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧丁ù丳à丧中갢丧e̲Ì갮ò갢개àлÒùì丛갨лò>} );
ok("\x[9B1D]"  ~~ m/^<-:InByzantineMusicalSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧丁ù丳à丧中갢丧e̲Ì갮ò갢개àлÒùì丛갨лò>} );

# InCJKCompatibility


ok("\c[SQUARE APAATO]" ~~ m/^<:InCJKCompatibility>$/, q{Ìà中개両 <:갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù>} );
ok(!( "\c[SQUARE APAATO]" ~~ m/^<:!InCJKCompatibility>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù>} );
ok(!( "\c[SQUARE APAATO]" ~~ m/^<-:InCJKCompatibility>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù>} );
ok(!( "\x[B8A5]"  ~~ m/^<:InCJKCompatibility>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù>} );
ok("\x[B8A5]"  ~~ m/^<:!InCJKCompatibility>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù>} );
ok("\x[B8A5]"  ~~ m/^<-:InCJKCompatibility>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù>} );
ok("\x[B8A5]\c[SQUARE APAATO]" ~~ m/<:InCJKCompatibility>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù>} );

# InCJKCompatibilityForms


ok(!( "\x[3528]"  ~~ m/^<:InCJKCompatibilityForms>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ùЕ갨сìò>} );
ok("\x[3528]"  ~~ m/^<:!InCJKCompatibilityForms>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ùЕ갨сìò>} );
ok("\x[3528]"  ~~ m/^<-:InCJKCompatibilityForms>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ùЕ갨сìò>} );

# InCJKCompatibilityIdeographs


ok(!( "\x[69F7]"  ~~ m/^<:InCJKCompatibilityIdeographs>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù갈𝐝e̲갨æсà𝐩両ò>} );
ok("\x[69F7]"  ~~ m/^<:!InCJKCompatibilityIdeographs>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù갈𝐝e̲갨æсà𝐩両ò>} );
ok("\x[69F7]"  ~~ m/^<-:InCJKCompatibilityIdeographs>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù갈𝐝e̲갨æсà𝐩両ò>} );

# InCJKCompatibilityIdeographsSupplement


ok(!( "\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<:InCJKCompatibilityIdeographsSupplement>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù갈𝐝e̲갨æсà𝐩両òÒ갮𝐩𝐩лe̲ìe̲丧中>} );
ok("\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<:!InCJKCompatibilityIdeographsSupplement>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù갈𝐝e̲갨æсà𝐩両òÒ갮𝐩𝐩лe̲ìe̲丧中>} );
ok("\c[CANADIAN SYLLABICS NUNAVIK HO]"  ~~ m/^<-:InCJKCompatibilityIdeographsSupplement>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲갂갨ì𝐩à中갢丛갢л갢中ù갈𝐝e̲갨æсà𝐩両òÒ갮𝐩𝐩лe̲ìe̲丧中>} );

# InCJKRadicalsSupplement


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<:InCJKRadicalsSupplement>$/, q{Ìà中개両 <:갈丧갂𝐉K̲Сà𝐝갢개àлòÒ갮𝐩𝐩лe̲ìe̲丧中>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<:!InCJKRadicalsSupplement>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲Сà𝐝갢개àлòÒ갮𝐩𝐩лe̲ìe̲丧中>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-:InCJKRadicalsSupplement>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲Сà𝐝갢개àлòÒ갮𝐩𝐩лe̲ìe̲丧中>} );
ok(!( "\x[37B4]"  ~~ m/^<:InCJKRadicalsSupplement>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂𝐉K̲Сà𝐝갢개àлòÒ갮𝐩𝐩лe̲ìe̲丧中>} );
ok("\x[37B4]"  ~~ m/^<:!InCJKRadicalsSupplement>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲Сà𝐝갢개àлòÒ갮𝐩𝐩лe̲ìe̲丧中>} );
ok("\x[37B4]"  ~~ m/^<-:InCJKRadicalsSupplement>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲Сà𝐝갢개àлòÒ갮𝐩𝐩лe̲ìe̲丧中>} );
ok("\x[37B4]\c[CJK RADICAL REPEAT]" ~~ m/<:InCJKRadicalsSupplement>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갂𝐉K̲Сà𝐝갢개àлòÒ갮𝐩𝐩лe̲ìe̲丧中>} );

# InCJKSymbolsAndPunctuation


ok("\c[IDEOGRAPHIC SPACE]" ~~ m/^<:InCJKSymbolsAndPunctuation>$/, q{Ìà中개両 <:갈丧갂𝐉K̲Òùì丛갨лòÀ丧𝐝𝐏갮丧개中갮à中갢갨丧>} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<:!InCJKSymbolsAndPunctuation>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲Òùì丛갨лòÀ丧𝐝𝐏갮丧개中갮à中갢갨丧>} );
ok(!( "\c[IDEOGRAPHIC SPACE]" ~~ m/^<-:InCJKSymbolsAndPunctuation>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲Òùì丛갨лòÀ丧𝐝𝐏갮丧개中갮à中갢갨丧>} );
ok(!( "\x[80AA]"  ~~ m/^<:InCJKSymbolsAndPunctuation>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂𝐉K̲Òùì丛갨лòÀ丧𝐝𝐏갮丧개中갮à中갢갨丧>} );
ok("\x[80AA]"  ~~ m/^<:!InCJKSymbolsAndPunctuation>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲Òùì丛갨лòÀ丧𝐝𝐏갮丧개中갮à中갢갨丧>} );
ok("\x[80AA]"  ~~ m/^<-:InCJKSymbolsAndPunctuation>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲Òùì丛갨лòÀ丧𝐝𝐏갮丧개中갮à中갢갨丧>} );
ok("\x[80AA]\c[IDEOGRAPHIC SPACE]" ~~ m/<:InCJKSymbolsAndPunctuation>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갂𝐉K̲Òùì丛갨лòÀ丧𝐝𝐏갮丧개中갮à中갢갨丧>} );

# InCJKUnifiedIdeographs


ok("\x[4E00]" ~~ m/^<:InCJKUnifiedIdeographs>$/, q{Ìà中개両 <:갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両ò>} );
ok(!( "\x[4E00]" ~~ m/^<:!InCJKUnifiedIdeographs>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両ò>} );
ok(!( "\x[4E00]" ~~ m/^<-:InCJKUnifiedIdeographs>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両ò>} );
ok(!( "\x[3613]"  ~~ m/^<:InCJKUnifiedIdeographs>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両ò>} );
ok("\x[3613]"  ~~ m/^<:!InCJKUnifiedIdeographs>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両ò>} );
ok("\x[3613]"  ~~ m/^<-:InCJKUnifiedIdeographs>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両ò>} );
ok("\x[3613]\x[4E00]" ~~ m/<:InCJKUnifiedIdeographs>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両ò>} );

# InCJKUnifiedIdeographsExtensionA


ok("\x[3400]" ~~ m/^<:InCJKUnifiedIdeographsExtensionA>$/, q{Ìà中개両 <:갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両òE̲ч中e̲丧ò갢갨丧À>} );
ok(!( "\x[3400]" ~~ m/^<:!InCJKUnifiedIdeographsExtensionA>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両òE̲ч中e̲丧ò갢갨丧À>} );
ok(!( "\x[3400]" ~~ m/^<-:InCJKUnifiedIdeographsExtensionA>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両òE̲ч中e̲丧ò갢갨丧À>} );
ok(!( "\c[SQUARE HOORU]"  ~~ m/^<:InCJKUnifiedIdeographsExtensionA>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両òE̲ч中e̲丧ò갢갨丧À>} );
ok("\c[SQUARE HOORU]"  ~~ m/^<:!InCJKUnifiedIdeographsExtensionA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両òE̲ч中e̲丧ò갢갨丧À>} );
ok("\c[SQUARE HOORU]"  ~~ m/^<-:InCJKUnifiedIdeographsExtensionA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両òE̲ч中e̲丧ò갢갨丧À>} );
ok("\c[SQUARE HOORU]\x[3400]" ~~ m/<:InCJKUnifiedIdeographsExtensionA>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両òE̲ч中e̲丧ò갢갨丧À>} );

# InCJKUnifiedIdeographsExtensionB


ok(!( "\x[AC3B]"  ~~ m/^<:InCJKUnifiedIdeographsExtensionB>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両òE̲ч中e̲丧ò갢갨丧丁>} );
ok("\x[AC3B]"  ~~ m/^<:!InCJKUnifiedIdeographsExtensionB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両òE̲ч中e̲丧ò갢갨丧丁>} );
ok("\x[AC3B]"  ~~ m/^<-:InCJKUnifiedIdeographsExtensionB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂𝐉K̲갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両òE̲ч中e̲丧ò갢갨丧丁>} );

# InCherokee


ok("\c[CHEROKEE LETTER A]" ~~ m/^<:InCherokee>$/, q{Ìà中개両 <:갈丧갂両e̲с갨k̲e̲e̲>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<:!InCherokee>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂両e̲с갨k̲e̲e̲>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<-:InCherokee>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂両e̲с갨k̲e̲e̲>} );
ok(!( "\x[985F]"  ~~ m/^<:InCherokee>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂両e̲с갨k̲e̲e̲>} );
ok("\x[985F]"  ~~ m/^<:!InCherokee>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂両e̲с갨k̲e̲e̲>} );
ok("\x[985F]"  ~~ m/^<-:InCherokee>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂両e̲с갨k̲e̲e̲>} );
ok("\x[985F]\c[CHEROKEE LETTER A]" ~~ m/<:InCherokee>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갂両e̲с갨k̲e̲e̲>} );

# InCombiningDiacriticalMarks


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:InCombiningDiacriticalMarks>$/, q{Ìà中개両 <:갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲ò>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!InCombiningDiacriticalMarks>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲ò>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:InCombiningDiacriticalMarks>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲ò>} );
ok(!( "\x[76DA]"  ~~ m/^<:InCombiningDiacriticalMarks>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲ò>} );
ok("\x[76DA]"  ~~ m/^<:!InCombiningDiacriticalMarks>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲ò>} );
ok("\x[76DA]"  ~~ m/^<-:InCombiningDiacriticalMarks>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲ò>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/<:InCombiningDiacriticalMarks>/, q{Ìà中개両 ò갨л갢中àсù <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲ò>} );

# InCombiningDiacriticalMarksforSymbols


ok("\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<:InCombiningDiacriticalMarksforSymbols>$/, q{Ìà中개両 <:갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲òе갨сÒùì丛갨лò>} );
ok(!( "\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<:!InCombiningDiacriticalMarksforSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲òе갨сÒùì丛갨лò>} );
ok(!( "\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/^<-:InCombiningDiacriticalMarksforSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲òе갨сÒùì丛갨лò>} );
ok(!( "\x[7345]"  ~~ m/^<:InCombiningDiacriticalMarksforSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲òе갨сÒùì丛갨лò>} );
ok("\x[7345]"  ~~ m/^<:!InCombiningDiacriticalMarksforSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲òе갨сÒùì丛갨лò>} );
ok("\x[7345]"  ~~ m/^<-:InCombiningDiacriticalMarksforSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲òе갨сÒùì丛갨лò>} );
ok("\c[COMBINING LEFT HARPOON ABOVE]" ~~ m/<:InCombiningDiacriticalMarksforSymbols>/, q{Ìà中개両 ò갨л갢中àсù <갈丧갂갨ì丛갢丧갢丧æ𝐃갢à개с갢中갢개àлÌàсk̲òе갨сÒùì丛갨лò>} );

# InCombiningHalfMarks


ok(!( "\x[6C2E]"  ~~ m/^<:InCombiningHalfMarks>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ万àлеÌàсk̲ò>} );
ok("\x[6C2E]"  ~~ m/^<:!InCombiningHalfMarks>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ万àлеÌàсk̲ò>} );
ok("\x[6C2E]"  ~~ m/^<-:InCombiningHalfMarks>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂갨ì丛갢丧갢丧æ万àлеÌàсk̲ò>} );

# InControlPictures


ok("\c[SYMBOL FOR NULL]" ~~ m/^<:InControlPictures>$/, q{Ìà中개両 <:갈丧갂갨丧中с갨л𝐏갢개中갮сe̲ò>} );
ok(!( "\c[SYMBOL FOR NULL]" ~~ m/^<:!InControlPictures>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂갨丧中с갨л𝐏갢개中갮сe̲ò>} );
ok(!( "\c[SYMBOL FOR NULL]" ~~ m/^<-:InControlPictures>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂갨丧中с갨л𝐏갢개中갮сe̲ò>} );
ok(!( "\x[BCE2]"  ~~ m/^<:InControlPictures>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂갨丧中с갨л𝐏갢개中갮сe̲ò>} );
ok("\x[BCE2]"  ~~ m/^<:!InControlPictures>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂갨丧中с갨л𝐏갢개中갮сe̲ò>} );
ok("\x[BCE2]"  ~~ m/^<-:InControlPictures>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂갨丧中с갨л𝐏갢개中갮сe̲ò>} );
ok("\x[BCE2]\c[SYMBOL FOR NULL]" ~~ m/<:InControlPictures>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갂갨丧中с갨л𝐏갢개中갮сe̲ò>} );

# InCurrencySymbols


ok("\c[EURO-CURRENCY SIGN]" ~~ m/^<:InCurrencySymbols>$/, q{Ìà中개両 <:갈丧갂갮ссe̲丧개ùÒùì丛갨лò>} );
ok(!( "\c[EURO-CURRENCY SIGN]" ~~ m/^<:!InCurrencySymbols>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂갮ссe̲丧개ùÒùì丛갨лò>} );
ok(!( "\c[EURO-CURRENCY SIGN]" ~~ m/^<-:InCurrencySymbols>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂갮ссe̲丧개ùÒùì丛갨лò>} );
ok(!( "\x[8596]"  ~~ m/^<:InCurrencySymbols>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂갮ссe̲丧개ùÒùì丛갨лò>} );
ok("\x[8596]"  ~~ m/^<:!InCurrencySymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂갮ссe̲丧개ùÒùì丛갨лò>} );
ok("\x[8596]"  ~~ m/^<-:InCurrencySymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂갮ссe̲丧개ùÒùì丛갨лò>} );
ok("\x[8596]\c[EURO-CURRENCY SIGN]" ~~ m/<:InCurrencySymbols>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갂갮ссe̲丧개ùÒùì丛갨лò>} );

# InCyrillic


ok("\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<:InCyrillic>$/, q{Ìà中개両 <:갈丧갂ùс갢лл갢개>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<:!InCyrillic>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂ùс갢лл갢개>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<-:InCyrillic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂ùс갢лл갢개>} );
ok(!( "\x[51B2]"  ~~ m/^<:InCyrillic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂ùс갢лл갢개>} );
ok("\x[51B2]"  ~~ m/^<:!InCyrillic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂ùс갢лл갢개>} );
ok("\x[51B2]"  ~~ m/^<-:InCyrillic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂ùс갢лл갢개>} );
ok("\x[51B2]\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/<:InCyrillic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갂ùс갢лл갢개>} );

# InCyrillicSupplementary


ok("\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<:InCyrillicSupplementary>$/, q{Ìà中개両 <:갈丧갂ùс갢лл갢개Ò갮𝐩𝐩лe̲ìe̲丧中àсù>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<:!InCyrillicSupplementary>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갂ùс갢лл갢개Ò갮𝐩𝐩лe̲ìe̲丧中àсù>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/^<-:InCyrillicSupplementary>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갂ùс갢лл갢개Ò갮𝐩𝐩лe̲ìe̲丧中àсù>} );
ok(!( "\x[7BD9]"  ~~ m/^<:InCyrillicSupplementary>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갂ùс갢лл갢개Ò갮𝐩𝐩лe̲ìe̲丧中àсù>} );
ok("\x[7BD9]"  ~~ m/^<:!InCyrillicSupplementary>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갂ùс갢лл갢개Ò갮𝐩𝐩лe̲ìe̲丧中àсù>} );
ok("\x[7BD9]"  ~~ m/^<-:InCyrillicSupplementary>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갂ùс갢лл갢개Ò갮𝐩𝐩лe̲ìe̲丧中àсù>} );
ok("\x[7BD9]\c[CYRILLIC CAPITAL LETTER KOMI DE]" ~~ m/<:InCyrillicSupplementary>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갂ùс갢лл갢개Ò갮𝐩𝐩лe̲ìe̲丧中àсù>} );

# InDeseret


ok(!( "\c[TAMIL DIGIT FOUR]"  ~~ m/^<:InDeseret>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧𝐃e̲òe̲сe̲中>} );
ok("\c[TAMIL DIGIT FOUR]"  ~~ m/^<:!InDeseret>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧𝐃e̲òe̲сe̲中>} );
ok("\c[TAMIL DIGIT FOUR]"  ~~ m/^<-:InDeseret>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧𝐃e̲òe̲сe̲中>} );

# InDevanagari


ok("\x[0900]" ~~ m/^<:InDevanagari>$/, q{Ìà中개両 <:갈丧𝐃e̲𝐯à丧àæàс갢>} );
ok(!( "\x[0900]" ~~ m/^<:!InDevanagari>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧𝐃e̲𝐯à丧àæàс갢>} );
ok(!( "\x[0900]" ~~ m/^<-:InDevanagari>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧𝐃e̲𝐯à丧àæàс갢>} );
ok(!( "\x[BB12]"  ~~ m/^<:InDevanagari>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧𝐃e̲𝐯à丧àæàс갢>} );
ok("\x[BB12]"  ~~ m/^<:!InDevanagari>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧𝐃e̲𝐯à丧àæàс갢>} );
ok("\x[BB12]"  ~~ m/^<-:InDevanagari>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧𝐃e̲𝐯à丧àæàс갢>} );
ok("\x[BB12]\n\x[0900]" ~~ m/<:InDevanagari>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧𝐃e̲𝐯à丧àæàс갢>} );

# InDingbats


ok("\x[2700]" ~~ m/^<:InDingbats>$/, q{Ìà中개両 <:갈丧𝐃갢丧æ丛à中ò>} );
ok(!( "\x[2700]" ~~ m/^<:!InDingbats>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧𝐃갢丧æ丛à中ò>} );
ok(!( "\x[2700]" ~~ m/^<-:InDingbats>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧𝐃갢丧æ丛à中ò>} );
ok(!( "\x[D7A8]"  ~~ m/^<:InDingbats>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧𝐃갢丧æ丛à中ò>} );
ok("\x[D7A8]"  ~~ m/^<:!InDingbats>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧𝐃갢丧æ丛à中ò>} );
ok("\x[D7A8]"  ~~ m/^<-:InDingbats>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧𝐃갢丧æ丛à中ò>} );
ok("\x[D7A8]\x[2700]" ~~ m/<:InDingbats>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧𝐃갢丧æ丛à中ò>} );

# InEnclosedAlphanumerics


ok("\c[CIRCLED DIGIT ONE]" ~~ m/^<:InEnclosedAlphanumerics>$/, q{Ìà中개両 <:갈丧E̲丧개л갨òe̲𝐝Àл𝐩両à丧갮ìe̲с갢개ò>} );
ok(!( "\c[CIRCLED DIGIT ONE]" ~~ m/^<:!InEnclosedAlphanumerics>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧E̲丧개л갨òe̲𝐝Àл𝐩両à丧갮ìe̲с갢개ò>} );
ok(!( "\c[CIRCLED DIGIT ONE]" ~~ m/^<-:InEnclosedAlphanumerics>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧E̲丧개л갨òe̲𝐝Àл𝐩両à丧갮ìe̲с갢개ò>} );
ok(!( "\x[C3A2]"  ~~ m/^<:InEnclosedAlphanumerics>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧E̲丧개л갨òe̲𝐝Àл𝐩両à丧갮ìe̲с갢개ò>} );
ok("\x[C3A2]"  ~~ m/^<:!InEnclosedAlphanumerics>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧E̲丧개л갨òe̲𝐝Àл𝐩両à丧갮ìe̲с갢개ò>} );
ok("\x[C3A2]"  ~~ m/^<-:InEnclosedAlphanumerics>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧E̲丧개л갨òe̲𝐝Àл𝐩両à丧갮ìe̲с갢개ò>} );
ok("\x[C3A2]\c[CIRCLED DIGIT ONE]" ~~ m/<:InEnclosedAlphanumerics>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧E̲丧개л갨òe̲𝐝Àл𝐩両à丧갮ìe̲с갢개ò>} );

# InEnclosedCJKLettersAndMonths


ok("\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<:InEnclosedCJKLettersAndMonths>$/, q{Ìà中개両 <:갈丧E̲丧개л갨òe̲𝐝갂𝐉K̲Лe̲中中e̲сòÀ丧𝐝Ì갨丧中両ò>} );
ok(!( "\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<:!InEnclosedCJKLettersAndMonths>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧E̲丧개л갨òe̲𝐝갂𝐉K̲Лe̲中中e̲сòÀ丧𝐝Ì갨丧中両ò>} );
ok(!( "\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/^<-:InEnclosedCJKLettersAndMonths>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧E̲丧개л갨òe̲𝐝갂𝐉K̲Лe̲中中e̲сòÀ丧𝐝Ì갨丧中両ò>} );
ok(!( "\x[5B44]"  ~~ m/^<:InEnclosedCJKLettersAndMonths>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧E̲丧개л갨òe̲𝐝갂𝐉K̲Лe̲中中e̲сòÀ丧𝐝Ì갨丧中両ò>} );
ok("\x[5B44]"  ~~ m/^<:!InEnclosedCJKLettersAndMonths>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧E̲丧개л갨òe̲𝐝갂𝐉K̲Лe̲中中e̲сòÀ丧𝐝Ì갨丧中両ò>} );
ok("\x[5B44]"  ~~ m/^<-:InEnclosedCJKLettersAndMonths>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧E̲丧개л갨òe̲𝐝갂𝐉K̲Лe̲中中e̲сòÀ丧𝐝Ì갨丧中両ò>} );
ok("\x[5B44]\c[PARENTHESIZED HANGUL KIYEOK]" ~~ m/<:InEnclosedCJKLettersAndMonths>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧E̲丧개л갨òe̲𝐝갂𝐉K̲Лe̲中中e̲сòÀ丧𝐝Ì갨丧中両ò>} );

# InEthiopic


ok("\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<:InEthiopic>$/, q{Ìà中개両 <:갈丧E̲中両갢갨𝐩갢개>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<:!InEthiopic>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧E̲中両갢갨𝐩갢개>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<-:InEthiopic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧E̲中両갢갨𝐩갢개>} );
ok(!( "\x[BBAE]"  ~~ m/^<:InEthiopic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧E̲中両갢갨𝐩갢개>} );
ok("\x[BBAE]"  ~~ m/^<:!InEthiopic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧E̲中両갢갨𝐩갢개>} );
ok("\x[BBAE]"  ~~ m/^<-:InEthiopic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧E̲中両갢갨𝐩갢개>} );
ok("\x[BBAE]\c[ETHIOPIC SYLLABLE HA]" ~~ m/<:InEthiopic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧E̲中両갢갨𝐩갢개>} );

# InGeneralPunctuation


ok("\c[EN QUAD]" ~~ m/^<:InGeneralPunctuation>$/, q{Ìà中개両 <:갈丧Æe̲丧e̲сàл𝐏갮丧개中갮à中갢갨丧>} );
ok(!( "\c[EN QUAD]" ~~ m/^<:!InGeneralPunctuation>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Æe̲丧e̲сàл𝐏갮丧개中갮à中갢갨丧>} );
ok(!( "\c[EN QUAD]" ~~ m/^<-:InGeneralPunctuation>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Æe̲丧e̲сàл𝐏갮丧개中갮à中갢갨丧>} );
ok(!( "\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<:InGeneralPunctuation>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Æe̲丧e̲сàл𝐏갮丧개中갮à中갢갨丧>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<:!InGeneralPunctuation>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Æe̲丧e̲сàл𝐏갮丧개中갮à中갢갨丧>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]"  ~~ m/^<-:InGeneralPunctuation>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Æe̲丧e̲сàл𝐏갮丧개中갮à中갢갨丧>} );
ok("\c[MEDIUM RIGHT PARENTHESIS ORNAMENT]\c[EN QUAD]" ~~ m/<:InGeneralPunctuation>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Æe̲丧e̲сàл𝐏갮丧개中갮à中갢갨丧>} );

# InGeometricShapes


ok("\c[BLACK SQUARE]" ~~ m/^<:InGeometricShapes>$/, q{Ìà中개両 <:갈丧Æe̲갨ìe̲中с갢개Ò両à𝐩e̲ò>} );
ok(!( "\c[BLACK SQUARE]" ~~ m/^<:!InGeometricShapes>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Æe̲갨ìe̲中с갢개Ò両à𝐩e̲ò>} );
ok(!( "\c[BLACK SQUARE]" ~~ m/^<-:InGeometricShapes>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Æe̲갨ìe̲中с갢개Ò両à𝐩e̲ò>} );
ok(!( "\x[B700]"  ~~ m/^<:InGeometricShapes>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Æe̲갨ìe̲中с갢개Ò両à𝐩e̲ò>} );
ok("\x[B700]"  ~~ m/^<:!InGeometricShapes>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Æe̲갨ìe̲中с갢개Ò両à𝐩e̲ò>} );
ok("\x[B700]"  ~~ m/^<-:InGeometricShapes>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Æe̲갨ìe̲中с갢개Ò両à𝐩e̲ò>} );
ok("\x[B700]\c[BLACK SQUARE]" ~~ m/<:InGeometricShapes>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Æe̲갨ìe̲中с갢개Ò両à𝐩e̲ò>} );


# InGeorgian


ok("\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<:InGeorgian>$/, q{Ìà中개両 <:갈丧Æe̲갨сæ갢à丧>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<:!InGeorgian>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Æe̲갨сæ갢à丧>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<-:InGeorgian>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Æe̲갨сæ갢à丧>} );
ok(!( "\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<:InGeorgian>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Æe̲갨сæ갢à丧>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<:!InGeorgian>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Æe̲갨сæ갢à丧>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]"  ~~ m/^<-:InGeorgian>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Æe̲갨сæ갢à丧>} );
ok("\c[IDEOGRAPHIC TELEGRAPH SYMBOL FOR HOUR ONE]\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/<:InGeorgian>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Æe̲갨сæ갢à丧>} );

# InGothic


ok(!( "\x[4825]"  ~~ m/^<:InGothic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Æ갨中両갢개>} );
ok("\x[4825]"  ~~ m/^<:!InGothic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Æ갨中両갢개>} );
ok("\x[4825]"  ~~ m/^<-:InGothic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Æ갨中両갢개>} );

# InGreekExtended


ok("\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<:InGreekExtended>$/, q{Ìà中개両 <:갈丧Æсe̲e̲k̲E̲ч中e̲丧𝐝e̲𝐝>} );
ok(!( "\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<:!InGreekExtended>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Æсe̲e̲k̲E̲ч中e̲丧𝐝e̲𝐝>} );
ok(!( "\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/^<-:InGreekExtended>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Æсe̲e̲k̲E̲ч中e̲丧𝐝e̲𝐝>} );
ok(!( "\x[B9B7]"  ~~ m/^<:InGreekExtended>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Æсe̲e̲k̲E̲ч中e̲丧𝐝e̲𝐝>} );
ok("\x[B9B7]"  ~~ m/^<:!InGreekExtended>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Æсe̲e̲k̲E̲ч中e̲丧𝐝e̲𝐝>} );
ok("\x[B9B7]"  ~~ m/^<-:InGreekExtended>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Æсe̲e̲k̲E̲ч中e̲丧𝐝e̲𝐝>} );
ok("\x[B9B7]\c[GREEK SMALL LETTER ALPHA WITH PSILI]" ~~ m/<:InGreekExtended>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Æсe̲e̲k̲E̲ч中e̲丧𝐝e̲𝐝>} );

# InGreekAndCoptic


ok("\x[0370]" ~~ m/^<:InGreekAndCoptic>$/, q{Ìà中개両 <:갈丧Æсe̲e̲k̲À丧𝐝갂갨𝐩中갢개>} );
ok(!( "\x[0370]" ~~ m/^<:!InGreekAndCoptic>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Æсe̲e̲k̲À丧𝐝갂갨𝐩中갢개>} );
ok(!( "\x[0370]" ~~ m/^<-:InGreekAndCoptic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Æсe̲e̲k̲À丧𝐝갂갨𝐩中갢개>} );
ok(!( "\x[7197]"  ~~ m/^<:InGreekAndCoptic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Æсe̲e̲k̲À丧𝐝갂갨𝐩中갢개>} );
ok("\x[7197]"  ~~ m/^<:!InGreekAndCoptic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Æсe̲e̲k̲À丧𝐝갂갨𝐩中갢개>} );
ok("\x[7197]"  ~~ m/^<-:InGreekAndCoptic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Æсe̲e̲k̲À丧𝐝갂갨𝐩中갢개>} );
ok("\x[7197]\x[0370]" ~~ m/<:InGreekAndCoptic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Æсe̲e̲k̲À丧𝐝갂갨𝐩中갢개>} );

# InGujarati


ok("\x[0A80]" ~~ m/^<:InGujarati>$/, q{Ìà中개両 <:갈丧Æ갮𝐣àсà中갢>} );
ok(!( "\x[0A80]" ~~ m/^<:!InGujarati>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Æ갮𝐣àсà中갢>} );
ok(!( "\x[0A80]" ~~ m/^<-:InGujarati>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Æ갮𝐣àсà中갢>} );
ok(!( "\x[3B63]"  ~~ m/^<:InGujarati>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Æ갮𝐣àсà中갢>} );
ok("\x[3B63]"  ~~ m/^<:!InGujarati>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Æ갮𝐣àсà中갢>} );
ok("\x[3B63]"  ~~ m/^<-:InGujarati>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Æ갮𝐣àсà中갢>} );
ok("\x[3B63]\x[0A80]" ~~ m/<:InGujarati>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Æ갮𝐣àсà中갢>} );

# InGurmukhi


ok("\x[0A00]" ~~ m/^<:InGurmukhi>$/, q{Ìà中개両 <:갈丧Æ갮сì갮k̲両갢>} );
ok(!( "\x[0A00]" ~~ m/^<:!InGurmukhi>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Æ갮сì갮k̲両갢>} );
ok(!( "\x[0A00]" ~~ m/^<-:InGurmukhi>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Æ갮сì갮k̲両갢>} );
ok(!( "\x[10C8]"  ~~ m/^<:InGurmukhi>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Æ갮сì갮k̲両갢>} );
ok("\x[10C8]"  ~~ m/^<:!InGurmukhi>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Æ갮сì갮k̲両갢>} );
ok("\x[10C8]"  ~~ m/^<-:InGurmukhi>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Æ갮сì갮k̲両갢>} );
ok("\x[10C8]\x[0A00]" ~~ m/<:InGurmukhi>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Æ갮сì갮k̲両갢>} );

# InHalfwidthAndFullwidthForms


ok(!( "\x[CA55]"  ~~ m/^<:InHalfwidthAndFullwidthForms>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧万àлеw̲갢𝐝中両À丧𝐝Е갮ллw̲갢𝐝中両Е갨сìò>} );
ok("\x[CA55]"  ~~ m/^<:!InHalfwidthAndFullwidthForms>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧万àлеw̲갢𝐝中両À丧𝐝Е갮ллw̲갢𝐝中両Е갨сìò>} );
ok("\x[CA55]"  ~~ m/^<-:InHalfwidthAndFullwidthForms>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧万àлеw̲갢𝐝中両À丧𝐝Е갮ллw̲갢𝐝中両Е갨сìò>} );

# InHangulCompatibilityJamo


ok("\x[3130]" ~~ m/^<:InHangulCompatibilityJamo>$/, q{Ìà中개両 <:갈丧万à丧æ갮л갂갨ì𝐩à中갢丛갢л갢中ù𝐉àì갨>} );
ok(!( "\x[3130]" ~~ m/^<:!InHangulCompatibilityJamo>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧万à丧æ갮л갂갨ì𝐩à中갢丛갢л갢中ù𝐉àì갨>} );
ok(!( "\x[3130]" ~~ m/^<-:InHangulCompatibilityJamo>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧万à丧æ갮л갂갨ì𝐩à中갢丛갢л갢中ù𝐉àì갨>} );
ok(!( "\c[MEASURED BY]"  ~~ m/^<:InHangulCompatibilityJamo>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧万à丧æ갮л갂갨ì𝐩à中갢丛갢л갢中ù𝐉àì갨>} );
ok("\c[MEASURED BY]"  ~~ m/^<:!InHangulCompatibilityJamo>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧万à丧æ갮л갂갨ì𝐩à中갢丛갢л갢中ù𝐉àì갨>} );
ok("\c[MEASURED BY]"  ~~ m/^<-:InHangulCompatibilityJamo>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧万à丧æ갮л갂갨ì𝐩à中갢丛갢л갢中ù𝐉àì갨>} );
ok("\c[MEASURED BY]\x[3130]" ~~ m/<:InHangulCompatibilityJamo>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧万à丧æ갮л갂갨ì𝐩à中갢丛갢л갢中ù𝐉àì갨>} );

# InHangulJamo


ok("\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<:InHangulJamo>$/, q{Ìà中개両 <:갈丧万à丧æ갮л𝐉àì갨>} );
ok(!( "\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<:!InHangulJamo>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧万à丧æ갮л𝐉àì갨>} );
ok(!( "\c[HANGUL CHOSEONG KIYEOK]" ~~ m/^<-:InHangulJamo>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧万à丧æ갮л𝐉àì갨>} );
ok(!( "\x[3B72]"  ~~ m/^<:InHangulJamo>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧万à丧æ갮л𝐉àì갨>} );
ok("\x[3B72]"  ~~ m/^<:!InHangulJamo>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧万à丧æ갮л𝐉àì갨>} );
ok("\x[3B72]"  ~~ m/^<-:InHangulJamo>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧万à丧æ갮л𝐉àì갨>} );
ok("\x[3B72]\c[HANGUL CHOSEONG KIYEOK]" ~~ m/<:InHangulJamo>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧万à丧æ갮л𝐉àì갨>} );

# InHangulSyllables


ok("\x[CD95]" ~~ m/^<:InHangulSyllables>$/, q{Ìà中개両 <:갈丧万à丧æ갮лÒùллà丛лe̲ò>} );
ok(!( "\x[CD95]" ~~ m/^<:!InHangulSyllables>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧万à丧æ갮лÒùллà丛лe̲ò>} );
ok(!( "\x[CD95]" ~~ m/^<-:InHangulSyllables>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧万à丧æ갮лÒùллà丛лe̲ò>} );
ok(!( "\x[D7B0]"  ~~ m/^<:InHangulSyllables>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧万à丧æ갮лÒùллà丛лe̲ò>} );
ok("\x[D7B0]"  ~~ m/^<:!InHangulSyllables>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧万à丧æ갮лÒùллà丛лe̲ò>} );
ok("\x[D7B0]"  ~~ m/^<-:InHangulSyllables>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧万à丧æ갮лÒùллà丛лe̲ò>} );
ok("\x[D7B0]\x[CD95]" ~~ m/<:InHangulSyllables>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧万à丧æ갮лÒùллà丛лe̲ò>} );

# InHanunoo


ok("\c[HANUNOO LETTER A]" ~~ m/^<:InHanunoo>$/, q{Ìà中개両 <:갈丧万à丧갮丧갨갨>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<:!InHanunoo>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧万à丧갮丧갨갨>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<-:InHanunoo>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧万à丧갮丧갨갨>} );
ok(!( "\x[6F4F]"  ~~ m/^<:InHanunoo>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧万à丧갮丧갨갨>} );
ok("\x[6F4F]"  ~~ m/^<:!InHanunoo>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧万à丧갮丧갨갨>} );
ok("\x[6F4F]"  ~~ m/^<-:InHanunoo>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧万à丧갮丧갨갨>} );
ok("\x[6F4F]\c[HANUNOO LETTER A]" ~~ m/<:InHanunoo>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧万à丧갮丧갨갨>} );

# InHebrew


ok("\x[0590]" ~~ m/^<:InHebrew>$/, q{Ìà中개両 <:갈丧万e̲丛сe̲w̲>} );
ok(!( "\x[0590]" ~~ m/^<:!InHebrew>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧万e̲丛сe̲w̲>} );
ok(!( "\x[0590]" ~~ m/^<-:InHebrew>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧万e̲丛сe̲w̲>} );
ok(!( "\x[0777]"  ~~ m/^<:InHebrew>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧万e̲丛сe̲w̲>} );
ok("\x[0777]"  ~~ m/^<:!InHebrew>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧万e̲丛сe̲w̲>} );
ok("\x[0777]"  ~~ m/^<-:InHebrew>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧万e̲丛сe̲w̲>} );
ok("\x[0777]\x[0590]" ~~ m/<:InHebrew>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧万e̲丛сe̲w̲>} );

# InHighPrivateUseSurrogates


ok(!( "\x[D04F]"  ~~ m/^<:InHighPrivateUseSurrogates>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧万갢æ両𝐏с갢𝐯à中e̲갔òe̲Ò갮сс갨æà中e̲ò>} );
ok("\x[D04F]"  ~~ m/^<:!InHighPrivateUseSurrogates>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧万갢æ両𝐏с갢𝐯à中e̲갔òe̲Ò갮сс갨æà中e̲ò>} );
ok("\x[D04F]"  ~~ m/^<-:InHighPrivateUseSurrogates>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧万갢æ両𝐏с갢𝐯à中e̲갔òe̲Ò갮сс갨æà中e̲ò>} );

# InHighSurrogates


ok(!( "\x[D085]"  ~~ m/^<:InHighSurrogates>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧万갢æ両Ò갮сс갨æà中e̲ò>} );
ok("\x[D085]"  ~~ m/^<:!InHighSurrogates>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧万갢æ両Ò갮сс갨æà中e̲ò>} );
ok("\x[D085]"  ~~ m/^<-:InHighSurrogates>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧万갢æ両Ò갮сс갨æà中e̲ò>} );

# InHiragana


ok("\x[3040]" ~~ m/^<:InHiragana>$/, q{Ìà中개両 <:갈丧万갢сàæà丧à>} );
ok(!( "\x[3040]" ~~ m/^<:!InHiragana>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧万갢сàæà丧à>} );
ok(!( "\x[3040]" ~~ m/^<-:InHiragana>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧万갢сàæà丧à>} );
ok(!( "\x[AC7C]"  ~~ m/^<:InHiragana>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧万갢сàæà丧à>} );
ok("\x[AC7C]"  ~~ m/^<:!InHiragana>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧万갢сàæà丧à>} );
ok("\x[AC7C]"  ~~ m/^<-:InHiragana>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧万갢сàæà丧à>} );
ok("\x[AC7C]\x[3040]" ~~ m/<:InHiragana>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧万갢сàæà丧à>} );

# InIPAExtensions


ok("\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<:InIPAExtensions>$/, q{Ìà中개両 <:갈丧갈𝐏ÀE̲ч中e̲丧ò갢갨丧ò>} );
ok(!( "\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<:!InIPAExtensions>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갈𝐏ÀE̲ч中e̲丧ò갢갨丧ò>} );
ok(!( "\c[LATIN SMALL LETTER TURNED A]" ~~ m/^<-:InIPAExtensions>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갈𝐏ÀE̲ч中e̲丧ò갢갨丧ò>} );
ok(!( "\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<:InIPAExtensions>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갈𝐏ÀE̲ч中e̲丧ò갢갨丧ò>} );
ok("\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<:!InIPAExtensions>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갈𝐏ÀE̲ч中e̲丧ò갢갨丧ò>} );
ok("\c[HANGUL LETTER SSANGIEUNG]"  ~~ m/^<-:InIPAExtensions>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갈𝐏ÀE̲ч中e̲丧ò갢갨丧ò>} );
ok("\c[HANGUL LETTER SSANGIEUNG]\c[LATIN SMALL LETTER TURNED A]" ~~ m/<:InIPAExtensions>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갈𝐏ÀE̲ч中e̲丧ò갢갨丧ò>} );

# InIdeographicDescriptionCharacters


ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:InIdeographicDescriptionCharacters>$/, q{Ìà中개両 <:갈丧갈𝐝e̲갨æсà𝐩両갢개𝐃e̲ò개с갢𝐩中갢갨丧갂両àсà개中e̲сò>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:!InIdeographicDescriptionCharacters>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갈𝐝e̲갨æсà𝐩両갢개𝐃e̲ò개с갢𝐩中갢갨丧갂両àсà개中e̲сò>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<-:InIdeographicDescriptionCharacters>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갈𝐝e̲갨æсà𝐩両갢개𝐃e̲ò개с갢𝐩中갢갨丧갂両àсà개中e̲сò>} );
ok(!( "\x[9160]"  ~~ m/^<:InIdeographicDescriptionCharacters>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갈𝐝e̲갨æсà𝐩両갢개𝐃e̲ò개с갢𝐩中갢갨丧갂両àсà개中e̲сò>} );
ok("\x[9160]"  ~~ m/^<:!InIdeographicDescriptionCharacters>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갈𝐝e̲갨æсà𝐩両갢개𝐃e̲ò개с갢𝐩中갢갨丧갂両àсà개中e̲сò>} );
ok("\x[9160]"  ~~ m/^<-:InIdeographicDescriptionCharacters>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갈𝐝e̲갨æсà𝐩両갢개𝐃e̲ò개с갢𝐩中갢갨丧갂両àсà개中e̲сò>} );
ok("\x[9160]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/<:InIdeographicDescriptionCharacters>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갈𝐝e̲갨æсà𝐩両갢개𝐃e̲ò개с갢𝐩中갢갨丧갂両àсà개中e̲сò>} );

# InKanbun


ok("\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<:InKanbun>$/, q{Ìà中개両 <:갈丧K̲à丧丛갮丧>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<:!InKanbun>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧K̲à丧丛갮丧>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/^<-:InKanbun>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲à丧丛갮丧>} );
ok(!( "\x[A80C]"  ~~ m/^<:InKanbun>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧K̲à丧丛갮丧>} );
ok("\x[A80C]"  ~~ m/^<:!InKanbun>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧K̲à丧丛갮丧>} );
ok("\x[A80C]"  ~~ m/^<-:InKanbun>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲à丧丛갮丧>} );
ok("\x[A80C]\c[IDEOGRAPHIC ANNOTATION LINKING MARK]" ~~ m/<:InKanbun>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧K̲à丧丛갮丧>} );

# InKangxiRadicals


ok("\c[KANGXI RADICAL ONE]" ~~ m/^<:InKangxiRadicals>$/, q{Ìà中개両 <:갈丧K̲à丧æч갢Сà𝐝갢개àлò>} );
ok(!( "\c[KANGXI RADICAL ONE]" ~~ m/^<:!InKangxiRadicals>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧K̲à丧æч갢Сà𝐝갢개àлò>} );
ok(!( "\c[KANGXI RADICAL ONE]" ~~ m/^<-:InKangxiRadicals>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲à丧æч갢Сà𝐝갢개àлò>} );
ok(!( "\x[891A]"  ~~ m/^<:InKangxiRadicals>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧K̲à丧æч갢Сà𝐝갢개àлò>} );
ok("\x[891A]"  ~~ m/^<:!InKangxiRadicals>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧K̲à丧æч갢Сà𝐝갢개àлò>} );
ok("\x[891A]"  ~~ m/^<-:InKangxiRadicals>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲à丧æч갢Сà𝐝갢개àлò>} );
ok("\x[891A]\c[KANGXI RADICAL ONE]" ~~ m/<:InKangxiRadicals>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧K̲à丧æч갢Сà𝐝갢개àлò>} );

# InKannada


ok("\x[0C80]" ~~ m/^<:InKannada>$/, q{Ìà中개両 <:갈丧K̲à丧丧à𝐝à>} );
ok(!( "\x[0C80]" ~~ m/^<:!InKannada>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧K̲à丧丧à𝐝à>} );
ok(!( "\x[0C80]" ~~ m/^<-:InKannada>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲à丧丧à𝐝à>} );
ok(!( "\x[B614]"  ~~ m/^<:InKannada>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧K̲à丧丧à𝐝à>} );
ok("\x[B614]"  ~~ m/^<:!InKannada>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧K̲à丧丧à𝐝à>} );
ok("\x[B614]"  ~~ m/^<-:InKannada>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲à丧丧à𝐝à>} );
ok("\x[B614]\x[0C80]" ~~ m/<:InKannada>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧K̲à丧丧à𝐝à>} );

# InKatakana


ok("\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<:InKatakana>$/, q{Ìà中개両 <:갈丧K̲à中àk̲à丧à>} );
ok(!( "\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<:!InKatakana>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧K̲à中àk̲à丧à>} );
ok(!( "\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/^<-:InKatakana>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲à中àk̲à丧à>} );
ok(!( "\x[7EB8]"  ~~ m/^<:InKatakana>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧K̲à中àk̲à丧à>} );
ok("\x[7EB8]"  ~~ m/^<:!InKatakana>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧K̲à中àk̲à丧à>} );
ok("\x[7EB8]"  ~~ m/^<-:InKatakana>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲à中àk̲à丧à>} );
ok("\x[7EB8]\c[KATAKANA-HIRAGANA DOUBLE HYPHEN]" ~~ m/<:InKatakana>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧K̲à中àk̲à丧à>} );

# InKatakanaPhoneticExtensions


ok("\c[KATAKANA LETTER SMALL KU]" ~~ m/^<:InKatakanaPhoneticExtensions>$/, q{Ìà中개両 <:갈丧K̲à中àk̲à丧à𝐏両갨丧e̲中갢개E̲ч中e̲丧ò갢갨丧ò>} );
ok(!( "\c[KATAKANA LETTER SMALL KU]" ~~ m/^<:!InKatakanaPhoneticExtensions>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧K̲à中àk̲à丧à𝐏両갨丧e̲中갢개E̲ч中e̲丧ò갢갨丧ò>} );
ok(!( "\c[KATAKANA LETTER SMALL KU]" ~~ m/^<-:InKatakanaPhoneticExtensions>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲à中àk̲à丧à𝐏両갨丧e̲中갢개E̲ч中e̲丧ò갢갨丧ò>} );
ok(!( "\x[97C2]"  ~~ m/^<:InKatakanaPhoneticExtensions>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧K̲à中àk̲à丧à𝐏両갨丧e̲中갢개E̲ч中e̲丧ò갢갨丧ò>} );
ok("\x[97C2]"  ~~ m/^<:!InKatakanaPhoneticExtensions>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧K̲à中àk̲à丧à𝐏両갨丧e̲中갢개E̲ч中e̲丧ò갢갨丧ò>} );
ok("\x[97C2]"  ~~ m/^<-:InKatakanaPhoneticExtensions>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲à中àk̲à丧à𝐏両갨丧e̲中갢개E̲ч中e̲丧ò갢갨丧ò>} );
ok("\x[97C2]\c[KATAKANA LETTER SMALL KU]" ~~ m/<:InKatakanaPhoneticExtensions>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧K̲à中àk̲à丧à𝐏両갨丧e̲中갢개E̲ч中e̲丧ò갢갨丧ò>} );

# InKhmer

ok("\c[KHMER LETTER KA]" ~~ m/^<:InKhmer>$/, q{Ìà中개両 <:갈丧K̲両ìe̲с>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<:!InKhmer>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧K̲両ìe̲с>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<-:InKhmer>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲両ìe̲с>} );
ok(!( "\x[CAFA]"  ~~ m/^<:InKhmer>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧K̲両ìe̲с>} );
ok("\x[CAFA]"  ~~ m/^<:!InKhmer>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧K̲両ìe̲с>} );
ok("\x[CAFA]"  ~~ m/^<-:InKhmer>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧K̲両ìe̲с>} );
ok("\x[CAFA]\c[KHMER LETTER KA]" ~~ m/<:InKhmer>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧K̲両ìe̲с>} );

# InLao


ok("\x[0E80]" ~~ m/^<:InLao>$/, q{Ìà中개両 <:갈丧Лà갨>} );
ok(!( "\x[0E80]" ~~ m/^<:!InLao>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Лà갨>} );
ok(!( "\x[0E80]" ~~ m/^<-:InLao>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Лà갨>} );
ok(!( "\x[07BF]"  ~~ m/^<:InLao>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Лà갨>} );
ok("\x[07BF]"  ~~ m/^<:!InLao>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Лà갨>} );
ok("\x[07BF]"  ~~ m/^<-:InLao>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Лà갨>} );
ok("\x[07BF]\x[0E80]" ~~ m/<:InLao>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Лà갨>} );

# InLatin1Supplement


ok("\x[0080]" ~~ m/^<:InLatin1Supplement>$/, q{Ìà中개両 <:갈丧Лà中갢丧1Ò갮𝐩𝐩лe̲ìe̲丧中>} );
ok(!( "\x[0080]" ~~ m/^<:!InLatin1Supplement>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Лà中갢丧1Ò갮𝐩𝐩лe̲ìe̲丧中>} );
ok(!( "\x[0080]" ~~ m/^<-:InLatin1Supplement>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Лà中갢丧1Ò갮𝐩𝐩лe̲ìe̲丧中>} );
ok(!( "\x[D062]"  ~~ m/^<:InLatin1Supplement>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Лà中갢丧1Ò갮𝐩𝐩лe̲ìe̲丧中>} );
ok("\x[D062]"  ~~ m/^<:!InLatin1Supplement>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Лà中갢丧1Ò갮𝐩𝐩лe̲ìe̲丧中>} );
ok("\x[D062]"  ~~ m/^<-:InLatin1Supplement>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Лà中갢丧1Ò갮𝐩𝐩лe̲ìe̲丧中>} );
ok("\x[D062]\x[0080]" ~~ m/<:InLatin1Supplement>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Лà中갢丧1Ò갮𝐩𝐩лe̲ìe̲丧中>} );

# InLatinExtendedA


ok("\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<:InLatinExtendedA>$/, q{Ìà中개両 <:갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<:!InLatinExtendedA>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/^<-:InLatinExtendedA>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À>} );
ok(!( "\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<:InLatinExtendedA>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<:!InLatinExtendedA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]"  ~~ m/^<-:InLatinExtendedA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À>} );
ok("\c[IDEOGRAPHIC ANNOTATION EARTH MARK]\c[LATIN CAPITAL LETTER A WITH MACRON]" ~~ m/<:InLatinExtendedA>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À>} );

# InLatinExtendedAdditional


ok("\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<:InLatinExtendedAdditional>$/, q{Ìà中개両 <:갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À𝐝𝐝갢中갢갨丧àл>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<:!InLatinExtendedAdditional>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À𝐝𝐝갢中갢갨丧àл>} );
ok(!( "\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/^<-:InLatinExtendedAdditional>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À𝐝𝐝갢中갢갨丧àл>} );
ok(!( "\x[9A44]"  ~~ m/^<:InLatinExtendedAdditional>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À𝐝𝐝갢中갢갨丧àл>} );
ok("\x[9A44]"  ~~ m/^<:!InLatinExtendedAdditional>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À𝐝𝐝갢中갢갨丧àл>} );
ok("\x[9A44]"  ~~ m/^<-:InLatinExtendedAdditional>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À𝐝𝐝갢中갢갨丧àл>} );
ok("\x[9A44]\c[LATIN CAPITAL LETTER A WITH RING BELOW]" ~~ m/<:InLatinExtendedAdditional>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝À𝐝𝐝갢中갢갨丧àл>} );

# InLatinExtendedB


ok("\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<:InLatinExtendedB>$/, q{Ìà中개両 <:갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝丁>} );
ok(!( "\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<:!InLatinExtendedB>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝丁>} );
ok(!( "\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/^<-:InLatinExtendedB>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝丁>} );
ok(!( "\x[7544]"  ~~ m/^<:InLatinExtendedB>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝丁>} );
ok("\x[7544]"  ~~ m/^<:!InLatinExtendedB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝丁>} );
ok("\x[7544]"  ~~ m/^<-:InLatinExtendedB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝丁>} );
ok("\x[7544]\c[LATIN SMALL LETTER B WITH STROKE]" ~~ m/<:InLatinExtendedB>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Лà中갢丧E̲ч中e̲丧𝐝e̲𝐝丁>} );

# InLetterlikeSymbols


ok("\c[ACCOUNT OF]" ~~ m/^<:InLetterlikeSymbols>$/, q{Ìà中개両 <:갈丧Лe̲中中e̲сл갢k̲e̲Òùì丛갨лò>} );
ok(!( "\c[ACCOUNT OF]" ~~ m/^<:!InLetterlikeSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Лe̲中中e̲сл갢k̲e̲Òùì丛갨лò>} );
ok(!( "\c[ACCOUNT OF]" ~~ m/^<-:InLetterlikeSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Лe̲中中e̲сл갢k̲e̲Òùì丛갨лò>} );
ok(!( "\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<:InLetterlikeSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Лe̲中中e̲сл갢k̲e̲Òùì丛갨лò>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<:!InLetterlikeSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Лe̲中中e̲сл갢k̲e̲Òùì丛갨лò>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]"  ~~ m/^<-:InLetterlikeSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Лe̲中中e̲сл갢k̲e̲Òùì丛갨лò>} );
ok("\c[LATIN CAPITAL LETTER X WITH DOT ABOVE]\c[ACCOUNT OF]" ~~ m/<:InLetterlikeSymbols>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Лe̲中中e̲сл갢k̲e̲Òùì丛갨лò>} );

# InLowSurrogates


ok(!( "\x[5ECC]"  ~~ m/^<:InLowSurrogates>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Л갨w̲Ò갮сс갨æà中e̲ò>} );
ok("\x[5ECC]"  ~~ m/^<:!InLowSurrogates>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Л갨w̲Ò갮сс갨æà中e̲ò>} );
ok("\x[5ECC]"  ~~ m/^<-:InLowSurrogates>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Л갨w̲Ò갮сс갨æà中e̲ò>} );

# InMalayalam


ok("\x[0D00]" ~~ m/^<:InMalayalam>$/, q{Ìà中개両 <:갈丧Ìàлàùàлàì>} );
ok(!( "\x[0D00]" ~~ m/^<:!InMalayalam>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ìàлàùàлàì>} );
ok(!( "\x[0D00]" ~~ m/^<-:InMalayalam>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ìàлàùàлàì>} );
ok(!( "\x[3457]"  ~~ m/^<:InMalayalam>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ìàлàùàлàì>} );
ok("\x[3457]"  ~~ m/^<:!InMalayalam>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ìàлàùàлàì>} );
ok("\x[3457]"  ~~ m/^<-:InMalayalam>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ìàлàùàлàì>} );
ok("\x[0D01]\x[0D00]" ~~ m/<:InMalayalam>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ìàлàùàлàì>} );

# InMathematicalAlphanumericSymbols


ok(!( "\x[6B79]"  ~~ m/^<:InMathematicalAlphanumericSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ìà中両e̲ìà中갢개àлÀл𝐩両à丧갮ìe̲с갢개Òùì丛갨лò>} );
ok("\x[6B79]"  ~~ m/^<:!InMathematicalAlphanumericSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ìà中両e̲ìà中갢개àлÀл𝐩両à丧갮ìe̲с갢개Òùì丛갨лò>} );
ok("\x[6B79]"  ~~ m/^<-:InMathematicalAlphanumericSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ìà中両e̲ìà中갢개àлÀл𝐩両à丧갮ìe̲с갢개Òùì丛갨лò>} );

# InMathematicalOperators


ok("\c[FOR ALL]" ~~ m/^<:InMathematicalOperators>$/, q{Ìà中개両 <:갈丧Ìà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok(!( "\c[FOR ALL]" ~~ m/^<:!InMathematicalOperators>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ìà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok(!( "\c[FOR ALL]" ~~ m/^<-:InMathematicalOperators>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ìà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok(!( "\x[BBC6]"  ~~ m/^<:InMathematicalOperators>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ìà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok("\x[BBC6]"  ~~ m/^<:!InMathematicalOperators>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ìà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok("\x[BBC6]"  ~~ m/^<-:InMathematicalOperators>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ìà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok("\x[BBC6]\c[FOR ALL]" ~~ m/<:InMathematicalOperators>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ìà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );

# InMiscellaneousMathematicalSymbolsA


ok("\x[27C0]" ~~ m/^<:InMiscellaneousMathematicalSymbolsA>$/, q{Ìà中개両 <:갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лòÀ>} );
ok(!( "\x[27C0]" ~~ m/^<:!InMiscellaneousMathematicalSymbolsA>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лòÀ>} );
ok(!( "\x[27C0]" ~~ m/^<-:InMiscellaneousMathematicalSymbolsA>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лòÀ>} );
ok(!( "\x[065D]"  ~~ m/^<:InMiscellaneousMathematicalSymbolsA>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лòÀ>} );
ok("\x[065D]"  ~~ m/^<:!InMiscellaneousMathematicalSymbolsA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лòÀ>} );
ok("\x[065D]"  ~~ m/^<-:InMiscellaneousMathematicalSymbolsA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лòÀ>} );
ok("\x[065D]\x[27C0]" ~~ m/<:InMiscellaneousMathematicalSymbolsA>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лòÀ>} );

# InMiscellaneousMathematicalSymbolsB


ok("\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<:InMiscellaneousMathematicalSymbolsB>$/, q{Ìà中개両 <:갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лò丁>} );
ok(!( "\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<:!InMiscellaneousMathematicalSymbolsB>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лò丁>} );
ok(!( "\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/^<-:InMiscellaneousMathematicalSymbolsB>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лò丁>} );
ok(!( "\x[56A6]"  ~~ m/^<:InMiscellaneousMathematicalSymbolsB>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лò丁>} );
ok("\x[56A6]"  ~~ m/^<:!InMiscellaneousMathematicalSymbolsB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лò丁>} );
ok("\x[56A6]"  ~~ m/^<-:InMiscellaneousMathematicalSymbolsB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лò丁>} );
ok("\x[56A6]\c[TRIPLE VERTICAL BAR DELIMITER]" ~~ m/<:InMiscellaneousMathematicalSymbolsB>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÌà中両e̲ìà中갢개àлÒùì丛갨лò丁>} );

# InMiscellaneousSymbols


ok("\c[BLACK SUN WITH RAYS]" ~~ m/^<:InMiscellaneousSymbols>$/, q{Ìà中개両 <:갈丧Ì갢ò개e̲ллà丧e̲갨갮òÒùì丛갨лò>} );
ok(!( "\c[BLACK SUN WITH RAYS]" ~~ m/^<:!InMiscellaneousSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÒùì丛갨лò>} );
ok(!( "\c[BLACK SUN WITH RAYS]" ~~ m/^<-:InMiscellaneousSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÒùì丛갨лò>} );
ok(!( "\x[3EE7]"  ~~ m/^<:InMiscellaneousSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÒùì丛갨лò>} );
ok("\x[3EE7]"  ~~ m/^<:!InMiscellaneousSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÒùì丛갨лò>} );
ok("\x[3EE7]"  ~~ m/^<-:InMiscellaneousSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÒùì丛갨лò>} );
ok("\x[3EE7]\c[BLACK SUN WITH RAYS]" ~~ m/<:InMiscellaneousSymbols>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮òÒùì丛갨лò>} );

# InMiscellaneousTechnical


ok("\c[DIAMETER SIGN]" ~~ m/^<:InMiscellaneousTechnical>$/, q{Ìà中개両 <:갈丧Ì갢ò개e̲ллà丧e̲갨갮ò专e̲개両丧갢개àл>} );
ok(!( "\c[DIAMETER SIGN]" ~~ m/^<:!InMiscellaneousTechnical>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮ò专e̲개両丧갢개àл>} );
ok(!( "\c[DIAMETER SIGN]" ~~ m/^<-:InMiscellaneousTechnical>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮ò专e̲개両丧갢개àл>} );
ok(!( "\x[2EFC]"  ~~ m/^<:InMiscellaneousTechnical>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮ò专e̲개両丧갢개àл>} );
ok("\x[2EFC]"  ~~ m/^<:!InMiscellaneousTechnical>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮ò专e̲개両丧갢개àл>} );
ok("\x[2EFC]"  ~~ m/^<-:InMiscellaneousTechnical>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮ò专e̲개両丧갢개àл>} );
ok("\x[2EFC]\c[DIAMETER SIGN]" ~~ m/<:InMiscellaneousTechnical>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ì갢ò개e̲ллà丧e̲갨갮ò专e̲개両丧갢개àл>} );

# InMongolian


ok("\c[MONGOLIAN BIRGA]" ~~ m/^<:InMongolian>$/, q{Ìà中개両 <:갈丧Ì갨丧æ갨л갢à丧>} );
ok(!( "\c[MONGOLIAN BIRGA]" ~~ m/^<:!InMongolian>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ì갨丧æ갨л갢à丧>} );
ok(!( "\c[MONGOLIAN BIRGA]" ~~ m/^<-:InMongolian>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ì갨丧æ갨л갢à丧>} );
ok(!( "\x[AFB4]"  ~~ m/^<:InMongolian>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ì갨丧æ갨л갢à丧>} );
ok("\x[AFB4]"  ~~ m/^<:!InMongolian>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ì갨丧æ갨л갢à丧>} );
ok("\x[AFB4]"  ~~ m/^<-:InMongolian>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ì갨丧æ갨л갢à丧>} );
ok("\x[AFB4]\c[MONGOLIAN BIRGA]" ~~ m/<:InMongolian>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ì갨丧æ갨л갢à丧>} );

# InMusicalSymbols


ok(!( "\x[0CE4]"  ~~ m/^<:InMusicalSymbols>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ì갮ò갢개àлÒùì丛갨лò>} );
ok("\x[0CE4]"  ~~ m/^<:!InMusicalSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ì갮ò갢개àлÒùì丛갨лò>} );
ok("\x[0CE4]"  ~~ m/^<-:InMusicalSymbols>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ì갮ò갢개àлÒùì丛갨лò>} );

# InMyanmar


ok("\c[MYANMAR LETTER KA]" ~~ m/^<:InMyanmar>$/, q{Ìà中개両 <:갈丧Ìùà丧ìàс>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<:!InMyanmar>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ìùà丧ìàс>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<-:InMyanmar>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ìùà丧ìàс>} );
ok(!( "\x[1DDB]"  ~~ m/^<:InMyanmar>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ìùà丧ìàс>} );
ok("\x[1DDB]"  ~~ m/^<:!InMyanmar>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ìùà丧ìàс>} );
ok("\x[1DDB]"  ~~ m/^<-:InMyanmar>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ìùà丧ìàс>} );
ok("\x[1DDB]\c[MYANMAR LETTER KA]" ~~ m/<:InMyanmar>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ìùà丧ìàс>} );

# InNumberForms

ok("\x[2150]" ~~ m/^<:InNumberForms>$/, q{Ìà中개両 <:갈丧不갮ì丛e̲сЕ갨сìò>} );
ok(!( "\x[2150]" ~~ m/^<:!InNumberForms>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧不갮ì丛e̲сЕ갨сìò>} );
ok(!( "\x[2150]" ~~ m/^<-:InNumberForms>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧不갮ì丛e̲сЕ갨сìò>} );
ok(!( "\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<:InNumberForms>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧不갮ì丛e̲сЕ갨сìò>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<:!InNumberForms>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧不갮ì丛e̲сЕ갨сìò>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]"  ~~ m/^<-:InNumberForms>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧不갮ì丛e̲сЕ갨сìò>} );
ok("\c[BLACK RIGHT-POINTING SMALL TRIANGLE]\x[2150]" ~~ m/<:InNumberForms>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧不갮ì丛e̲сЕ갨сìò>} );

# InOgham


ok("\c[OGHAM SPACE MARK]" ~~ m/^<:InOgham>$/, q{Ìà中개両 <:갈丧갎æ両àì>} );
ok(!( "\c[OGHAM SPACE MARK]" ~~ m/^<:!InOgham>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갎æ両àì>} );
ok(!( "\c[OGHAM SPACE MARK]" ~~ m/^<-:InOgham>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갎æ両àì>} );
ok(!( "\x[768C]"  ~~ m/^<:InOgham>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갎æ両àì>} );
ok("\x[768C]"  ~~ m/^<:!InOgham>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갎æ両àì>} );
ok("\x[768C]"  ~~ m/^<-:InOgham>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갎æ両àì>} );
ok("\x[768C]\c[OGHAM SPACE MARK]" ~~ m/<:InOgham>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갎æ両àì>} );

# InOldItalic


ok(!( "\x[C597]"  ~~ m/^<:InOldItalic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갎л𝐝갈中àл갢개>} );
ok("\x[C597]"  ~~ m/^<:!InOldItalic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갎л𝐝갈中àл갢개>} );
ok("\x[C597]"  ~~ m/^<-:InOldItalic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갎л𝐝갈中àл갢개>} );

# InOpticalCharacterRecognition


ok("\c[OCR HOOK]" ~~ m/^<:InOpticalCharacterRecognition>$/, q{Ìà中개両 <:갈丧갎𝐩中갢개àл갂両àсà개中e̲сСe̲개갨æ丧갢中갢갨丧>} );
ok(!( "\c[OCR HOOK]" ~~ m/^<:!InOpticalCharacterRecognition>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갎𝐩中갢개àл갂両àсà개中e̲сСe̲개갨æ丧갢中갢갨丧>} );
ok(!( "\c[OCR HOOK]" ~~ m/^<-:InOpticalCharacterRecognition>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갎𝐩中갢개àл갂両àсà개中e̲сСe̲개갨æ丧갢中갢갨丧>} );
ok(!( "\x[BE80]"  ~~ m/^<:InOpticalCharacterRecognition>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갎𝐩中갢개àл갂両àсà개中e̲сСe̲개갨æ丧갢中갢갨丧>} );
ok("\x[BE80]"  ~~ m/^<:!InOpticalCharacterRecognition>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갎𝐩中갢개àл갂両àсà개中e̲сСe̲개갨æ丧갢中갢갨丧>} );
ok("\x[BE80]"  ~~ m/^<-:InOpticalCharacterRecognition>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갎𝐩中갢개àл갂両àсà개中e̲сСe̲개갨æ丧갢中갢갨丧>} );
ok("\x[BE80]\c[OCR HOOK]" ~~ m/<:InOpticalCharacterRecognition>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갎𝐩中갢개àл갂両àсà개中e̲сСe̲개갨æ丧갢中갢갨丧>} );

# InOriya


ok("\x[0B00]" ~~ m/^<:InOriya>$/, q{Ìà中개両 <:갈丧갎с갢ùà>} );
ok(!( "\x[0B00]" ~~ m/^<:!InOriya>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갎с갢ùà>} );
ok(!( "\x[0B00]" ~~ m/^<-:InOriya>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갎с갢ùà>} );
ok(!( "\c[YI SYLLABLE GGEX]"  ~~ m/^<:InOriya>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갎с갢ùà>} );
ok("\c[YI SYLLABLE GGEX]"  ~~ m/^<:!InOriya>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갎с갢ùà>} );
ok("\c[YI SYLLABLE GGEX]"  ~~ m/^<-:InOriya>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갎с갢ùà>} );
ok("\c[YI SYLLABLE GGEX]\x[0B00]" ~~ m/<:InOriya>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갎с갢ùà>} );

# InPrivateUseArea


ok(!( "\x[B6B1]"  ~~ m/^<:InPrivateUseArea>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧𝐏с갢𝐯à中e̲갔òe̲Àсe̲à>} );
ok("\x[B6B1]"  ~~ m/^<:!InPrivateUseArea>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧𝐏с갢𝐯à中e̲갔òe̲Àсe̲à>} );
ok("\x[B6B1]"  ~~ m/^<-:InPrivateUseArea>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧𝐏с갢𝐯à中e̲갔òe̲Àсe̲à>} );

# InRunic


ok("\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<:InRunic>$/, q{Ìà中개両 <:갈丧С갮丧갢개>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<:!InRunic>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧С갮丧갢개>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<-:InRunic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧С갮丧갢개>} );
ok(!( "\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<:InRunic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧С갮丧갢개>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<:!InRunic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧С갮丧갢개>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]"  ~~ m/^<-:InRunic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧С갮丧갢개>} );
ok("\c[SINHALA LETTER MAHAAPRAANA KAYANNA]\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/<:InRunic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧С갮丧갢개>} );

# InSinhala


ok("\x[0D80]" ~~ m/^<:InSinhala>$/, q{Ìà中개両 <:갈丧Ò갢丧両àлà>} );
ok(!( "\x[0D80]" ~~ m/^<:!InSinhala>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ò갢丧両àлà>} );
ok(!( "\x[0D80]" ~~ m/^<-:InSinhala>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갢丧両àлà>} );
ok(!( "\x[1060]"  ~~ m/^<:InSinhala>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ò갢丧両àлà>} );
ok("\x[1060]"  ~~ m/^<:!InSinhala>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ò갢丧両àлà>} );
ok("\x[1060]"  ~~ m/^<-:InSinhala>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갢丧両àлà>} );
ok("\x[1060]\x[0D80]" ~~ m/<:InSinhala>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ò갢丧両àлà>} );

# InSmallFormVariants


ok(!( "\x[5285]"  ~~ m/^<:InSmallFormVariants>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧ÒìàллЕ갨сì𝐕àс갢à丧中ò>} );
ok("\x[5285]"  ~~ m/^<:!InSmallFormVariants>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧ÒìàллЕ갨сì𝐕àс갢à丧中ò>} );
ok("\x[5285]"  ~~ m/^<-:InSmallFormVariants>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧ÒìàллЕ갨сì𝐕àс갢à丧中ò>} );

# InSpacingModifierLetters


ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<:InSpacingModifierLetters>$/, q{Ìà中개両 <:갈丧Ò𝐩à개갢丧æÌ갨𝐝갢е갢e̲сЛe̲中中e̲сò>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<:!InSpacingModifierLetters>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ò𝐩à개갢丧æÌ갨𝐝갢е갢e̲сЛe̲中中e̲сò>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-:InSpacingModifierLetters>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò𝐩à개갢丧æÌ갨𝐝갢е갢e̲сЛe̲中中e̲сò>} );
ok(!( "\x[5326]"  ~~ m/^<:InSpacingModifierLetters>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ò𝐩à개갢丧æÌ갨𝐝갢е갢e̲сЛe̲中中e̲сò>} );
ok("\x[5326]"  ~~ m/^<:!InSpacingModifierLetters>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ò𝐩à개갢丧æÌ갨𝐝갢е갢e̲сЛe̲中中e̲сò>} );
ok("\x[5326]"  ~~ m/^<-:InSpacingModifierLetters>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò𝐩à개갢丧æÌ갨𝐝갢е갢e̲сЛe̲中中e̲сò>} );
ok("\x[5326]\c[MODIFIER LETTER SMALL H]" ~~ m/<:InSpacingModifierLetters>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ò𝐩à개갢丧æÌ갨𝐝갢е갢e̲сЛe̲中中e̲сò>} );

# InSpecials


ok(!( "\x[3DF1]"  ~~ m/^<:InSpecials>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ò𝐩e̲개갢àлò>} );
ok("\x[3DF1]"  ~~ m/^<:!InSpecials>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ò𝐩e̲개갢àлò>} );
ok("\x[3DF1]"  ~~ m/^<-:InSpecials>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò𝐩e̲개갢àлò>} );

# InSuperscriptsAndSubscripts


ok("\c[SUPERSCRIPT ZERO]" ~~ m/^<:InSuperscriptsAndSubscripts>$/, q{Ìà中개両 <:갈丧Ò갮𝐩e̲сò개с갢𝐩中òÀ丧𝐝Ò갮丛ò개с갢𝐩中ò>} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<:!InSuperscriptsAndSubscripts>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ò갮𝐩e̲сò개с갢𝐩中òÀ丧𝐝Ò갮丛ò개с갢𝐩中ò>} );
ok(!( "\c[SUPERSCRIPT ZERO]" ~~ m/^<-:InSuperscriptsAndSubscripts>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갮𝐩e̲сò개с갢𝐩中òÀ丧𝐝Ò갮丛ò개с갢𝐩中ò>} );
ok(!( "\x[3E71]"  ~~ m/^<:InSuperscriptsAndSubscripts>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ò갮𝐩e̲сò개с갢𝐩中òÀ丧𝐝Ò갮丛ò개с갢𝐩中ò>} );
ok("\x[3E71]"  ~~ m/^<:!InSuperscriptsAndSubscripts>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ò갮𝐩e̲сò개с갢𝐩中òÀ丧𝐝Ò갮丛ò개с갢𝐩中ò>} );
ok("\x[3E71]"  ~~ m/^<-:InSuperscriptsAndSubscripts>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갮𝐩e̲сò개с갢𝐩中òÀ丧𝐝Ò갮丛ò개с갢𝐩中ò>} );
ok("\x[3E71]\c[SUPERSCRIPT ZERO]" ~~ m/<:InSuperscriptsAndSubscripts>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ò갮𝐩e̲сò개с갢𝐩中òÀ丧𝐝Ò갮丛ò개с갢𝐩中ò>} );

# InSupplementalArrowsA


ok("\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<:InSupplementalArrowsA>$/, q{Ìà中개両 <:갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲òÀ>} );
ok(!( "\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<:!InSupplementalArrowsA>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲òÀ>} );
ok(!( "\c[UPWARDS QUADRUPLE ARROW]" ~~ m/^<-:InSupplementalArrowsA>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲òÀ>} );
ok(!( "\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<:InSupplementalArrowsA>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲òÀ>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<:!InSupplementalArrowsA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲òÀ>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]"  ~~ m/^<-:InSupplementalArrowsA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲òÀ>} );
ok("\c[GREEK SMALL LETTER OMICRON WITH TONOS]\c[UPWARDS QUADRUPLE ARROW]" ~~ m/<:InSupplementalArrowsA>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲òÀ>} );

# InSupplementalArrowsB


ok("\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<:InSupplementalArrowsB>$/, q{Ìà中개両 <:갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲ò丁>} );
ok(!( "\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<:!InSupplementalArrowsB>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲ò丁>} );
ok(!( "\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/^<-:InSupplementalArrowsB>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲ò丁>} );
ok(!( "\x[C1A9]"  ~~ m/^<:InSupplementalArrowsB>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲ò丁>} );
ok("\x[C1A9]"  ~~ m/^<:!InSupplementalArrowsB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲ò丁>} );
ok("\x[C1A9]"  ~~ m/^<-:InSupplementalArrowsB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲ò丁>} );
ok("\x[C1A9]\c[RIGHTWARDS TWO-HEADED ARROW WITH VERTICAL STROKE]" ~~ m/<:InSupplementalArrowsB>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÀсс갨w̲ò丁>} );

# InSupplementalMathematicalOperators


ok("\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<:InSupplementalMathematicalOperators>$/, q{Ìà中개両 <:갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÌà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok(!( "\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<:!InSupplementalMathematicalOperators>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÌà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok(!( "\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/^<-:InSupplementalMathematicalOperators>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÌà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok(!( "\x[9EBD]"  ~~ m/^<:InSupplementalMathematicalOperators>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÌà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok("\x[9EBD]"  ~~ m/^<:!InSupplementalMathematicalOperators>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÌà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok("\x[9EBD]"  ~~ m/^<-:InSupplementalMathematicalOperators>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÌà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );
ok("\x[9EBD]\c[N-ARY CIRCLED DOT OPERATOR]" ~~ m/<:InSupplementalMathematicalOperators>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àлÌà中両e̲ìà中갢개àл갎𝐩e̲сà中갨сò>} );

# InSupplementaryPrivateUseAreaA


ok(!( "\x[07E3]"  ~~ m/^<:InSupplementaryPrivateUseAreaA>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àсù𝐏с갢𝐯à中e̲갔òe̲Àсe̲àÀ>} );
ok("\x[07E3]"  ~~ m/^<:!InSupplementaryPrivateUseAreaA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àсù𝐏с갢𝐯à中e̲갔òe̲Àсe̲àÀ>} );
ok("\x[07E3]"  ~~ m/^<-:InSupplementaryPrivateUseAreaA>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àсù𝐏с갢𝐯à中e̲갔òe̲Àсe̲àÀ>} );

# InSupplementaryPrivateUseAreaB


ok(!( "\x[4C48]"  ~~ m/^<:InSupplementaryPrivateUseAreaB>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àсù𝐏с갢𝐯à中e̲갔òe̲Àсe̲à丁>} );
ok("\x[4C48]"  ~~ m/^<:!InSupplementaryPrivateUseAreaB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àсù𝐏с갢𝐯à中e̲갔òe̲Àсe̲à丁>} );
ok("\x[4C48]"  ~~ m/^<-:InSupplementaryPrivateUseAreaB>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ò갮𝐩𝐩лe̲ìe̲丧中àсù𝐏с갢𝐯à中e̲갔òe̲Àсe̲à丁>} );

# InSyriac


ok("\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<:InSyriac>$/, q{Ìà中개両 <:갈丧Òùс갢à개>} );
ok(!( "\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<:!InSyriac>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Òùс갢à개>} );
ok(!( "\c[SYRIAC END OF PARAGRAPH]" ~~ m/^<-:InSyriac>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Òùс갢à개>} );
ok(!( "\c[YI SYLLABLE NZIEP]"  ~~ m/^<:InSyriac>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Òùс갢à개>} );
ok("\c[YI SYLLABLE NZIEP]"  ~~ m/^<:!InSyriac>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Òùс갢à개>} );
ok("\c[YI SYLLABLE NZIEP]"  ~~ m/^<-:InSyriac>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Òùс갢à개>} );
ok("\c[YI SYLLABLE NZIEP]\c[SYRIAC END OF PARAGRAPH]" ~~ m/<:InSyriac>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Òùс갢à개>} );

# InTagalog


ok("\c[TAGALOG LETTER A]" ~~ m/^<:InTagalog>$/, q{Ìà中개両 <:갈丧专àæàл갨æ>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<:!InTagalog>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧专àæàл갨æ>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<-:InTagalog>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧专àæàл갨æ>} );
ok(!( "\c[GEORGIAN LETTER BAN]"  ~~ m/^<:InTagalog>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧专àæàл갨æ>} );
ok("\c[GEORGIAN LETTER BAN]"  ~~ m/^<:!InTagalog>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧专àæàл갨æ>} );
ok("\c[GEORGIAN LETTER BAN]"  ~~ m/^<-:InTagalog>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧专àæàл갨æ>} );
ok("\c[GEORGIAN LETTER BAN]\c[TAGALOG LETTER A]" ~~ m/<:InTagalog>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧专àæàл갨æ>} );

# InTagbanwa


ok("\c[TAGBANWA LETTER A]" ~~ m/^<:InTagbanwa>$/, q{Ìà中개両 <:갈丧专àæ丛à丧w̲à>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<:!InTagbanwa>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧专àæ丛à丧w̲à>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<-:InTagbanwa>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧专àæ丛à丧w̲à>} );
ok(!( "\x[5776]"  ~~ m/^<:InTagbanwa>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧专àæ丛à丧w̲à>} );
ok("\x[5776]"  ~~ m/^<:!InTagbanwa>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧专àæ丛à丧w̲à>} );
ok("\x[5776]"  ~~ m/^<-:InTagbanwa>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧专àæ丛à丧w̲à>} );
ok("\x[5776]\c[TAGBANWA LETTER A]" ~~ m/<:InTagbanwa>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧专àæ丛à丧w̲à>} );

# InTags


ok(!( "\x[3674]"  ~~ m/^<:InTags>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧专àæò>} );
ok("\x[3674]"  ~~ m/^<:!InTags>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧专àæò>} );
ok("\x[3674]"  ~~ m/^<-:InTags>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧专àæò>} );

# InTamil


ok("\x[0B80]" ~~ m/^<:InTamil>$/, q{Ìà中개両 <:갈丧专àì갢л>} );
ok(!( "\x[0B80]" ~~ m/^<:!InTamil>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧专àì갢л>} );
ok(!( "\x[0B80]" ~~ m/^<-:InTamil>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧专àì갢л>} );
ok(!( "\x[B58F]"  ~~ m/^<:InTamil>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧专àì갢л>} );
ok("\x[B58F]"  ~~ m/^<:!InTamil>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧专àì갢л>} );
ok("\x[B58F]"  ~~ m/^<-:InTamil>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧专àì갢л>} );
ok("\x[B58F]\x[0B80]" ~~ m/<:InTamil>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧专àì갢л>} );

# InTelugu


ok("\x[0C00]" ~~ m/^<:InTelugu>$/, q{Ìà中개両 <:갈丧专e̲л갮æ갮>} );
ok(!( "\x[0C00]" ~~ m/^<:!InTelugu>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧专e̲л갮æ갮>} );
ok(!( "\x[0C00]" ~~ m/^<-:InTelugu>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧专e̲л갮æ갮>} );
ok(!( "\x[8AC5]"  ~~ m/^<:InTelugu>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧专e̲л갮æ갮>} );
ok("\x[8AC5]"  ~~ m/^<:!InTelugu>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧专e̲л갮æ갮>} );
ok("\x[8AC5]"  ~~ m/^<-:InTelugu>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧专e̲л갮æ갮>} );
ok("\x[8AC5]\n\x[0C00]" ~~ m/<:InTelugu>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧专e̲л갮æ갮>} );

# InThaana


ok("\c[THAANA LETTER HAA]" ~~ m/^<:InThaana>$/, q{Ìà中개両 <:갈丧专両àà丧à>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<:!InThaana>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧专両àà丧à>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<-:InThaana>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧专両àà丧à>} );
ok(!( "\x[BB8F]"  ~~ m/^<:InThaana>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧专両àà丧à>} );
ok("\x[BB8F]"  ~~ m/^<:!InThaana>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧专両àà丧à>} );
ok("\x[BB8F]"  ~~ m/^<-:InThaana>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧专両àà丧à>} );
ok("\x[BB8F]\c[THAANA LETTER HAA]" ~~ m/<:InThaana>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧专両àà丧à>} );

# InThai


ok("\x[0E00]" ~~ m/^<:InThai>$/, q{Ìà中개両 <:갈丧专両à갢>} );
ok(!( "\x[0E00]" ~~ m/^<:!InThai>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧专両à갢>} );
ok(!( "\x[0E00]" ~~ m/^<-:InThai>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧专両à갢>} );
ok(!( "\x[9395]"  ~~ m/^<:InThai>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧专両à갢>} );
ok("\x[9395]"  ~~ m/^<:!InThai>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧专両à갢>} );
ok("\x[9395]"  ~~ m/^<-:InThai>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧专両à갢>} );
ok("\x[9395]\x[0E00]" ~~ m/<:InThai>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧专両à갢>} );

# InTibetan


ok("\c[TIBETAN SYLLABLE OM]" ~~ m/^<:InTibetan>$/, q{Ìà中개両 <:갈丧专갢丛e̲中à丧>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<:!InTibetan>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧专갢丛e̲中à丧>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<-:InTibetan>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧专갢丛e̲中à丧>} );
ok(!( "\x[957A]"  ~~ m/^<:InTibetan>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧专갢丛e̲中à丧>} );
ok("\x[957A]"  ~~ m/^<:!InTibetan>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧专갢丛e̲中à丧>} );
ok("\x[957A]"  ~~ m/^<-:InTibetan>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧专갢丛e̲中à丧>} );
ok("\x[957A]\c[TIBETAN SYLLABLE OM]" ~~ m/<:InTibetan>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧专갢丛e̲中à丧>} );

# InUnifiedCanadianAboriginalSyllabics


ok("\x[1400]" ~~ m/^<:InUnifiedCanadianAboriginalSyllabics>$/, q{Ìà中개両 <:갈丧갔丧갢е갢e̲𝐝갂à丧à𝐝갢à丧À丛갨с갢æ갢丧àлÒùллà丛갢개ò>} );
ok(!( "\x[1400]" ~~ m/^<:!InUnifiedCanadianAboriginalSyllabics>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧갔丧갢е갢e̲𝐝갂à丧à𝐝갢à丧À丛갨с갢æ갢丧àлÒùллà丛갢개ò>} );
ok(!( "\x[1400]" ~~ m/^<-:InUnifiedCanadianAboriginalSyllabics>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧갔丧갢е갢e̲𝐝갂à丧à𝐝갢à丧À丛갨с갢æ갢丧àлÒùллà丛갢개ò>} );
ok(!( "\x[9470]"  ~~ m/^<:InUnifiedCanadianAboriginalSyllabics>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧갔丧갢е갢e̲𝐝갂à丧à𝐝갢à丧À丛갨с갢æ갢丧àлÒùллà丛갢개ò>} );
ok("\x[9470]"  ~~ m/^<:!InUnifiedCanadianAboriginalSyllabics>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧갔丧갢е갢e̲𝐝갂à丧à𝐝갢à丧À丛갨с갢æ갢丧àлÒùллà丛갢개ò>} );
ok("\x[9470]"  ~~ m/^<-:InUnifiedCanadianAboriginalSyllabics>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧갔丧갢е갢e̲𝐝갂à丧à𝐝갢à丧À丛갨с갢æ갢丧àлÒùллà丛갢개ò>} );
ok("\x[9470]\x[1400]" ~~ m/<:InUnifiedCanadianAboriginalSyllabics>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧갔丧갢е갢e̲𝐝갂à丧à𝐝갢à丧À丛갨с갢æ갢丧àлÒùллà丛갢개ò>} );

# InVariationSelectors


ok(!( "\x[764D]"  ~~ m/^<:InVariationSelectors>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧𝐕àс갢à中갢갨丧Òe̲лe̲개中갨сò>} );
ok("\x[764D]"  ~~ m/^<:!InVariationSelectors>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧𝐕àс갢à中갢갨丧Òe̲лe̲개中갨сò>} );
ok("\x[764D]"  ~~ m/^<-:InVariationSelectors>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧𝐕àс갢à中갢갨丧Òe̲лe̲개中갨сò>} );

# InYiRadicals


ok("\c[YI RADICAL QOT]" ~~ m/^<:InYiRadicals>$/, q{Ìà中개両 <:갈丧Ù갢Сà𝐝갢개àлò>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:!InYiRadicals>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ù갢Сà𝐝갢개àлò>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<-:InYiRadicals>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ù갢Сà𝐝갢개àлò>} );
ok(!( "\x[3A4E]"  ~~ m/^<:InYiRadicals>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ù갢Сà𝐝갢개àлò>} );
ok("\x[3A4E]"  ~~ m/^<:!InYiRadicals>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ù갢Сà𝐝갢개àлò>} );
ok("\x[3A4E]"  ~~ m/^<-:InYiRadicals>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ù갢Сà𝐝갢개àлò>} );
ok("\x[3A4E]\c[YI RADICAL QOT]" ~~ m/<:InYiRadicals>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ù갢Сà𝐝갢개àлò>} );

# InYiSyllables


ok("\c[YI SYLLABLE IT]" ~~ m/^<:InYiSyllables>$/, q{Ìà中개両 <:갈丧Ù갢Òùллà丛лe̲ò>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<:!InYiSyllables>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧Ù갢Òùллà丛лe̲ò>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-:InYiSyllables>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧Ù갢Òùллà丛лe̲ò>} );
ok(!( "\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<:InYiSyllables>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧Ù갢Òùллà丛лe̲ò>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<:!InYiSyllables>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧Ù갢Òùллà丛лe̲ò>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]"  ~~ m/^<-:InYiSyllables>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧Ù갢Òùллà丛лe̲ò>} );
ok("\c[PARALLEL WITH HORIZONTAL STROKE]\c[YI SYLLABLE IT]" ~~ m/<:InYiSyllables>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈丧Ù갢Òùллà丛лe̲ò>} );



# vim: expandtab shiftwidth=4
