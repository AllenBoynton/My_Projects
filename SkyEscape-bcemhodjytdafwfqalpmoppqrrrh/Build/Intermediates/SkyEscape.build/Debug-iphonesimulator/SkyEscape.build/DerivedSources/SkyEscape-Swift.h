// Generated by Apple Swift version 3.1 (swiftlang-802.0.53 clang-802.0.42)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
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

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
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
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
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
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
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
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import SpriteKit;
@import CoreGraphics;
@import Foundation;
@import GameKit;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;

SWIFT_CLASS("_TtC9SkyEscape11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey, id> * _Nullable)launchOptions SWIFT_WARN_UNUSED_RESULT;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class SKView;
@class UITouch;
@class UIEvent;
@class NSCoder;

SWIFT_CLASS("_TtC9SkyEscape12CreditsScene")
@interface CreditsScene : SKScene
- (void)didMoveToView:(SKView * _Nonnull)view;
- (void)touchesBegan:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (nonnull instancetype)initWithSize:(CGSize)size OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class SKPhysicsBody;
@class SKEmitterNode;
@class SKNode;
@class SKSpriteNode;
@class SKTexture;
@class SKLabelNode;
@class GKAchievement;
@class SKPhysicsContact;

SWIFT_CLASS("_TtC9SkyEscape9GameScene")
@interface GameScene : SKScene <SKPhysicsContactDelegate>
@property (nonatomic, strong) SKPhysicsBody * _Nonnull firstBody;
@property (nonatomic, strong) SKPhysicsBody * _Nonnull secondBody;
@property (nonatomic) CGPoint touchLocation;
@property (nonatomic, strong) SKEmitterNode * _Nonnull smokeTrail;
@property (nonatomic, strong) SKEmitterNode * _Nonnull explode;
@property (nonatomic, readonly, strong) SKNode * _Nonnull node;
@property (nonatomic, strong) SKSpriteNode * _Nonnull player;
@property (nonatomic, copy) NSArray<SKTexture *> * _Nonnull textureArray;
@property (nonatomic, strong) SKSpriteNode * _Nonnull newEnemy;
@property (nonatomic, copy) NSArray<SKSpriteNode *> * _Nonnull enemyPlaneArray;
@property (nonatomic, strong) SKSpriteNode * _Nonnull enemyFire;
@property (nonatomic, strong) SKSpriteNode * _Nonnull missiles;
@property (nonatomic, strong) SKSpriteNode * _Nonnull turret;
@property (nonatomic, strong) SKSpriteNode * _Nonnull soldierWalk;
@property (nonatomic, strong) SKSpriteNode * _Nonnull soldierShoot;
@property (nonatomic, copy) NSArray<SKTexture *> * _Nonnull explosionTextures;
@property (nonatomic, strong) SKSpriteNode * _Nonnull bullet;
@property (nonatomic, strong) SKSpriteNode * _Nonnull bombs;
@property (nonatomic, strong) SKSpriteNode * _Nonnull powerUps;
@property (nonatomic, strong) SKSpriteNode * _Nonnull coins;
@property (nonatomic, copy) NSArray<SKTexture *> * _Nonnull wingmenArray;
@property (nonatomic, strong) SKSpriteNode * _Nonnull skyExplosion;
@property (nonatomic, strong) SKSpriteNode * _Nonnull randomAlly;
@property (nonatomic) BOOL died;
@property (nonatomic) BOOL gamePaused;
@property (nonatomic) BOOL gameStarted;
@property (nonatomic) BOOL gameOver;
@property (nonatomic, strong) SKSpriteNode * _Nonnull display;
@property (nonatomic, strong) SKSpriteNode * _Nonnull pauseNode;
@property (nonatomic, strong) SKSpriteNode * _Nonnull pauseButton;
@property (nonatomic, strong) SKSpriteNode * _Nonnull startButton;
@property (nonatomic, strong) SKSpriteNode * _Nonnull continueBTN;
@property (nonatomic, strong) SKSpriteNode * _Nonnull showLeader;
@property (nonatomic, strong) SKSpriteNode * _Nonnull coinImage;
@property (nonatomic, strong) SKLabelNode * _Nonnull gameOverLabel;
@property (nonatomic, strong) SKLabelNode * _Nonnull levelTimerLabel;
@property (nonatomic) NSInteger timescore;
@property (nonatomic) NSInteger timesecond;
@property (nonatomic, strong) SKLabelNode * _Nonnull healthLabel;
@property (nonatomic) NSInteger health;
@property (nonatomic, strong) SKLabelNode * _Null_unspecified scoreLabel;
@property (nonatomic) int64_t score;
@property (nonatomic, strong) SKLabelNode * _Null_unspecified powerUpLabel;
@property (nonatomic) NSInteger powerUpCount;
@property (nonatomic, strong) SKLabelNode * _Null_unspecified coinCountLbl;
@property (nonatomic) NSInteger coinCount;
@property (nonatomic, copy) NSString * _Nullable achievementIdentifier;
@property (nonatomic) int64_t progressPercentage;
@property (nonatomic, strong) GKAchievement * _Nullable levelAchievement;
@property (nonatomic, strong) GKAchievement * _Nullable scoreAchievement;
@property (nonatomic, strong) GKAchievement * _Nullable powerUpAchievement;
- (void)restartScene;
- (void)startScene;
- (void)didMoveToView:(SKView * _Nonnull)view;
- (void)touchesBegan:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)touchesMoved:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (void)didBeginContact:(SKPhysicsContact * _Nonnull)contact;
- (void)bothNodesGone;
- (void)oneNodeGone;
- (void)removeBothNodes;
- (void)update:(NSTimeInterval)currentTime;
- (void)createBackground;
- (void)moveBackground;
- (void)createMidground;
- (void)moveMidground;
- (void)createForeground;
- (void)moveForeground;
- (void)setupPlayer;
- (void)fireBullets;
- (void)fireBombs;
- (void)spawnWingman;
- (void)spawnPowerUps;
- (void)spawnCoins;
- (void)skyExplosions;
- (void)spawnEnemyPlanes;
- (void)spawnEnemyFire;
- (void)setupTurret;
- (void)spawnTurretMissiles;
- (void)setupSoldiers;
- (void)setupShooters;
- (void)enemyExplosion:(SKNode * _Nonnull)plane;
- (void)fire:(CGPoint)pos;
- (void)sparks:(CGPoint)pos;
- (void)crashSound;
- (void)continueButton;
- (void)createHUD;
- (void)pauseGame;
- (void)playGame;
- (void)showPauseAlert;
- (void)holdGame;
- (void)diedOnce;
- (void)showGameOverAlert;
- (void)didSimulatePhysics;
- (CGFloat)randomBetweenNumbers:(CGFloat)firstNum secondNum:(CGFloat)secondNum SWIFT_WARN_UNUSED_RESULT;
- (CGFloat)random SWIFT_WARN_UNUSED_RESULT;
- (CGFloat)random:(CGFloat)min max:(CGFloat)max SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithSize:(CGSize)size OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class GKLocalPlayer;
@class GKGameCenterViewController;
@class NSBundle;

SWIFT_CLASS("_TtC9SkyEscape18GameViewController")
@interface GameViewController : UIViewController <GKGameCenterControllerDelegate>
@property (nonatomic, strong) GameScene * _Nonnull scene;
/// The local player object.
@property (nonatomic, readonly, strong) GKLocalPlayer * _Nonnull gameCenterPlayer;
- (void)viewDidLoad;
- (void)authenticatePlayer;
- (void)notificationReceived;
- (void)authenticationDidChange:(NSNotification * _Nonnull)notification;
- (void)reportScore:(int64_t)score;
- (void)gameCenterStateChanged;
- (void)showLeaderboard;
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController * _Nonnull)gameCenterViewController;
@property (nonatomic, readonly) BOOL shouldAutorotate;
@property (nonatomic, readonly) UIInterfaceOrientationMask supportedInterfaceOrientations;
@property (nonatomic, readonly) BOOL prefersStatusBarHidden;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC9SkyEscape16InstructionScene")
@interface InstructionScene : SKScene
- (void)didMoveToView:(SKView * _Nonnull)view;
- (void)touchesBegan:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (nonnull instancetype)initWithSize:(CGSize)size OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC9SkyEscape8MainMenu")
@interface MainMenu : SKScene
- (void)didMoveToView:(SKView * _Nonnull)view;
- (SKSpriteNode * _Nonnull)infoButtonNode SWIFT_WARN_UNUSED_RESULT;
- (void)touchesBegan:(NSSet<UITouch *> * _Nonnull)touches withEvent:(UIEvent * _Nullable)event;
- (nonnull instancetype)initWithSize:(CGSize)size OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
