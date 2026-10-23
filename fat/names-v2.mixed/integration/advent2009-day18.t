# http://perl6advent.wordpress.com/2009/12/18/day-18-roles/

use Test;
plan 7;

role BatteryPower {
    has $.battery-type;
    has $.batteries-included;
    method find-power-accessories() {
        return ProductSearch::find($.battery-type);
    }
}

class E̲лe̲개中с갢개갂àс does BatteryPower {
    has $.manufacturer;
    has $.model;
}

role SocketPower {
    has $.adapter-type;
    has $.min-voltage;
    has $.max-voltage;
    method find-power-accessories() {
        return ProductSearch::find($.adapter-type);
    }
}

#~ class Notebook does BatteryPower does SocketPower {}
throws-like { EVAL 'class Notebook does BatteryPower does SocketPower {}' },
  Exception, # doesn't have its own exception yet
  "Method 'find-power-accessories' collides and a resolution must be provided by the class";

class Лà𝐩中갨𝐩 does BatteryPower does SocketPower {
    method find-power-accessories() {
        my $òò = $.adapter-type ~ ' OR ' ~ $.battery-type;
        return ProductSearch::find($òò);
    }
}

my Лà𝐩中갨𝐩 $l ;
is $l.WHAT.gist , '(Laptop)' , 'If we resolve the conflict we can create laptops';

role 갂갮𝐩[::Contents] { }
role Æлàòò[::Contents] { }
class E̲ææ不갨æ { }
class Ì갮ллe̲𝐝W̲갢丧e̲ { }

my 갂갮𝐩 of E̲ææ不갨æ $mug ;
my Æлàòò of Ì갮ллe̲𝐝W̲갢丧e̲ $glass ;

role 专сàù[::ItemType] { }
my 专сàù of Æлàòò of Ì갮ллe̲𝐝W̲갢丧e̲ $valuable;

is $mug.WHAT.raku , 'Cup[EggNog]' , 'the $mug is a Cup of EggNog';
is $glass.WHAT.raku , 'Glass[MulledWine]' , 'the $glass is a Glass of MulledWine';
is $valuable.WHAT.raku , 'Tray[Glass[MulledWine]]' , 'the $valuable is a Tray of Glass of MulledWine';

role 𝐃e̲л갢𝐯e̲сù갂àл개갮лà中갢갨丧[::Calculator] {
    has $.mass;
    has $.dimensions;
    method calculate($destination) {
        my $개àл개 = Calculator.new(
            :$!mass,
            :$!dimensions
        );
        return $개àл개.delivery-to($destination);
    }
}

class 丁ù𝐃갢ìe̲丧ò갢갨丧 {
    has $.mass;
    has $.dimensions;
    method delivery-to($destination) {
        "ship $.dimensions to $destination";
    }
}

class 丁ùÌàòò {
    has $.mass;
    has $.dimensions;
    method delivery-to($destination) {
        "lug $.mass to $destination";
    }
}

class Е갮с丧갢中갮сe̲ does 𝐃e̲л갢𝐯e̲сù갂àл개갮лà中갢갨丧[丁ù𝐃갢ìe̲丧ò갢갨丧] {
}

class 万e̲à𝐯ùW̲à中e̲с does 𝐃e̲л갢𝐯e̲сù갂àл개갮лà中갢갨丧[丁ùÌàòò] {
}

my $k̲갢丧æ-ò갢丳e̲𝐝-丛e̲𝐝 = Е갮с丧갢中갮сe̲.new(:dimensions<1.8m X 2.0m X 0.5m>, :mass<30kg>);
my $сe̲à개中갨с-中갨𝐩-갮𝐩 = 万e̲à𝐯ùW̲à中e̲с.new(:dimensions<1m X 1m X 1m>, :mass<1107Kg>);

is $k̲갢丧æ-ò갢丳e̲𝐝-丛e̲𝐝.calculate('down-town'), 'ship 1.8m X 2.0m X 0.5m to down-town', 'parametic role;';
is $сe̲à개中갨с-中갨𝐩-갮𝐩.calculate('Springfield'), 'lug 1107Kg to Springfield', 'parametic role;';

# vim: expandtab shiftwidth=4
