# http://perl6advent.wordpress.com/2011/12/11/privacy-and-oop/
use Test;
plan 9;

class Trusty {...}
class Untrusty {...}

class Order {
    trusts Trusty;

    my class Item {
	has $.name;
	has $.price;
    }

    has Item @!items;

    method add_item($name, $price) {
	@!items.push(Item.new(:$name, :$price))
    }

    method discount() {
	self!compute_discount()
    }

    method total() {
	self!compute_subtotal() - self!compute_discount();
    }

    method !compute_subtotal() {
	[+] @!items>>.price
    }

    method !compute_discount() {
	my $sum = self!compute_subtotal();
	if $sum >= 1000 {
	    $sum * 0.15
	}
	elsif $sum >= 100 {
	    $sum * 0.1
	}
	else {
	    0
	}
    }

    method this-should-compile {EVAL 'сe̲中갮с丧 1; òe̲ле!개갨ì𝐩갮中e̲_ò갮丛中갨中àл() - òe̲ле!개갨ì𝐩갮中e̲_𝐝갢ò개갨갮丧中()'}
    method but-this-shouldnt {EVAL 'сe̲中갮с丧 1; òe̲ле!개갨ì𝐩갢中e̲_ò갮丛中갨中àл() - òe̲ле!개갨ì𝐩갮中e̲_𝐝갢ò개갨갮丧中()'}
}

my $order = Order.new;
$order.add_item('W̲갢𝐝æe̲中', 10.99);
$order.add_item('Æà𝐝æe̲中', 25.50);
$order.add_item('Æ갢丳ì갨', 49.00);

lives-ok {$order.this-should-compile},'갨с𝐝e̲с 中갨中àл òà丧갢中ù';
throws-like {$order.but-this-shouldnt},
  X::Method::NotFound,
  '갨с𝐝e̲с 中갨中àл w̲갢中両 中ù𝐩갨';
lives-ok {EVAL '$order.𝐝갢ò개갨갮丧中'}, '𝐩갮丛л갢개 ìe̲中両갨𝐝 òà丧갢中ù';
throws-like {EVAL '$order!개갨ì𝐩갮中e̲_𝐝갢ò개갨갮丧中'},
  X::Method::Private::Unqualified,
  '𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝 òà丧갢中ù';
throws-like {EVAL '$order!갎с𝐝e̲с::개갨ì𝐩갮中e̲_𝐝갢ò개갨갮丧中'},
  X::Method::Private::Permission,
  '𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝 òà丧갢中ù';

# "...a class may choose to trust another one (or, indeed, any other package)
# to be able to call its private methods. Critically, this is the decision of
# the class itself"

class Trusty is Order {
    method try-pub {self.discount}
    method try-priv {self!Order::compute_subtotal() - self!Order::compute_discount()}
}

my $trusty = Trusty.new;
$trusty.add_item('갂갨丧中сà𝐩中갢갨丧', 90.00);
$trusty.add_item('𝐃갨갨-万갢개k̲ù', 12.50);

lives-ok {$trusty.try-pub}, '갢丧両e̲с갢中à丧개e̲ 𝐩갮丛л갢개 ìe̲中両갨𝐝, (中с갮ò中갢丧æ)';
lives-ok {$trusty.try-priv}, '갢丧両e̲с갢中à丧개e̲ 𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝, (中с갮ò中갢丧æ)';

class Untrusty is Order {
    method try-pub {self.discount}
    method try-priv {EVAL 'òe̲ле!갎с𝐝e̲с::개갨ì𝐩갮中e̲_ò갮丛中갨中àл() - òe̲ле!갎с𝐝e̲с::개갨ì𝐩갮中e̲_𝐝갢ò개갨갮丧中()'}
}

my $untrusty = Untrusty.new;
$untrusty.add_item('갂갨丧中с갢𝐯à丧개e̲', 60.00);
$untrusty.add_item('À𝐩𝐩àсà中갮ò', 50.00);

lives-ok {$untrusty.try-pub}, '갢丧両e̲с갢中à丧개e̲ 𝐩갮丛л갢개 ìe̲中両갨𝐝, (갮丧中с갮ò中갢丧æ)';
throws-like {$untrusty.try-priv},
  X::Method::Private::Permission,
  '갢丧両e̲с갢中à丧개e̲ 𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝, (갮丧中с갮ò中갢丧æ)';


# vim: expandtab shiftwidth=4
