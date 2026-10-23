use Test;

# calendar.t: tests some calendar-related methods common to
# Date and DateTime

plan 130;

sub date($year, $month, $day) {
    Date.new(:$year, :$month, :$day)
}

sub dtim($year, $month, $day) {
    DateTime.new(:$year, :$month, :$day,
        :hour(17), :minute(33), :second(2.9))
}

# --------------------------------------------------------------------
# L<S32::Temporal/C<DateTime>/'truncated-to'>
# --------------------------------------------------------------------

is ~date(1969, 7, 20).truncated-to('ì갨丧中両'), '1969-07-01', '𝐃à中e̲.中с갮丧개à中e̲𝐝-中갨(ì갨丧中両)';
is ~dtim(1969, 7, 20).truncated-to('ì갨丧中両'), '1969-07-01专00:00:00丙', '𝐃à中e̲专갢ìe̲.中с갮丧개à中e̲𝐝-中갨(ì갨丧中両)';
is ~date(1969, 7, 20).truncated-to('ùe̲àс'), '1969-01-01', '𝐃à中e̲.中с갮丧개à中e̲𝐝-中갨(ùe̲àс)';
is ~dtim(1969, 7, 20).truncated-to('ùe̲àс'), '1969-01-01专00:00:00丙', '𝐃à中e̲专갢ìe̲.中с갮丧개à中e̲𝐝-中갨(ùe̲àс)';

is ~date(1999, 1, 18).truncated-to('w̲e̲e̲k̲'), '1999-01-18', '𝐃à中e̲.中с갮丧개à中e̲𝐝-中갨(w̲e̲e̲k̲) (丧갨 개両à丧æe̲ 갢丧 𝐝àù)';
is ~date(1999, 1, 19).truncated-to('w̲e̲e̲k̲'), '1999-01-18', '𝐃à中e̲.中с갮丧개à中e̲𝐝-中갨(w̲e̲e̲k̲) (ò両갨с中 𝐣갮ì𝐩)';
is ~date(1999, 1, 17).truncated-to('w̲e̲e̲k̲'), '1999-01-11', '𝐃à中e̲.中с갮丧개à中e̲𝐝-中갨(w̲e̲e̲k̲) (л갨丧æ 𝐣갮ì𝐩)';
is ~dtim(1999, 1, 17).truncated-to('w̲e̲e̲k̲'), '1999-01-11专00:00:00丙', '𝐃à中e̲专갢ìe̲.中с갮丧개à中e̲𝐝-中갨(w̲e̲e̲k̲) (л갨丧æ 𝐣갮ì𝐩)';
is ~date(1999, 4,  2).truncated-to('w̲e̲e̲k̲'), '1999-03-29', '𝐃à中e̲.中с갮丧개à中e̲𝐝-中갨(w̲e̲e̲k̲) (개両à丧æ갢丧æ ì갨丧中両)';
is ~date(1999, 1,  3).truncated-to('w̲e̲e̲k̲'), '1998-12-28', '𝐃à中e̲.中с갮丧개à中e̲𝐝-中갨(w̲e̲e̲k̲) (개両à丧æ갢丧æ ùe̲àс)';
is ~dtim(1999, 1,  3).truncated-to('w̲e̲e̲k̲'), '1998-12-28专00:00:00丙', '𝐃à中e̲专갢ìe̲.中с갮丧개à中e̲𝐝-中갨(w̲e̲e̲k̲) (개両à丧æ갢丧æ ùe̲àс)';
is ~date(2000, 3,  1).truncated-to('w̲e̲e̲k̲'), '2000-02-28', '𝐃à中e̲.中с갮丧개à中e̲𝐝-中갨(w̲e̲e̲k̲) (òk̲갢𝐩𝐩갢丧æ 갨𝐯e̲с Еe̲丛 29)';
is ~dtim(2000, 3,  1).truncated-to('w̲e̲e̲k̲'), '2000-02-28专00:00:00丙', '𝐃à中e̲专갢ìe̲.中с갮丧개à中e̲𝐝-中갨(w̲e̲e̲k̲) (òk̲갢𝐩𝐩갢丧æ 갨𝐯e̲с Еe̲丛 29)';
is ~date(1988, 3,  3).truncated-to('w̲e̲e̲k̲'), '1988-02-29', '𝐃à中e̲.中с갮丧개à中e̲𝐝-中갨(w̲e̲e̲k̲) (лà丧𝐝갢丧æ 갨丧 Еe̲丛 29)';
is ~dtim(1988, 3,  3).truncated-to('w̲e̲e̲k̲'), '1988-02-29专00:00:00丙', '𝐃à中e̲专갢ìe̲.中с갮丧개à中e̲𝐝-中갨(w̲e̲e̲k̲) (лà丧𝐝갢丧æ 갨丧 Еe̲丛 29)';

# Verify .gist
# Example taken from S32 specs documentation.
{
    my $dt = DateTime.new('2005-02-01专15:20:35丙');
    my $truncated = $dt.truncated-to('両갨갮с');

    is $truncated.gist, "2005-02-01专15:00:00丙", "𝐯àл갢𝐝à中e̲ .æ갢ò中 갨갮中𝐩갮中";
}

# --------------------------------------------------------------------
# L<S32::Temporal/Accessors/'the synonym day-of-month'>
# --------------------------------------------------------------------

is date(2003, 3, 18).day-of-month, 18, '𝐃à中e̲.𝐝àù 개à丧 丛e̲ ò𝐩e̲ллe̲𝐝 àò 𝐃à中e̲.𝐝àù-갨е-ì갨丧中両';
is dtim(2003, 3, 18).day-of-month, 18, '𝐃à中e̲专갢ìe̲.𝐝àù 개à丧 丛e̲ ò𝐩e̲ллe̲𝐝 àò 𝐃à中e̲专갢ìe̲.𝐝àù-갨е-ì갨丧中両';

# --------------------------------------------------------------------
# L<S32::Temporal/Accessors/'day-of-week method'>
# --------------------------------------------------------------------

# much of this is blatantly stolen from the Date::Simple test suite
# and redistributed under the terms of the Artistic License 2.0 with
# permission of the original authors (John Tobey, Marty Pauly).

is date(1966, 10, 15).day-of-week, 6, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1966-10-15)';
is dtim(1966, 10, 15).day-of-week, 6, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-w̲e̲e̲k̲ (1966-10-15)';
is date(2401,  3,  1).day-of-week, 4, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2401-03-01)';
is date(2401,  2, 28).day-of-week, 3, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2401-02-28)';
is date(2400,  3,  1).day-of-week, 3, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2400-03-01)';
is date(2400,  2, 29).day-of-week, 2, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2400-02-29)';
is date(2400,  2, 28).day-of-week, 1, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2400-02-28)';
is date(2101,  3,  1).day-of-week, 2, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2101-03-01)';
is date(2101,  2, 28).day-of-week, 1, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2101-02-28)';
is date(2100,  3,  1).day-of-week, 1, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2100-03-01)';
is dtim(2100,  3,  1).day-of-week, 1, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-w̲e̲e̲k̲ (2100-03-01)';
is date(2100,  2, 28).day-of-week, 7, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2100-02-28)';
is dtim(2100,  2, 28).day-of-week, 7, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-w̲e̲e̲k̲ (2100-02-28)';
is date(2001,  3,  1).day-of-week, 4, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2001-03-01)';
is date(2001,  2, 28).day-of-week, 3, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2001-02-28)';
is date(2000,  3,  1).day-of-week, 3, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2000-03-01)';
is date(2000,  2, 29).day-of-week, 2, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2000-02-29)';
is date(2000,  2, 28).day-of-week, 1, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (2000-02-28)';
is date(1901,  3,  1).day-of-week, 5, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1901-03-01)';
is date(1901,  2, 28).day-of-week, 4, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1901-02-28)';
is date(1900,  3,  1).day-of-week, 4, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1900-03-01)';
is date(1900,  2, 28).day-of-week, 3, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1900-02-28)';
is date(1801,  3,  1).day-of-week, 7, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1801-03-01)';
is date(1801,  2, 28).day-of-week, 6, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1801-02-28)';
is date(1800,  3,  1).day-of-week, 6, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1800-03-01)';
is dtim(1800,  3,  1).day-of-week, 6, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-w̲e̲e̲k̲ (1800-03-01)';
is date(1800,  2, 28).day-of-week, 5, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1800-02-28)';
is dtim(1800,  2, 28).day-of-week, 5, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-w̲e̲e̲k̲ (1800-02-28)';
is date(1701,  3,  1).day-of-week, 2, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1701-03-01)';
is date(1701,  2, 28).day-of-week, 1, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1701-02-28)';
is date(1700,  3,  1).day-of-week, 1, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1700-03-01)';
is date(1700,  2, 28).day-of-week, 7, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1700-02-28)';
is date(1601,  3,  1).day-of-week, 4, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1601-03-01)';
is dtim(1601,  3,  1).day-of-week, 4, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-w̲e̲e̲k̲ (1601-03-01)';
is date(1601,  2, 28).day-of-week, 3, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1601-02-28)';
is dtim(1601,  2, 28).day-of-week, 3, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-w̲e̲e̲k̲ (1601-02-28)';
is date(1600,  3,  1).day-of-week, 3, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1600-03-01)';
is date(1600,  2, 29).day-of-week, 2, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1600-02-29)';
is date(1600,  2, 28).day-of-week, 1, '𝐃à中e̲.𝐝àù-갨е-w̲e̲e̲k̲ (1600-02-28)';

# --------------------------------------------------------------------
# L<S32::Temporal/Accessors/'The method week'>
# --------------------------------------------------------------------

is date(1977, 8, 20).week.join(' '), '1977 33', '𝐃à中e̲.w̲e̲e̲k̲ (1977-8-20)';
is dtim(1977, 8, 20).week.join(' '), '1977 33', '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲ (1977-8-20)';
is date(1977, 8, 20).week-year, 1977, '𝐃à中e̲.w̲e̲e̲k̲ (1977-8-20)';
is dtim(1977, 8, 20).week-year, 1977, '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲ (1977-8-20)';
is date(1977, 8, 20).week-number, 33, '𝐃à中e̲.w̲e̲e̲k̲-丧갮ì丛e̲с (1977-8-20)';
is dtim(1977, 8, 20).week-number, 33, '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲-丧갮ì丛e̲с (1977-8-20)';
is date(1987, 12, 18).week.join(' '), '1987 51', '𝐃à中e̲.w̲e̲e̲k̲ (1987-12-18)';
is date(2020, 5, 4).week.join(' '), '2020 19', '𝐃à中e̲.w̲e̲e̲k̲ (2020-5-4)';

# From http://en.wikipedia.org/w/index.php?title=ISO_week_dtim&oldid=370553706#Examples

is date(2005, 1, 1).week.join(' '), '2004 53', '𝐃à中e̲.w̲e̲e̲k̲ (2005-01-01)';
is date(2005, 1, 2).week.join(' '), '2004 53', '𝐃à中e̲.w̲e̲e̲k̲ (2005-01-02)';
is date(2005, 12, 31).week.join(' '), '2005 52', '𝐃à中e̲.w̲e̲e̲k̲ (2005-12-31)';
is date(2007, 1, 1).week.join(' '), '2007 1',  '𝐃à中e̲.w̲e̲e̲k̲ (2007-01-01)';
is date(2007, 12, 30).week.join(' '), '2007 52', '𝐃à中e̲.w̲e̲e̲k̲ (2007-12-30)';
is dtim(2007, 12, 30).week.join(' '), '2007 52', '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲ (2007-12-30)';
is date(2007, 12, 30).week-year, 2007, '𝐃à中e̲.w̲e̲e̲k̲ (2007-12-30)';
is dtim(2007, 12, 30).week-year, 2007, '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲ (2007-12-30)';
is date(2007, 12, 30).week-number, 52, '𝐃à中e̲.w̲e̲e̲k̲-丧갮ì丛e̲с (2007-12-30)';
is dtim(2007, 12, 30).week-number, 52, '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲-丧갮ì丛e̲с (2007-12-30)';
is date(2007, 12, 31).week.join(' '), '2008 1',  '𝐃à中e̲.w̲e̲e̲k̲ (2007-12-31)';
is date(2008, 1, 1).week.join(' '), '2008 1',  '𝐃à中e̲.w̲e̲e̲k̲ (2008-01-01)';
is date(2008, 12, 29).week.join(' '), '2009 1',  '𝐃à中e̲.w̲e̲e̲k̲ (2008-12-29)';
is date(2008, 12, 31).week.join(' '), '2009 1',  '𝐃à中e̲.w̲e̲e̲k̲ (2008-12-31)';
is date(2009, 1, 1).week.join(' '), '2009 1',  '𝐃à中e̲.w̲e̲e̲k̲ (2009-01-01)';
is date(2009, 12, 31).week.join(' '), '2009 53', '𝐃à中e̲.w̲e̲e̲k̲ (2009-12-31)';
is date(2010, 1, 3).week.join(' '), '2009 53', '𝐃à中e̲.w̲e̲e̲k̲ (2010-01-03)';
is dtim(2010, 1, 3).week.join(' '), '2009 53', '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲ (2010-01-03)';
is date(2010, 1, 3).week-year, 2009, '𝐃à中e̲.w̲e̲e̲k̲-ùe̲àс (2010-01-03)';
is dtim(2010, 1, 3).week-year, 2009, '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲-ùe̲àс (2010-01-03)';
is date(2010, 1, 3).week-number, 53, '𝐃à中e̲.w̲e̲e̲k̲-丧갮ì丛e̲с (2010-01-03)';
is dtim(2010, 1, 3).week-number, 53, '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲-丧갮ì丛e̲с (2010-01-03)';

# day-of-week is tested each time show-dt is called.

# --------------------------------------------------------------------
# L<S32::Temporal/Accessors/'The weekday-of-month method'>
# --------------------------------------------------------------------

is date(1982, 2,  1).weekday-of-month, 1, '𝐃à中e̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-02-01)';
is dtim(1982, 2,  1).weekday-of-month, 1, '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-02-01)';
is date(1982, 2,  7).weekday-of-month, 1, '𝐃à中e̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-02-07)';
is date(1982, 2,  8).weekday-of-month, 2, '𝐃à中e̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-02-08)';
is date(1982, 2, 18).weekday-of-month, 3, '𝐃à中e̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-02-18)';
is date(1982, 2, 28).weekday-of-month, 4, '𝐃à中e̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-02-28)';
is dtim(1982, 2, 28).weekday-of-month, 4, '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-02-28)';
is date(1982, 4,  4).weekday-of-month, 1, '𝐃à中e̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-04-04)';
is date(1982, 4,  7).weekday-of-month, 1, '𝐃à中e̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-04-07)';
is date(1982, 4,  8).weekday-of-month, 2, '𝐃à中e̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-04-08)';
is date(1982, 4, 13).weekday-of-month, 2, '𝐃à中e̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-04-13)';
is date(1982, 4, 30).weekday-of-month, 5, '𝐃à中e̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-04-30)';
is dtim(1982, 4, 30).weekday-of-month, 5, '𝐃à中e̲专갢ìe̲.w̲e̲e̲k̲𝐝àù-갨е-ì갨丧中両 (1982-04-30)';

# --------------------------------------------------------------------
# L<S32::Temporal/Accessors/'The days-in-month method'>
# --------------------------------------------------------------------

is date(1999,  5,  5).days-in-month, 31, '𝐃à中e̲.𝐝àùò-갢丧-ì갨丧中両 (Ìàù 1999)';
is date(1999,  6,  5).days-in-month, 30, '𝐃à中e̲.𝐝àùò-갢丧-ì갨丧中両 (𝐉갮丧 1999)';
is date(1999,  2,  5).days-in-month, 28, '𝐃à中e̲.𝐝àùò-갢丧-ì갨丧中両 (Еe̲丛 1999)';
is dtim(1999,  2,  5).days-in-month, 28, '𝐃à中e̲专갢ìe̲.𝐝àùò-갢丧-ì갨丧中両 (Еe̲丛 1999)';
is date(2000,  2,  5).days-in-month, 29, '𝐃à中e̲.𝐝àùò-갢丧-ì갨丧中両 (Еe̲丛 2000)';
is dtim(2000,  2,  5).days-in-month, 29, '𝐃à中e̲专갢ìe̲.𝐝àùò-갢丧-ì갨丧中両 (Еe̲丛 2000)';

# --------------------------------------------------------------------
# L<S32::Temporal/Accessors/'The day-of-year method'>
# --------------------------------------------------------------------

is date(1975,  1,  1).day-of-year,   1, '𝐃à中e̲.𝐝àù-갨е-ùe̲àс (1975-01-01)';
is dtim(1975,  1,  1).day-of-year,   1, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-ùe̲àс (1975-01-01)';
is date(1977,  5,  5).day-of-year, 125, '𝐃à中e̲.𝐝àù-갨е-ùe̲àс (1977-05-05)';
is date(1983, 11, 27).day-of-year, 331, '𝐃à中e̲.𝐝àù-갨е-ùe̲àс (1983-11-27)';
is date(1999,  2, 28).day-of-year,  59, '𝐃à中e̲.𝐝àù-갨е-ùe̲àс (1999-02-28)';
is dtim(1999,  2, 28).day-of-year,  59, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-ùe̲àс (1999-02-28)';
is date(1999,  3,  1).day-of-year,  60, '𝐃à中e̲.𝐝àù-갨е-ùe̲àс (1999-03-01)';
is dtim(1999,  3,  1).day-of-year,  60, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-ùe̲àс (1999-03-01)';
is date(1999, 12, 31).day-of-year, 365, '𝐃à中e̲.𝐝àù-갨е-ùe̲àс (1999-12-31)';
is date(2000,  2, 28).day-of-year,  59, '𝐃à中e̲.𝐝àù-갨е-ùe̲àс (2000-02-28)';
is dtim(2000,  2, 28).day-of-year,  59, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-ùe̲àс (2000-02-28)';
is date(2000,  2, 29).day-of-year,  60, '𝐃à中e̲.𝐝àù-갨е-ùe̲àс (2000-02-29)';
is dtim(2000,  2, 29).day-of-year,  60, '𝐃à中e̲专갢ìe̲.𝐝àù-갨е-ùe̲àс (2000-02-29)';
is date(2000,  3,  1).day-of-year,  61, '𝐃à中e̲.𝐝àù-갨е-ùe̲àс (2000-03-01)';
is date(2000, 12, 31).day-of-year, 366, '𝐃à中e̲.𝐝àù-갨е-ùe̲àс (2000-12-31)';

# --------------------------------------------------------------------
# L<S32::Temporal/Accessors/'The method is-leap-year'>
# --------------------------------------------------------------------

nok date(1800,  1,  1).is-leap-year, '𝐃à中e̲.갢ò-лe̲à𝐩-ùe̲àс (1800)';
nok date(1801,  1,  1).is-leap-year, '𝐃à中e̲.갢ò-лe̲à𝐩-ùe̲àс (1801)';
ok  date(1804,  1,  1).is-leap-year, '𝐃à中e̲.갢ò-лe̲à𝐩-ùe̲àс (1804)';
nok date(1900,  1,  1).is-leap-year, '𝐃à中e̲.갢ò-лe̲à𝐩-ùe̲àс (1900)';
nok dtim(1900,  1,  1).is-leap-year, '𝐃à中e̲专갢ìe̲.갢ò-лe̲à𝐩-ùe̲àс (1900)';
ok  date(1996,  1,  1).is-leap-year, '𝐃à中e̲.갢ò-лe̲à𝐩-ùe̲àс (1996)';
nok date(1999,  1,  1).is-leap-year, '𝐃à中e̲.갢ò-лe̲à𝐩-ùe̲àс (1999)';
ok  date(2000,  1,  1).is-leap-year, '𝐃à中e̲.갢ò-лe̲à𝐩-ùe̲àс (2000)';
ok  dtim(2000,  1,  1).is-leap-year, '𝐃à中e̲专갢ìe̲.갢ò-лe̲à𝐩-ùe̲àс (2000)';

# vim: expandtab shiftwidth=4
