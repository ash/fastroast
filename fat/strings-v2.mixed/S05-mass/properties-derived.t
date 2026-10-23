use Test;

=begin pod

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/properties_slow_to_compile.t.

XXX needs more clarification on the case of the rules,
ie letter vs. Letter vs isLetter

Some notes regarding specific unicode codepoints chosen below
(based on Unicode 5.1):

   U+4DFF : just before the CJK Unified Ideographs block

=end pod

plan 213;

# ASCIIHexDigit

ok("\c[DIGIT ZERO]" ~~ m/^<:ASCIIHexDigit>$/, q{Ìà中개両 <:ÀÒ갂갈갈万e̲ч𝐃갢æ갢中>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!ASCIIHexDigit>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <ÀÒ갂갈갈万e̲ч𝐃갢æ갢中>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:ASCIIHexDigit>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <ÀÒ갂갈갈万e̲ч𝐃갢æ갢中>} );
ok(!( "\x[53BA]"  ~~ m/^<:ASCIIHexDigit>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <ÀÒ갂갈갈万e̲ч𝐃갢æ갢中>} );
ok("\x[53BA]"  ~~ m/^<:!ASCIIHexDigit>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <ÀÒ갂갈갈万e̲ч𝐃갢æ갢中>} );
ok("\x[53BA]"  ~~ m/^<-:ASCIIHexDigit>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <ÀÒ갂갈갈万e̲ч𝐃갢æ갢中>} );
ok("\x[53BA]\c[DIGIT ZERO]" ~~ m/<:ASCIIHexDigit>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <ÀÒ갂갈갈万e̲ч𝐃갢æ갢中>} );

# Dash


ok("\c[HYPHEN-MINUS]" ~~ m/^<:Dash>$/, q{Ìà中개両 <:𝐃àò両>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<:!Dash>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <𝐃àò両>} );
ok(!( "\c[HYPHEN-MINUS]" ~~ m/^<-:Dash>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <𝐃àò両>} );
ok(!( "\x[53F7]"  ~~ m/^<:Dash>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <𝐃àò両>} );
ok("\x[53F7]"  ~~ m/^<:!Dash>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <𝐃àò両>} );
ok("\x[53F7]"  ~~ m/^<-:Dash>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <𝐃àò両>} );
ok("\x[53F7]\c[HYPHEN-MINUS]" ~~ m/<:Dash>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <𝐃àò両>} );

# Diacritic


ok("\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<:Diacritic>$/, q{Ìà中개両 <:𝐃갢à개с갢中갢개>} );
ok(!( "\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<:!Diacritic>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <𝐃갢à개с갢中갢개>} );
ok(!( "\c[MODIFIER LETTER CAPITAL A]" ~~ m/^<-:Diacritic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <𝐃갢à개с갢中갢개>} );
ok(!( "\x[1BCD]"  ~~ m/^<:Diacritic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <𝐃갢à개с갢中갢개>} );
ok("\x[1BCD]"  ~~ m/^<:!Diacritic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <𝐃갢à개с갢中갢개>} );
ok("\x[1BCD]"  ~~ m/^<-:Diacritic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <𝐃갢à개с갢中갢개>} );
ok("\x[1BCD]\c[MODIFIER LETTER CAPITAL A]" ~~ m/<:Diacritic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <𝐃갢à개с갢中갢개>} );

# Extender


ok("\c[MIDDLE DOT]" ~~ m/^<:Extender>$/, q{Ìà中개両 <:E̲ч中e̲丧𝐝e̲с>} );
ok(!( "\c[MIDDLE DOT]" ~~ m/^<:!Extender>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <E̲ч中e̲丧𝐝e̲с>} );
ok(!( "\c[MIDDLE DOT]" ~~ m/^<-:Extender>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <E̲ч中e̲丧𝐝e̲с>} );
ok(!( "\x[3A18]"  ~~ m/^<:Extender>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <E̲ч中e̲丧𝐝e̲с>} );
ok("\x[3A18]"  ~~ m/^<:!Extender>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <E̲ч中e̲丧𝐝e̲с>} );
ok("\x[3A18]"  ~~ m/^<-:Extender>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <E̲ч中e̲丧𝐝e̲с>} );
ok("\x[3A18]\c[MIDDLE DOT]" ~~ m/<:Extender>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <E̲ч中e̲丧𝐝e̲с>} );

# GraphemeLink


#?rakudo.jvm    7 skip "isGraphemeLink"
ok("\c[HANUNOO SIGN PAMUDPOD]" ~~ m/^<:GraphemeLink>$/, q{Ìà中개両 <:Æсà𝐩両e̲ìe̲Л갢丧k̲>} );
ok(!( "\c[HANUNOO SIGN PAMUDPOD]" ~~ m/^<:!GraphemeLink>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Æсà𝐩両e̲ìe̲Л갢丧k̲>} );
ok(!( "\c[HANUNOO SIGN PAMUDPOD]" ~~ m/^<-:GraphemeLink>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Æсà𝐩両e̲ìe̲Л갢丧k̲>} );
ok(!( "\x[4989]"  ~~ m/^<:GraphemeLink>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Æсà𝐩両e̲ìe̲Л갢丧k̲>} );
ok("\x[4989]"  ~~ m/^<:!GraphemeLink>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Æсà𝐩両e̲ìe̲Л갢丧k̲>} );
ok("\x[4989]"  ~~ m/^<-:GraphemeLink>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Æсà𝐩両e̲ìe̲Л갢丧k̲>} );

# HexDigit


ok("\c[DIGIT ZERO]" ~~ m/^<:HexDigit>$/, q{Ìà中개両 <:万e̲ч𝐃갢æ갢中>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<:!HexDigit>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <万e̲ч𝐃갢æ갢中>} );
ok(!( "\c[DIGIT ZERO]" ~~ m/^<-:HexDigit>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <万e̲ч𝐃갢æ갢中>} );
ok(!( "\x[6292]"  ~~ m/^<:HexDigit>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <万e̲ч𝐃갢æ갢中>} );
ok("\x[6292]"  ~~ m/^<:!HexDigit>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <万e̲ч𝐃갢æ갢中>} );
ok("\x[6292]"  ~~ m/^<-:HexDigit>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <万e̲ч𝐃갢æ갢中>} );
ok("\x[6292]\c[DIGIT ZERO]" ~~ m/<:HexDigit>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <万e̲ч𝐃갢æ갢中>} );

# Hyphen

ok("\c[KATAKANA MIDDLE DOT]" ~~ m/^<:Hyphen>$/, q{Ìà中개両 <:万ù𝐩両e̲丧>} );
ok(!( "\c[KATAKANA MIDDLE DOT]" ~~ m/^<:!Hyphen>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <万ù𝐩両e̲丧>} );
ok(!( "\c[KATAKANA MIDDLE DOT]" ~~ m/^<-:Hyphen>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <万ù𝐩両e̲丧>} );
ok(!( "\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<:Hyphen>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <万ù𝐩両e̲丧>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<:!Hyphen>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <万ù𝐩両e̲丧>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]"  ~~ m/^<-:Hyphen>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <万ù𝐩両e̲丧>} );
ok("\c[BOX DRAWINGS DOWN DOUBLE AND LEFT SINGLE]\c[KATAKANA MIDDLE DOT]" ~~ m/<:Hyphen>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <万ù𝐩両e̲丧>} );

# Ideographic


ok("\x[8AB0]" ~~ m/^<:Ideographic>$/, q{Ìà中개両 <:갈𝐝e̲갨æсà𝐩両갢개>} );
ok(!( "\x[8AB0]" ~~ m/^<:!Ideographic>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈𝐝e̲갨æсà𝐩両갢개>} );
ok(!( "\x[8AB0]" ~~ m/^<-:Ideographic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈𝐝e̲갨æсà𝐩両갢개>} );
ok(!( "À"  ~~ m/^<:Ideographic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈𝐝e̲갨æсà𝐩両갢개>} );
ok("À"  ~~ m/^<:!Ideographic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈𝐝e̲갨æсà𝐩両갢개>} );
ok("À"  ~~ m/^<-:Ideographic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈𝐝e̲갨æсà𝐩両갢개>} );
ok("À\x[8AB0]" ~~ m/<:Ideographic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈𝐝e̲갨æсà𝐩両갢개>} );

# IDSBinaryOperator


ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:IDSBinaryOperator>$/, q{Ìà中개両 <:갈𝐃Ò丁갢丧àсù갎𝐩e̲сà中갨с>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<:!IDSBinaryOperator>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈𝐃Ò丁갢丧àсù갎𝐩e̲сà中갨с>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/^<-:IDSBinaryOperator>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈𝐃Ò丁갢丧àсù갎𝐩e̲сà中갨с>} );
ok(!( "\x[59E9]"  ~~ m/^<:IDSBinaryOperator>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈𝐃Ò丁갢丧àсù갎𝐩e̲сà中갨с>} );
ok("\x[59E9]"  ~~ m/^<:!IDSBinaryOperator>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈𝐃Ò丁갢丧àсù갎𝐩e̲сà中갨с>} );
ok("\x[59E9]"  ~~ m/^<-:IDSBinaryOperator>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈𝐃Ò丁갢丧àсù갎𝐩e̲сà中갨с>} );
ok("\x[59E9]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO RIGHT]" ~~ m/<:IDSBinaryOperator>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈𝐃Ò丁갢丧àсù갎𝐩e̲сà中갨с>} );

# IDSTrinaryOperator

ok("\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<:IDSTrinaryOperator>$/, q{Ìà中개両 <:갈𝐃Ò专с갢丧àсù갎𝐩e̲сà中갨с>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<:!IDSTrinaryOperator>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갈𝐃Ò专с갢丧àсù갎𝐩e̲сà中갨с>} );
ok(!( "\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/^<-:IDSTrinaryOperator>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갈𝐃Ò专с갢丧àсù갎𝐩e̲сà中갨с>} );
ok(!( "\x[9224]"  ~~ m/^<:IDSTrinaryOperator>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갈𝐃Ò专с갢丧àсù갎𝐩e̲сà中갨с>} );
ok("\x[9224]"  ~~ m/^<:!IDSTrinaryOperator>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갈𝐃Ò专с갢丧àсù갎𝐩e̲сà中갨с>} );
ok("\x[9224]"  ~~ m/^<-:IDSTrinaryOperator>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갈𝐃Ò专с갢丧àсù갎𝐩e̲сà中갨с>} );
ok("\x[9224]\c[IDEOGRAPHIC DESCRIPTION CHARACTER LEFT TO MIDDLE AND RIGHT]" ~~ m/<:IDSTrinaryOperator>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갈𝐃Ò专с갢丧àсù갎𝐩e̲сà中갨с>} );

# JoinControl


ok("\c[ZERO WIDTH NON-JOINER]" ~~ m/^<:JoinControl>$/, q{Ìà中개両 <:𝐉갨갢丧갂갨丧中с갨л>} );
ok(!( "\c[ZERO WIDTH NON-JOINER]" ~~ m/^<:!JoinControl>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <𝐉갨갢丧갂갨丧中с갨л>} );
ok(!( "\c[ZERO WIDTH NON-JOINER]" ~~ m/^<-:JoinControl>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <𝐉갨갢丧갂갨丧中с갨л>} );
ok(!( "\c[BENGALI LETTER DDHA]"  ~~ m/^<:JoinControl>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <𝐉갨갢丧갂갨丧中с갨л>} );
ok("\c[BENGALI LETTER DDHA]"  ~~ m/^<:!JoinControl>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <𝐉갨갢丧갂갨丧中с갨л>} );
ok("\c[BENGALI LETTER DDHA]"  ~~ m/^<-:JoinControl>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <𝐉갨갢丧갂갨丧中с갨л>} );
ok("\c[BENGALI LETTER DDHA]\n\c[ZERO WIDTH NON-JOINER]" ~~ m/<:JoinControl>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <𝐉갨갢丧갂갨丧中с갨л>} );

# LogicalOrderException


ok("\c[THAI CHARACTER SARA E]" ~~ m/^<:LogicalOrderException>$/, q{Ìà中개両 <:Л갨æ갢개àл갎с𝐝e̲сE̲ч개e̲𝐩中갢갨丧>} );
ok(!( "\c[THAI CHARACTER SARA E]" ~~ m/^<:!LogicalOrderException>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Л갨æ갢개àл갎с𝐝e̲сE̲ч개e̲𝐩中갢갨丧>} );
ok(!( "\c[THAI CHARACTER SARA E]" ~~ m/^<-:LogicalOrderException>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Л갨æ갢개àл갎с𝐝e̲сE̲ч개e̲𝐩中갢갨丧>} );
ok(!( "\x[857B]"  ~~ m/^<:LogicalOrderException>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Л갨æ갢개àл갎с𝐝e̲сE̲ч개e̲𝐩中갢갨丧>} );
ok("\x[857B]"  ~~ m/^<:!LogicalOrderException>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Л갨æ갢개àл갎с𝐝e̲сE̲ч개e̲𝐩中갢갨丧>} );
ok("\x[857B]"  ~~ m/^<-:LogicalOrderException>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Л갨æ갢개àл갎с𝐝e̲сE̲ч개e̲𝐩中갢갨丧>} );
ok(!( "\x[857B]" ~~ m/^<:LogicalOrderException>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <Л갨æ갢개àл갎с𝐝e̲сE̲ч개e̲𝐩中갢갨丧>} );
ok("\x[857B]" ~~ m/^<:!LogicalOrderException>$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Л갨æ갢개àл갎с𝐝e̲сE̲ч개e̲𝐩中갢갨丧>} );
ok("\x[857B]" ~~ m/^<-:LogicalOrderException>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Л갨æ갢개àл갎с𝐝e̲сE̲ч개e̲𝐩中갢갨丧>} );
ok("\x[857B]\x[857B]\c[THAI CHARACTER SARA E]" ~~ m/<:LogicalOrderException>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Л갨æ갢개àл갎с𝐝e̲сE̲ч개e̲𝐩中갢갨丧>} );

# NoncharacterCodePoint

ok(!( "\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<:NoncharacterCodePoint>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <不갨丧개両àсà개中e̲с갂갨𝐝e̲𝐏갨갢丧中>} );
ok("\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<:!NoncharacterCodePoint>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <不갨丧개両àсà개中e̲с갂갨𝐝e̲𝐏갨갢丧中>} );
ok("\c[LATIN LETTER REVERSED GLOTTAL STOP WITH STROKE]"  ~~ m/^<-:NoncharacterCodePoint>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <不갨丧개両àсà개中e̲с갂갨𝐝e̲𝐏갨갢丧中>} );
ok(!( "\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<:NoncharacterCodePoint>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <不갨丧개両àсà개中e̲с갂갨𝐝e̲𝐏갨갢丧中>} );
ok("\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<:!NoncharacterCodePoint>$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <不갨丧개両àсà개中e̲с갂갨𝐝e̲𝐏갨갢丧中>} );
ok("\c[ARABIC-INDIC DIGIT ZERO]" ~~ m/^<-:NoncharacterCodePoint>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <不갨丧개両àсà개中e̲с갂갨𝐝e̲𝐏갨갢丧中>} );


# QuotationMark


ok("\c[QUOTATION MARK]" ~~ m/^<:QuotationMark>$/, q{Ìà中개両 <:Q̲갮갨中à中갢갨丧Ìàсk̲>} );
ok(!( "\c[QUOTATION MARK]" ~~ m/^<:!QuotationMark>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Q̲갮갨中à中갢갨丧Ìàсk̲>} );
ok(!( "\c[QUOTATION MARK]" ~~ m/^<-:QuotationMark>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Q̲갮갨中à中갢갨丧Ìàсk̲>} );
ok(!( "\x[C890]"  ~~ m/^<:QuotationMark>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Q̲갮갨中à中갢갨丧Ìàсk̲>} );
ok("\x[C890]"  ~~ m/^<:!QuotationMark>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Q̲갮갨中à中갢갨丧Ìàсk̲>} );
ok("\x[C890]"  ~~ m/^<-:QuotationMark>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Q̲갮갨中à中갢갨丧Ìàсk̲>} );
ok("\x[C890]\c[QUOTATION MARK]" ~~ m/<:QuotationMark>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Q̲갮갨中à中갢갨丧Ìàсk̲>} );

# Radical


ok("\c[CJK RADICAL REPEAT]" ~~ m/^<:Radical>$/, q{Ìà中개両 <:Сà𝐝갢개àл>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<:!Radical>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Сà𝐝갢개àл>} );
ok(!( "\c[CJK RADICAL REPEAT]" ~~ m/^<-:Radical>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Сà𝐝갢개àл>} );
ok(!( "\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<:Radical>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Сà𝐝갢개àл>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<:!Radical>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Сà𝐝갢개àл>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]"  ~~ m/^<-:Radical>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Сà𝐝갢개àл>} );
ok("\c[HANGUL JONGSEONG CHIEUCH]\c[CJK RADICAL REPEAT]" ~~ m/<:Radical>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Сà𝐝갢개àл>} );

# SoftDotted


ok("\c[LATIN SMALL LETTER I]" ~~ m/^<:SoftDotted>$/, q{Ìà中개両 <:Ò갨е中𝐃갨中中e̲𝐝>} );
ok(!( "\c[LATIN SMALL LETTER I]" ~~ m/^<:!SoftDotted>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <Ò갨е中𝐃갨中中e̲𝐝>} );
ok(!( "\c[LATIN SMALL LETTER I]" ~~ m/^<-:SoftDotted>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <Ò갨е中𝐃갨中中e̲𝐝>} );
ok(!( "\x[ADEF]"  ~~ m/^<:SoftDotted>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <Ò갨е中𝐃갨中中e̲𝐝>} );
ok("\x[ADEF]"  ~~ m/^<:!SoftDotted>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Ò갨е中𝐃갨中中e̲𝐝>} );
ok("\x[ADEF]"  ~~ m/^<-:SoftDotted>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Ò갨е中𝐃갨中中e̲𝐝>} );
ok(!( "\c[DOLLAR SIGN]" ~~ m/^<:SoftDotted>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 <Ò갨е中𝐃갨中中e̲𝐝>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<:!SoftDotted>$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <Ò갨е中𝐃갨中中e̲𝐝>} );
ok("\c[DOLLAR SIGN]" ~~ m/^<-:SoftDotted>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <Ò갨е中𝐃갨中中e̲𝐝>} );
ok("\x[ADEF]\c[DOLLAR SIGN]\c[LATIN SMALL LETTER I]" ~~ m/<:SoftDotted>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <Ò갨е中𝐃갨中中e̲𝐝>} );

# TerminalPunctuation


ok("\c[EXCLAMATION MARK]" ~~ m/^<:TerminalPunctuation>$/, q{Ìà中개両 <:专e̲сì갢丧àл𝐏갮丧개中갮à中갢갨丧>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<:!TerminalPunctuation>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <专e̲сì갢丧àл𝐏갮丧개中갮à中갢갨丧>} );
ok(!( "\c[EXCLAMATION MARK]" ~~ m/^<-:TerminalPunctuation>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <专e̲сì갢丧àл𝐏갮丧개中갮à中갢갨丧>} );
ok(!( "\x[3C9D]"  ~~ m/^<:TerminalPunctuation>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <专e̲сì갢丧àл𝐏갮丧개中갮à中갢갨丧>} );
ok("\x[3C9D]"  ~~ m/^<:!TerminalPunctuation>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <专e̲сì갢丧àл𝐏갮丧개中갮à中갢갨丧>} );
ok("\x[3C9D]"  ~~ m/^<-:TerminalPunctuation>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <专e̲сì갢丧àл𝐏갮丧개中갮à中갢갨丧>} );
ok("\x[3C9D]\c[EXCLAMATION MARK]" ~~ m/<:TerminalPunctuation>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <专e̲сì갢丧àл𝐏갮丧개中갮à中갢갨丧>} );

# UnifiedIdeograph


ok("\x[7896]" ~~ m/^<:UnifiedIdeograph>$/, q{Ìà中개両 <:갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両>} );
ok(!( "\x[7896]" ~~ m/^<:!UnifiedIdeograph>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両>} );
ok(!( "\x[7896]" ~~ m/^<-:UnifiedIdeograph>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両>} );
ok(!( "\x[4DFF]"  ~~ m/^<:UnifiedIdeograph>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両>} );
ok("\x[4DFF]"  ~~ m/^<:!UnifiedIdeograph>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両>} );
ok("\x[4DFF]"  ~~ m/^<-:UnifiedIdeograph>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両>} );
ok("\x[4DFF]\x[7896]" ~~ m/<:UnifiedIdeograph>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <갔丧갢е갢e̲𝐝갈𝐝e̲갨æсà𝐩両>} );

# WhiteSpace


ok("\c[CHARACTER TABULATION]" ~~ m/^<:WhiteSpace>$/, q{Ìà中개両 <:W̲両갢中e̲Ò𝐩à개e̲>} );
ok(!( "\c[CHARACTER TABULATION]" ~~ m/^<:!WhiteSpace>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 <W̲両갢中e̲Ò𝐩à개e̲>} );
ok(!( "\c[CHARACTER TABULATION]" ~~ m/^<-:WhiteSpace>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 <W̲両갢中e̲Ò𝐩à개e̲>} );
ok(!( "\x[6358]"  ~~ m/^<:WhiteSpace>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 <W̲両갢中e̲Ò𝐩à개e̲>} );
ok("\x[6358]"  ~~ m/^<:!WhiteSpace>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 <W̲両갢中e̲Ò𝐩à개e̲>} );
ok("\x[6358]"  ~~ m/^<-:WhiteSpace>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 <W̲両갢中e̲Ò𝐩à개e̲>} );
ok("\x[6358]\c[CHARACTER TABULATION]" ~~ m/<:WhiteSpace>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 <W̲両갢中e̲Ò𝐩à개e̲>} );

# Alphabetic      # Lu + Ll + Lt + Lm + Lo + OtherAlphabetic


ok("\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<:Alphabetic>$/, q{Ìà中개両 (Л갮 + Лл + Л中 + Лì + Л갨 + 갎中両e̲сÀл𝐩両à丛e̲中갢개)} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<:!Alphabetic>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 갎中両e̲сÀл𝐩両à丛e̲中갢개)} );
ok(!( "\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/^<-:Alphabetic>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 갎中両e̲сÀл𝐩両à丛e̲中갢개)} );
ok(!( "\x[297C]"  ~~ m/^<:Alphabetic>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 갎中両e̲сÀл𝐩両à丛e̲中갢개)} );
ok("\x[297C]"  ~~ m/^<:!Alphabetic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 갎中両e̲сÀл𝐩両à丛e̲中갢개)} );
ok("\x[297C]"  ~~ m/^<-:Alphabetic>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 갎中両e̲сÀл𝐩両à丛e̲中갢개)} );
ok("\x[297C]\n\c[DEVANAGARI SIGN CANDRABINDU]" ~~ m/<:Alphabetic>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 갎中両e̲сÀл𝐩両à丛e̲中갢개)} );

# Lowercase       # Ll + OtherLowercase


ok("\c[LATIN SMALL LETTER A]" ~~ m/^<:Lowercase>$/, q{Ìà中개両 (Лл + 갎中両e̲сЛ갨w̲e̲с개àòe̲)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<:!Lowercase>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (Лл + 갎中両e̲сЛ갨w̲e̲с개àòe̲)} );
ok(!( "\c[LATIN SMALL LETTER A]" ~~ m/^<-:Lowercase>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (Лл + 갎中両e̲сЛ갨w̲e̲с개àòe̲)} );
ok(!( "\x[6220]"  ~~ m/^<:Lowercase>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (Лл + 갎中両e̲сЛ갨w̲e̲с개àòe̲)} );
ok("\x[6220]"  ~~ m/^<:!Lowercase>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (Лл + 갎中両e̲сЛ갨w̲e̲с개àòe̲)} );
ok("\x[6220]"  ~~ m/^<-:Lowercase>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (Лл + 갎中両e̲сЛ갨w̲e̲с개àòe̲)} );
ok(!( "\x[6220]" ~~ m/^<:Lowercase>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 (Лл + 갎中両e̲сЛ갨w̲e̲с개àòe̲)} );
ok("\x[6220]" ~~ m/^<:!Lowercase>$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (Лл + 갎中両e̲сЛ갨w̲e̲с개àòe̲)} );
ok("\x[6220]" ~~ m/^<-:Lowercase>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (Лл + 갎中両e̲сЛ갨w̲e̲с개àòe̲)} );
ok("\x[6220]\x[6220]\c[LATIN SMALL LETTER A]" ~~ m/<:Lowercase>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (Лл + 갎中両e̲сЛ갨w̲e̲с개àòe̲)} );

# Uppercase       # Lu + OtherUppercase


ok("\c[LATIN CAPITAL LETTER A]" ~~ m/^<:Uppercase>$/, q{Ìà中개両 (Л갮 + 갎中両e̲с갔𝐩𝐩e̲с개àòe̲)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<:!Uppercase>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (Л갮 + 갎中両e̲с갔𝐩𝐩e̲с개àòe̲)} );
ok(!( "\c[LATIN CAPITAL LETTER A]" ~~ m/^<-:Uppercase>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (Л갮 + 갎中両e̲с갔𝐩𝐩e̲с개àòe̲)} );
ok(!( "\x[C080]"  ~~ m/^<:Uppercase>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (Л갮 + 갎中両e̲с갔𝐩𝐩e̲с개àòe̲)} );
ok("\x[C080]"  ~~ m/^<:!Uppercase>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (Л갮 + 갎中両e̲с갔𝐩𝐩e̲с개àòe̲)} );
ok("\x[C080]"  ~~ m/^<-:Uppercase>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (Л갮 + 갎中両e̲с갔𝐩𝐩e̲с개àòe̲)} );
ok("\x[C080]\c[LATIN CAPITAL LETTER A]" ~~ m/<:Uppercase>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (Л갮 + 갎中両e̲с갔𝐩𝐩e̲с개àòe̲)} );

# Math            # Sm + OtherMath


ok("\c[PLUS SIGN]" ~~ m/^<:Math>$/, q{Ìà中개両 (Òì + 갎中両e̲сÌà中両)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<:!Math>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (Òì + 갎中両e̲сÌà中両)} );
ok(!( "\c[PLUS SIGN]" ~~ m/^<-:Math>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (Òì + 갎中両e̲сÌà中両)} );
ok(!( "\x[D4D2]"  ~~ m/^<:Math>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (Òì + 갎中両e̲сÌà中両)} );
ok("\x[D4D2]"  ~~ m/^<:!Math>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (Òì + 갎中両e̲сÌà中両)} );
ok("\x[D4D2]"  ~~ m/^<-:Math>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (Òì + 갎中両e̲сÌà中両)} );
ok(!( "\c[COMBINING GRAVE ACCENT]" ~~ m/^<:Math>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 (Òì + 갎中両e̲сÌà中両)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<:!Math>$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (Òì + 갎中両e̲сÌà中両)} );
ok("\c[COMBINING GRAVE ACCENT]" ~~ m/^<-:Math>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (Òì + 갎中両e̲сÌà中両)} );
ok("\x[D4D2]\c[COMBINING GRAVE ACCENT]\c[PLUS SIGN]" ~~ m/<:Math>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (Òì + 갎中両e̲сÌà中両)} );

# ID_Start        # Lu + Ll + Lt + Lm + Lo + Nl


ok("\x[C276]" ~~ m/^<:ID_Start>$/, q{Ìà中개両 (Л갮 + Лл + Л中 + Лì + Л갨 + 不л)} );
ok(!( "\x[C276]" ~~ m/^<:!ID_Start>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 不л)} );
ok(!( "\x[C276]" ~~ m/^<-:ID_Start>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 不л)} );
ok(!( "\x[D7A4]"  ~~ m/^<:ID_Start>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 不л)} );
ok("\x[D7A4]"  ~~ m/^<:!ID_Start>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 不л)} );
ok("\x[D7A4]"  ~~ m/^<-:ID_Start>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 不л)} );
ok("\x[D7A4]\x[C276]" ~~ m/<:ID_Start>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (Л갮 + Лл + Л中 + Лì + Л갨 + 不л)} );

# ID_Continue     # ID_Start + Mn + Mc + Nd + Pc


ok("\x[949B]" ~~ m/^<:ID_Continue>$/, q{Ìà中개両 (갈𝐃_Ò中àс中 + Ì丧 + Ì개 + 不𝐝 + 𝐏개)} );
ok(!( "\x[949B]" ~~ m/^<:!ID_Continue>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (갈𝐃_Ò中àс中 + Ì丧 + Ì개 + 不𝐝 + 𝐏개)} );
ok(!( "\x[949B]" ~~ m/^<-:ID_Continue>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (갈𝐃_Ò中àс中 + Ì丧 + Ì개 + 不𝐝 + 𝐏개)} );
ok(!( "\x[0BD1]"  ~~ m/^<:ID_Continue>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (갈𝐃_Ò中àс中 + Ì丧 + Ì개 + 不𝐝 + 𝐏개)} );
ok("\x[0BD1]"  ~~ m/^<:!ID_Continue>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (갈𝐃_Ò中àс中 + Ì丧 + Ì개 + 不𝐝 + 𝐏개)} );
ok("\x[0BD1]"  ~~ m/^<-:ID_Continue>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (갈𝐃_Ò中àс中 + Ì丧 + Ì개 + 不𝐝 + 𝐏개)} );
ok("\x[0BD1]\x[949B]" ~~ m/<:ID_Continue>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (갈𝐃_Ò中àс中 + Ì丧 + Ì개 + 不𝐝 + 𝐏개)} );

# Any             # Any character

#?rakudo.jvm 4 skip 'isAny NYI'
ok("\x[C709]" ~~ m/^<:Any>$/, q{Ìà中개両 (À丧ù 개両àсà개中e̲с)} );
ok(!( "\x[C709]" ~~ m/^<:!Any>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (À丧ù 개両àсà개中e̲с)} );
ok(!( "\x[C709]" ~~ m/^<-:Any>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (À丧ù 개両àсà개中e̲с)} );
ok("\x[C709]" ~~ m/<:Any>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (À丧ù 개両àсà개中e̲с)} );

# Assigned        # Any non-Cn character (i.e. synonym for \P{Cn})


ok("\x[C99D]" ~~ m/^<:Assigned>$/, q<Ìà中개両 (À丧ù 丧갨丧-갂丧 개両àсà개中e̲с (갢.e̲. òù丧갨丧ùì е갨с \P{Cn}))> );
ok(!( "\x[C99D]" ~~ m/^<:!Assigned>$/ ), q<𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (À丧ù 丧갨丧-갂丧 개両àсà개中e̲с (갢.e̲. òù丧갨丧ùì е갨с \P{Cn}))> );
ok(!( "\x[C99D]" ~~ m/^<-:Assigned>$/ ), q<𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (À丧ù 丧갨丧-갂丧 개両àсà개中e̲с (갢.e̲. òù丧갨丧ùì е갨с \P{Cn}))> );
ok(!( "\x[D7A4]"  ~~ m/^<:Assigned>$/ ), q<𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (À丧ù 丧갨丧-갂丧 개両àсà개中e̲с (갢.e̲. òù丧갨丧ùì е갨с \P{Cn}))> );
ok("\x[D7A4]"  ~~ m/^<:!Assigned>$/, q<Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (À丧ù 丧갨丧-갂丧 개両àсà개中e̲с (갢.e̲. òù丧갨丧ùì е갨с \P{Cn}))> );
ok("\x[D7A4]"  ~~ m/^<-:Assigned>$/, q<Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (À丧ù 丧갨丧-갂丧 개両àсà개中e̲с (갢.e̲. òù丧갨丧ùì е갨с \P{Cn}))> );
ok("\x[D7A4]\x[C99D]" ~~ m/<:Assigned>/, q<Ìà中개両 갮丧à丧개両갨сe̲𝐝 (À丧ù 丧갨丧-갂丧 개両àсà개中e̲с (갢.e̲. òù丧갨丧ùì е갨с \P{Cn}))> );

# Unassigned      # Synonym for \p{Cn}


#?rakudo.jvm todo 'isUnassigned NYI'
ok("\x[110E9]" ~~ m/^<:Unassigned>$/, q<Ìà中개両 (Òù丧갨丧ùì е갨с \p{Cn})> );
ok(!( "\x[110E9]" ~~ m/^<:!Unassigned>$/ ), q<𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (Òù丧갨丧ùì е갨с \p{Cn})> );
ok(!( "\x[110E9]" ~~ m/^<-:Unassigned>$/ ), q<𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (Òù丧갨丧ùì е갨с \p{Cn})> );
ok(!( "\c[RIGHT OUTER JOIN]"  ~~ m/^<:Unassigned>$/ ), q<𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (Òù丧갨丧ùì е갨с \p{Cn})> );
ok("\c[RIGHT OUTER JOIN]"  ~~ m/^<:!Unassigned>$/, q<Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (Òù丧갨丧ùì е갨с \p{Cn})> );
ok("\c[RIGHT OUTER JOIN]"  ~~ m/^<-:Unassigned>$/, q<Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (Òù丧갨丧ùì е갨с \p{Cn})> );
ok("\c[RIGHT OUTER JOIN]\x[110E9]" ~~ m/<:Unassigned>/, q<Ìà中개両 갮丧à丧개両갨сe̲𝐝 (Òù丧갨丧ùì е갨с \p{Cn})> );

# Common          # Codepoint not explicitly assigned to a script


#?rakudo.jvm 10 skip 'isCommon NYI'
ok("\c[ELECTRIC LIGHT BULB]" ~~ m/^<:Common>$/, q{Ìà中개両 (갂갨𝐝e̲𝐩갨갢丧中 丧갨中 e̲ч𝐩л갢개갢中лù àòò갢æ丧e̲𝐝 中갨 à ò개с갢𝐩中)} );
ok(!( "\c[ELECTRIC LIGHT BULB]" ~~ m/^<:!Common>$/ ), q{𝐃갨丧'中 ìà中개両 丧e̲æà中e̲𝐝 (갂갨𝐝e̲𝐩갨갢丧中 丧갨中 e̲ч𝐩л갢개갢中лù àòò갢æ丧e̲𝐝 中갨 à ò개с갢𝐩中)} );
ok(!( "\c[ELECTRIC LIGHT BULB]" ~~ m/^<-:Common>$/ ), q{𝐃갨丧'中 ìà中개両 갢丧𝐯e̲с中e̲𝐝 (갂갨𝐝e̲𝐩갨갢丧中 丧갨中 e̲ч𝐩л갢개갢中лù àòò갢æ丧e̲𝐝 中갨 à ò개с갢𝐩中)} );
ok(!( "\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<:Common>$/ ), q{𝐃갨丧'中 ìà中개両 갮丧сe̲лà中e̲𝐝 (갂갨𝐝e̲𝐩갨갢丧中 丧갨中 e̲ч𝐩л갢개갢中лù àòò갢æ丧e̲𝐝 中갨 à ò개с갢𝐩中)} );
ok("\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<:!Common>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (갂갨𝐝e̲𝐩갨갢丧中 丧갨中 e̲ч𝐩л갢개갢中лù àòò갢æ丧e̲𝐝 中갨 à ò개с갢𝐩中)} );
ok("\c[KANNADA SIGN ANUSVARA]"  ~~ m/^<-:Common>$/, q{Ìà中개両 갮丧сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (갂갨𝐝e̲𝐩갨갢丧中 丧갨中 e̲ч𝐩л갢개갢中лù àòò갢æ丧e̲𝐝 中갨 à ò개с갢𝐩中)} );
ok(!( "\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<:Common>$/ ), q{𝐃갨丧'中 ìà中개両 сe̲лà中e̲𝐝 (갂갨𝐝e̲𝐩갨갢丧中 丧갨中 e̲ч𝐩л갢개갢中лù àòò갢æ丧e̲𝐝 中갨 à ò개с갢𝐩中)} );
ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<:!Common>$/, q{Ìà中개両 сe̲лà中e̲𝐝 丧e̲æà中e̲𝐝 (갂갨𝐝e̲𝐩갨갢丧中 丧갨中 e̲ч𝐩л갢개갢中лù àòò갢æ丧e̲𝐝 中갨 à ò개с갢𝐩中)} );
ok("\c[KHMER VOWEL INHERENT AQ]" ~~ m/^<-:Common>$/, q{Ìà中개両 сe̲лà中e̲𝐝 갢丧𝐯e̲с中e̲𝐝 (갂갨𝐝e̲𝐩갨갢丧中 丧갨中 e̲ч𝐩л갢개갢中лù àòò갢æ丧e̲𝐝 中갨 à ò개с갢𝐩中)} );
ok("\c[KANNADA SIGN ANUSVARA]\c[KHMER VOWEL INHERENT AQ]\c[ELECTRIC LIGHT BULB]" ~~ m/<:Common>/, q{Ìà中개両 갮丧à丧개両갨сe̲𝐝 (갂갨𝐝e̲𝐩갨갢丧中 丧갨中 e̲ч𝐩л갢개갢中лù àòò갢æ丧e̲𝐝 中갨 à ò개с갢𝐩中)} );

# TODO: missing properties which are broken up to Perl 5.10 e.g.
# Grapheme_Base
# Grapheme_Extend
# Grapheme_Cluster_Break=CN
# Grapheme_Cluster_Break=Control
# Grapheme_Cluster_Break=CR
# Grapheme_Cluster_Break=EX
# Grapheme_Cluster_Break=Extend
# Grapheme_Cluster_Break=L
# Grapheme_Cluster_Break=LF
# Grapheme_Cluster_Break=LV
# Grapheme_Cluster_Break=LVT
# Grapheme_Cluster_Break=Other
# Grapheme_Cluster_Break=PP
# Grapheme_Cluster_Break=Prepend
# Grapheme_Cluster_Break=SM
# Grapheme_Cluster_Break=SpacingMark
# Grapheme_Cluster_Break=T
# Grapheme_Cluster_Break=V
# Grapheme_Cluster_Break=XX

# vim: expandtab shiftwidth=4
