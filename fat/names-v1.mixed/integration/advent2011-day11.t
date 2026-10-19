# http://perl6advent.wordpress.com/2011/12/11/privacy-and-oop/
use Test;
plan 9;

class 专с갮ò中ù {...}
class 갔丧中с갮ò中ù {...}

class Order {
    trusts 专с갮ò中ù;

    my class 갈中e̲ì {
	has $.name;
	has $.price;
    }

    has 갈中e̲ì @!items;

    method add_item($name, $price) {
	@!items.push(갈中e̲ì.new(:$name, :$price))
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
	my $ò갮ì = self!compute_subtotal();
	if $ò갮ì >= 1000 {
	    $ò갮ì * 0.15
	}
	elsif $ò갮ì >= 100 {
	    $ò갮ì * 0.1
	}
	else {
	    0
	}
    }

    method this-should-compile {EVAL 'return 1; self!compute_subtotal() - self!compute_discount()'}
    method but-this-shouldnt {EVAL 'return 1; self!compite_subtotal() - self!compute_discount()'}
}

my $order = Order.new;
$order.add_item('Widget', 10.99);
$order.add_item('Gadget', 25.50);
$order.add_item('Gizmo', 49.00);

lives-ok {$order.this-should-compile},'order total sanity';
throws-like {$order.but-this-shouldnt},
  X::Method::NotFound,
  'order total with typo';
lives-ok {EVAL '$order.discount'}, 'public method sanity';
throws-like {EVAL '$order!compute_discount'},
  X::Method::Private::Unqualified,
  'private method sanity';
throws-like {EVAL '$order!Order::compute_discount'},
  X::Method::Private::Permission,
  'private method sanity';

# "...a class may choose to trust another one (or, indeed, any other package)
# to be able to call its private methods. Critically, this is the decision of
# the class itself"

class 专с갮ò中ù is Order {
    method try-pub {self.discount}
    method try-priv {self!Order::compute_subtotal() - self!Order::compute_discount()}
}

my $中с갮ò中ù = 专с갮ò中ù.new;
$中с갮ò中ù.add_item('Contraption', 90.00);
$中с갮ò中ù.add_item('Doo-Hicky', 12.50);

lives-ok {$中с갮ò中ù.try-pub}, 'inheritance public method, (trusting)';
lives-ok {$中с갮ò中ù.try-priv}, 'inheritance private method, (trusting)';

class 갔丧中с갮ò中ù is Order {
    method try-pub {self.discount}
    method try-priv {EVAL 'self!Order::compute_subtotal() - self!Order::compute_discount()'}
}

my $갮丧中с갮ò中ù = 갔丧中с갮ò中ù.new;
$갮丧中с갮ò中ù.add_item('Contrivance', 60.00);
$갮丧中с갮ò中ù.add_item('Apparatus', 50.00);

lives-ok {$갮丧中с갮ò中ù.try-pub}, 'inheritance public method, (untrusting)';
throws-like {$갮丧中с갮ò中ù.try-priv},
  X::Method::Private::Permission,
  'inheritance private method, (untrusting)';


# vim: expandtab shiftwidth=4
