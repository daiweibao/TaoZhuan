//
//  MyRecordButtonView.m
//  GongXiangJie
//
//  Created by 爱恨的潮汐 on 2017/7/24.
//  Copyright © 2017年 北京嗅美科技有限公司. All rights reserved.
//

#import "MyRecordButtonView.h"
#import "MOKORecorderTool.h"
#import "MOKORecordShowManager.h"
#import "MOKORecordButton.h"
#define kFakeTimerDuration       1
#define kMaxRecordDuration       60     //最长录音时长
#define kRemainCountingDuration  10     //剩余多少秒开始倒计时

@interface MyRecordButtonView()<MOKOSecretTrainRecorderDelegate>
@property (nonatomic, strong) MOKORecordShowManager *voiceRecordCtrl;
@property (nonatomic, assign) MOKORecordState currentRecordState;
@property (nonatomic, strong) NSTimer *fakeTimer;
@property (nonatomic, assign) float duration;
@property (nonatomic, assign) BOOL canceled;

@property (nonatomic, strong) MOKORecordButton *recordButton;
@property (nonatomic, strong) MOKORecorderTool *recorder;

@end

@implementation MyRecordButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.recordButton = [MOKORecordButton buttonWithType:UIButtonTypeCustom];
        self.recorder = [MOKORecorderTool sharedRecorder];
        self.recorder.delegate = self;
        self.recordButton.frame =CGRectMake(0, 0,SCREEN_WIDTH-88-40, 34);
        self.recordButton.backgroundColor = [UIColor whiteColor];
        self.recordButton.titleLabel.font = [UIFont systemFontOfSize:14];
        self.recordButton.layer.cornerRadius = 5;
        self.recordButton.layer.borderWidth = 1;
        self.recordButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        self.recordButton.clipsToBounds = YES;
        [self.recordButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:self.recordButton];
        
        //录音相关
        [self toDoRecord];
    }
    return self;
}
#pragma mark ---- 录音全部状态的监听 以及视图的构建 切换
-(void)toDoRecord
{
    __weak typeof(self) weak_self = self;
    //手指按下
    self.recordButton.recordTouchDownAction = ^(MOKORecordButton *sender){
        
        //按下回调
        if (weak_self.downButtonPlay) {
            weak_self.downButtonPlay();
        }
        
        //如果用户没有开启麦克风权限,不能让其录音
        if (![weak_self canRecord]) return;
        
//        NSLog(@"开始录音");
        if (sender.highlighted) {
            sender.highlighted = YES;
            [sender setButtonStateWithRecording];
        }
        [weak_self.recorder startRecording];
        weak_self.currentRecordState = MOKORecordState_Recording;
        [weak_self dispatchVoiceState];
    };
    
    //手指抬起
    self.recordButton.recordTouchUpInsideAction = ^(MOKORecordButton *sender){
//        NSLog(@"完成录音");
        //时长(过渡一下，不然拿不到)
        float durationMy = weak_self.duration;
        
        [sender setButtonStateWithNormal];
        [weak_self.recorder stopRecording];
        weak_self.currentRecordState = MOKORecordState_Normal;
        [weak_self dispatchVoiceState];
        
        
        //录音时间小于2秒不发送
        if (durationMy<2) {
            [MBProgressHUD showError:@"说话时间太短"];
            return ;
        }
        
        //得到录音路径
      NSURL * urlAudio = [weak_self.recorder getVoicePath];
        
        if (urlAudio) {
            //回调录音文件,和录音时长
            if (weak_self.getAudioPathURL) {
                weak_self.getAudioPathURL(urlAudio,durationMy);
            }
            
        }
        
    };
    
    //手指滑出按钮
    self.recordButton.recordTouchUpOutsideAction = ^(MOKORecordButton *sender){
//        NSLog(@"取消录音");
        [sender setButtonStateWithNormal];
        weak_self.currentRecordState = MOKORecordState_Normal;
        [weak_self dispatchVoiceState];
    };
    
    //中间状态  从 TouchDragInside ---> TouchDragOutside
    self.recordButton.recordTouchDragExitAction = ^(MOKORecordButton *sender){
        weak_self.currentRecordState = MOKORecordState_ReleaseToCancel;
        [weak_self dispatchVoiceState];
    };
    
    //中间状态  从 TouchDragOutside ---> TouchDragInside
    self.recordButton.recordTouchDragEnterAction = ^(MOKORecordButton *sender){
//        NSLog(@"继续录音");
        weak_self.currentRecordState = MOKORecordState_Recording;
        [weak_self dispatchVoiceState];
    };
}

- (void)startFakeTimer
{
    if (_fakeTimer) {
        [_fakeTimer invalidate];
        _fakeTimer = nil;
    }
    self.fakeTimer = [NSTimer scheduledTimerWithTimeInterval:kFakeTimerDuration target:self selector:@selector(onFakeTimerTimeOut) userInfo:nil repeats:YES];
    [_fakeTimer fire];
}

- (void)stopFakeTimer
{
    if (_fakeTimer) {
        [_fakeTimer invalidate];
        _fakeTimer = nil;
    }
}

- (void)onFakeTimerTimeOut
{
    self.duration += kFakeTimerDuration;
//    NSLog(@"+++duration+++ %f",self.duration);
    float remainTime = kMaxRecordDuration-self.duration;
    if ((int)remainTime == 0) {
        self.currentRecordState = MOKORecordState_Normal;
        [self dispatchVoiceState];
    }
    else if ([self shouldShowCounting]) {
        self.currentRecordState = MOKORecordState_RecordCounting;
        [self dispatchVoiceState];
        [self.voiceRecordCtrl showRecordCounting:remainTime];
    }
    else
    {
        [self.recorder.recorder updateMeters];
        float   level = 0.0f;                // The linear 0.0 .. 1.0 value we need.
        
        float   minDecibels = -80.0f; // Or use -60dB, which I measured in a silent room.
        float decibels = [self.recorder.recorder peakPowerForChannel:0];
        if (decibels < minDecibels)
        {
            level = 0.0f;
        }
        else if (decibels >= 0.0f)
        {
            level = 1.0f;
        }
        else
        {
            float   root            = 2.0f;
            float   minAmp          = powf(10.0f, 0.05f * minDecibels);
            float   inverseAmpRange = 1.0f / (1.0f - minAmp);
            float   amp             = powf(10.0f, 0.05f * decibels);
            float   adjAmp          = (amp - minAmp) * inverseAmpRange;
            level = powf(adjAmp, 1.0f / root);
        }
        
//        NSLog(@"平均值 %f", level );
        //        NSLog(@"平均值 %f", level * 120);
        
        [self.voiceRecordCtrl updatePower:level];
    }
}
- (BOOL)shouldShowCounting
{
    if (self.duration >= (kMaxRecordDuration-kRemainCountingDuration) && self.duration < kMaxRecordDuration && self.currentRecordState != MOKORecordState_ReleaseToCancel) {
        return YES;
    }
    return NO;
}

- (void)resetState
{
    [self stopFakeTimer];
    self.duration = 0;
    self.canceled = YES;
}

- (void)dispatchVoiceState
{
    if (_currentRecordState == MOKORecordState_Recording) {
        self.canceled = NO;
        [self startFakeTimer];
    }
    else if (_currentRecordState == MOKORecordState_Normal)
    {
        [self resetState];
    }
    [self.voiceRecordCtrl updateUIWithRecordState:_currentRecordState];
}

- (MOKORecordShowManager *)voiceRecordCtrl
{
    if (_voiceRecordCtrl == nil) {
        _voiceRecordCtrl = [MOKORecordShowManager new];
    }
    return _voiceRecordCtrl;
}

//判断是否允许使用麦克风7.0新增的方法requestRecordPermission
-(BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                bCanRecord = YES;
            }
            else {
                bCanRecord = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:nil
                                                message:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"
                                               delegate:nil
                                      cancelButtonTitle:@"关闭"
                                      otherButtonTitles:nil] show];
                });
            }
        }];
    }
    return bCanRecord;
}

- (void)playVoice
{
//    NSLog(@"播放录音");
    [self.recorder playRecordingFile];
}


@end
