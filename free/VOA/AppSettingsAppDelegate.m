//
//  AppSettingsAppDelegate.m
//  VOA
//
//  Created by song zhao on 12-2-2.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "AppSettingsAppDelegate.h" 
#import "FlurryAnalytics.h" //Flurry对应用信息进行统计

@implementation AppSettingsAppDelegate

@synthesize windowOne;
@synthesize windowTwo;
@synthesize rootControllerOne;
@synthesize rootControllerTwo;
@synthesize myView;
@synthesize scrollView;
@synthesize pageControl;
//@synthesize window;

@synthesize left;
@synthesize right;
@synthesize leftDefault;
@synthesize rightDefault;


/**
 *  帮助页控制函数
 */
- (void)changePage:(UIPageControl *)sender 
{
    int page = pageControl.currentPage;
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];  
}

/**
 *  Flurry所需函数
 */
void uncaughtExceptionHandler(NSException *exception) {
    [FlurryAnalytics logError:@"Uncaught" message:@"Crash!" exception:exception];
}

/**
 *  注册推送成功时调用
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString * tokenAsString = [[[deviceToken description] 
                                 stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] 
                                stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[NSUserDefaults standardUserDefaults] setObject:tokenAsString forKey:@"DeviceTokenStringVOAC"];
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"pushToken"]; //标志尚未成功发送pushToken值
    [self pushToken:tokenAsString];
}

/**
 *  注册推送失败
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
//     NSLog(@"error:regist failture");
}

/**
 *  应用内容加载
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //设置Flurry
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [FlurryAnalytics startSession:@"58YPRS8Q6FT7KMVJXYBC"]; //引号内为注册得到的应用编号
    kNetTest;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"alertShowed"]; //设置尚未检测队列下载情况

//    [VOAView clearAllDownload];
//    [YISwipeShiftCaret install];
    //注册消息推送
//    if(!application.enabledRemoteNotificationTypes){
//        NSLog(@"注册推送");
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge)];
//    } else {
//        NSLog(@"已注册推送");
//    }
    
//已添加推送的机器可以获取token
//    NSString *deviceTokenStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceTokenStringVOAC"];
//    NSLog(@"deviceToken:%@",deviceTokenStr);
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; //badgeNumber清零
    
//回到后台前可以利用此方法进行一些操作
//    [[NSNotificationCenter defaultCenter]        
//     addObserver:self        
//     selector:@selector(applicationWillResignActive:)        
//     name:UIApplicationWillResignActiveNotification
//     object:nil];
    
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isStudying"];
    
    
    if ([Constants isPad]) {
//        NSLog(@"ipad");
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pbg-ipad.png"]];
        img.frame = self.windowTwo.frame;
        self.rootControllerTwo.wantsFullScreenLayout = YES;
        [self.windowTwo addSubview:img];
        [img release], img = nil;
        [self.windowTwo addSubview:rootControllerTwo.view];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"] == nil) {//初次安装时进行的操作和展示
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"firstLaunch"]; //应用打开次数置1
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"synContext"]; //
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"keepScreenLight"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"mulValueColor"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:20] forKey:@"mulValueFont"];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"hightlightLoc"];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"shakeCtrlPlay"];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"recordRead"];
            [[NSUserDefaults standardUserDefaults] setFloat:1.0f forKey:@"appVersionC"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"playMode"];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"autoDownload"];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"nightMode"];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:isBought];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"kBePro"];
            [[NSUserDefaults standardUserDefaults] setFloat:1.0f forKey:@"speed"];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"nightMode"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showSen"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"catchPause"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"synScroll"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:0] forKey:@"nowUser"];
            NSDate *nowDate = [NSDate date];
            [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"vipDate"]; //vip到期时间
            
            NSMutableArray *waitReadCountArray = [[NSMutableArray alloc] init];
            [waitReadCountArray addObject:[NSNumber numberWithInteger:0]];//预置一个无效数
            [[NSUserDefaults standardUserDefaults] setObject:waitReadCountArray forKey:@"waitReadCount"];
            //展示帮助界面
            numOfPages = 6;
            scrollView = [[UIScrollView alloc] initWithFrame:self.windowTwo.bounds];
            scrollView.pagingEnabled = YES;
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.scrollEnabled = YES;
            scrollView.clipsToBounds = YES;
            scrollView.delegate = self;
            pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(334, 960, 100, 40)];
            pageControl.numberOfPages = 6;
            [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
            for (NSUInteger i = 1; i <= numOfPages; i++)
            {
                NSString *imageName = [NSString stringWithFormat:@"helpP%d.png", i];
                UIView * pageView = [[UIView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * (i-1), 0, scrollView.frame.size.width, scrollView.frame.size.height)];
                UIImage *image = [UIImage imageNamed:imageName];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
                imageView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
                pageView.tag = i;	// tag our images for later use when we place them in serial fashion
                [pageView addSubview:imageView];
                [scrollView addSubview:pageView];
                [imageView release],imageView = nil;
                [pageView release], pageView = nil;
            }
            [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * numOfPages, scrollView.frame.size.height)];
            myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.windowTwo.frame.size.width, self.windowTwo.frame.size.height)];
            [myView setBackgroundColor:[UIColor clearColor]];
            [myView addSubview:scrollView];
            [scrollView release];
            [myView addSubview:pageControl];
            [pageControl release];
            [self.windowTwo addSubview:myView];
        } else {
            if(!application.enabledRemoteNotificationTypes){
//                NSLog(@"注册推送");
                [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge)];
            } else {
//                NSLog(@"已注册推送");
            }
            float appVersion = [[[NSUserDefaults standardUserDefaults] objectForKey:@"appVersionC"] floatValue];
            if (appVersion < 1.0f) { //新版本的一些新设置等
                [[NSUserDefaults standardUserDefaults] setFloat:1.0f forKey:@"appVersionC"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"haveScore"];
                [[NSUserDefaults standardUserDefaults] setFloat:1.0f forKey:@"speed"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showSen"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"catchPause"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"synScroll"];
                NSMutableArray *waitReadCountArray = [[NSMutableArray alloc] init];
                [waitReadCountArray addObject:[NSNumber numberWithInteger:0]];//预置一个无效数
                [[NSUserDefaults standardUserDefaults] setObject:waitReadCountArray forKey:@"waitReadCount"];
            }
            int lunchTime = [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch"];
            if (lunchTime < 5) {
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:lunchTime+1] forKey:@"firstLaunch"];
//                NSLog(@"lunchTime:%i", lunchTime+1);
            } else {
                if (![[NSUserDefaults standardUserDefaults] boolForKey:@"haveScore"]) {
                    UIAlertView *scoreAlert = [[UIAlertView alloc] initWithTitle:nil message:kAppOne delegate:self cancelButtonTitle:kAppThree otherButtonTitles:kAppTwo,nil];
                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"firstLaunch"];
                    [scoreAlert setTag:1];
                    [scoreAlert show];
                }
            }
            int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
            NSDate *vipDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"vipDate"]; //vip到期时间
            if (([vipDate compare:[NSDate date]] == NSOrderedDescending)&&(nowUserID>0)) {                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"kBePro"];
            } else if([[NSUserDefaults standardUserDefaults] boolForKey:isBought])
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"kBePro"];
            }else
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"kBePro"];
            }
        }
        
        [self.windowTwo makeKeyAndVisible];//最后两句基本都一样
    }else {
//        NSLog(@"iphone");
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pbg.png"]];
        img.frame = self.windowOne.frame;
        self.rootControllerOne.wantsFullScreenLayout = YES;
        [self.windowOne addSubview:img];
        [img release], img = nil;
        self.windowOne.rootViewController = self.rootControllerOne;
//        [self.windowOne addSubview:rootControllerOne.view];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"] == nil) {
            //        NSLog(@"first");
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"firstLaunch"];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"synContext"]; //初始显示中文翻译
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"keepScreenLight"]; //屏幕常亮
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"mulValueColor"]; //高亮色初始设红色
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:15] forKey:@"mulValueFont"]; //字体大小15
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"hightlightLoc"]; //高亮区域默认不居中
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"shakeCtrlPlay"]; //默认晃动设备可控制播放
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"recordRead"]; //默认开启跟读模式
            [[NSUserDefaults standardUserDefaults] setFloat:1.0f forKey:@"appVersionC"]; //版本号3.2
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"playMode"]; //默认单曲循环
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"autoDownload"]; //默认自动下载
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"nightMode"]; //默认关闭夜间模式
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:isBought];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"kBePro"]; //默认为免费版
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"haveScore"]; //默认尚未给应用进行打分
            [[NSUserDefaults standardUserDefaults] setFloat:1.0f forKey:@"speed"]; //默认播放速度正常
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showSen"]; //默认显示单词的例句
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"catchPause"]; //默认屏幕取词时不暂停播放
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"synScroll"]; //默认播放时高亮同步滚动
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:0] forKey:@"nowUser"];

            NSDate *nowDate = [NSDate date];
            [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"vipDate"]; //vip到期时间
            NSMutableArray *waitReadCountArray = [[NSMutableArray alloc] init];
            [waitReadCountArray addObject:[NSNumber numberWithInteger:0]];//预置一个无效数
            [[NSUserDefaults standardUserDefaults] setObject:waitReadCountArray forKey:@"waitReadCount"]; //waitReadCountArray数组的元素为无网状态下所听读的新闻的id,方便统计新闻已听读的人数
            
            //展示用户帮助
            numOfPages = 6;
            //        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
            scrollView = [[UIScrollView alloc] initWithFrame:self.windowOne.bounds];
            scrollView.pagingEnabled = YES;
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.scrollEnabled = YES;
            scrollView.clipsToBounds = YES;
            scrollView.delegate = self;
            
            pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(110, 450, 100, 40)];
            pageControl.numberOfPages = 6;
            [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged]; 
            
            for (NSUInteger i = 1; i <= numOfPages; i++)
            {
                NSString *imageName = [NSString stringWithFormat:@"help%d.png", i];
                UIView * pageView = [[UIView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width * (i-1), 0, scrollView.frame.size.width, scrollView.frame.size.height)];
                UIImage *image = [UIImage imageNamed:imageName];
                UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                // setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
                imageView.frame = CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height);
                pageView.tag = i;	// tag our images for later use when we place them in serial fashion
                [pageView addSubview:imageView];
                [scrollView addSubview:pageView];
                [imageView release], imageView = nil;
                [pageView release], pageView = nil;
            }
            [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width * numOfPages, scrollView.frame.size.height)];
            
            myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.windowOne.frame.size.width, self.windowOne.frame.size.height)];
            [myView setBackgroundColor:[UIColor clearColor]];
            [myView addSubview:scrollView];
            [scrollView release];
            [myView addSubview:pageControl];
            [pageControl release];
            [self.windowOne addSubview:myView];
        } else {
            if(!application.enabledRemoteNotificationTypes){ //注册开启应用推送功能
//                NSLog(@"注册推送");
                [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge)];
            } else {
//                NSLog(@"已注册推送");
            }
            float appVersion = [[[NSUserDefaults standardUserDefaults] objectForKey:@"appVersionC"] floatValue];
            if (appVersion < 1.0f) { //新版本的一些新设置等
                [[NSUserDefaults standardUserDefaults] setFloat:1.0f forKey:@"appVersionC"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"haveScore"];
                [[NSUserDefaults standardUserDefaults] setFloat:1.0f forKey:@"speed"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showSen"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"catchPause"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"synScroll"];
                NSMutableArray *waitReadCountArray = [[NSMutableArray alloc] init];
                [waitReadCountArray addObject:[NSNumber numberWithInteger:0]];//预置一个无效数
                [[NSUserDefaults standardUserDefaults] setObject:waitReadCountArray forKey:@"waitReadCount"];
            }
            int lunchTime = [[NSUserDefaults standardUserDefaults] integerForKey:@"firstLaunch"];
            if (lunchTime < 5) { //打开应用三次之后开始检测是否对应用打分然后弹出提示框
                [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:lunchTime+1] forKey:@"firstLaunch"];
//                NSLog(@"lunchTime:%i", lunchTime+1);
            } else {
                if (![[NSUserDefaults standardUserDefaults] boolForKey:@"haveScore"]) {
                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"firstLaunch"];
                    UIAlertView *scoreAlert = [[UIAlertView alloc] initWithTitle:nil message:kAppOne delegate:self cancelButtonTitle:kAppThree otherButtonTitles:kAppTwo,nil];
                    [scoreAlert setTag:1];
                    [scoreAlert show];
                }
            }
            int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
            NSDate *vipDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"vipDate"]; //vip到期时间
            if (([vipDate compare:[NSDate date]] == NSOrderedDescending)&&(nowUserID>0)) {
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"kBePro"];
            }else if ([[NSUserDefaults standardUserDefaults] boolForKey:isBought])
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"kBePro"];
            }
            else {
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"kBePro"];
            }
        }
        
        [self.windowOne makeKeyAndVisible];//最后两句基本都一样
    }
    
    //向服务器发送token值
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"pushToken"]){
        NSString *deviceTokenStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceTokenStringVOAC"];
        [self pushToken:deviceTokenStr];
    }
    
    

    return YES;
}

/**
 *  程序进入后台之前调用
 */
- (void)applicationWillResignActive:(UIApplication *)application
{
//     NSLog(@"EnterBackground");
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    
    /*
     进入后台前判断音频是否正在播放：若在播放标识正在学习；否则记录结束时间与日期。
     */
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];//取消屏幕常亮
//    NSLog(@"应用进入后台");
    PlayViewController *play = [PlayViewController sharedPlayer];
    if ([play isPlaying]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isStudying"];
        if (play.isInterupted) { //若有外部打断，进入后台前暂停播放
            [play playButtonPressed:play.playButton];
        }
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YY-MM-dd-a-hh-mm-ss"];
        NSString* locationString=[formatter stringFromDate: [NSDate date]];
        NSArray* timeArray=[locationString componentsSeparatedByString:@"-"];
        NSInteger value_Y= [[timeArray objectAtIndex:0]integerValue];
        NSInteger value_M= [[timeArray objectAtIndex:1]integerValue];
        NSInteger value_D= [[timeArray objectAtIndex:2]integerValue];
        NSString *am = [timeArray objectAtIndex:3];
        NSInteger value_h = 0;
        if ([am isEqualToString:@"PM"]) {
            value_h= [[timeArray objectAtIndex:4]integerValue] + 12;
        } else {
            value_h= [[timeArray objectAtIndex:4]integerValue];
        }
        NSInteger value_m= [[timeArray objectAtIndex:5]integerValue];
        NSInteger value_s= [[timeArray objectAtIndex:6]integerValue];
        NSInteger value_All = value_h*60*60 + value_m*60 + value_s;
//        NSLog(@"%@:%2i-%2i-%2i-%2i-%2i-%2i", locationString, value_Y, value_M, value_D, value_h, value_m, value_s);
        NSString *nowDate = [NSString stringWithFormat:@"%2i-%2i-%2i", value_Y, value_M, value_D];
        NSString *todayDate = [[NSUserDefaults standardUserDefaults] stringForKey:@"todayDate"];
        NSString *nowTime = [NSString stringWithFormat:@"%2i:%2i:%2i", value_h, value_m, value_s];
        NSInteger seconds = value_All - [[NSUserDefaults standardUserDefaults] integerForKey:@"nowSeconds"];
        NSInteger timeId = [StudyTime findLastId] + 1;
        if ([nowDate isEqualToString:todayDate]) {
            StudyTime *studyTime = [[StudyTime alloc] initWithTimeId:timeId userId:0 seconds:seconds date:nowDate beginTime:[[NSUserDefaults standardUserDefaults] stringForKey:@"nowTime"] endTime:nowTime];
            [studyTime insert];
            [studyTime release];
        } else {
            NSInteger value_All_Day = 24 * 60 * 60;
            seconds = value_All_Day - [[NSUserDefaults standardUserDefaults] integerForKey:@"nowSeconds"];
            StudyTime *studyTime = [[StudyTime alloc] initWithTimeId:timeId userId:0 seconds:seconds date:todayDate beginTime:[[NSUserDefaults standardUserDefaults] stringForKey:@"nowTime"] endTime:@"24:00:00"];
            [studyTime insert];
            [studyTime release];
            
            [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"todayDate"];
            seconds = value_All;
            StudyTime *studyTimeOne = [[StudyTime alloc] initWithTimeId:timeId userId:0 seconds:seconds date:nowDate beginTime:@"00:00:00" endTime:nowTime];
            [studyTimeOne insert];
            [studyTimeOne release];
        }
        
        [[NSUserDefaults standardUserDefaults] setInteger:value_All forKey:@"nowSeconds"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%2i-%2i-%2i", value_Y, value_M, value_D] forKey:@"todayDate"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%2i:%2i:%2i", value_h, value_m, value_s] forKey:@"nowTime"];
        [formatter release];
    }
    
}

/**
 *  程序进入后台时调用
 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
//    NSLog(@"EnterBackground");
//    PlayViewController *play = [PlayViewController sharedPlayer];
////    [play stopRecord];
//    [play.controller stopRecord];
//    [play stopRecordPlay];
//    NSDate *date = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *comps;
//    
//    // 年月日获得
//    comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) 
//                        fromDate:date];
//    NSInteger year = [comps year];
//    NSInteger month = [comps month];
//    NSInteger day = [comps day];
//    NSLog(@"year: %d month: %d, day: %d", year, month, day);
//    NSLog(@"date:%@",[NSString stringWithFormat:@"%d-%d-%d",year,month,day]);
    
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:3];
}

/**
 *  程序进入后台之前调用
 */
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

/**
 *  程序回到前台时调用，打开应用完成加载后也回调用
 */
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    /*
     检测是否正在学习，若未标志正在学习，记录开始时间与日期。并且若有网的话告诉服务器无网时所听的新闻。
     */
    kNetTest;
//    NSLog(@"应用激活");
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isStudying"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isStudying"];
    } else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YY-MM-dd-a-hh-mm-ss"];
        NSString* locationString=[formatter stringFromDate: [NSDate date]];
        NSArray* timeArray=[locationString componentsSeparatedByString:@"-"];
        NSInteger value_Y= [[timeArray objectAtIndex:0]integerValue];
        NSInteger value_M= [[timeArray objectAtIndex:1]integerValue];
        NSInteger value_D= [[timeArray objectAtIndex:2]integerValue];
        NSString *am = [timeArray objectAtIndex:3];
        NSInteger value_h = 0;
        if ([am isEqualToString:@"PM"]) {
            value_h= [[timeArray objectAtIndex:4]integerValue] + 12;
        } else {
            value_h= [[timeArray objectAtIndex:4]integerValue];
        }
        NSInteger value_m= [[timeArray objectAtIndex:5]integerValue];
        NSInteger value_s= [[timeArray objectAtIndex:6]integerValue];
        NSInteger value_All = value_h*60*60 + value_m*60 + value_s;
//        NSLog(@"%@:%2i-%2i-%2i-%2i-%2i-%2i", locationString, value_Y, value_M, value_D, value_h, value_m, value_s);
        [[NSUserDefaults standardUserDefaults] setInteger:value_All forKey:@"nowSeconds"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%2i-%2i-%2i", value_Y, value_M, value_D] forKey:@"todayDate"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%2i:%2i:%2i", value_h, value_m, value_s] forKey:@"nowTime"];
        [formatter release];
    }
    
    if (kNetIsExist) {
        NSMutableArray *myArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"waitReadCount"];
        if (myArray.count > 1) {
            NSMutableString *sendReadCount = [NSMutableString stringWithString:@"http://voa.iyuba.com/voa/UnicomApi?protocol=70001&format=xml"];
            NSMutableString *voaids = [NSMutableString stringWithString:@"&voaids=0"];
            NSMutableString *counts = [NSMutableString stringWithString:@"&counts=0"];
            NSNumber *a;
            for (a in myArray) {
                [voaids appendString:[NSString stringWithFormat:@",%@", a]];
                [counts appendString:[NSString stringWithFormat:@",1"]];
                //                NSLog(@"array %@", a);
            }
            [sendReadCount appendString:voaids];
            [sendReadCount appendString:counts];
//            NSLog(@"url:%@", sendReadCount);
            [self updateReadCount:sendReadCount];
        }
    }
//    NSLog(@"applicationDidBecomeActive");
//    AudioSessionSetActive(true);
    
    NSArray *array = [UIImage splitImageIntoTwoParts:[UIImage imageNamed:([Constants isPad]? @"Default-Portrait.png": (isiPhone5? @"Default-568h.png": @"Default.png"))]];
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[array objectAtIndex:0]];
    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[array objectAtIndex:1]];
    self.leftDefault = leftImageView;
    self.rightDefault = rightImageView;
    [leftImageView release];
    [rightImageView release];
    //    for (UIView *myViews in  myView.subviews){
    //        [myViews setHidden:YES];
    //    }
    if ([Constants isPad]) {
        [windowTwo addSubview:self.leftDefault];
        [windowTwo addSubview:self.rightDefault];
    } else {
        [windowOne addSubview:self.leftDefault];
        [windowOne addSubview:self.rightDefault];
    }
    
    self.leftDefault.transform = CGAffineTransformIdentity;
    self.rightDefault.transform = CGAffineTransformIdentity;
    
    [UIView beginAnimations:@"splitDefault" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    if ([Constants isPad]) {
        self.leftDefault.transform = CGAffineTransformMakeTranslation(-384 ,0);
        self.rightDefault.transform = CGAffineTransformMakeTranslation(384 ,0);
    } else {
        self.leftDefault.transform = CGAffineTransformMakeTranslation(-160 ,0);
        self.rightDefault.transform = CGAffineTransformMakeTranslation(160 ,0);
    }
    
    [UIView commitAnimations];
    
}

/**
 *  程序退出时调用
 */
- (void)applicationWillTerminate:(UIApplication *)application
{
//    [self disconnect];
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
//    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
//    NSLog(@"应用结束");
    
    /*
     记录结束时间和日期。
     */
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YY-MM-dd-a-hh-mm-ss"];
    NSString* locationString=[formatter stringFromDate: [NSDate date]];
    NSArray* timeArray=[locationString componentsSeparatedByString:@"-"];
    NSInteger value_Y= [[timeArray objectAtIndex:0]integerValue];
    NSInteger value_M= [[timeArray objectAtIndex:1]integerValue];
    NSInteger value_D= [[timeArray objectAtIndex:2]integerValue];
    NSString *am = [timeArray objectAtIndex:3];
    NSInteger value_h = 0;
    if ([am isEqualToString:@"PM"]) {
        value_h= [[timeArray objectAtIndex:4]integerValue] + 12;
    } else {
        value_h= [[timeArray objectAtIndex:4]integerValue];
    }
    NSInteger value_m= [[timeArray objectAtIndex:5]integerValue];
    NSInteger value_s= [[timeArray objectAtIndex:6]integerValue];
    NSInteger value_All = value_h*60*60 + value_m*60 + value_s;
//    NSLog(@"%@:%2i-%2i-%2i-%2i-%2i-%2i", locationString, value_Y, value_M, value_D, value_h, value_m, value_s);
    NSString *nowDate = [NSString stringWithFormat:@"%2i-%2i-%2i", value_Y, value_M, value_D];
    NSString *todayDate = [[NSUserDefaults standardUserDefaults] stringForKey:@"todayDate"];
    NSString *nowTime = [NSString stringWithFormat:@"%2i:%2i:%2i", value_h, value_m, value_s];
    NSInteger seconds = value_All - [[NSUserDefaults standardUserDefaults] integerForKey:@"nowSeconds"];
    NSInteger timeId = [StudyTime findLastId] + 1;
    if ([nowDate isEqualToString:todayDate]) {
        StudyTime *studyTime = [[StudyTime alloc] initWithTimeId:timeId userId:0 seconds:seconds date:nowDate beginTime:[[NSUserDefaults standardUserDefaults] stringForKey:@"nowTime"] endTime:nowTime];
        [studyTime insert];
        [studyTime release];
    
    } else {
        NSInteger value_All_Day = 24 * 60 * 60;
        seconds = value_All_Day - [[NSUserDefaults standardUserDefaults] integerForKey:@"nowSeconds"];
        StudyTime *studyTime = [[StudyTime alloc] initWithTimeId:timeId userId:0 seconds:seconds date:todayDate beginTime:[[NSUserDefaults standardUserDefaults] stringForKey:@"nowTime"] endTime:@"24:00:00"];
        [studyTime insert];
        [studyTime release];
        
        [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"todayDate"];
        seconds = value_All;
        StudyTime *studyTimeOne = [[StudyTime alloc] initWithTimeId:timeId userId:0 seconds:seconds date:nowDate beginTime:@"00:00:00" endTime:nowTime];
        [studyTimeOne insert];
        [studyTimeOne release];
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:value_All forKey:@"nowSeconds"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%2i-%2i-%2i", value_Y, value_M, value_D] forKey:@"todayDate"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%2i:%2i:%2i", value_h, value_m, value_s] forKey:@"nowTime"];
    [formatter release];
}


- (void)dealloc {
    [myView release], myView = nil;
    if ([Constants isPad]) {
        [rootControllerTwo release];
        [windowTwo release];
    }else {
        [rootControllerOne release];
        [windowOne release];
    }
    [super dealloc];
}

#pragma mark - AlertDelegate
/**
 *  alert点击按钮时的协议
 */
- (void)modalView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//点击确定下载为0，取消为1
        //        if (alertView.tag == 1) {
        //        }
        //        else if (alertView.tag == 2){
        //        }
        //        else if (alertView.tag == 3)
        //        {
        //            LogController *myLog = [[LogController alloc]init];
        //            [self.navigationController pushViewController:myLog animated:YES];
        //            [myLog release], myLog = nil;
        //        }
    } else if (buttonIndex == 1) {
        if (alertView.tag == 1){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"haveScore"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=610242646"]];
        }
    }
    [alertView release];
}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"split"] && finished) {
        
        [self.left removeFromSuperview];
        [self.right removeFromSuperview];
        [myView removeFromSuperview];
    } else if ([animationID isEqualToString:@"splitDefault"] && finished) {
        
        [self.leftDefault removeFromSuperview];
        [self.rightDefault removeFromSuperview];
        //        [myView removeFromSuperview];
    }
}

#pragma mark - UIScrollViewDelegate
/**
 *  滑动UIScrollView时响应
 */
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    if (scrollView.contentOffset.x>(pageWidth*(numOfPages-0.9))) {
        NSArray *array = [UIImage splitImageIntoTwoParts:[UIImage imageNamed:([Constants isPad]? @"helpP6.png": @"help6.png")]];
        UIImageView *leftImage = [[UIImageView alloc] initWithImage:[array objectAtIndex:0]];
        UIImageView *rightImage = [[UIImageView alloc] initWithImage:[array objectAtIndex:1]];
        leftImage.frame = CGRectMake(0, 0, leftImage.frame.size.width, myView.frame.size.height);
        rightImage.frame = CGRectMake(0, 0, rightImage.frame.size.width, myView.frame.size.height);
        self.left = leftImage;
        self.right = rightImage;
        [leftImage release];
        [rightImage release];
        for (UIView *myViews in  myView.subviews){
            [myViews setHidden:YES];
        }
        [myView addSubview:self.left];
        [myView addSubview:self.right];
//        [left release];
//        [right release];
        self.left.transform = CGAffineTransformIdentity;
        self.right.transform = CGAffineTransformIdentity;
        
        [UIView beginAnimations:@"split" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        
        if ([Constants isPad]) {
            self.left.transform = CGAffineTransformMakeTranslation(-384 ,0);
            self.right.transform = CGAffineTransformMakeTranslation(384 ,0);
        } else {
            self.left.transform = CGAffineTransformMakeTranslation(-160 ,0);
            self.right.transform = CGAffineTransformMakeTranslation(160 ,0);
        }
        
        [UIView commitAnimations];
        
        
        //        [myView removeFromSuperview];
    }
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

#pragma mark - Http connect
/**
 *  向服务器发送token值
 */
- (void)pushToken:(NSString *) token
{
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/phoneToken.jsp?token=%@&appID=610242646",token];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:@"token"];
    [request startAsynchronous];
}

/**
 *  向服务器上传新闻听读次数
 */
- (void)updateReadCount:(NSString *) url   {
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:@"readCount"];
    [request startSynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSData *myData = [request responseData];
    if ([request.username isEqualToString:@"token"]) {
        NSString *returnData = [[NSString alloc] initWithData:myData encoding:NSUTF8StringEncoding];
        for (NSString *matchOne in [returnData componentsMatchedByRegex:@"\\d"]) {
            //        NSLog(@"request:%i",[matchOne integerValue]);
            if ([matchOne integerValue] > 0) {
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"pushToken"];
                //            NSLog(@"da");
            } else {
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"pushToken"];
                //            NSLog(@"xiao");
            }
        }
        [returnData release],returnData = nil;
    } else if ([request.username isEqualToString:@"readCount"]) {
//        NSLog(@"zhao");
        DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
        
        NSArray *itemsTwo = [doc nodesForXPath:@"data" error:nil];
        if (itemsTwo) {
            for (DDXMLElement *obj in itemsTwo) {
                NSInteger resultCode = [[[obj elementForName:@"ResultCode"] stringValue] integerValue];
                if (resultCode != 701) {
                    [doc release], doc = nil;
                    return;
                }
            }
        }
        NSArray *items = [doc nodesForXPath:@"data/Row" error:nil];
        if (items) {
                for (DDXMLElement *obj in items) {
                    NSInteger nowCount = [[[obj elementForName:@"ReadCount"] stringValue]integerValue];
                    if (nowCount > [[VOAView find:[[[obj elementForName:@"VoaId"] stringValue]integerValue]] _readCount].integerValue) {
                        
                        [VOAView alterReadCount:[[[obj elementForName:@"VoaId"] stringValue]integerValue] count:nowCount];
                    }
                    
                }
                NSMutableArray *waitReadCountArray = [[NSMutableArray alloc] init];
                [waitReadCountArray addObject:[NSNumber numberWithInteger:0]];//预置一个无效数
                [[NSUserDefaults standardUserDefaults] setObject:waitReadCountArray forKey:@"waitReadCount"];
            }
        [doc release], doc = nil;
    }
    
}

@end
