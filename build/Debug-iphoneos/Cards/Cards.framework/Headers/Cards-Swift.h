// Generated by Apple Swift version 4.2 (swiftlang-1000.0.36 clang-1000.10.44)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import CoreGraphics;
@import Foundation;
@import UIKit;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="Cards",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

@class Card;
@class CardHighlight;
@class UIButton;
@class CardPlayer;

SWIFT_PROTOCOL("_TtP5Cards12CardDelegate_")
@protocol CardDelegate
@optional
- (void)cardDidTapInsideCard:(Card * _Nonnull)card;
- (void)cardWillShowDetailViewWithCard:(Card * _Nonnull)card;
- (void)cardDidShowDetailViewWithCard:(Card * _Nonnull)card;
- (void)cardWillCloseDetailViewWithCard:(Card * _Nonnull)card;
- (void)cardDidCloseDetailViewWithCard:(Card * _Nonnull)card;
- (void)cardIsShowingDetailWithCard:(Card * _Nonnull)card;
- (void)cardIsHidingDetailWithCard:(Card * _Nonnull)card;
- (void)cardDetailIsScrollingWithCard:(Card * _Nonnull)card;
- (void)cardHighlightDidTapButtonWithCard:(CardHighlight * _Nonnull)card button:(UIButton * _Nonnull)button;
- (void)cardPlayerDidPlayWithCard:(CardPlayer * _Nonnull)card;
- (void)cardPlayerDidPauseWithCard:(CardPlayer * _Nonnull)card;
@end

@class UIColor;
@class UIImage;
@class NSCoder;

SWIFT_CLASS("_TtC5Cards4Card")
@interface Card : UIView <CardDelegate>
/// Color for the card’s labels.
@property (nonatomic, strong) UIColor * _Nonnull textColor;
/// Amount of blur for the card’s shadow.
@property (nonatomic) CGFloat shadowBlur;
/// Alpha of the card’s shadow.
@property (nonatomic) float shadowOpacity;
/// Color of the card’s shadow.
@property (nonatomic, strong) UIColor * _Nonnull shadowColor;
/// The image to display in the background.
@property (nonatomic, strong) UIImage * _Nullable backgroundImage;
/// Corner radius of the card.
@property (nonatomic) CGFloat cardRadius;
/// Insets between card’s content and edges ( in percentage )
@property (nonatomic) CGFloat contentInset;
/// Color of the card’s background.
@property (nonatomic, strong) UIColor * _Nullable backgroundColor;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)drawRect:(CGRect)rect;
@end

@class UIViewController;
@protocol UIViewControllerAnimatedTransitioning;

@interface Card (SWIFT_EXTENSION(Cards)) <UIViewControllerTransitioningDelegate>
- (id <UIViewControllerAnimatedTransitioning> _Nullable)animationControllerForPresentedController:(UIViewController * _Nonnull)presented presentingController:(UIViewController * _Nonnull)presenting sourceController:(UIViewController * _Nonnull)source SWIFT_WARN_UNUSED_RESULT;
- (id <UIViewControllerAnimatedTransitioning> _Nullable)animationControllerForDismissedController:(UIViewController * _Nonnull)dismissed SWIFT_WARN_UNUSED_RESULT;
@end

@class UITouch;
@class UIEvent;

@interface Card (SWIFT_EXTENSION(Cards)) <UIGestureRecognizerDelegate>
- (void)touchesEnded:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)touchesBegan:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
@end


SWIFT_CLASS("_TtC5Cards11CardArticle")
@interface CardArticle : Card
/// Text of the title label.
@property (nonatomic, copy) NSString * _Nonnull title;
/// Max font size the title label.
@property (nonatomic) CGFloat titleSize;
/// Text of the subtitle label.
@property (nonatomic, copy) NSString * _Nonnull subtitle;
/// Max font size the subtitle label.
@property (nonatomic) CGFloat subtitleSize;
/// Text of the category label.
@property (nonatomic, copy) NSString * _Nonnull category;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)drawRect:(CGRect)rect;
@end



SWIFT_CLASS("_TtC5Cards9CardGroup")
@interface CardGroup : Card
/// Text of the title label.
@property (nonatomic, copy) NSString * _Nonnull title;
/// Max font size the title label.
@property (nonatomic) CGFloat titleSize;
/// Text of the subtitle label.
@property (nonatomic, copy) NSString * _Nonnull subtitle;
/// Max font size the subtitle label.
@property (nonatomic) CGFloat subtitleSize;
/// Style for the blur effect.
@property (nonatomic) UIBlurEffectStyle blurEffect;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)drawRect:(CGRect)rect;
@end


SWIFT_CLASS("_TtC5Cards16CardGroupSliding")
@interface CardGroupSliding : CardGroup
/// Size for the collection view items.
@property (nonatomic) CGFloat iconsSize;
/// Corner radius of the collection view items
@property (nonatomic) CGFloat iconsRadius;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)drawRect:(CGRect)rect;
@end

@class UICollectionView;
@class UICollectionViewLayout;

@interface CardGroupSliding (SWIFT_EXTENSION(Cards)) <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView * _Nonnull)collectionView layout:(UICollectionViewLayout * _Nonnull)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
@end

@class UICollectionViewCell;

@interface CardGroupSliding (SWIFT_EXTENSION(Cards)) <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView * _Nonnull)collectionView numberOfItemsInSection:(NSInteger)section SWIFT_WARN_UNUSED_RESULT;
- (UICollectionViewCell * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView cellForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC5Cards13CardHighlight")
@interface CardHighlight : Card
/// Text of the title label.
@property (nonatomic, copy) NSString * _Nonnull title;
/// Max font size the title label.
@property (nonatomic) CGFloat titleSize;
/// Text of the title label of the item at the bottom.
@property (nonatomic, copy) NSString * _Nonnull itemTitle;
/// Max font size the subtitle label of the item at the bottom.
@property (nonatomic) CGFloat itemTitleSize;
/// Text of the subtitle label of the item at the bottom.
@property (nonatomic, copy) NSString * _Nonnull itemSubtitle;
/// Max font size the subtitle label of the item at the bottom.
@property (nonatomic) CGFloat itemSubtitleSize;
/// Image displayed in the icon ImageView.
@property (nonatomic, strong) UIImage * _Nullable icon;
/// Corner radius for the icon ImageView
@property (nonatomic) CGFloat iconRadius;
/// Text for the card’s button.
@property (nonatomic, copy) NSString * _Nonnull buttonText;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)drawRect:(CGRect)rect;
@end


SWIFT_CLASS("_TtC5Cards10CardPlayer")
@interface CardPlayer : Card
/// Text of the title label.
@property (nonatomic, copy) NSString * _Nonnull title;
/// Max font size of the title label.
@property (nonatomic) CGFloat titleSize;
/// Text of the subtitle label.
@property (nonatomic, copy) NSString * _Nonnull subtitle;
/// Max font size of the subtitle label.
@property (nonatomic) CGFloat subtitleSize;
/// Text of the category label.
@property (nonatomic, copy) NSString * _Nonnull category;
/// Size for the play button in the player.
@property (nonatomic) CGFloat playBtnSize;
/// Image shown in the play button.
@property (nonatomic, strong) UIImage * _Nullable playImage;
/// Image shown before the player is loaded.
@property (nonatomic, strong) UIImage * _Nullable playerCover;
/// If the player should start the playback when is ready.
@property (nonatomic) BOOL isAutoplayEnabled;
/// If the player should restart the playback when it ends.
@property (nonatomic) BOOL shouldRestartVideoWhenPlaybackEnds;
/// Source for the video ( streaming or local ).
@property (nonatomic, copy) NSURL * _Nullable videoSource;
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)drawRect:(CGRect)rect;
- (void)touchesBegan:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
@end






SWIFT_CLASS("_TtC5Cards13SlidingCVCell")
@interface SlidingCVCell : UICollectionViewCell
- (nonnull instancetype)initWithFrame:(CGRect)frame OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)drawRect:(CGRect)rect;
@end



#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop