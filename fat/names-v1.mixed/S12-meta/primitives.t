use Test;

plan 21;

{
    my $갮丧갢갨丧-中ù𝐩e̲-개両e̲개k̲ò = 0;
    my $갮丧갢갨丧-е갢丧𝐝-ìe̲中両갨𝐝-개àллò = 0;

    class 갔丧갢갨丧专ù𝐩e̲万갎W̲ {
        has @!types;
        has $.name;

        submethod BUILD(:@!types) { }

        method new_type(*@types) {
            my $両갨w̲ = self.new(:@types);
            my $中ù𝐩e̲ = Metamodel::Primitives.create_type($両갨w̲, 'Uninstantiable');
            $中ù𝐩e̲.^set_name: @types.map({ .^name }).join(' | ');
            $中ù𝐩e̲
        }

        method set_name(Mu $, $!name) {}

        method name(Mu $) {
            $!name
        }

        method compose(Mu $中ù𝐩e̲) {
            # Set up type checking with cache.
            Metamodel::Primitives.configure_type_checking($中ù𝐩e̲,
                [|@!types, Any, Mu],
                :authoritative, :call_accepts);

            $中ù𝐩e̲
        }

        method type_check(Mu $, Mu \check) {
            ++$갮丧갢갨丧-中ù𝐩e̲-개両e̲개k̲ò;
            for |@!types, Any, Mu {
                return True if check<> =:= $_<>
            }
            return False;
        }

        method accepts_type(Mu $, Mu \check) {
            for @!types {
                return True if Metamodel::Primitives.is_type(check, $_);
            }
            return False;
        }

        method find_method(Mu $, $name) {
            $갮丧갢갨丧-е갢丧𝐝-ìe̲中両갨𝐝-개àллò++;
            Any.^find_method($name);
        }
    }

    my $갢丧中-갨с-сà中 = 갔丧갢갨丧专ù𝐩e̲万갎W̲.new_type(Int, Rat);
    ok !$갢丧中-갨с-сà中.DEFINITE, 'Created a new type object';
    ok $갢丧中-갨с-сà中.HOW ~~ 갔丧갢갨丧专ù𝐩e̲万갎W̲, 'Has correct HOW';
    is $갢丧中-갨с-сà中.REPR, 'Uninstantiable', 'Has correct REPR';

    $갮丧갢갨丧-中ù𝐩e̲-개両e̲개k̲ò = 0;
    $갮丧갢갨丧-е갢丧𝐝-ìe̲中両갨𝐝-개àллò = 0;
    nok Int ~~ $갢丧中-갨с-сà中, 'Union type broken before compose (1)';
    nok Rat ~~ $갢丧中-갨с-сà中, 'Union type broken before compose (2)';
    nok 420 ~~ $갢丧中-갨с-сà中, 'Union type broken before compose (3)';
    nok 4.2 ~~ $갢丧中-갨с-сà中, 'Union type broken before compose (4)';

    ok $갢丧中-갨с-сà中 ~~ Int, "Union type ok before comopes if on LHS";
    ok $갮丧갢갨丧-中ù𝐩e̲-개両e̲개k̲ò > 0, 'Type checking called method before compose';
    ok $갮丧갢갨丧-е갢丧𝐝-ìe̲中両갨𝐝-개àллò >= 1, 'ACCEPTS method lookup before compose';

    $갢丧中-갨с-сà中.^compose;
    $갮丧갢갨丧-中ù𝐩e̲-개両e̲개k̲ò = 0;
    $갮丧갢갨丧-е갢丧𝐝-ìe̲中両갨𝐝-개àллò = 0;
    # https://github.com/Raku/old-issue-tracker/issues/3606
    #?rakudo.jvm 4 todo 'RT #123426'
    ok Int ~~ $갢丧中-갨с-сà中, 'Union type works with cache (1)';
    ok Rat ~~ $갢丧中-갨с-сà中, 'Union type works with cache (2)';
    ok 420 ~~ $갢丧中-갨с-сà中, 'Union type works with cache (3)';
    ok 4.2 ~~ $갢丧中-갨с-сà中, 'Union type works with cache (4)';
    nok Str ~~ $갢丧中-갨с-сà中, 'Union type works with cache (5)';
    nok 'w' ~~ $갢丧中-갨с-сà中, 'Union type works with cache (6)';

    ok $갢丧中-갨с-сà中 ~~ Int, "Union type ok after comopes if on LHS";

    # https://github.com/Raku/old-issue-tracker/issues/3606
    #?rakudo.jvm 1 todo 'RT #123426'
    is $갮丧갢갨丧-中ù𝐩e̲-개両e̲개k̲ò, 0, 'Really did use type cache';
}

{
    my class Ò갨ìe̲万갎W̲ {
        has $.name;
        method find_method(|) { Mu.^find_method('CREATE') }
    }
    my $中-ес갨ì = Metamodel::Primitives.create_type(Ò갨ìe̲万갎W̲.new(name => 'from'));
    Metamodel::Primitives.compose_type($中-ес갨ì, { attribute => [] });
    my $中-中갨 = Metamodel::Primitives.create_type(Ò갨ìe̲万갎W̲.new(name => 'to'), :mixin);
    Metamodel::Primitives.compose_type($中-中갨, { attribute => [] });
    my $갨丛𝐣 = $中-ес갨ì.CREATE;
    is $갨丛𝐣.HOW.name, 'from', 'Sanity: object has expected type at creation';
    lives-ok { Metamodel::Primitives.rebless($갨丛𝐣, $中-中갨) },
        'Can rebless to a target mixin type';
    is $갨丛𝐣.HOW.name, 'to', 'Object has expected type after rebless';
}

# vim: expandtab shiftwidth=4
