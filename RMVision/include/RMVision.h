////////////////////////////////////////////////////////////////////////////////
//  RMVision.h
////////////////////////////////////////////////////////////////////////////////
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#import "RMVisionObjects.h"
#import "RMVisionModuleProtocol.h"

@class RMVisionModule;
@class RMVisionTrainingData;

typedef enum { RMCamera_Back = 0, RMCamera_Front = 1 } RMCamera;
typedef enum { RMCameraQuality_High, RMCameraQuality_Low } RMCameraQuality;
typedef enum {
    RMVisionBrightnessStateUnknown   = 0,
    RMVisionBrightnessStateTooDark   = 1,
    RMVisionBrightnessStateDark      = 2,
    RMVisionBrightnessStateBright    = 3,
    RMVisionBrightnessStateTooBright = 4,
} RMVisionBrightnessState;

extern NSString *const RMVisionModule_TakePicture;
extern NSString *const RMVisionModule_TakeVideo;
extern NSString *const RMVisionModule_FaceDetection;
extern NSString *const RMVisionModule_EyeDetection;
extern NSString *const RMVisionModule_GPUImageExample;

@protocol RMVisionDelegate;

@interface RMVision : NSObject
@property (nonatomic) RMCamera camera;
@property (nonatomic) RMCameraQuality quality;
@property (nonatomic, readonly) float width;
@property (nonatomic, readonly) float height;
@property (nonatomic, readonly, getter=isGrayscaleMode) BOOL grayscaleMode;
@property (nonatomic, readonly) BOOL isSlow;
@property (atomic, readonly, getter=isRunning) BOOL running;
@property (nonatomic, getter=isImageFlipped) BOOL imageFlipped;
@property (nonatomic, getter=isAudioEnabled) BOOL audioEnabled;
@property (nonatomic) int targetFrameRate;
@property (nonatomic) CGPoint focusPointOfInterest;
@property (nonatomic) CGPoint exposurePointOfInterest;
@property (atomic, readonly) float fps;
@property (nonatomic, weak) id <RMVisionDelegate> delegate;
@property (nonatomic, readonly) AVCaptureSession *session;
@property (nonatomic, readonly) AVCaptureDevice *device;
@property (nonatomic, readonly) AVCaptureVideoDataOutput *videoOutput;
@property (nonatomic, readonly) AVCaptureVideoPreviewLayer *videoPreviewLayer;
- (id)init;
- (id)initWithCamera:(RMCamera)camera;
- (id)initWithCamera:(RMCamera)camera andQuality:(RMCameraQuality)quality;
- (void)startCapture;
- (void)startCaptureWithCompletion:(void (^)(BOOL didSuccessfullyStart))completion;
- (void)stopCapture;
- (void)stopCaptureWithCompletion:(void (^)(BOOL didSuccessfullyStop))completion;
- (UIImage *)currentImage;
@property (nonatomic, strong, readonly) NSSet *activeModules;
- (void)activateModule:(id<RMVisionModuleProtocol>)module;
- (void)deactivateModule:(id<RMVisionModuleProtocol>)module;
- (void)deactivateAllModules;
- (BOOL)activateModuleWithName:(NSString *)moduleName;
- (BOOL)deactivateModuleWithName:(NSString *)moduleName;
- (BOOL)pauseModuleWithName:(NSString *)moduleName;
- (BOOL)unpauseModuleWithName:(NSString *)moduleName;
- (BOOL)trainModule:(NSString *)moduleName withData:(id)trainingData;
@end

@protocol RMVisionDelegate <NSObject>
@optional
- (void)didDetectFace:(RMFace *)face;
- (void)didLoseFace;
- (void)didDetectMotion:(RMMotion *)motion;
- (void)didLoseMotion;
- (void)didDetectBlob:(RMBlob *)blob;
- (void)didLoseBlob;
- (void)didDetectLine:(RMLine *)line;
- (void)didLoseLine:(RMLine *)line;
- (void)didDetectColors:(RMColors *)colors;
- (void)didLoseColors;
- (void)showDebugImage:(UIImage *)debugImage;
@end

#import "RMVisionModule.h"
#import "RMBorderView.h"
#import "RMBrightnessMeteringModule.h"
#import "RMEyeDetectionModule.h"
#import "RMFaceDetectionModule.h"
#import "RMGPUImageExampleModule.h"
#import "RMImageUtils.h"
#import "RMLineDetectionModule.h"
#import "RMMotionDetectionModule.h"
#import "RMMotionTriggeredColorTrainingModule.h"
#import "RMPictureModule.h"
#import "RMThroughRomosEyesModule.h"
#import "RMVideoModule.h"
#import "RMVisualStasisDetectionModule.h"
#import "RMVisionBrightHueSegmentationModule.h"
#import "RMVisionDebugBroker.h"
#import "RMVisionNaiveLineTrainingModule.h"
#import "RMVisionObjectTrackingModule.h"
#import "RMVisionObjectTrackingModuleDebug.h"
