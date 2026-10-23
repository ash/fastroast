unit module FatRoast::CoreNames;

# The names Rakudo's CORE gives a program, as a string may spell them:
# `'Str'`, `'True'`, `'Less'`, `'X::AdHoc'`, `'IO::Path'`. A test compares
# such a string with what code prints (`.^name`, `~True`, `~(1 cmp 2)`), so
# strings-v2 keeps its letters. A snapshot of Rakudo 2026.09, the oracle, made
# by tools/core-names.raku, so that what a transform does never depends on
# the engine FatRoast runs on.
my constant %NAMES = qw<
    AST Allomorph Any Array Array::Element Array::Element::Access
    Array::Shaped Array::Shaped1 Array::Shaped2 Array::Shaped3 Array::Slice
    Array::Slice::Access Array::Slice::Assign Array::Slice::Bind
    Array::Typed Associative Attribute Awaitable Awaitable::Handle Awaiter
    Awaiter::Blocking Backtrace Backtrace::Frame Bag BagHash Baggy BigEndian
    Blob Block Bool Bool::False Bool::True Broken Buf CORE-SETTING-REV CX
    CX::Done CX::Emit CX::Last CX::Next CX::Proceed CX::Redo CX::Return
    CX::Succeed CX::Take CX::Warn CallFrame Callable Cancellation Capture
    Channel Code Collation CompUnit CompUnit::DependencySpecification
    CompUnit::Handle CompUnit::Loader CompUnit::PrecompilationDependency
    CompUnit::PrecompilationDependency::File CompUnit::PrecompilationId
    CompUnit::PrecompilationRepository
    CompUnit::PrecompilationRepository::Default
    CompUnit::PrecompilationRepository::None CompUnit::PrecompilationStore
    CompUnit::PrecompilationStore::File
    CompUnit::PrecompilationStore::FileSystem CompUnit::PrecompilationUnit
    CompUnit::PrecompilationUnit::File CompUnit::Repository
    CompUnit::Repository::AbsolutePath CompUnit::Repository::Distribution
    CompUnit::Repository::FileSystem CompUnit::Repository::Installable
    CompUnit::Repository::Installation CompUnit::Repository::Locally
    CompUnit::Repository::NQP CompUnit::Repository::Perl5
    CompUnit::Repository::Spec CompUnit::Repository::Unknown
    CompUnit::RepositoryRegistry Compiler Complex ComplexStr
    ContainerDescriptor Cool CurrentThreadScheduler Cursor Date DateTime
    Dateish Deprecation Distribution Distribution::Hash
    Distribution::Locally Distribution::Path Distribution::Resource
    Distribution::Resources Distro Duration EXPORTHOW Empty Encoding
    Encoding::Builtin Encoding::Decoder Encoding::Decoder::Builtin
    Encoding::Encoder Encoding::Encoder::Builtin
    Encoding::Encoder::TranslateNewlineWrapper Encoding::Registry Endian
    Endian::BigEndian Endian::LittleEndian Endian::NativeEndian Enumeration
    Exception Exceptions Exceptions::JSON Failure False FatRat
    FileChangeEvent FileChangeEvent::FileChanged
    FileChangeEvent::FileRenamed FileChanged FileRenamed ForeignCode Grammar
    HardRoutine Hash Hash::Object Hash::Ordered Hash::Typed Hashray Hyper
    HyperConfiguration HyperSeq HyperWhatever IO IO::ArgFiles IO::CatHandle
    IO::Handle IO::Notification IO::Notification::Change IO::Path
    IO::Path::Cygwin IO::Path::Parts IO::Path::QNX IO::Path::Spec
    IO::Path::Unix IO::Path::Win32 IO::Pipe IO::Socket IO::Socket::Async
    IO::Socket::Async::ListenSocket IO::Socket::Async::Port-Number
    IO::Socket::INET IO::Spec IO::Spec::Cygwin IO::Spec::QNX IO::Spec::Unix
    IO::Spec::Win32 IO::Special Inf Instant Int IntAttrRef IntLexRef
    IntPosRef IntStr Iterable IterationBuffer IterationEnd Iterator
    JSONException Junction Kept Kernel Label Less List List::Reifier
    LittleEndian Lock Lock::Async Lock::ConditionVariable Lock::Soft Macro
    Map Match Metamodel Metamodel::Archetypes Metamodel::ArrayType
    Metamodel::AttributeContainer Metamodel::BUILDALL Metamodel::BUILDPLAN
    Metamodel::BaseType Metamodel::BoolificationProtocol Metamodel::C3MRO
    Metamodel::ClassHOW Metamodel::CoercionHOW Metamodel::Composing
    Metamodel::ConcreteRoleHOW Metamodel::Concretization
    Metamodel::ConcretizationCache Metamodel::Configuration
    Metamodel::ContainerSpecProtocol Metamodel::CurriedRoleHOW
    Metamodel::DefaultParent Metamodel::DefiniteHOW Metamodel::Documenting
    Metamodel::EnumHOW Metamodel::Explaining Metamodel::Finalization
    Metamodel::GenericHOW Metamodel::GrammarHOW Metamodel::LanguageRevision
    Metamodel::MROBasedMethodDispatch Metamodel::MROBasedTypeChecking
    Metamodel::MetaMethodContainer Metamodel::MethodContainer
    Metamodel::MethodDelegation Metamodel::Mixins Metamodel::ModuleHOW
    Metamodel::MultiMethodContainer Metamodel::MultipleInheritance
    Metamodel::Naming Metamodel::NativeHOW Metamodel::NativeRefHOW
    Metamodel::Nominalizable Metamodel::PackageHOW
    Metamodel::ParametricRoleGroupHOW Metamodel::ParametricRoleHOW
    Metamodel::Primitives Metamodel::PrivateMethodContainer
    Metamodel::REPRComposeProtocol Metamodel::RoleContainer
    Metamodel::RolePunning Metamodel::Stashing Metamodel::SubsetHOW
    Metamodel::Trusting Metamodel::TypePretense Metamodel::Versioning Method
    MethodDispatcher Mix MixHash Mixy More Mu MultiDispatcher NFC NFD NFKC
    NFKD NQPMatchRole NQPdidMATCH NaN NativeEndian Nil Num NumAttrRef
    NumLexRef NumPosRef NumStr Numeric NumericEnumeration
    NumericStringyEnumeration ObjAt Operator OperatorProperties Order
    Order::Less Order::More Order::Same PF_INET PF_INET6 PF_LOCAL PF_MAX
    PF_UNIX PF_UNSPEC PROCESS PROTO_TCP PROTO_UDP Pair ParallelSequence
    Parameter Perl Planned Pod Pod::Block Pod::Block::Code
    Pod::Block::Comment Pod::Block::Declarator Pod::Block::Input
    Pod::Block::Named Pod::Block::Output Pod::Block::Para Pod::Block::Table
    Pod::Config Pod::Defn Pod::FormattingCode Pod::Heading Pod::Item
    Pod::Raw Positional PositionalBindFailover PredictiveIterator Proc
    Proc::Async Proc::Async::Pipe Promise PromiseStatus
    PromiseStatus::Broken PromiseStatus::Kept PromiseStatus::Planned
    ProtocolFamily ProtocolFamily::PF_INET ProtocolFamily::PF_INET6
    ProtocolFamily::PF_LOCAL ProtocolFamily::PF_MAX ProtocolFamily::PF_UNIX
    ProtocolFamily::PF_UNSPEC ProtocolType ProtocolType::PROTO_TCP
    ProtocolType::PROTO_UDP Proxy PseudoStash QuantHash QuantHash::KeyOf
    REPL RaceSeq Raku RakuAST Rakudo Rakudo::Deprecations Rakudo::Internals
    Rakudo::Internals::CompilerServices Rakudo::Internals::EvalIdSource
    Rakudo::Internals::HyperBatcher Rakudo::Internals::HyperIteratorBatcher
    Rakudo::Internals::HyperJoiner Rakudo::Internals::HyperPipeline
    Rakudo::Internals::HyperProcessor Rakudo::Internals::HyperRaceSharedImpl
    Rakudo::Internals::HyperRebatcher Rakudo::Internals::HyperToIterator
    Rakudo::Internals::HyperWorkBatch Rakudo::Internals::HyperWorkStage
    Rakudo::Internals::ImplementationDetail Rakudo::Internals::IterationSet
    Rakudo::Internals::JSON Rakudo::Internals::LoweredAwayLexical
    Rakudo::Internals::RaceToIterator Rakudo::Internals::ReactAwaitHandle
    Rakudo::Internals::ReactAwaitable
    Rakudo::Internals::ReactOneWheneverAwaitHandle
    Rakudo::Internals::RegexBoolification6cMarker
    Rakudo::Internals::ShapedArrayCommon Rakudo::Internals::SprintfHandler
    Rakudo::Internals::SupplySequencer Rakudo::IterateMoreWithPhasers
    Rakudo::IterateMoreWithoutPhasers Rakudo::IterateOneWithPhasers
    Rakudo::IterateOneWithoutPhasers Rakudo::IterateTwoWithoutPhasers
    Rakudo::Iterator Rakudo::Iterator::Blobby Rakudo::Iterator::Mappy
    Rakudo::Iterator::Mappy-kv-from-pairs Rakudo::Iterator::ShapeBranch
    Rakudo::Iterator::ShapeLeaf Rakudo::Metaops Rakudo::QuantHash
    Rakudo::QuantHash::Pairs Rakudo::QuantHash::Quanty-kv
    Rakudo::SlippyIterator Rakudo::Sorting Rakudo::Supply
    Rakudo::Supply::BlockState Rakudo::Supply::BlockTappable
    Rakudo::Supply::OneEmitTappable Rakudo::Supply::OneWheneverState
    Rakudo::Supply::OneWheneverTappable Rakudo::Unicodey Range Rat RatStr
    Rational Real Regex Routine SIGABRT SIGALRM SIGBREAK SIGBUS SIGCHLD
    SIGCONT SIGEMT SIGFPE SIGHUP SIGILL SIGINFO SIGINT SIGIO SIGKILL SIGPIPE
    SIGPROF SIGPWR SIGQUIT SIGSEGV SIGSTKFLT SIGSTOP SIGSYS SIGTERM SIGTHR
    SIGTRAP SIGTSTP SIGTTIN SIGTTOU SIGURG SIGUSR1 SIGUSR2 SIGVTALRM
    SIGWINCH SIGXCPU SIGXFSZ SOCK_DGRAM SOCK_MAX SOCK_PACKET SOCK_RAW
    SOCK_RDM SOCK_SEQPACKET SOCK_STREAM Same Scalar ScalarVAR Scheduler
    SeekFromBeginning SeekFromCurrent SeekFromEnd SeekType
    SeekType::SeekFromBeginning SeekType::SeekFromCurrent
    SeekType::SeekFromEnd Semaphore Seq Sequence Set SetHash Setty Signal
    Signal::SIGABRT Signal::SIGALRM Signal::SIGBREAK Signal::SIGBUS
    Signal::SIGCHLD Signal::SIGCONT Signal::SIGEMT Signal::SIGFPE
    Signal::SIGHUP Signal::SIGILL Signal::SIGINFO Signal::SIGINT
    Signal::SIGIO Signal::SIGKILL Signal::SIGPIPE Signal::SIGPROF
    Signal::SIGPWR Signal::SIGQUIT Signal::SIGSEGV Signal::SIGSTKFLT
    Signal::SIGSTOP Signal::SIGSYS Signal::SIGTERM Signal::SIGTHR
    Signal::SIGTRAP Signal::SIGTSTP Signal::SIGTTIN Signal::SIGTTOU
    Signal::SIGURG Signal::SIGUSR1 Signal::SIGUSR2 Signal::SIGVTALRM
    Signal::SIGWINCH Signal::SIGXCPU Signal::SIGXFSZ Signal::Signally
    Signature SignedBlob Slang Slip SocketType SocketType::SOCK_DGRAM
    SocketType::SOCK_MAX SocketType::SOCK_PACKET SocketType::SOCK_RAW
    SocketType::SOCK_RDM SocketType::SOCK_SEQPACKET SocketType::SOCK_STREAM
    SoftRoutine Stash Str StrAttrRef StrDistance StrLexRef StrPosRef Stringy
    StringyEnumeration Sub Submethod Supplier Supplier::Preserving Supply
    Systemic Tap Tappable Thread ThreadPoolScheduler True TypeEnv
    UINT64_UPPER UInt UIntAttrRef UIntLexRef UIntPosRef Uni Unicode
    UnsignedBlob VM ValueObjAt Variable Version WalkList Whatever
    WhateverCode WrapDispatcher X X::AdHoc X::Adverb X::Anon
    X::Anon::Augment X::Anon::Multi X::ArrayShapeMismatch X::Assignment
    X::Assignment::ArrayShapeMismatch X::Assignment::RO
    X::Assignment::RO::Comp X::Assignment::ToShaped X::Attribute
    X::Attribute::NoPackage X::Attribute::Package X::Attribute::Regex
    X::Attribute::Required X::Attribute::Scope X::Attribute::Scope::Package
    X::Attribute::Undeclared X::Augment X::Augment::NoSuchType X::Await
    X::Await::Died X::Backslash X::Backslash::NonVariableDollar
    X::Backslash::UnrecognizedSequence X::BadType X::Bind
    X::Bind::NativeType X::Bind::Rebind X::Bind::Slice X::Bind::ZenSlice
    X::Buf X::Buf::AsStr X::Buf::Pack X::Buf::Pack::NonASCII X::Caller
    X::Caller::NotDynamic X::Cannot X::Cannot::Capture X::Cannot::Empty
    X::Cannot::Lazy X::Cannot::Map X::Cannot::New X::Channel
    X::Channel::ReceiveOnClosed X::Channel::SendOnClosed X::Coerce
    X::Coerce::Impossible X::Coerce::Role X::Comp X::Comp::AdHoc
    X::Comp::BeginTime X::Comp::FailGoal X::Comp::Group X::Comp::NYI
    X::Comp::Trait X::Comp::Trait::Invalid X::Comp::Trait::NotOnNative
    X::Comp::Trait::Scope X::Comp::Trait::Unknown X::Comp::TypeCheck
    X::Comp::WheneverOutOfScope X::CompUnit
    X::CompUnit::UnsatisfiedDependency X::Composition
    X::Composition::NotComposable X::Constructor X::Constructor::BadType
    X::Constructor::Positional X::Control X::ControlFlow
    X::ControlFlow::Return X::DateTime X::DateTime::InvalidDeltaUnit
    X::DateTime::TimezoneClash X::Declaration X::Declaration::OurScopeInRole
    X::Declaration::Scope X::Declaration::Scope::Multi X::Delete X::Does
    X::Does::TypeObject X::Dynamic X::Dynamic::NotFound X::Dynamic::Package
    X::Dynamic::Postdeclaration X::EXPORTHOW X::EXPORTHOW::Conflict
    X::EXPORTHOW::InvalidDirective X::EXPORTHOW::NothingToSupersede
    X::Encoding X::Encoding::AlreadyRegistered X::Encoding::Unknown X::Enum
    X::Enum::NoValue X::Eval X::Eval::NoSuchLang X::Exhausted
    X::Experimental X::Export X::Export::NameClash X::Hash X::Hash::Store
    X::Hash::Store::OddNumber X::HyperOp X::HyperOp::Infinite
    X::HyperOp::NonDWIM X::HyperRace X::HyperRace::Died X::HyperWhatever
    X::HyperWhatever::Multiple X::IO X::IO::BinaryAndEncoding
    X::IO::BinaryMode X::IO::Chdir X::IO::Chmod X::IO::Chown X::IO::Closed
    X::IO::Copy X::IO::Cwd X::IO::Dir X::IO::Directory X::IO::DoesNotExist
    X::IO::Flush X::IO::Link X::IO::Lock X::IO::Mkdir X::IO::Move
    X::IO::NotAChild X::IO::NotAFile X::IO::Null X::IO::Rename
    X::IO::Resolve X::IO::Rmdir X::IO::Symlink X::IO::Unknown X::IO::Unlink
    X::IllegalDimensionInShape X::IllegalOnFixedDimensionArray X::Immutable
    X::Import X::Import::MissingSymbols X::Import::NoSuchTag
    X::Import::OnlystarProto X::Import::Positional X::Import::Redeclaration
    X::Inheritance X::Inheritance::NotComposed X::Inheritance::SelfInherit
    X::Inheritance::UnknownParent X::Inheritance::Unsupported X::Invalid
    X::Invalid::ComputedValue X::Invalid::Value X::InvalidCodepoint
    X::InvalidType X::InvalidTypeSmiley X::Ism X::Ism::Unknown X::Item
    X::Language X::Language::IncompatRevisions X::Language::ModRequired
    X::Language::TooLate X::Language::Unsupported X::LibEmpty X::LibNone
    X::Localizer X::Localizer::NoContainer X::Lock X::Lock::Async
    X::Lock::Async::NotLocked X::Lock::ConditionVariable
    X::Lock::ConditionVariable::Duplicate X::Lock::ConditionVariable::New
    X::Lock::ConditionVariable::NoMutex
    X::Lock::ConditionVariable::WrongThread X::Lock::Unlock
    X::Lock::Unlock::NoMutex X::Lock::Unlock::WrongThread X::MOP X::Make
    X::Make::MatchRequired X::Match X::Match::Bool X::Method
    X::Method::Duplicate X::Method::InvalidQualifier X::Method::NotFound
    X::Method::Private X::Method::Private::Permission
    X::Method::Private::Unqualified X::Mixin X::Mixin::NotComposable
    X::Multi X::Multi::Ambiguous X::Multi::NoMatch X::MultipleTypeSmiley
    X::MustBeParametric X::NQP X::NQP::NotFound X::NYI X::NYI::Available
    X::NYI::BigInt X::NoCoreRevision X::NoDispatcher X::NoSuchSymbol
    X::NoZeroArgMeaning X::Nominalizable X::Nominalizable::NoKind
    X::Nominalizable::NoWrappee X::NotEnoughDimensions
    X::NotFoundInRepository X::NotParametric X::NotSingleGrapheme X::Numeric
    X::Numeric::CannotConvert X::Numeric::Confused X::Numeric::DivideByZero
    X::Numeric::Overflow X::Numeric::Real X::Numeric::Underflow
    X::Numeric::Uninitialized X::OS X::Obsolete X::OutOfRange X::Package
    X::Package::SameNameAsEnclosing X::Package::Stubbed X::Package::UseLib
    X::Pairup X::Pairup::OddNumber X::Parameter X::Parameter::AfterDefault
    X::Parameter::BadType X::Parameter::Default
    X::Parameter::Default::TypeCheck X::Parameter::InvalidConcreteness
    X::Parameter::InvalidType X::Parameter::MultipleTypeConstraints
    X::Parameter::Placeholder X::Parameter::RW X::Parameter::Twigil
    X::Parameter::TypedSlurpy X::Parameter::WrongOrder X::ParametricConstant
    X::Phaser X::Phaser::Multiple X::Phaser::PrePost X::PhaserExceptions
    X::Placeholder X::Placeholder::Attribute X::Placeholder::Block
    X::Placeholder::Mainline X::Placeholder::NonPlaceholder X::Pod
    X::PoisonedAlias X::Pragma X::Pragma::CannotPrecomp
    X::Pragma::CannotWhat X::Pragma::MustOneOf X::Pragma::NoArgs
    X::Pragma::OnlyOne X::Pragma::Unknown X::Pragma::UnknownArg X::Proc
    X::Proc::Async X::Proc::Async::AlreadyStarted X::Proc::Async::BindOrUse
    X::Proc::Async::CharsOrBytes X::Proc::Async::MissingColsRows
    X::Proc::Async::MustBeStarted X::Proc::Async::OpenForWriting
    X::Proc::Async::SupplyOrStd X::Proc::Async::TapBeforeSpawn
    X::Proc::Unsuccessful X::Promise X::Promise::Broken
    X::Promise::CauseOnlyValidOnBroken X::Promise::Combinator
    X::Promise::Resolved X::Promise::Vowed X::PseudoPackage
    X::PseudoPackage::InDeclaration X::QuoteWords X::QuoteWords::Missing
    X::QuoteWords::Missing::Closer X::REPL X::REPL::InvalidEnvironment
    X::Range X::Range::CannotIterate X::Range::Incomparable
    X::Range::InvalidArg X::Range::Rand X::Range::Rand::InvalidEndpoints
    X::React X::React::Died X::Redeclaration X::Redeclaration::Multi
    X::Redeclaration::Outer X::Role X::Role::Attribute
    X::Role::Attribute::Conflicts X::Role::Attribute::Exists
    X::Role::BodyReturn X::Role::Group X::Role::Group::Documenting
    X::Role::Initialization X::Role::Instantiation X::Role::Parametric
    X::Role::Parametric::NoSuchCandidate X::Role::Unimplemented
    X::Role::Unimplemented::Multi X::Role::Unresolved
    X::Role::Unresolved::Method X::Role::Unresolved::Multi
    X::Role::Unresolved::Private X::RoleApplier X::RoleApplier::Method
    X::Routine X::Routine::Unwrap X::Scheduler X::Scheduler::CueInNaNSeconds
    X::SecurityPolicy X::SecurityPolicy::Eval X::Seq X::Seq::Consumed
    X::Seq::NotIndexable X::Sequence X::Sequence::Deduction
    X::Sequence::Endpoint X::Set X::Set::Coerce X::Signature
    X::Signature::NameClash X::Signature::Placeholder X::Str
    X::Str::InvalidCharName X::Str::Match X::Str::Numeric X::Str::Sprintf
    X::Str::Sprintf::Directives X::Str::Subst X::Str::Subst::Adverb
    X::Str::Trans X::Str::Trans::IllegalKey X::Str::Trans::InvalidArg
    X::StubCode X::Subscript X::Subscript::Negative X::Supply
    X::Supply::Combinator X::Supply::Migrate X::Supply::Migrate::Needs
    X::Supply::New X::Symbol X::Symbol::Kind X::Symbol::NotDynamic
    X::Symbol::NotLexical X::Syntax X::Syntax::AddCategorical
    X::Syntax::AddCategorical::TooFewParts
    X::Syntax::AddCategorical::TooManyParts X::Syntax::Adverb
    X::Syntax::AmbiguousAdverb X::Syntax::Argument
    X::Syntax::Argument::MOPMacro X::Syntax::Augment
    X::Syntax::Augment::Adverb X::Syntax::Augment::Illegal
    X::Syntax::Augment::WithoutMonkeyTyping X::Syntax::BlockGobbled
    X::Syntax::CannotMeta X::Syntax::Coercer X::Syntax::Coercer::TooComplex
    X::Syntax::Comment X::Syntax::Comment::Embedded
    X::Syntax::ConditionalOperator
    X::Syntax::ConditionalOperator::PrecedenceTooLoose
    X::Syntax::ConditionalOperator::SecondPartGobbled
    X::Syntax::ConditionalOperator::SecondPartInvalid X::Syntax::Confused
    X::Syntax::Doc X::Syntax::Doc::Declarator X::Syntax::DuplicatedPrefix
    X::Syntax::Extension X::Syntax::Extension::Category
    X::Syntax::Extension::Null X::Syntax::Extension::SpecialForm
    X::Syntax::Extension::TooComplex X::Syntax::InfixInTermPosition
    X::Syntax::KeywordAsFunction X::Syntax::Malformed
    X::Syntax::Malformed::Elsif X::Syntax::Missing X::Syntax::Name
    X::Syntax::Name::Null X::Syntax::NegatedPair X::Syntax::NoSelf
    X::Syntax::NonAssociative X::Syntax::NonListAssociative
    X::Syntax::Number X::Syntax::Number::IllegalDecimal
    X::Syntax::Number::LiteralType X::Syntax::Number::RadixOutOfRange
    X::Syntax::P5 X::Syntax::ParentAsHash X::Syntax::Perl5Var X::Syntax::Pod
    X::Syntax::Pod::BeginWithDirective X::Syntax::Pod::BeginWithoutEnd
    X::Syntax::Pod::BeginWithoutIdentifier X::Syntax::Pod::DeclaratorLeading
    X::Syntax::Pod::DeclaratorTrailing X::Syntax::Pod::DirectiveWithLevel
    X::Syntax::Regex X::Syntax::Regex::Adverb X::Syntax::Regex::Alias
    X::Syntax::Regex::InsignificantWhitespace
    X::Syntax::Regex::MalformedRange X::Syntax::Regex::NonQuantifiable
    X::Syntax::Regex::NullRegex X::Syntax::Regex::QuantifierValue
    X::Syntax::Regex::SolitaryBacktrackControl
    X::Syntax::Regex::SolitaryModifier X::Syntax::Regex::SolitaryQuantifier
    X::Syntax::Regex::SpacesInBareRange
    X::Syntax::Regex::UnrecognizedBoundary
    X::Syntax::Regex::UnrecognizedMetachar
    X::Syntax::Regex::UnrecognizedModifier X::Syntax::Regex::Unspace
    X::Syntax::Regex::Unterminated X::Syntax::Reserved X::Syntax::Self
    X::Syntax::Self::WithoutObject X::Syntax::Signature
    X::Syntax::Signature::InvocantMarker
    X::Syntax::Signature::InvocantNotAllowed X::Syntax::Term
    X::Syntax::Term::MissingInitializer X::Syntax::Type
    X::Syntax::Type::Adverb X::Syntax::UnlessElse X::Syntax::Variable
    X::Syntax::Variable::BadType X::Syntax::Variable::ConflictingTypes
    X::Syntax::Variable::IndirectDeclaration
    X::Syntax::Variable::Initializer X::Syntax::Variable::Match
    X::Syntax::Variable::MissingInitializer X::Syntax::Variable::Numeric
    X::Syntax::Variable::SignatureAssignment
    X::Syntax::Variable::SignatureWithoutInitializer
    X::Syntax::Variable::Twigil X::Syntax::VirtualCall
    X::Syntax::WithoutElse X::Temporal X::Temporal::InvalidFormat
    X::Temporal::OutOfRange X::TooLateForREPR X::TooManyDimensions X::Trait
    X::Trait::Invalid X::Trait::NotOnNative X::Trait::Scope
    X::Trait::Unknown X::TypeCheck X::TypeCheck::Argument
    X::TypeCheck::Assignment X::TypeCheck::Attribute
    X::TypeCheck::Attribute::Default X::TypeCheck::Binding
    X::TypeCheck::Binding::Parameter X::TypeCheck::Return
    X::TypeCheck::Splice X::Undeclared X::Undeclared::Symbols X::UnitScope
    X::UnitScope::Invalid X::UnitScope::MustHaveUnit X::UnitScope::TooLate
    X::Useless X::Useless::Declaration X::Value X::Value::Dynamic
    X::WhateverCode X::WhateverCode::SmartMatch
    X::WhateverCode::SmartMatch::LHS X::WheneverOutOfScope X::Worry
    X::Worry::P5 X::Worry::P5::BackReference X::Worry::P5::LeadingZero
    X::Worry::P5::Reference X::Worry::Precedence X::Worry::Precedence::Range
    X::Wrapper
>.Set;

sub core-name(Str:D $name --> Bool:D) is export { %NAMES{$name}:exists }
