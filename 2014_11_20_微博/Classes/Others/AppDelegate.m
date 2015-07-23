//
//  AppDelegate.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-20.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "AppDelegate.h"
#import <Availability.h>
#import <AVFoundation/AVFoundation.h>
#import "XXBRootViewTools.h"

@interface AppDelegate ()
/**
 *  用于后台播放音乐用的
 */
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /**
     申请通知
     */
    if (iOS8)
    {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [application registerUserNotificationSettings:setting];

    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];
        [self.window makeKeyAndVisible];
    /**
     *  选择主窗口
     */
    [XXBRootViewTools  chooseRootViewController:self.window];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:taskID];
    }];
    
    if (!iOS8) {
        // 播放,新浪微博给一个没有声音的Mp3,目的是需要告诉苹果,我在播放东西,并不需要让用户听到.
        // 创建本地播放对象
        // url:要播放文件的url
        // 获取url,从bundle里面获取
        // 获取本地播放文件的url
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        _player = player;
        
        // -1无限播放
        player.numberOfLoops = -1;
        
        [player prepareToPlay];
        
        [player play];
        
    }

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /**
     *  接收到内存警告
     */
}
@end
