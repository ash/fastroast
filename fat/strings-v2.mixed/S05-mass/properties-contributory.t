use Test;


plan 41;

# OtherAlphabetic

ok("\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<:OtherAlphabetic>$/, q{Ìà中개両 <:갎中両e̲сÀл𝐩両à丛e̲中갢개>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<:!OtherAlphabetic>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갎中両e̲сÀл𝐩両à丛e̲中갢개>} );
ok(!( "\c[COMBINING GREEK YPOGEGRAMMENI]" ~~ m/^<-:OtherAlphabetic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲сÀл𝐩両à丛e̲中갢개>} );
ok(!( "\x[413C]"  ~~ m/^<:OtherAlphabetic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갎中両e̲сÀл𝐩両à丛e̲中갢개>} );
ok("\x[413C]"  ~~ m/^<:!OtherAlphabetic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갎中両e̲сÀл𝐩両à丛e̲中갢개>} );
ok("\x[413C]"  ~~ m/^<-:OtherAlphabetic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲сÀл𝐩両à丛e̲中갢개>} );

# OtherDefaultIgnorableCodePoint


ok("\c[HANGUL FILLER]" ~~ m/^<:OtherDefaultIgnorableCodePoint>$/, q{Ìà中개両 <:갎中両e̲с𝐃e̲еà갮л中갈æ丧갨сà丛лe̲갂갨𝐝e̲𝐏갨갢丧中>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<:!OtherDefaultIgnorableCodePoint>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갎中両e̲с𝐃e̲еà갮л中갈æ丧갨сà丛лe̲갂갨𝐝e̲𝐏갨갢丧中>} );
ok(!( "\c[HANGUL FILLER]" ~~ m/^<-:OtherDefaultIgnorableCodePoint>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲с𝐃e̲еà갮л中갈æ丧갨сà丛лe̲갂갨𝐝e̲𝐏갨갢丧中>} );
ok(!( "\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<:OtherDefaultIgnorableCodePoint>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갎中両e̲с𝐃e̲еà갮л中갈æ丧갨сà丛лe̲갂갨𝐝e̲𝐏갨갢丧中>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<:!OtherDefaultIgnorableCodePoint>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갎中両e̲с𝐃e̲еà갮л中갈æ丧갨сà丛лe̲갂갨𝐝e̲𝐏갨갢丧中>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]"  ~~ m/^<-:OtherDefaultIgnorableCodePoint>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲с𝐃e̲еà갮л中갈æ丧갨сà丛лe̲갂갨𝐝e̲𝐏갨갢丧中>} );
ok("\c[VERTICAL BAR DOUBLE LEFT TURNSTILE]\c[HANGUL FILLER]" ~~ m/<:OtherDefaultIgnorableCodePoint>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갎中両e̲с𝐃e̲еà갮л中갈æ丧갨сà丛лe̲갂갨𝐝e̲𝐏갨갢丧中>} );

# OtherGraphemeExtend


ok("\c[BENGALI VOWEL SIGN AA]" ~~ m/^<:OtherGraphemeExtend>$/, q{Ìà中개両 <:갎中両e̲сÆсà𝐩両e̲ìe̲E̲ч中e̲丧𝐝>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<:!OtherGraphemeExtend>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갎中両e̲сÆсà𝐩両e̲ìe̲E̲ч中e̲丧𝐝>} );
ok(!( "\c[BENGALI VOWEL SIGN AA]" ~~ m/^<-:OtherGraphemeExtend>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲сÆсà𝐩両e̲ìe̲E̲ч中e̲丧𝐝>} );
ok(!( "\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<:OtherGraphemeExtend>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갎中両e̲сÆсà𝐩両e̲ìe̲E̲ч中e̲丧𝐝>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<:!OtherGraphemeExtend>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갎中両e̲сÆсà𝐩両e̲ìe̲E̲ч中e̲丧𝐝>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]"  ~~ m/^<-:OtherGraphemeExtend>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲сÆсà𝐩両e̲ìe̲E̲ч中e̲丧𝐝>} );
ok("\c[APL FUNCTIONAL SYMBOL EPSILON UNDERBAR]\n\c[BENGALI VOWEL SIGN AA]" ~~ m/<:OtherGraphemeExtend>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갎中両e̲сÆсà𝐩両e̲ìe̲E̲ч中e̲丧𝐝>} );

# OtherLowercase


ok("\c[MODIFIER LETTER SMALL H]" ~~ m/^<:OtherLowercase>$/, q{Ìà中개両 <:갎中両e̲сЛ갨w̲e̲с개àòe̲>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<:!OtherLowercase>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갎中両e̲сЛ갨w̲e̲с개àòe̲>} );
ok(!( "\c[MODIFIER LETTER SMALL H]" ~~ m/^<-:OtherLowercase>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲сЛ갨w̲e̲с개àòe̲>} );
ok(!( "\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<:OtherLowercase>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갎中両e̲сЛ갨w̲e̲с개àòe̲>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<:!OtherLowercase>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갎中両e̲сЛ갨w̲e̲с개àòe̲>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]"  ~~ m/^<-:OtherLowercase>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲сЛ갨w̲e̲с개àòe̲>} );
ok("\c[HANGUL LETTER NIEUN-CIEUC]\c[MODIFIER LETTER SMALL H]" ~~ m/<:OtherLowercase>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갎中両e̲сЛ갨w̲e̲с개àòe̲>} );

# OtherMath


ok("\c[SUPERSCRIPT LEFT PARENTHESIS]" ~~ m/^<:OtherMath>$/, q{Ìà中개両 <:갎中両e̲сÌà中両>} );
ok(!( "\c[SUPERSCRIPT LEFT PARENTHESIS]" ~~ m/^<:!OtherMath>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갎中両e̲сÌà中両>} );
ok(!( "\c[SUPERSCRIPT LEFT PARENTHESIS]" ~~ m/^<-:OtherMath>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲сÌà中両>} );
ok(!( "\x[B43A]"  ~~ m/^<:OtherMath>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갎中両e̲сÌà中両>} );
ok("\x[B43A]"  ~~ m/^<:!OtherMath>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갎中両e̲сÌà中両>} );
ok("\x[B43A]"  ~~ m/^<-:OtherMath>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲сÌà中両>} );
ok("\x[B43A]\c[SUPERSCRIPT LEFT PARENTHESIS]" ~~ m/<:OtherMath>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갎中両e̲сÌà中両>} );

# OtherUppercase


ok("\c[ROMAN NUMERAL ONE]" ~~ m/^<:OtherUppercase>$/, q{Ìà中개両 <:갎中両e̲с갔𝐩𝐩e̲с개àòe̲>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<:!OtherUppercase>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갎中両e̲с갔𝐩𝐩e̲с개àòe̲>} );
ok(!( "\c[ROMAN NUMERAL ONE]" ~~ m/^<-:OtherUppercase>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲с갔𝐩𝐩e̲с개àòe̲>} );
ok(!( "\x[D246]"  ~~ m/^<:OtherUppercase>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갎中両e̲с갔𝐩𝐩e̲с개àòe̲>} );
ok("\x[D246]"  ~~ m/^<:!OtherUppercase>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갎中両e̲с갔𝐩𝐩e̲с개àòe̲>} );
ok("\x[D246]"  ~~ m/^<-:OtherUppercase>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갎中両e̲с갔𝐩𝐩e̲с개àòe̲>} );
ok("\x[D246]\c[ROMAN NUMERAL ONE]" ~~ m/<:OtherUppercase>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갎中両e̲с갔𝐩𝐩e̲с개àòe̲>} );

# vim: expandtab shiftwidth=4
