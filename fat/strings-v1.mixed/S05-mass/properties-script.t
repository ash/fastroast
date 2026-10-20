use Test;

=begin pod

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/properties_slow_to_compile.t.

XXX needs more clarification on the case of the rules,
ie letter vs. Letter vs isLetter

=end pod

plan 360;

# BidiL       # Left-to-Right

#?rakudo.jvm 35 skip 'Unicode properties with arguments'
ok("\c[YI SYLLABLE IT]" ~~ m/^<:bc<L>>$/, q{Ìà中개両 (Лe̲е中-中갨-С갢æ両中)} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<!:bc<L>>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (Лe̲е中-中갨-С갢æ両中)} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-:bc<L>>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (Лe̲е中-中갨-С갢æ両中)} );
ok(!( "\x[05D0]"  ~~ m/^<:bc<L>>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (Лe̲е中-中갨-С갢æ両中)} );
ok("\x[05D0]"  ~~ m/^<!:bc<L>>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (Лe̲е中-中갨-С갢æ両中)} );
ok("\x[05D0]"  ~~ m/^<-:bc<L>>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (Лe̲е中-中갨-С갢æ両中)} );
ok("\x[05D0]\c[YI SYLLABLE IT]" ~~ m/<:bc<L>>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (Лe̲е中-中갨-С갢æ両中)} );

# bc<EN>      # European Number


ok("\c[DIGIT ZERO]" ~~ m/^<:bc<EN>>$/, q{Ìà中개両 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<!:bc<EN>>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с)} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:bc<EN>>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с)} );
ok(!( "\x[AFFB]"  ~~ m/^<:bc<EN>>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с)} );
ok("\x[AFFB]"  ~~ m/^<!:bc<EN>>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с)} );
ok("\x[AFFB]"  ~~ m/^<-:bc<EN>>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с)} );
ok("\x[AFFB]\c[DIGIT ZERO]" ~~ m/<:bc<EN>>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с)} );

# bc<ES>      # European Number Separator


ok("\c[PLUS SIGN]" ~~ m/^<:bc<ES>>$/, q{Ìà中개両 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с Òe̲𝐩àсà中갨с)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<!:bc<ES>>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с Òe̲𝐩àсà中갨с)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-:bc<ES>>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с Òe̲𝐩àсà中갨с)} );
ok(!( "\x[7B89]"  ~~ m/^<:bc<ES>>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с Òe̲𝐩àсà中갨с)} );
ok("\x[7B89]"  ~~ m/^<!:bc<ES>>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с Òe̲𝐩àсà中갨с)} );
ok("\x[7B89]"  ~~ m/^<-:bc<ES>>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с Òe̲𝐩àсà中갨с)} );
ok("\x[7B89]\c[PLUS SIGN]" ~~ m/<:bc<ES>>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с Òe̲𝐩àсà中갨с)} );

# bc<ET>      # European Number Terminator


ok("\c[NUMBER SIGN]" ~~ m/^<:bc<ET>>$/, q{Ìà中개両 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с 专e̲сì갢丧à中갨с)} );
ok(!( "\c[NUMBER SIGN]" ~~ m/^<!:bc<ET>>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с 专e̲сì갢丧à中갨с)} );
ok(!( "\c[NUMBER SIGN]" ~~ m/^<-:bc<ET>>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с 专e̲сì갢丧à中갨с)} );
ok(!( "\x[6780]"  ~~ m/^<:bc<ET>>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с 专e̲сì갢丧à中갨с)} );
ok("\x[6780]"  ~~ m/^<!:bc<ET>>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с 专e̲сì갢丧à中갨с)} );
ok("\x[6780]"  ~~ m/^<-:bc<ET>>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с 专e̲сì갢丧à中갨с)} );
ok("\x[6780]\c[NUMBER SIGN]" ~~ m/<:bc<ET>>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (E̲갮с갨𝐩e̲à丧 不갮ì丛e̲с 专e̲сì갢丧à中갨с)} );

# bc<WS>      # Whitespace


ok("\c[FF]" ~~ m/^<:bc<WS>>$/, q{Ìà中개両 (W̲両갢中e̲ò𝐩à개e̲)} );
ok(!( "\c[FF]" ~~ m/^<!:bc<WS>>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (W̲両갢中e̲ò𝐩à개e̲)} );
ok(!( "\c[FF]" ~~ m/^<-:bc<WS>>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (W̲両갢中e̲ò𝐩à개e̲)} );
ok(!( "\x[6CF9]"  ~~ m/^<:bc<WS>>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (W̲両갢中e̲ò𝐩à개e̲)} );
ok("\x[6CF9]"  ~~ m/^<!:bc<WS>>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (W̲両갢中e̲ò𝐩à개e̲)} );
ok("\x[6CF9]"  ~~ m/^<-:bc<WS>>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (W̲両갢中e̲ò𝐩à개e̲)} );
ok("\x[6CF9]\c[FF]" ~~ m/<:bc<WS>>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (W̲両갢中e̲ò𝐩à개e̲)} );


# Arabic


ok("\c[ARABIC LETTER HAMZA]" ~~ m/^<:Arabic>$/, q{Ìà中개両 <:Àсà丛갢개>} );
ok(!( "\c[ARABIC LETTER HAMZA]" ~~ m/^<!:Arabic>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Àсà丛갢개>} );
ok(!( "\c[ARABIC LETTER HAMZA]" ~~ m/^<-:Arabic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Àсà丛갢개>} );
ok(!( "\x[A649]"  ~~ m/^<:Arabic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Àсà丛갢개>} );
ok("\x[A649]"  ~~ m/^<!:Arabic>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Àсà丛갢개>} );
ok("\x[A649]"  ~~ m/^<-:Arabic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Àсà丛갢개>} );
ok("\x[A649]\c[ARABIC LETTER HAMZA]" ~~ m/<:Arabic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Àсà丛갢개>} );

# Armenian


ok("\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<:Armenian>$/, q{Ìà中개両 <:Àсìe̲丧갢à丧>} );
ok(!( "\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<!:Armenian>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Àсìe̲丧갢à丧>} );
ok(!( "\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/^<-:Armenian>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Àсìe̲丧갢à丧>} );
ok(!( "\x[CBFF]"  ~~ m/^<:Armenian>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Àсìe̲丧갢à丧>} );
ok("\x[CBFF]"  ~~ m/^<!:Armenian>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Àсìe̲丧갢à丧>} );
ok("\x[CBFF]"  ~~ m/^<-:Armenian>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Àсìe̲丧갢à丧>} );
ok("\x[CBFF]\c[ARMENIAN CAPITAL LETTER AYB]" ~~ m/<:Armenian>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Àсìe̲丧갢à丧>} );

# Bengali


ok("\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<:Bengali>$/, q{Ìà中개両 <:丁e̲丧æàл갢>} );
ok(!( "\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<!:Bengali>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <丁e̲丧æàл갢>} );
ok(!( "\c[BENGALI SIGN CANDRABINDU]" ~~ m/^<-:Bengali>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <丁e̲丧æàл갢>} );
ok(!( "\x[D1E8]"  ~~ m/^<:Bengali>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <丁e̲丧æàл갢>} );
ok("\x[D1E8]"  ~~ m/^<!:Bengali>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <丁e̲丧æàл갢>} );
ok("\x[D1E8]"  ~~ m/^<-:Bengali>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <丁e̲丧æàл갢>} );
ok("\x[D1E8]\n\c[BENGALI SIGN CANDRABINDU]" ~~ m/<:Bengali>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <丁e̲丧æàл갢>} );

# Bopomofo


ok("\c[BOPOMOFO LETTER B]" ~~ m/^<:Bopomofo>$/, q{Ìà中개両 <:丁갨𝐩갨ì갨е갨>} );
ok(!( "\c[BOPOMOFO LETTER B]" ~~ m/^<!:Bopomofo>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <丁갨𝐩갨ì갨е갨>} );
ok(!( "\c[BOPOMOFO LETTER B]" ~~ m/^<-:Bopomofo>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <丁갨𝐩갨ì갨е갨>} );
ok(!( "\x[B093]"  ~~ m/^<:Bopomofo>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <丁갨𝐩갨ì갨е갨>} );
ok("\x[B093]"  ~~ m/^<!:Bopomofo>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <丁갨𝐩갨ì갨е갨>} );
ok("\x[B093]"  ~~ m/^<-:Bopomofo>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <丁갨𝐩갨ì갨е갨>} );
ok("\x[B093]\c[BOPOMOFO LETTER B]" ~~ m/<:Bopomofo>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <丁갨𝐩갨ì갨е갨>} );

# Buhid


ok("\c[BUHID LETTER A]" ~~ m/^<:Buhid>$/, q{Ìà中개両 <:丁갮両갢𝐝>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<!:Buhid>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <丁갮両갢𝐝>} );
ok(!( "\c[BUHID LETTER A]" ~~ m/^<-:Buhid>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <丁갮両갢𝐝>} );
ok(!( "\x[C682]"  ~~ m/^<:Buhid>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <丁갮両갢𝐝>} );
ok("\x[C682]"  ~~ m/^<!:Buhid>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <丁갮両갢𝐝>} );
ok("\x[C682]"  ~~ m/^<-:Buhid>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <丁갮両갢𝐝>} );
ok("\x[C682]\c[BUHID LETTER A]" ~~ m/<:Buhid>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <丁갮両갢𝐝>} );

# Canadian_Aboriginal


ok("\c[CANADIAN SYLLABICS E]" ~~ m/^<:Canadian_Aboriginal>$/, q{Ìà中개両 <:갂à丧à𝐝갢à丧_À丛갨с갢æ갢丧àл>} );
ok(!( "\c[CANADIAN SYLLABICS E]" ~~ m/^<!:Canadian_Aboriginal>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갂à丧à𝐝갢à丧_À丛갨с갢æ갢丧àл>} );
ok(!( "\c[CANADIAN SYLLABICS E]" ~~ m/^<-:Canadian_Aboriginal>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갂à丧à𝐝갢à丧_À丛갨с갢æ갢丧àл>} );
ok(!( "\x[888B]"  ~~ m/^<:Canadian_Aboriginal>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갂à丧à𝐝갢à丧_À丛갨с갢æ갢丧àл>} );
ok("\x[888B]"  ~~ m/^<!:Canadian_Aboriginal>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갂à丧à𝐝갢à丧_À丛갨с갢æ갢丧àл>} );
ok("\x[888B]"  ~~ m/^<-:Canadian_Aboriginal>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갂à丧à𝐝갢à丧_À丛갨с갢æ갢丧àл>} );
ok(!( "\x[9FA6]" ~~ m/^<:Canadian_Aboriginal>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <갂à丧à𝐝갢à丧_À丛갨с갢æ갢丧àл>} );
ok("\x[9FA6]" ~~ m/^<!:Canadian_Aboriginal>.$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갂à丧à𝐝갢à丧_À丛갨с갢æ갢丧àл>} );
ok("\x[9FA6]" ~~ m/^<-:Canadian_Aboriginal>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갂à丧à𝐝갢à丧_À丛갨с갢æ갢丧àл>} );
ok("\x[888B]\x[9FA6]\c[CANADIAN SYLLABICS E]" ~~ m/<:Canadian_Aboriginal>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갂à丧à𝐝갢à丧_À丛갨с갢æ갢丧àл>} );

# Cherokee


ok("\c[CHEROKEE LETTER A]" ~~ m/^<:Cherokee>$/, q{Ìà中개両 <:갂両e̲с갨k̲e̲e̲>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<!:Cherokee>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갂両e̲с갨k̲e̲e̲>} );
ok(!( "\c[CHEROKEE LETTER A]" ~~ m/^<-:Cherokee>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갂両e̲с갨k̲e̲e̲>} );
ok(!( "\x[8260]"  ~~ m/^<:Cherokee>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갂両e̲с갨k̲e̲e̲>} );
ok("\x[8260]"  ~~ m/^<!:Cherokee>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갂両e̲с갨k̲e̲e̲>} );
ok("\x[8260]"  ~~ m/^<-:Cherokee>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갂両e̲с갨k̲e̲e̲>} );
ok(!( "\x[9FA6]" ~~ m/^<:Cherokee>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <갂両e̲с갨k̲e̲e̲>} );
ok("\x[9FA6]" ~~ m/^<!:Cherokee>.$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갂両e̲с갨k̲e̲e̲>} );
ok("\x[9FA6]" ~~ m/^<-:Cherokee>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갂両e̲с갨k̲e̲e̲>} );
ok("\x[8260]\x[9FA6]\c[CHEROKEE LETTER A]" ~~ m/<:Cherokee>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갂両e̲с갨k̲e̲e̲>} );

# Cyrillic


ok("\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<:Cyrillic>$/, q{Ìà中개両 <:갂ùс갢лл갢개>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<!:Cyrillic>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갂ùс갢лл갢개>} );
ok(!( "\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/^<-:Cyrillic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갂ùс갢лл갢개>} );
ok(!( "\x[B7DF]"  ~~ m/^<:Cyrillic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갂ùс갢лл갢개>} );
ok("\x[B7DF]"  ~~ m/^<!:Cyrillic>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갂ùс갢лл갢개>} );
ok("\x[B7DF]"  ~~ m/^<-:Cyrillic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갂ùс갢лл갢개>} );
ok(!( "\x[D7A4]" ~~ m/^<:Cyrillic>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <갂ùс갢лл갢개>} );
ok("\x[D7A4]" ~~ m/^<!:Cyrillic>.$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갂ùс갢лл갢개>} );
ok("\x[D7A4]" ~~ m/^<-:Cyrillic>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갂ùс갢лл갢개>} );
ok("\x[B7DF]\x[D7A4]\c[CYRILLIC CAPITAL LETTER IE WITH GRAVE]" ~~ m/<:Cyrillic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갂ùс갢лл갢개>} );

# Deseret


ok(!( "\x[A8A0]"  ~~ m/^<:Deseret>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <𝐃e̲òe̲сe̲中>} );
ok("\x[A8A0]"  ~~ m/^<!:Deseret>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <𝐃e̲òe̲сe̲中>} );
ok("\x[A8A0]"  ~~ m/^<-:Deseret>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <𝐃e̲òe̲сe̲中>} );

# Devanagari


ok("\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<:Devanagari>$/, q{Ìà中개両 <:𝐃e̲𝐯à丧àæàс갢>} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<!:Devanagari>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <𝐃e̲𝐯à丧àæàс갢>} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<-:Devanagari>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <𝐃e̲𝐯à丧àæàс갢>} );
ok(!( "\x[D291]"  ~~ m/^<:Devanagari>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <𝐃e̲𝐯à丧àæàс갢>} );
ok("\x[D291]"  ~~ m/^<!:Devanagari>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <𝐃e̲𝐯à丧àæàс갢>} );
ok("\x[D291]"  ~~ m/^<-:Devanagari>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <𝐃e̲𝐯à丧àæàс갢>} );
ok("\x[D291]\n\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/<:Devanagari>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <𝐃e̲𝐯à丧àæàс갢>} );

# Ethiopic


ok("\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<:Ethiopic>$/, q{Ìà中개両 <:E̲中両갢갨𝐩갢개>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<!:Ethiopic>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <E̲中両갢갨𝐩갢개>} );
ok(!( "\c[ETHIOPIC SYLLABLE HA]" ~~ m/^<-:Ethiopic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <E̲中両갢갨𝐩갢개>} );
ok(!( "\x[A9FA]"  ~~ m/^<:Ethiopic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <E̲中両갢갨𝐩갢개>} );
ok("\x[A9FA]"  ~~ m/^<!:Ethiopic>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <E̲中両갢갨𝐩갢개>} );
ok("\x[A9FA]"  ~~ m/^<-:Ethiopic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <E̲中両갢갨𝐩갢개>} );
ok("\x[A9FA]\c[ETHIOPIC SYLLABLE HA]" ~~ m/<:Ethiopic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <E̲中両갢갨𝐩갢개>} );

# Georgian


ok("\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<:Georgian>$/, q{Ìà中개両 <:Æe̲갨сæ갢à丧>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<!:Georgian>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Æe̲갨сæ갢à丧>} );
ok(!( "\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/^<-:Georgian>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Æe̲갨сæ갢à丧>} );
ok(!( "\x[BBC9]"  ~~ m/^<:Georgian>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Æe̲갨сæ갢à丧>} );
ok("\x[BBC9]"  ~~ m/^<!:Georgian>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Æe̲갨сæ갢à丧>} );
ok("\x[BBC9]"  ~~ m/^<-:Georgian>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Æe̲갨сæ갢à丧>} );
ok("\x[BBC9]\c[GEORGIAN CAPITAL LETTER AN]" ~~ m/<:Georgian>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Æe̲갨сæ갢à丧>} );

# Gothic


ok(!( "\x[5888]"  ~~ m/^<:Gothic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Æ갨中両갢개>} );
ok("\x[5888]"  ~~ m/^<!:Gothic>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Æ갨中両갢개>} );
ok("\x[5888]"  ~~ m/^<-:Gothic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Æ갨中両갢개>} );

# Greek


ok("\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<:Greek>$/, q{Ìà中개両 <:Æсe̲e̲k̲>} );
ok(!( "\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<!:Greek>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Æсe̲e̲k̲>} );
ok(!( "\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/^<-:Greek>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Æсe̲e̲k̲>} );
ok(!( "\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<:Greek>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Æсe̲e̲k̲>} );
ok("\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<!:Greek>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Æсe̲e̲k̲>} );
ok("\c[ETHIOPIC SYLLABLE KEE]"  ~~ m/^<-:Greek>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Æсe̲e̲k̲>} );
ok("\c[ETHIOPIC SYLLABLE KEE]\c[GREEK LETTER SMALL CAPITAL GAMMA]" ~~ m/<:Greek>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Æсe̲e̲k̲>} );

# Gujarati


ok("\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<:Gujarati>$/, q{Ìà中개両 <:Æ갮𝐣àсà中갢>} );
ok(!( "\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<!:Gujarati>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Æ갮𝐣àсà中갢>} );
ok(!( "\c[GUJARATI SIGN CANDRABINDU]" ~~ m/^<-:Gujarati>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Æ갮𝐣àсà中갢>} );
ok(!( "\x[D108]"  ~~ m/^<:Gujarati>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Æ갮𝐣àсà中갢>} );
ok("\x[D108]"  ~~ m/^<!:Gujarati>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Æ갮𝐣àсà中갢>} );
ok("\x[D108]"  ~~ m/^<-:Gujarati>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Æ갮𝐣àсà中갢>} );
ok("\x[D108]\n\c[GUJARATI SIGN CANDRABINDU]" ~~ m/<:Gujarati>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Æ갮𝐣àсà中갢>} );

# Gurmukhi


ok("\c[GURMUKHI SIGN BINDI]" ~~ m/^<:Gurmukhi>$/, q{Ìà中개両 <:Æ갮сì갮k̲両갢>} );
ok(!( "\c[GURMUKHI SIGN BINDI]" ~~ m/^<!:Gurmukhi>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Æ갮сì갮k̲両갢>} );
ok(!( "\c[GURMUKHI SIGN BINDI]" ~~ m/^<-:Gurmukhi>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Æ갮сì갮k̲両갢>} );
ok(!( "\x[5E05]"  ~~ m/^<:Gurmukhi>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Æ갮сì갮k̲両갢>} );
ok("\x[5E05]"  ~~ m/^<!:Gurmukhi>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Æ갮сì갮k̲両갢>} );
ok("\x[5E05]"  ~~ m/^<-:Gurmukhi>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Æ갮сì갮k̲両갢>} );
ok("\x[5E05]\n\c[GURMUKHI SIGN BINDI]" ~~ m/<:Gurmukhi>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Æ갮сì갮k̲両갢>} );

# Han


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<:Han>$/, q{Ìà中개両 <:万à丧>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<!:Han>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <万à丧>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-:Han>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <万à丧>} );
ok(!( "\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<:Han>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <万à丧>} );
ok("\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<!:Han>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <万à丧>} );
ok("\c[CANADIAN SYLLABICS KAA]"  ~~ m/^<-:Han>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <万à丧>} );
ok("\c[CANADIAN SYLLABICS KAA]\c[CJK RADICAL REPEAT]" ~~ m/<:Han>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <万à丧>} );

# Hangul


ok("\x[AC00]" ~~ m/^<:Hangul>$/, q{Ìà中개両 <:万à丧æ갮л>} );
ok(!( "\x[AC00]" ~~ m/^<!:Hangul>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <万à丧æ갮л>} );
ok(!( "\x[AC00]" ~~ m/^<-:Hangul>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <万à丧æ갮л>} );
ok(!( "\x[9583]"  ~~ m/^<:Hangul>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <万à丧æ갮л>} );
ok("\x[9583]"  ~~ m/^<!:Hangul>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <万à丧æ갮л>} );
ok("\x[9583]"  ~~ m/^<-:Hangul>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <万à丧æ갮л>} );
ok("\x[9583]\x[AC00]" ~~ m/<:Hangul>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <万à丧æ갮л>} );

# Hanunoo


ok("\c[HANUNOO LETTER A]" ~~ m/^<:Hanunoo>$/, q{Ìà中개両 <:万à丧갮丧갨갨>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<!:Hanunoo>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <万à丧갮丧갨갨>} );
ok(!( "\c[HANUNOO LETTER A]" ~~ m/^<-:Hanunoo>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <万à丧갮丧갨갨>} );
ok(!( "\x[7625]"  ~~ m/^<:Hanunoo>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <万à丧갮丧갨갨>} );
ok("\x[7625]"  ~~ m/^<!:Hanunoo>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <万à丧갮丧갨갨>} );
ok("\x[7625]"  ~~ m/^<-:Hanunoo>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <万à丧갮丧갨갨>} );
ok("\x[7625]\c[HANUNOO LETTER A]" ~~ m/<:Hanunoo>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <万à丧갮丧갨갨>} );

# Hebrew


ok("\c[HEBREW LETTER ALEF]" ~~ m/^<:Hebrew>$/, q{Ìà中개両 <:万e̲丛сe̲w̲>} );
ok(!( "\c[HEBREW LETTER ALEF]" ~~ m/^<!:Hebrew>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <万e̲丛сe̲w̲>} );
ok(!( "\c[HEBREW LETTER ALEF]" ~~ m/^<-:Hebrew>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <万e̲丛сe̲w̲>} );
ok(!( "\c[YI SYLLABLE SSIT]"  ~~ m/^<:Hebrew>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <万e̲丛сe̲w̲>} );
ok("\c[YI SYLLABLE SSIT]"  ~~ m/^<!:Hebrew>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <万e̲丛сe̲w̲>} );
ok("\c[YI SYLLABLE SSIT]"  ~~ m/^<-:Hebrew>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <万e̲丛сe̲w̲>} );
ok("\c[YI SYLLABLE SSIT]\c[HEBREW LETTER ALEF]" ~~ m/<:Hebrew>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <万e̲丛сe̲w̲>} );

# Hiragana


ok("\c[HIRAGANA LETTER SMALL A]" ~~ m/^<:Hiragana>$/, q{Ìà中개両 <:万갢сàæà丧à>} );
ok(!( "\c[HIRAGANA LETTER SMALL A]" ~~ m/^<!:Hiragana>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <万갢сàæà丧à>} );
ok(!( "\c[HIRAGANA LETTER SMALL A]" ~~ m/^<-:Hiragana>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <万갢сàæà丧à>} );
ok(!( "\c[CANADIAN SYLLABICS Y]"  ~~ m/^<:Hiragana>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <万갢сàæà丧à>} );
ok("\c[CANADIAN SYLLABICS Y]"  ~~ m/^<!:Hiragana>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <万갢сàæà丧à>} );
ok("\c[CANADIAN SYLLABICS Y]"  ~~ m/^<-:Hiragana>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <万갢сàæà丧à>} );
ok("\c[CANADIAN SYLLABICS Y]\c[HIRAGANA LETTER SMALL A]" ~~ m/<:Hiragana>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <万갢сàæà丧à>} );

# Inherited


ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Inherited>$/, q{Ìà中개両 <:갈丧両e̲с갢中e̲𝐝>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Inherited>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈丧両e̲с갢中e̲𝐝>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Inherited>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈丧両e̲с갢中e̲𝐝>} );
ok(!( "\x[75FA]"  ~~ m/^<:Inherited>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈丧両e̲с갢中e̲𝐝>} );
ok("\x[75FA]"  ~~ m/^<!:Inherited>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈丧両e̲с갢中e̲𝐝>} );
ok("\x[75FA]"  ~~ m/^<-:Inherited>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈丧両e̲с갢中e̲𝐝>} );

# Kannada


ok("\c[KANNADA SIGN ANUSVARA]" ~~ m/^<:Kannada>$/, q{Ìà中개両 <:K̲à丧丧à𝐝à>} );
ok(!( "\c[KANNADA SIGN ANUSVARA]" ~~ m/^<!:Kannada>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <K̲à丧丧à𝐝à>} );
ok(!( "\c[KANNADA SIGN ANUSVARA]" ~~ m/^<-:Kannada>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <K̲à丧丧à𝐝à>} );
ok(!( "\x[C1DF]"  ~~ m/^<:Kannada>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <K̲à丧丧à𝐝à>} );
ok("\x[C1DF]"  ~~ m/^<!:Kannada>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <K̲à丧丧à𝐝à>} );
ok("\x[C1DF]"  ~~ m/^<-:Kannada>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <K̲à丧丧à𝐝à>} );
ok("\x[C1DF]\n\c[KANNADA SIGN ANUSVARA]" ~~ m/<:Kannada>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <K̲à丧丧à𝐝à>} );

# Katakana


ok("\c[KATAKANA LETTER SMALL A]" ~~ m/^<:Katakana>$/, q{Ìà中개両 <:K̲à中àk̲à丧à>} );
ok(!( "\c[KATAKANA LETTER SMALL A]" ~~ m/^<!:Katakana>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <K̲à中àk̲à丧à>} );
ok(!( "\c[KATAKANA LETTER SMALL A]" ~~ m/^<-:Katakana>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <K̲à中àk̲à丧à>} );
ok(!( "\x[177A]"  ~~ m/^<:Katakana>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <K̲à中àk̲à丧à>} );
ok("\x[177A]"  ~~ m/^<!:Katakana>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <K̲à中àk̲à丧à>} );
ok("\x[177A]"  ~~ m/^<-:Katakana>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <K̲à中àk̲à丧à>} );
ok("\x[177A]\c[KATAKANA LETTER SMALL A]" ~~ m/<:Katakana>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <K̲à中àk̲à丧à>} );

# Khmer


ok("\c[KHMER LETTER KA]" ~~ m/^<:Khmer>$/, q{Ìà中개両 <:K̲両ìe̲с>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<!:Khmer>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <K̲両ìe̲с>} );
ok(!( "\c[KHMER LETTER KA]" ~~ m/^<-:Khmer>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <K̲両ìe̲с>} );
ok(!( "\c[GEORGIAN LETTER QAR]"  ~~ m/^<:Khmer>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <K̲両ìe̲с>} );
ok("\c[GEORGIAN LETTER QAR]"  ~~ m/^<!:Khmer>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <K̲両ìe̲с>} );
ok("\c[GEORGIAN LETTER QAR]"  ~~ m/^<-:Khmer>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <K̲両ìe̲с>} );
ok("\c[GEORGIAN LETTER QAR]\c[KHMER LETTER KA]" ~~ m/<:Khmer>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <K̲両ìe̲с>} );

# Lao


ok("\c[LAO LETTER KO]" ~~ m/^<:Lao>$/, q{Ìà中개両 <:Лà갨>} );
ok(!( "\c[LAO LETTER KO]" ~~ m/^<!:Lao>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Лà갨>} );
ok(!( "\c[LAO LETTER KO]" ~~ m/^<-:Lao>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Лà갨>} );
ok(!( "\x[3DA9]"  ~~ m/^<:Lao>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Лà갨>} );
ok("\x[3DA9]"  ~~ m/^<!:Lao>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Лà갨>} );
ok("\x[3DA9]"  ~~ m/^<-:Lao>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Лà갨>} );
ok(!( "\x[3DA9]" ~~ m/^<:Lao>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <Лà갨>} );
ok("\x[3DA9]" ~~ m/^<!:Lao>.$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Лà갨>} );
ok("\x[3DA9]" ~~ m/^<-:Lao>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Лà갨>} );
ok("\x[3DA9]\x[3DA9]\c[LAO LETTER KO]" ~~ m/<:Lao>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Лà갨>} );

# Latin


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:Latin>$/, q{Ìà中개両 <:Лà中갢丧>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<!:Latin>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Лà中갢丧>} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:Latin>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Лà中갢丧>} );
ok(!( "\x[C549]"  ~~ m/^<:Latin>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Лà中갢丧>} );
ok("\x[C549]"  ~~ m/^<!:Latin>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Лà中갢丧>} );
ok("\x[C549]"  ~~ m/^<-:Latin>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Лà中갢丧>} );
ok(!( "\x[C549]" ~~ m/^<:Latin>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <Лà中갢丧>} );
ok("\x[C549]" ~~ m/^<!:Latin>.$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Лà中갢丧>} );
ok("\x[C549]" ~~ m/^<-:Latin>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Лà中갢丧>} );
ok("\x[C549]\x[C549]\c[LATIN CAPITAL LETTER A]" ~~ m/<:Latin>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Лà中갢丧>} );

# Malayalam


ok("\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<:Malayalam>$/, q{Ìà中개両 <:Ìàлàùàлàì>} );
ok(!( "\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<!:Malayalam>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Ìàлàùàлàì>} );
ok(!( "\c[MALAYALAM SIGN ANUSVARA]" ~~ m/^<-:Malayalam>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Ìàлàùàлàì>} );
ok(!( "\x[625C]"  ~~ m/^<:Malayalam>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Ìàлàùàлàì>} );
ok("\x[625C]"  ~~ m/^<!:Malayalam>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Ìàлàùàлàì>} );
ok("\x[625C]"  ~~ m/^<-:Malayalam>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Ìàлàùàлàì>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Malayalam>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <Ìàлàùàлàì>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Malayalam>.$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Ìàлàùàлàì>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Malayalam>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Ìàлàùàлàì>} );
ok("\x[625C]\c[COMBINING GRAVE ACCENT]\n\c[MALAYALAM SIGN ANUSVARA]" ~~ m/<:Malayalam>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Ìàлàùàлàì>} );

# Mongolian


ok("\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<:Mongolian>$/, q{Ìà中개両 <:Ì갨丧æ갨л갢à丧>} );
ok(!( "\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<!:Mongolian>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Ì갨丧æ갨л갢à丧>} );
ok(!( "\c[MONGOLIAN DIGIT ZERO]" ~~ m/^<-:Mongolian>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Ì갨丧æ갨л갢à丧>} );
ok(!( "\x[5F93]"  ~~ m/^<:Mongolian>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Ì갨丧æ갨л갢à丧>} );
ok("\x[5F93]"  ~~ m/^<!:Mongolian>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Ì갨丧æ갨л갢à丧>} );
ok("\x[5F93]"  ~~ m/^<-:Mongolian>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Ì갨丧æ갨л갢à丧>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Mongolian>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <Ì갨丧æ갨л갢à丧>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Mongolian>.$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Ì갨丧æ갨л갢à丧>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Mongolian>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Ì갨丧æ갨л갢à丧>} );
ok("\x[5F93]\c[COMBINING GRAVE ACCENT]\c[MONGOLIAN DIGIT ZERO]" ~~ m/<:Mongolian>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Ì갨丧æ갨л갢à丧>} );

# Myanmar


ok("\c[MYANMAR LETTER KA]" ~~ m/^<:Myanmar>$/, q{Ìà中개両 <:Ìùà丧ìàс>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<!:Myanmar>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Ìùà丧ìàс>} );
ok(!( "\c[MYANMAR LETTER KA]" ~~ m/^<-:Myanmar>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Ìùà丧ìàс>} );
ok(!( "\x[649A]"  ~~ m/^<:Myanmar>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Ìùà丧ìàс>} );
ok("\x[649A]"  ~~ m/^<!:Myanmar>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Ìùà丧ìàс>} );
ok("\x[649A]"  ~~ m/^<-:Myanmar>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Ìùà丧ìàс>} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Myanmar>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <Ìùà丧ìàс>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<!:Myanmar>.$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Ìùà丧ìàс>} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Myanmar>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Ìùà丧ìàс>} );
ok("\x[649A]\c[COMBINING GRAVE ACCENT]\c[MYANMAR LETTER KA]" ~~ m/<:Myanmar>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Ìùà丧ìàс>} );

# Ogham


ok("\c[OGHAM LETTER BEITH]" ~~ m/^<:Ogham>$/, q{Ìà中개両 <:갎æ両àì>} );
ok(!( "\c[OGHAM LETTER BEITH]" ~~ m/^<!:Ogham>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갎æ両àì>} );
ok(!( "\c[OGHAM LETTER BEITH]" ~~ m/^<-:Ogham>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갎æ両àì>} );
ok(!( "\c[KATAKANA LETTER KA]"  ~~ m/^<:Ogham>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갎æ両àì>} );
ok("\c[KATAKANA LETTER KA]"  ~~ m/^<!:Ogham>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갎æ両àì>} );
ok("\c[KATAKANA LETTER KA]"  ~~ m/^<-:Ogham>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갎æ両àì>} );
ok("\c[KATAKANA LETTER KA]\c[OGHAM LETTER BEITH]" ~~ m/<:Ogham>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갎æ両àì>} );

# Old_Italic


ok(!( "\x[8BB7]"  ~~ m/^<:Old_Italic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갎л𝐝_갈中àл갢개>} );
ok("\x[8BB7]"  ~~ m/^<!:Old_Italic>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갎л𝐝_갈中àл갢개>} );
ok("\x[8BB7]"  ~~ m/^<-:Old_Italic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갎л𝐝_갈中àл갢개>} );

# Oriya


ok("\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<:Oriya>$/, q{Ìà中개両 <:갎с갢ùà>} );
ok(!( "\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<!:Oriya>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갎с갢ùà>} );
ok(!( "\c[ORIYA SIGN CANDRABINDU]" ~~ m/^<-:Oriya>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갎с갢ùà>} );
ok(!( "\x[4292]"  ~~ m/^<:Oriya>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갎с갢ùà>} );
ok("\x[4292]"  ~~ m/^<!:Oriya>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갎с갢ùà>} );
ok("\x[4292]"  ~~ m/^<-:Oriya>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갎с갢ùà>} );
ok("\x[4292]\n\c[ORIYA SIGN CANDRABINDU]" ~~ m/<:Oriya>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갎с갢ùà>} );

# Runic


ok("\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<:Runic>$/, q{Ìà中개両 <:С갮丧갢개>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<!:Runic>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <С갮丧갢개>} );
ok(!( "\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/^<-:Runic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <С갮丧갢개>} );
ok(!( "\x[9857]"  ~~ m/^<:Runic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <С갮丧갢개>} );
ok("\x[9857]"  ~~ m/^<!:Runic>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <С갮丧갢개>} );
ok("\x[9857]"  ~~ m/^<-:Runic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <С갮丧갢개>} );
ok("\x[9857]\c[RUNIC LETTER FEHU FEOH FE F]" ~~ m/<:Runic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <С갮丧갢개>} );

# Sinhala


ok("\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<:Sinhala>$/, q{Ìà中개両 <:Ò갢丧両àлà>} );
ok(!( "\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<!:Sinhala>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Ò갢丧両àлà>} );
ok(!( "\c[SINHALA SIGN ANUSVARAYA]" ~~ m/^<-:Sinhala>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Ò갢丧両àлà>} );
ok(!( "\x[5DF5]"  ~~ m/^<:Sinhala>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Ò갢丧両àлà>} );
ok("\x[5DF5]"  ~~ m/^<!:Sinhala>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Ò갢丧両àлà>} );
ok("\x[5DF5]"  ~~ m/^<-:Sinhala>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Ò갢丧両àлà>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Sinhala>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <Ò갢丧両àлà>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<!:Sinhala>.$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Ò갢丧両àлà>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Sinhala>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Ò갢丧両àлà>} );
ok("\x[5DF5]\c[YI RADICAL QOT]\n\c[SINHALA SIGN ANUSVARAYA]" ~~ m/<:Sinhala>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Ò갢丧両àлà>} );

# Syriac


ok("\c[SYRIAC LETTER ALAPH]" ~~ m/^<:Syriac>$/, q{Ìà中개両 <:Òùс갢à개>} );
ok(!( "\c[SYRIAC LETTER ALAPH]" ~~ m/^<!:Syriac>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Òùс갢à개>} );
ok(!( "\c[SYRIAC LETTER ALAPH]" ~~ m/^<-:Syriac>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Òùс갢à개>} );
ok(!( "\x[57F0]"  ~~ m/^<:Syriac>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Òùс갢à개>} );
ok("\x[57F0]"  ~~ m/^<!:Syriac>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Òùс갢à개>} );
ok("\x[57F0]"  ~~ m/^<-:Syriac>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Òùс갢à개>} );
ok(!( "\c[YI RADICAL QOT]" ~~ m/^<:Syriac>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <Òùс갢à개>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<!:Syriac>.$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Òùс갢à개>} );
ok("\c[YI RADICAL QOT]" ~~ m/^<-:Syriac>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Òùс갢à개>} );
ok("\x[57F0]\c[YI RADICAL QOT]\c[SYRIAC LETTER ALAPH]" ~~ m/<:Syriac>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Òùс갢à개>} );

# Tagalog


ok("\c[TAGALOG LETTER A]" ~~ m/^<:Tagalog>$/, q{Ìà中개両 <:专àæàл갨æ>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<!:Tagalog>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <专àæàл갨æ>} );
ok(!( "\c[TAGALOG LETTER A]" ~~ m/^<-:Tagalog>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <专àæàл갨æ>} );
ok(!( "\x[3DE8]"  ~~ m/^<:Tagalog>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <专àæàл갨æ>} );
ok("\x[3DE8]"  ~~ m/^<!:Tagalog>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <专àæàл갨æ>} );
ok("\x[3DE8]"  ~~ m/^<-:Tagalog>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <专àæàл갨æ>} );
ok("\x[3DE8]\c[TAGALOG LETTER A]" ~~ m/<:Tagalog>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <专àæàл갨æ>} );

# Tagbanwa


ok("\c[TAGBANWA LETTER A]" ~~ m/^<:Tagbanwa>$/, q{Ìà中개両 <:专àæ丛à丧w̲à>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<!:Tagbanwa>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <专àæ丛à丧w̲à>} );
ok(!( "\c[TAGBANWA LETTER A]" ~~ m/^<-:Tagbanwa>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <专àæ丛à丧w̲à>} );
ok(!( "\c[CHEROKEE LETTER TLV]"  ~~ m/^<:Tagbanwa>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <专àæ丛à丧w̲à>} );
ok("\c[CHEROKEE LETTER TLV]"  ~~ m/^<!:Tagbanwa>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <专àæ丛à丧w̲à>} );
ok("\c[CHEROKEE LETTER TLV]"  ~~ m/^<-:Tagbanwa>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <专àæ丛à丧w̲à>} );
ok("\c[CHEROKEE LETTER TLV]\c[TAGBANWA LETTER A]" ~~ m/<:Tagbanwa>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <专àæ丛à丧w̲à>} );

# Tamil


ok("\c[TAMIL SIGN ANUSVARA]" ~~ m/^<:Tamil>$/, q{Ìà中개両 <:专àì갢л>} );
ok(!( "\c[TAMIL SIGN ANUSVARA]" ~~ m/^<!:Tamil>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <专àì갢л>} );
ok(!( "\c[TAMIL SIGN ANUSVARA]" ~~ m/^<-:Tamil>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <专àì갢л>} );
ok(!( "\x[8DF2]"  ~~ m/^<:Tamil>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <专àì갢л>} );
ok("\x[8DF2]"  ~~ m/^<!:Tamil>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <专àì갢л>} );
ok("\x[8DF2]"  ~~ m/^<-:Tamil>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <专àì갢л>} );
ok("\x[8DF2]\n\c[TAMIL SIGN ANUSVARA]" ~~ m/<:Tamil>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <专àì갢л>} );

# Telugu


ok("\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<:Telugu>$/, q{Ìà中개両 <:专e̲л갮æ갮>} );
ok(!( "\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<!:Telugu>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <专e̲л갮æ갮>} );
ok(!( "\c[TELUGU SIGN CANDRABINDU]" ~~ m/^<-:Telugu>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <专e̲л갮æ갮>} );
ok(!( "\x[8088]"  ~~ m/^<:Telugu>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <专e̲л갮æ갮>} );
ok("\x[8088]"  ~~ m/^<!:Telugu>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <专e̲л갮æ갮>} );
ok("\x[8088]"  ~~ m/^<-:Telugu>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <专e̲л갮æ갮>} );
ok("\x[8088]\n\c[TELUGU SIGN CANDRABINDU]" ~~ m/<:Telugu>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <专e̲л갮æ갮>} );

# Thaana


ok("\c[THAANA LETTER HAA]" ~~ m/^<:Thaana>$/, q{Ìà中개両 <:专両àà丧à>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<!:Thaana>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <专両àà丧à>} );
ok(!( "\c[THAANA LETTER HAA]" ~~ m/^<-:Thaana>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <专両àà丧à>} );
ok(!( "\x[5240]"  ~~ m/^<:Thaana>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <专両àà丧à>} );
ok("\x[5240]"  ~~ m/^<!:Thaana>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <专両àà丧à>} );
ok("\x[5240]"  ~~ m/^<-:Thaana>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <专両àà丧à>} );
ok("\x[5240]\c[THAANA LETTER HAA]" ~~ m/<:Thaana>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <专両àà丧à>} );

# Thai


ok("\c[THAI CHARACTER KO KAI]" ~~ m/^<:Thai>$/, q{Ìà中개両 <:专両à갢>} );
ok(!( "\c[THAI CHARACTER KO KAI]" ~~ m/^<!:Thai>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <专両à갢>} );
ok(!( "\c[THAI CHARACTER KO KAI]" ~~ m/^<-:Thai>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <专両à갢>} );
ok(!( "\x[CAD3]"  ~~ m/^<:Thai>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <专両à갢>} );
ok("\x[CAD3]"  ~~ m/^<!:Thai>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <专両à갢>} );
ok("\x[CAD3]"  ~~ m/^<-:Thai>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <专両à갢>} );
ok("\x[CAD3]\c[THAI CHARACTER KO KAI]" ~~ m/<:Thai>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <专両à갢>} );

# Tibetan


ok("\c[TIBETAN SYLLABLE OM]" ~~ m/^<:Tibetan>$/, q{Ìà中개両 <:专갢丛e̲中à丧>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<!:Tibetan>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <专갢丛e̲中à丧>} );
ok(!( "\c[TIBETAN SYLLABLE OM]" ~~ m/^<-:Tibetan>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <专갢丛e̲中à丧>} );
ok(!( "\x[8557]"  ~~ m/^<:Tibetan>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <专갢丛e̲中à丧>} );
ok("\x[8557]"  ~~ m/^<!:Tibetan>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <专갢丛e̲中à丧>} );
ok("\x[8557]"  ~~ m/^<-:Tibetan>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <专갢丛e̲中à丧>} );
ok("\x[8557]\c[TIBETAN SYLLABLE OM]" ~~ m/<:Tibetan>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <专갢丛e̲中à丧>} );

# Yi


ok("\c[YI SYLLABLE IT]" ~~ m/^<:Yi>$/, q{Ìà中개両 <:Ù갢>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<!:Yi>.$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Ù갢>} );
ok(!( "\c[YI SYLLABLE IT]" ~~ m/^<-:Yi>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Ù갢>} );
ok(!( "\x[BCD0]"  ~~ m/^<:Yi>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Ù갢>} );
ok("\x[BCD0]"  ~~ m/^<!:Yi>.$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Ù갢>} );
ok("\x[BCD0]"  ~~ m/^<-:Yi>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Ù갢>} );
ok("\x[BCD0]\c[YI SYLLABLE IT]" ~~ m/<:Yi>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Ù갢>} );


# vim: expandtab shiftwidth=4
