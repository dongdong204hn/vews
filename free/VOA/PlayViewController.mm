//
//  PlayViewControl.m
//  VOA
//
//  Created by song zhao on 12-2-6.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "PlayViewController.h"
//#import "SpeakHereController.h"

@implementation PlayViewController

@synthesize lyricScroll;
@synthesize lyricCnScroll;
@synthesize isFive;
@synthesize shareSenBtn;
@synthesize senImage;
@synthesize starImage;
@synthesize voa;
@synthesize myImageView;
@synthesize collectButton;	
@synthesize textScroll;
@synthesize timeSwitch;
@synthesize totalTimeLabel;//总时间
@synthesize currentTimeLabel;//当前时间
@synthesize timeSlider;//时间滑块
@synthesize sliderTimer;
@synthesize lyricSynTimer;
@synthesize lyricArray;
@synthesize timeArray;
@synthesize indexArray;
@synthesize lyricLabelArray;
@synthesize lyricCnLabelArray;
//@synthesize engLines;
//@synthesize cnLines;
@synthesize downloadFlg;
@synthesize mp3Url;
@synthesize wordPlayer;
@synthesize lyricCnArray;
@synthesize playButton;
@synthesize myHighLightWord;
@synthesize mp3Data;
@synthesize localFileExist;
@synthesize downloaded;
@synthesize newFile;
@synthesize userPath;
@synthesize myView;
@synthesize explainView;
@synthesize myWord;
//@synthesize switchFlg;
@synthesize HUD;
@synthesize viewOne;
@synthesize viewTwo;
@synthesize myScroll;
@synthesize imgWords;
@synthesize titleWords;
@synthesize player;
@synthesize playerFlag;
@synthesize myStop;
@synthesize playImage;
@synthesize pauseImage;
@synthesize loadingImage;
@synthesize alert;
@synthesize myCenter;
@synthesize nowUserId;
@synthesize pageControl;
//@synthesize wordFrame;
//@synthesize downloadingFlg;
//@synthesize isExisitNet;
@synthesize preButton;
@synthesize nextButton;
@synthesize bannerView_;
//@synthesize shareButton;
@synthesize loadProgress;
//@synthesize controller;
@synthesize lyCn;
@synthesize lyEn;
@synthesize commArray;
@synthesize commTableView;
@synthesize isNewComm;
@synthesize containerView;
@synthesize textView;
@synthesize nowPage;
@synthesize totalPage;
@synthesize btn_play;
@synthesize btn_record;
@synthesize fixTimer;
@synthesize recordTimer;
@synthesize recordSeconds;
@synthesize nowRecordSeconds;
@synthesize recordTime;
@synthesize fixSeconds;
@synthesize audioRecoder;
@synthesize m_isRecording;
@synthesize nowTime;
@synthesize avSet;
@synthesize recordLabel;
//@synthesize afterRecord;
@synthesize isFixing;
//@synthesize commNumber;
@synthesize fixTimeView;
@synthesize myPick;
@synthesize fixButton;
@synthesize clockButton;
@synthesize minsArray;
@synthesize hoursArray;
@synthesize secsArray;
@synthesize downloadingFlg;
@synthesize modeBtn;
@synthesize displayModeBtn;
@synthesize contentMode;
@synthesize playMode;
@synthesize playIndex;
@synthesize listArray;
@synthesize flushList;
@synthesize category;
@synthesize isFree;
@synthesize bottomView;
@synthesize btnOne;
@synthesize btnTwo;
@synthesize btnFour;
@synthesize btnThree;
@synthesize RoundBack;
@synthesize mySentence;
@synthesize colSenBtn;
@synthesize sendBtn;
@synthesize toolBtn;
@synthesize abBtn;
@synthesize lightSlider;
@synthesize speedSlider;
@synthesize toolView;
@synthesize speedMenu;
@synthesize aBtn;
@synthesize bBtn;
@synthesize aValue;
@synthesize bValue;
@synthesize isAbMenu;
@synthesize isSpeedMenu;
@synthesize selectWord;
@synthesize nowTextView;
@synthesize isResponse;
@synthesize isInforComm;
@synthesize isUpAlertShow;
@synthesize wordTouches;
@synthesize isInterupted;
//@synthesize soundFileURLRef;
//@synthesize soundFileObject;

extern NSMutableArray *downLoadList;
extern ASIHTTPRequest *nowrequest;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    isiPhone = ![Constants isPad];
	if (isiPhone) {
        self = [super initWithNibName:@"PlayViewController" bundle:nibBundleOrNil];
	}else {
        self = [super initWithNibName:@"PlayViewController-iPad" bundle:nibBundleOrNil];
    }
    if (self) {
        //        NSLog(@"%@",nibNameOrNil);
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - static method
+ (PlayViewController *)sharedPlayer
{
    static PlayViewController *sharedPlayer;
    
    @synchronized(self)
    {
        if (!sharedPlayer){
            sharedPlayer = [[PlayViewController alloc] init];
            //            sharedPlayer.voa = voa;
            sharedPlayer.isInforComm = NO;
        }
        else{
            
        }
        
        return sharedPlayer;
    }
}

+ (NSOperationQueue *)sharedQueue
{
    static NSOperationQueue *sharedSingleQueue;
    
    @synchronized(self)
    {
        if (!sharedSingleQueue){
            sharedSingleQueue = [[NSOperationQueue alloc] init];
            [sharedSingleQueue setMaxConcurrentOperationCount:1];
        }
        return sharedSingleQueue;
    }
}

//#pragma mark - instance method
//- (void) stopRecord {
////    [controller record:nil];
//    [controller myStopRecord];
//}
//
//- (void) stopRecordPlay {
//    [controller stopPlayQueue];
//}

#pragma mark - instance method

//- (IBAction) showComments:(id)sender {
//    if (isExisitNet) {
//        CommentViewController *voaComment = [[CommentViewController alloc] init];
//        voaComment.voaid = [voa _voaid];
//        [self.navigationController pushViewController:voaComment animated:YES];
//        [voaComment release], voaComment = nil;
//    }
//}

- (IBAction)doTool:(UIButton *) sender {
    if ([sender isSelected]) {
        [sender setSelected:NO];
        
        [UIView beginAnimations:@"classAniOne" context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
        [sender setBackgroundColor:[UIColor clearColor]];
        [toolView setAlpha:0.f];
        if (isiPhone) {
            [toolView setFrame:CGRectMake(0, 370 + (isFree? 0: 50) + kFiveAdd, 320, 0)];
        }else{
            [toolView setFrame:CGRectMake(0, 835 + (isFree? 0: 90) , 768, 0)];
        }
        [UIView commitAnimations];
    } else {
        [sender setSelected:YES];
        
        [UIView beginAnimations:@"classAniTwo" context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
//        [sender setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.44f]];
        [toolView setAlpha:1.0f];
        if (isiPhone) {
            [toolView setFrame:CGRectMake(0, 290 + (isFree? 0: 50) + kFiveAdd, 320, 80)];
        } else {
            [toolView setFrame:CGRectMake(0, 755 + (isFree? 0: 90), 768, 80)];
        }
        [UIView commitAnimations];
        
        //        [sender setBackgroundColor:[UIColor colorWithRed:0.44f green:0.44f blue:0.44f alpha:1.0f]];
    }
}

- (void) doResponse:(UIButton*) sender {
//    NSLog(@"doResponse:%d", sender.superview.tag);
    [textView becomeFirstResponder];
    for (int i = 0; i < [commArray count]/6; i++) {
        if (((NSString*)[commArray objectAtIndex:i*6]).integerValue == sender.superview.tag) {
            [textView setText:[NSString stringWithFormat:@"回复%@:", [commArray objectAtIndex:i*6+1]]];
        }
    }
    isResponse = YES;
    [textView setTag:sender.superview.tag];
}

- (IBAction) changeLan:(UIButton *)sender {
    if (sender.selected) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"synContext"];
        sender.selected = NO;
//        self.switchFlg = NO;
        //            [switchBtn setTitle:@"开" forState:UIControlStateNormal] ;
        for (UIView *hideView in textScroll.subviews) {
            if (hideView.tag < 200) {
                [hideView setHidden:NO];
            }
        }
        [lyricCnLabel setHidden:NO];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"synContext"];
        sender.selected = YES;
//        self.switchFlg = YES;
        //            [switchBtn setTitle:@"关" forState:UIControlStateNormal] ;
        for (UIView *hideView in textScroll.subviews) {
            if (hideView.tag < 200) {
                [hideView setHidden:YES];
            }
        }
        [lyricCnLabel setHidden:YES];
    }
}

- (IBAction) changeMode:(UIButton *)sender {
    playMode = (playMode + 1 > 3 ? 1 : playMode + 1);
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:playMode] forKey:@"playMode"];
    switch (playMode) {
        case 1:
            if (isiPhone) {
                [modeBtn setImage:[UIImage imageNamed:@"sin.png"] forState:UIControlStateNormal];
            } else {
                [modeBtn setImage:[UIImage imageNamed:@"sin-iPad.png"] forState:UIControlStateNormal];
            }
            
            [displayModeBtn setTitle:@"单曲循环" forState:UIControlStateNormal]; 
            break;
        case 2:
            if (isiPhone) {
                [modeBtn setImage:[UIImage imageNamed:@"seq.png"] forState:UIControlStateNormal];
            } else {
                [modeBtn setImage:[UIImage imageNamed:@"seq-iPad.png"] forState:UIControlStateNormal];
            }

            [displayModeBtn setTitle:@"顺序播放" forState:UIControlStateNormal];
            break;
        case 3:
            if (isiPhone) {
                [modeBtn setImage:[UIImage imageNamed:@"ran.png"] forState:UIControlStateNormal];
            } else {
                [modeBtn setImage:[UIImage imageNamed:@"ran-iPad.png"] forState:UIControlStateNormal];
            }
            
            [displayModeBtn setTitle:@"随机播放" forState:UIControlStateNormal];
            break;
        default:
            break;
    }

    [UIView beginAnimations:@"Display" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [displayModeBtn setAlpha:0.8];
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"Dismiss" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2.0];
    [displayModeBtn setAlpha:0];
    [UIView commitAnimations];
}

- (void) showFix:(id)sender
{
    //设置两个View切换时的淡入淡出效果
    [UIView beginAnimations:@"Switch" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.5];
    [fixTimeView setAlpha:0.6];
    [UIView commitAnimations];
}

- (IBAction) doFix:(id)sender
{
    //    [self changeTimer];
    if (isFixing) {
        isFixing = NO;
        [fixButton setTitle:@"开启定时" forState:UIControlStateNormal];
        if (isiPhone) {
            [clockButton setImage:[UIImage imageNamed:@"clockBBC.png"] forState:UIControlStateNormal];
        } else {
            [clockButton setImage:[UIImage imageNamed:@"clockBBCP.png"] forState:UIControlStateNormal];
        }
        
        [self changeTimer];
        //        [myPick selectRow:[myPick selectedRowInComponent:kMinComponent]+1 inComponent:kMinComponent animated:YES];
    } else {
        
        NSString *fixHour = [hoursArray objectAtIndex:[myPick selectedRowInComponent:kHourComponent]];
        NSString *fixMinute = [minsArray objectAtIndex:[myPick selectedRowInComponent:kMinComponent]];
        NSString *fixSecond = [minsArray objectAtIndex:[myPick selectedRowInComponent:kSecComponent]];
        fixSeconds = ([fixHour intValue]*60 + [fixMinute intValue])*60 + [fixSecond intValue];
        if (fixSeconds>0) {
            isFixing = YES;
            [fixButton setTitle:@"取消定时" forState:UIControlStateNormal];
            if (isiPhone) {
                [clockButton setImage:[UIImage imageNamed:@"clockedBBC.png"] forState:UIControlStateNormal];
            } else {
                [clockButton setImage:[UIImage imageNamed:@"clockedBBCP.png"] forState:UIControlStateNormal];
            }
            
            //            NSLog(@"%@时%@分%@秒--共:%d秒", fixHour, fixMinute,fixSecond,fixSeconds);
            [self changeTimer];
        }
        //        if (fixTimeView.hidden == NO) {
        //            [UIView beginAnimations:@"Switch" context:nil];
        //            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        //            [UIView setAnimationDuration:.5];
        //            [fixTimeView setHidden:YES];
        //            [UIView commitAnimations];
        //        }
    }
}

-(void)changeTimer
{
    //    //时间间隔
    //    NSTimeInterval timeInterval =1.0 ;
    //定时器
    if ([fixTimer isValid]) {
        [fixTimer invalidate];
        fixTimer = nil;
    } else {
        fixTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                    target:self
                                                  selector:@selector(handleFixTimer)
                                                  userInfo:nil
                                                   repeats:YES];
    }
}

-(void) handleFixTimer {
    fixSeconds--;
    if (fixSeconds != 0) {
        int sec = [myPick selectedRowInComponent:kSecComponent];
        int min = [myPick selectedRowInComponent:kMinComponent];
        int hour = [myPick selectedRowInComponent:kHourComponent];
        if (sec > 0) {
            [myPick selectRow:sec-1 inComponent:kSecComponent animated:YES];
        } else {
            if (min > 0) {
                [myPick selectRow:[self.secsArray count]-1 inComponent:kSecComponent animated:YES];
                [myPick selectRow:min-1 inComponent:kMinComponent animated:YES];
            } else {
                if (hour > 0) {
                    [myPick selectRow:[self.secsArray count]-1 inComponent:kSecComponent animated:YES];
                    [myPick selectRow:[self.minsArray count]-1 inComponent:kMinComponent animated:YES];
                    [myPick selectRow:hour-1 inComponent:kHourComponent animated:YES];
                }
                /*这句话其实可以不用写，为了保险起见就写了吧，。。*/
                else {
                    if ([self isPlaying]) {
                        [self playButtonPressed:playButton];
                    }
                    [myPick selectRow:0 inComponent:kSecComponent animated:YES];
                    [fixTimer invalidate];
                    fixTimer = nil;
                    isFixing = NO;
                    [fixButton setTitle:@"开启定时" forState:UIControlStateNormal];
                    if (isiPhone) {
                        [clockButton setImage:[UIImage imageNamed:@"clockBBC.png"] forState:UIControlStateNormal];
                    } else {
                        [clockButton setImage:[UIImage imageNamed:@"clockBBCP.png"] forState:UIControlStateNormal];
                    }
                }
            }
        }
    } else {
        if ([self isPlaying]) {
            [self playButtonPressed:playButton];
        }
        [myPick selectRow:0 inComponent:kSecComponent animated:YES];
        [fixTimer invalidate];
        fixTimer = nil;
        isFixing = NO;
        [fixButton setTitle:@"开启定时" forState:UIControlStateNormal];
        if (isiPhone) {
            [clockButton setImage:[UIImage imageNamed:@"clockBBC.png"] forState:UIControlStateNormal];
        } else {
            [clockButton setImage:[UIImage imageNamed:@"clockBBCP.png"] forState:UIControlStateNormal];
        }
        
    }
    
    
}
- (void) shareSen:(UIButton *)sender{
    isShareSen = YES;
    if (sender.tag==0) {
        [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(showSenShareBtn) userInfo:nil repeats:NO];
    }
    if(sender.tag==1){
    [self shareTo];
    }
}

-(IBAction)shareNew:(id)sender
{
    isShareSen = NO;
    [self shareTo];
}
- (void) shareTo {
    if (isiPhone) {
//        NSLog(@"isShareSen:%d",isShareSen);
//        if (isShareSen) {
//            UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:@"分享当前句子到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"自己收藏",@"新浪微博",@"人人网", nil];
//            [share showInView:self.view.window];
//            
//        }
//        else {
            UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:@"分享当前新闻到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博",@"人人网", nil];
            [share showInView:self.view.window];
            
//        }
        
    } else {
//        if (isShareSen) {
//            UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:@"分享当前句子到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"自己收藏",@"新浪微博",@"人人网", nil];
//            [share showInView:self.view];
//
//        } else {
            UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:@"分享当前新闻到" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪微博",@"人人网", nil];
            [share showInView:self.view];

//        }
    }
}

- (void)shareAll {
    
//    if (isExisitNet) {
//        NSString * time = [[voa._creatTime componentsMatchedByRegex:@"\\S+"] objectAtIndex:0];
//    NSLog(@"1");
//    NSLog(@"str2:%@", shareStr);
    NSString * Message = (isShareSen?[NSString stringWithFormat:@"@爱语吧 好喜欢这个句子\\^o^/:%@...", (lyEn.length > 80? [lyEn substringToIndex:80]: lyEn)]: [NSString stringWithFormat:@"@爱语吧 VOA英语听力\"%@\":%@", voa._title, [NSString stringWithFormat:@"%@...",[voa._descCn substringToIndex:40]]]);
//        NSString * Message = [NSString stringWithFormat:@"爱语吧VOA英语听力%@的新闻:%@很不错哦,你也来听听吧,试试有木有",time,voa._title];[NSString stringWithFormat:@"\"%@\"——%@", voa._title, voa._descCn]很不错哦,你也来听听吧,试试有木有
        int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
        if (nowUserID > 0) {
            [ShareToCNBox showWithText:Message link:[NSString stringWithFormat:@"http://apps.iyuba.com/voa/showItem.jsp?voaId=%d&network=weibo&userId=%d",voa._voaid,nowUserID] titleId:voa._voaid];
        } else {
            [ShareToCNBox showWithText:Message link:[NSString stringWithFormat:@"http://apps.iyuba.com/voa/showItem.jsp?voaId=%d&network=weibo",voa._voaid] titleId:voa._voaid];
        }
//    } else {
//        UIAlertView * alertShare = [[UIAlertView alloc] initWithTitle:@"分享失败" message:@"请您确保已连接网络" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertShare show];
//        [alertShare release];
//    }
//    NSLog(@"retina:%f",[[UIScreen mainScreen]scale]); 
}

- (void)ShareThisQuestion{
    //    if (isExisitNet) {
    NSString * url = Nil;
    url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/showItem.jsp?voaId=%d&network=weibo",voa._voaid];
    int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    if (nowUserID > 0) {
        url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/showItem.jsp?voaId=%d&network=weibo&userId=%d",voa._voaid,nowUserID];
    } else {
        url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/showItem.jsp?voaId=%d&network=weibo",voa._voaid];
    }
    NSString * time = [[voa._creatTime componentsMatchedByRegex:@"\\S+"] objectAtIndex:0];
    //    NSLog(@"shijian : %@",time);
    NSString * Message = [NSString stringWithFormat:@"爱语吧VOA英语听力%@的新闻",time];
    //    NSString * WeiboContent = [NSString stringWithFormat:@"%@%@",Message,url];
    SVShareTool * shareTool = [SVShareTool DefaultShareTool];
    //    [shareTool RenrenLogout];
    //    [self viewWillDisappear:YES];
    // 微博分享：
    //    [shareTool GetScreenshotAndShareOnWeibo:self WithContent:WeiboContent AndDelegate:self];[NSString stringWithFormat:@"@爱语吧 VOA英语听力\"%@\":%@", voa._title, [NSString stringWithFormat:@"%@...",[voa._descCn substringToIndex:40]]]
    
    //人人分享：这篇文章-哎呦,不错哦!大家都来听听看,有木有。边听边看读新闻,轻松舒畅学英语
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 url,@"url",
                                 Message,@"name",
                                 @"VOA英语伴旅",@"action_name",
                                 kMyWebLink,@"action_link",
                                 (voa._descCn == nil ? [voa._descCn substringToIndex:120] : @"轻松学外语,快乐交朋友,一切尽在爱语吧"),@"description",
                                 @"VOA英语伴旅",@"caption",
                                 kMyRenRenImage,@"image",
                                 (isShareSen?[NSString stringWithFormat:@"这个句子不错哦\\^o^/:%@...", (lyEn.length > 80? [lyEn substringToIndex:80]: lyEn)]: [NSString stringWithFormat:@"\"%@\"——%@", voa._title, [NSString stringWithFormat:@"%@...",[voa._descCn substringToIndex:40]]]),@"message",
                                 nil];
    //    NSLog(@"param:%@",[params valueForKey:@"action_name"]);
    [shareTool PublishFeedOnRenRen:self WithFeedParam:params TitleId:[NSString stringWithFormat:@"%d",voa._voaid]];
    //    } else {
    //        UIAlertView * alertShare = [[UIAlertView alloc] initWithTitle:@"分享失败" message:@"请您确保已连接网络" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //        [alertShare show];
    //        [alertShare release];
    //    }
}

- (void) collectThisSentence
{
    nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    mySentence.userId = nowUserId;
    if (nowUserId>0) {
           if ([mySentence alterCollect]) {
            alert = [[UIAlertView alloc] initWithTitle:kSentenceOne message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            
            [alert setBackgroundColor:[UIColor clearColor]];
            
            [alert setContentMode:UIViewContentModeScaleAspectFit];
            
            [alert show];
            
            NSTimer *timer = nil;
            timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
        }
    }else
    {
        UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:kColFour message:kSentenceTwo delegate:self cancelButtonTitle:kWordFour otherButtonTitles:nil ,nil];
        [addAlert setTag:3];
        [addAlert show];
    }
    
}
- (void)collectSentence:(UIButton *)sender{
    if (sender.tag==0) {
        [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(showColSenBtn) userInfo:nil repeats:NO];
    }
    if(sender.tag==1){
    nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    mySentence.userId = nowUserId;
    if (nowUserId>0) {
        if ([mySentence alterCollect]) {
            alert = [[UIAlertView alloc] initWithTitle:kSentenceOne message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            
            [alert setBackgroundColor:[UIColor clearColor]];
            
            [alert setContentMode:UIViewContentModeScaleAspectFit];
            
            [alert show];
            
            NSTimer *timer = nil;
            timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
        }
    }else
    {
        UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:kColFour message:kSentenceTwo delegate:self cancelButtonTitle:kWordFour otherButtonTitles:nil ,nil];
        [addAlert setTag:3];
        [addAlert show];
    }
    }
}
- (void)showColSenBtn {
    [UIView beginAnimations:@"SwitchFive" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [colSenBtn setFrame:(isiPhone? CGRectMake(900, 80, 65, 40): CGRectMake(2179,200, 130, 100))];
    [UIView commitAnimations];
    [colSenBtn setTag:1];
    [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(hideColSenBtn) userInfo:nil repeats:NO];
}

- (void)hideColSenBtn {
    [UIView beginAnimations:@"SwitchSix" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [colSenBtn setFrame:(isiPhone? CGRectMake(935, 80, 65, 40): CGRectMake(2249,200, 130, 100))];
    [UIView commitAnimations];
    [colSenBtn setTag:0];
//    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(setColBtnInvalid) userInfo:nil repeats:NO];
}
//-(void)setColBtnInvalid{
//    }
//

- (IBAction) changeView:(UIButton *)sender {
    //设置两个View切换时的淡入淡出效果
    //    [UIView beginAnimations:@"Switch" context:nil];
    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //    [UIView setAnimationDuration:.5];
    //    [RoundBack setCenter:sender.center];
    //    CGFloat pageWidth = myScroll.frame.size.width;
    /* 下取整直接去掉小数位 */
    //    int page = sender.tag-1;
    //    CGRect frame = myScroll.frame;
    //    frame.origin.x = frame.size.width * page;
    //    frame.origin.y = 0;
    //    [myScroll scrollRectToVisible:frame animated:YES];
    int page = sender.tag-1;
//    NSLog(@"page:%i", page);
    //    if ((![[NSUserDefaults standardUserDefaults] boolForKey:kBePro] && (page == 3 || page == 4)) || (![[NSUserDefaults standardUserDefaults] boolForKey:kBePow] && page == 2)){
    //        InnerBuyController *myInner = [[InnerBuyController alloc] init];
    //        [self.navigationController pushViewController:myInner animated:YES];
    //        [myInner release], myInner = nil;
    //    } else {
    CGRect frame = myScroll.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [myScroll scrollRectToVisible:frame animated:YES];
    
    //    }
}


- (CMTime)playerItemDuration
{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.3){
        /*
         * ios4.3以上使用下面的
         */
        AVPlayerItem *playerItem = [player currentItem];   
        return([playerItem duration]);
    }
    else {
        NSArray* seekRanges = [player.currentItem seekableTimeRanges];
        if (seekRanges.count > 0)  
        {  
            CMTimeRange range = [[seekRanges objectAtIndex:0] CMTimeRangeValue];  
            double duration = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration);  
            return CMTimeMakeWithSeconds(duration, NSEC_PER_SEC);
        }
        return CMTimeMakeWithSeconds(0.f, NSEC_PER_SEC);
    }
    
}

//-(void)updateCurrentTimeForPlayer:(AVPlayer *)p
//{
//    if (player.rate != 0.0)
//	{
//        CMTime playerDuration = [self playerItemDuration];
//        double duration = CMTimeGetSeconds(playerDuration);
//        CMTime playerProgress = [player currentTime];
//        double progress = CMTimeGetSeconds(playerProgress);
//		
////		if (duration > 0&&progress<duration-10)
//        if (duration >= 0 && progress <= duration)
//		{
//            [timeSlider setValue:progress];
//			totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
//            currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
//            //            NSLog(@"系统:%@",[timeSwitchClass timeToSwitchAdvance:progress]);
//            timeSlider.maximumValue = duration;
//			[timeSlider setEnabled:YES];
//		}
//		else
//		{
//		}
//        
//	}
//	//NSLog(@"-----lrcDisplay-----%@",[lrc getCurrentLrcWithTime:p.currentTime]);
//	
//}

- (IBAction) goBack:(UIButton *)sender
{
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
//    afterRecord = NO;
    [self myStopRecord];
    [self stopPlayRecord];
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)changePage:(UIPageControl *)sender
{
    int page = pageControl.currentPage;
    CGRect frame = myScroll.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [myScroll scrollRectToVisible:frame animated:YES];
}
//- (IBAction)changePage:(UIPageControl *)sender
//{
//    int page = pageControl.currentPage;
//    if (page > 1) {
//        //该代码是设置手机喇叭与麦克风同时工作 iphone 3.0以上版本 播放类型
//        UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
//        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
//        //设置采样率的
//        Float64 smpl=kAudioSessionProperty_CurrentHardwareSampleRate;
//        AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, sizeof(smpl), &smpl);
//        //设置声音输出扬声器 还是默认的接收器kAudioSessionOverrideAudioRoute_None
//        UInt32 audioRoute = kAudioSessionOverrideAudioRoute_Speaker; 
//        AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(UInt32), &audioRoute);
//        
//        double engHight = [@"a" sizeWithFont:CourierOne].height;
//        
////        NSLog(@"sen_num1:%d",sen_num);
//        CMTime playerProgress = [player currentTime];
//        double progress = CMTimeGetSeconds(playerProgress);
//        int i = 0;
//        for (; i < [timeArray count]; i++) {
//            if ((int)progress < [[timeArray objectAtIndex:i] unsignedIntValue]) {
//                sen_num = i+1;//跟读标识句子号
//                controller.recordTime = (i > 0 ? [[timeArray objectAtIndex:i] unsignedIntValue] - [[timeArray objectAtIndex:i-1] unsignedIntValue] : [[timeArray objectAtIndex:i] unsignedIntValue]) ;
//                break;
//            }
//        }
//        
//        [lyCn release];
//        [lyEn release];
//        lyEn = [[NSString alloc] initWithFormat:@"%@", [lyricArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
//        lyCn = [[NSString alloc] initWithFormat:@"%@", [lyricCnArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
//        
//        int eLines = 0;
//        
//        if (isiPhone) {
//            eLines = [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(260, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight;
//            [lyricLabel setFrame:CGRectMake(670, 20, 260, eLines * engHight)];
//            [lyricCnLabel setFrame:CGRectMake(670, 20+eLines * engHight, 260, 268-eLines * engHight)];
//        }else {
//            eLines = [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(568, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight;
//            [lyricLabel setFrame:CGRectMake(1636, 50, 568, eLines * engHight)];
//            [lyricCnLabel setFrame:CGRectMake(1636, 50+eLines * engHight, 568, 615-eLines * engHight)];
//            
//        }
//        
//        lyricLabel.text = lyEn;
//        if (![lyCn isEqualToString:@"null"] && ![lyCn isEqualToString:@""] && ![lyCn isEqualToString:@"test"]) {
//            lyricCnLabel.text = lyCn;
//        }else{
//            lyricCnLabel.text = @"";
//        }
//        //        lyricCnLabel.text = lyCn;
//        readRecord = YES;
//        [playButton setHidden:YES];
//        [timeSlider setHidden:YES];
//        [currentTimeLabel setHidden:YES];
//        [totalTimeLabel  setHidden:YES];
//        [loadProgress setHidden:YES];
//        [downloadFlg setHidden:YES];
//        [collectButton setHidden:YES];
//        [downloadingFlg setHidden:YES];
//        [controller.btn_play setHidden:NO];
//        [controller.btn_record setHidden:NO];
//        [controller.lvlMeter_in setHidden:NO];
//    }else {
//        //此种模式下无法播放的同时录音
//        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//        
//        [controller myStopRecord];
//        readRecord = NO;
//        [playButton setHidden:NO];
//        [timeSlider setHidden:NO];
//        [currentTimeLabel setHidden:NO];
//        [totalTimeLabel  setHidden:NO];
//        [loadProgress setHidden:NO];
//        [controller.btn_play setHidden:YES];
//        [controller.btn_record setHidden:YES];
//        [controller.lvlMeter_in setHidden:YES];
//        if (localFileExist) {
//            [downloadFlg setHidden:NO];
//        } else if ([VOAView isDownloading:voa._voaid]) {
//            [downloadingFlg setHidden:NO];
//        } else {
//            [collectButton setHidden:NO];
//        }
//    }
//    CGRect frame = myScroll.frame;
//    frame.origin.x = frame.size.width * page;
//    frame.origin.y = 0;
//    [myScroll scrollRectToVisible:frame animated:YES];
//}

- (void) doSend{
    if ([[textView text] length] > 0) {
        
        [self sendComments];
    }
    //    [inputText resignFirstResponder];
    //    if ([keyCommFd isFirstResponder]) {
    [self.view endEditing:YES];
    //    }
    //    NSLog(@"%@",[keyCommFd text]);
}

/**
 *  添加生词本按钮响应事件
 */
- (void) addWordPressed:(UIButton *)sender
{
    nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    //    NSLog(@"生词本添加用户：%d",nowUserId);
    myWord.userId = nowUserId;
    if ([sender isSelected]) {
        [VOAWord deleteWord:myWord.key userId:nowUserId];
        
        if (isiPhone) {
            [sender setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
        } else {
            [sender setImage:[UIImage imageNamed:@"addWord-iPad.png"] forState:UIControlStateNormal];
        }
        [sender setSelected:NO];
    } else {
        if (nowUserId>0) {
            if ([myWord alterCollect]) {
                if (isiPhone) {
                    [sender setImage:[UIImage imageNamed:@"addedWord.png"] forState:UIControlStateNormal];
                } else {
                    [sender setImage:[UIImage imageNamed:@"addedWord-iPad.png"] forState:UIControlStateNormal];
                }
                [sender setSelected:YES];
                
                //                alert = [[UIAlertView alloc] initWithTitle:kWordTwo message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
                //
                //                [alert setBackgroundColor:[UIColor clearColor]];
                //
                //                [alert setContentMode:UIViewContentModeScaleAspectFit];
                //
                //                [alert show];
                //
                //                NSTimer *timer = nil;
                //                timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
            }
        }else
        {
            UIAlertView *addAlert = [[UIAlertView alloc] initWithTitle:kColFour message:kWordThree delegate:self cancelButtonTitle:kWordFour otherButtonTitles:nil ,nil];
            [addAlert setTag:3];
            [addAlert show];
        }
        
    }
    
}

- (void) playWord:(UIButton *)sender
{
    if (wordPlayer) {
        [wordPlayer release];
    }
    wordPlayer =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:myWord.audio]];
    [wordPlayer play];
}

- (BOOL)isPlaying
{
//    NSLog(@"player rate = %lf %d",[player rate], [player rate] != 0.f);
	return [player rate] != 0.f;
}

- (IBAction)prePlay:(id)sender
{
    if (!player) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
//            player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem  playerItemWithAsset:avSet] ];
//        } else{
//            player = [[AVPlayer alloc] initWithURL:mp3Url];
//        }
//        [player seekToTime:nowTime];
        if (nowTime.value < 1) { //#$$#
            nowTime = kCMTimeZero;
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            if (avSet.playable) {
                player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem  playerItemWithAsset:avSet] ];
                [player seekToTime:nowTime];
            } else {
                [avSet release];
                if (localFileExist) {
                    avSet = [AVAsset assetWithURL:[NSURL fileURLWithPath:userPath]];
                    [avSet retain];
                    //            playerItem = [AVPlayerItem playerItemWithAsset:avSet];
                    player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:avSet]];
                    [player seekToTime:nowTime];
                } else {
                    avSet = [AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://static.iyuba.com/sounds/voa%@", voa._sound]]];
                    [avSet retain];
                    if (avSet.playable) {
                        player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:avSet]];
                        [player seekToTime:nowTime];
                    } else {
//                        NSLog(@"Asset loading failed");
                    }
                }
            }
        } else {
            player = [[AVPlayer alloc] initWithURL:mp3Url];
            [player seekToTime:nowTime];
        }
//        afterRecord = NO;
    }
    if (sen_num>2) {
        sen_num--;
    }
    if (readRecord) {
        if (notValid) {
            lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
                                                             target:self 
                                                           selector:@selector(lyricSyn) 
                                                           userInfo:nil 
                                                            repeats:YES];
            sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                           target:self
                                                         selector:@selector(updateSlider)
                                                         userInfo:nil 
                                                          repeats:YES];
            notValid = NO;
        }
        [self myStopRecord];
        [self stopPlayRecord];
//        double engHight = [@"a" sizeWithFont:CourierOne].height;
        if (![self isPlaying] && sen_num>1) {
            [player seekToTime:CMTimeMakeWithSeconds([[timeArray objectAtIndex:sen_num-1] unsignedIntValue], NSEC_PER_SEC)];
        }
        recordTime = (sen_num > 1 ? [[timeArray objectAtIndex:sen_num-1] unsignedIntValue] - [[timeArray objectAtIndex:sen_num-2] unsignedIntValue] : [[timeArray objectAtIndex:0] unsignedIntValue]) ;
//        NSLog(@"controller.recordTime:%d",controller.recordTime);
//        if (afterRecord) {
//            AVAudioSession *session = [AVAudioSession sharedInstance];
//            [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
//                player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem  playerItemWithAsset:avSet] ];
//            } else {
//                player = [[AVPlayer alloc] initWithURL:mp3Url];
//            }
//            
//            [player seekToTime:nowTime];
//            afterRecord = NO;
//        }
        [player play];
        if (isiPhone) {
            [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
        } else {
            [playButton setImage:[UIImage imageNamed:@"PplayPressed-iPad.png"] forState:UIControlStateNormal];
        }
        double engHight = [@"a" sizeWithFont:CourierOne].height;
        double cnHight = [@"赵" sizeWithFont:CourierOne].height;
        [lyCn release];
        [lyEn release];
        lyEn = [[NSString alloc] initWithFormat:@"%@", [lyricArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
        lyCn = [[NSString alloc] initWithFormat:@"%@", [lyricCnArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
        int eLines = 0;
        int cLines = 0;
        if (isiPhone) {
            eLines = lyEn != Nil ? [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(260, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight : 0;
            cLines = lyCn != Nil ? [lyCn sizeWithFont:CourierTwo constrainedToSize:CGSizeMake(260, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / cnHight + 1 : 0;
            [lyricScroll setContentSize:CGSizeMake(260, eLines * engHight)];
            [lyricCnScroll setContentSize:CGSizeMake(260, cLines * cnHight)];
            [lyricLabel setFrame:CGRectMake(0, 0, 260, eLines * engHight)];
            [lyricCnLabel setFrame:CGRectMake(0, 0, 260, cLines * cnHight)];
        }else {
            eLines = lyEn != Nil ? [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(568, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight : 0;
            cLines = lyCn != Nil ? [lyCn sizeWithFont:CourierTwo constrainedToSize:CGSizeMake(568, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / cnHight + 1 : 0;
            [lyricScroll setContentSize:CGSizeMake(568, eLines * engHight)];
            [lyricCnScroll setContentSize:CGSizeMake(568, cLines * cnHight)];
            [lyricLabel setFrame:CGRectMake(0, 0, 568, eLines * engHight)];
            [lyricCnLabel setFrame:CGRectMake(0, 0, 568, cLines * cnHight)];
        }
        lyricLabel.text = lyEn;
//        [lyEn release];
        [lyricLabel setNumberOfLines:10];
        if (![lyCn isEqualToString:@"null"] && ![lyCn isEqualToString:@""] && ![lyCn isEqualToString:@"test"]) {
            lyricCnLabel.text = lyCn;
//            [lyCn release];
        }else{
            lyricCnLabel.text = @"";
        }
        if (sen_num>1) {
        VOADetail *myVoaDetail=[VOADetail findByVoaidAndTime:self.voa._voaid timing:[[timeArray objectAtIndex:sen_num-2]unsignedIntValue]];
        [mySentence init];
        
        mySentence.SentenceId=[VOASentence findLastId]+1;
        mySentence.VoaId = myVoaDetail._voaid;
        mySentence.ParaId = myVoaDetail._paraid;
        mySentence.IdIndex = myVoaDetail._idIndex;
        mySentence.Sentence = myVoaDetail._sentence;
//            shareStr = myVoaDetail._sentence;
            mySentence.Sentence_cn = myVoaDetail._sentence_cn;
        
        mySentence.StartTime = [[timeArray objectAtIndex:sen_num-2]unsignedIntValue];
        if ([timeArray count]>sen_num-1) {
            mySentence.EndTime = [[timeArray objectAtIndex:sen_num-1]unsignedIntValue];
        }else{
            mySentence.EndTime = 1800 ;//默认30分钟
        }
//        NSLog(@"%d,%d,%d,%d,%d,%d,%d",self.voa._voaid,[[timeArray objectAtIndex:sen_num-2]unsignedIntValue],myVoaDetail._voaid,myVoaDetail._paraid,myVoaDetail._idIndex,mySentence.StartTime,mySentence.EndTime);
        }
        else{
            VOADetail *myVoaDetail=[VOADetail findByVoaidAndTime:self.voa._voaid timing:[[timeArray objectAtIndex:0]unsignedIntValue]];
            [mySentence init];
            
            mySentence.SentenceId=[VOASentence findLastId]+1;
            mySentence.VoaId = myVoaDetail._voaid;
            mySentence.ParaId = myVoaDetail._paraid;
            mySentence.IdIndex = myVoaDetail._idIndex;
            mySentence.Sentence = myVoaDetail._sentence;
//            shareStr = myVoaDetail._sentence;
            mySentence.Sentence_cn = myVoaDetail._sentence_cn;
//            NSLog(@"%d",sen_num);
//            NSLog(@"%d,%d,%d,%d",mySentence.SentenceId,mySentence.VoaId,mySentence.ParaId,mySentence.IdIndex);
            
            mySentence.StartTime = [[timeArray objectAtIndex:0]unsignedIntValue];
            mySentence.EndTime = [[timeArray objectAtIndex:1]unsignedIntValue];
//            NSLog(@"%d,%d,%d,%d,%d,%d,%d",self.voa._voaid,[[timeArray objectAtIndex:sen_num-2]unsignedIntValue],myVoaDetail._voaid,myVoaDetail._paraid,myVoaDetail._idIndex,mySentence.StartTime,mySentence.EndTime);

        }
        //        lyricCnLabel.text = lyCn;
//        [lyricCnLabel setNumberOfLines:cLines];
    }else {
        [LyricSynClass preLyricSyn:timeArray localPlayer:player];
    }
    if ([self isPlaying]) {
        [LyricSynClass preLyricSyn:timeArray localPlayer:player];
    }
}

- (IBAction)aftPlay:(id)sender
{
    
    if (!player) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
//            player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem  playerItemWithAsset:avSet] ];
//        } else {
//            player = [[AVPlayer alloc] initWithURL:mp3Url];
//        }
//        [player seekToTime:nowTime];
        
        if (nowTime.value < 1) {//#$$#
            nowTime = kCMTimeZero;
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            if (avSet.playable) {
                player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem  playerItemWithAsset:avSet] ];
                [player seekToTime:nowTime];
            } else {
                [avSet release];
                if (localFileExist) {
                    avSet = [AVAsset assetWithURL:[NSURL fileURLWithPath:userPath]];
                    [avSet retain];
                    //            playerItem = [AVPlayerItem playerItemWithAsset:avSet];
                    player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:avSet]];
                    [player seekToTime:nowTime];
                } else {
                    avSet = [AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://static.iyuba.com/sounds/voa%@", voa._sound]]];
                    [avSet retain];
                    if (avSet.playable) {
                        player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:avSet]];
                        [player seekToTime:nowTime];
                    } else {
//                        NSLog(@"Asset loading failed");
                    }
                }
            }
        } else {
            player = [[AVPlayer alloc] initWithURL:mp3Url];
            [player seekToTime:nowTime];
        }
        CMTime playerProgress = [player currentTime];
        double progress = CMTimeGetSeconds(playerProgress);
        int i = 0;
        for (; i < [timeArray count]; i++) {
            if ((int)progress < [[timeArray objectAtIndex:i] unsignedIntValue]) {
                sen_num = i+1;//跟读标识句子号
                recordTime = (i > 0 ? [[timeArray objectAtIndex:i] unsignedIntValue] - [[timeArray objectAtIndex:i-1] unsignedIntValue] : [[timeArray objectAtIndex:i] unsignedIntValue]) ;
                break;
            }
        }
//        NSLog(@"sen_num:%i", sen_num);
//        afterRecord = NO;
    }
//    AudioServicesPlaySystemSound (soundFileObject);
    if (readRecord) {
        if (notValid) {
            lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
                                                             target:self 
                                                           selector:@selector(lyricSyn) 
                                                           userInfo:nil 
                                                            repeats:YES];
            sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                           target:self
                                                         selector:@selector(updateSlider)
                                                         userInfo:nil 
                                                          repeats:YES];
            notValid = NO;
        }
        [self myStopRecord];
        [self stopPlayRecord];
        if (sen_num < [timeArray count]+1 && [self isPlaying]) {
            //        if (sen_num < [timeArray count]) {
            sen_num++;
            [player seekToTime:CMTimeMakeWithSeconds([[timeArray objectAtIndex:sen_num-2] unsignedIntValue], NSEC_PER_SEC)];
        }
//        NSLog(@"1");
        if (sen_num == [timeArray count]+1) {
            recordTime = 6;
        } else {
            recordTime = [[timeArray objectAtIndex:sen_num-1] unsignedIntValue] - [[timeArray objectAtIndex:sen_num-2] unsignedIntValue] ;
        }
//        NSLog(@"2");
//        if (afterRecord) {
//            AVAudioSession *session = [AVAudioSession sharedInstance];
//            [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
//                player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem  playerItemWithAsset:avSet] ];
//            } else {
//                player = [[AVPlayer alloc] initWithURL:mp3Url];
//            }
//            [player seekToTime:nowTime];
//            afterRecord = NO;
//        }
        [player play];
        if (isiPhone) {
            [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
        } else {
            [playButton setImage:[UIImage imageNamed:@"PplayPressed-iPad.png"] forState:UIControlStateNormal];
        }
        double engHight = [@"a" sizeWithFont:CourierOne].height;
        double cnHight = [@"赵" sizeWithFont:CourierOne].height;
        [lyCn release];
        [lyEn release];
        lyEn = [[NSString alloc] initWithFormat:@"%@", [lyricArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
        lyCn = [[NSString alloc] initWithFormat:@"%@", [lyricCnArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
//        NSLog(@"3");
        int eLines = 0;
        int cLines = 0;
        if (isiPhone) {
            eLines = lyEn != Nil ? [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(260, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight : 0;
            cLines = lyCn != Nil ? [lyCn sizeWithFont:CourierTwo constrainedToSize:CGSizeMake(260, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / cnHight + 1 : 0;
            [lyricScroll setContentSize:CGSizeMake(260, eLines * engHight)];
            [lyricCnScroll setContentSize:CGSizeMake(260, cLines * cnHight)];
            [lyricLabel setFrame:CGRectMake(0, 0, 260, eLines * engHight)];
            [lyricCnLabel setFrame:CGRectMake(0, 0, 260, cLines * cnHight)];
        }else {
            eLines = lyEn != Nil ? [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(568, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight : 0;
            cLines = lyCn != Nil ? [lyCn sizeWithFont:CourierTwo constrainedToSize:CGSizeMake(568, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / cnHight + 1 : 0;
            [lyricScroll setContentSize:CGSizeMake(568, eLines * engHight)];
            [lyricCnScroll setContentSize:CGSizeMake(568, cLines * cnHight)];
            [lyricLabel setFrame:CGRectMake(0, 0, 568, eLines * engHight)];
            [lyricCnLabel setFrame:CGRectMake(0, 0, 568, cLines * cnHight)];
        }
        
        lyricLabel.text = lyEn;
//        [lyEn release];
        [lyricLabel setNumberOfLines:10];
        if (![lyCn isEqualToString:@"null"] && ![lyCn isEqualToString:@""] && ![lyCn isEqualToString:@"test"]) {
            lyricCnLabel.text = lyCn;
//            [lyCn release];
        }else{
            lyricCnLabel.text = @"";
        }
        if (sen_num>1) {
            VOADetail *myVoaDetail=[VOADetail findByVoaidAndTime:self.voa._voaid timing:[[timeArray objectAtIndex:sen_num-2]unsignedIntValue]];
            [mySentence init];
            
            mySentence.SentenceId=[VOASentence findLastId]+1;
            mySentence.VoaId = myVoaDetail._voaid;
            mySentence.ParaId = myVoaDetail._paraid;
            mySentence.IdIndex = myVoaDetail._idIndex;
            mySentence.Sentence = myVoaDetail._sentence;
//            shareStr = myVoaDetail._sentence;
            mySentence.Sentence_cn = myVoaDetail._sentence_cn;
//            NSLog(@"%d",sen_num);

//            NSLog(@"%d,%d,%d,%d",mySentence.SentenceId,mySentence.VoaId,mySentence.ParaId,mySentence.IdIndex);
            
            mySentence.StartTime = [[timeArray objectAtIndex:sen_num-2]unsignedIntValue];
            if ([timeArray count]>sen_num-1) {
                mySentence.EndTime = [[timeArray objectAtIndex:sen_num-1]unsignedIntValue];
            }else{
                mySentence.EndTime = 1800 ;//默认30分钟
            }
//            NSLog(@"%d,%d,%d,%d,%d,%d,%d",self.voa._voaid,[[timeArray objectAtIndex:sen_num-2]unsignedIntValue],myVoaDetail._voaid,myVoaDetail._paraid,myVoaDetail._idIndex,mySentence.StartTime,mySentence.EndTime);
        }
        else{
            VOADetail *myVoaDetail=[VOADetail findByVoaidAndTime:self.voa._voaid timing:[[timeArray objectAtIndex:0]unsignedIntValue]];
            [mySentence init];
            
            mySentence.SentenceId=[VOASentence findLastId]+1;
            mySentence.VoaId = myVoaDetail._voaid;
            mySentence.ParaId = myVoaDetail._paraid;
            mySentence.IdIndex = myVoaDetail._idIndex;
            mySentence.Sentence = myVoaDetail._sentence;
//            shareStr = myVoaDetail._sentence;
            mySentence.Sentence_cn = myVoaDetail._sentence_cn;
//            NSLog(@"%d",sen_num);

//            NSLog(@"%d,%d,%d,%d",mySentence.SentenceId,mySentence.VoaId,mySentence.ParaId,mySentence.IdIndex);
            
            mySentence.StartTime = [[timeArray objectAtIndex:0]unsignedIntValue];
            mySentence.EndTime = [[timeArray objectAtIndex:1]unsignedIntValue];
//            NSLog(@"%d,%d,%d,%d,%d,%d,%d",self.voa._voaid,[[timeArray objectAtIndex:sen_num-2]unsignedIntValue],myVoaDetail._voaid,myVoaDetail._paraid,myVoaDetail._idIndex,mySentence.StartTime,mySentence.EndTime);
            
        }
        //        lyricCnLabel.text = lyCn;
//        [lyricCnLabel setNumberOfLines:cLines];    
    }else {
        [LyricSynClass aftLyricSyn:timeArray localPlayer:player];
    }
//    NSLog(@"4");
}

//- (IBAction) recordButtonPressed:(UIButton *)sender
//{
//    if (localFileExist) {
//        if ([self isPlaying])
//        {
//            [lyricSynTimer invalidate];
//            lyricSynTimer = nil;
//            [self setButtonImage:pauseImage];
//        }
//    }else
//    {
//        if ([self isPlaying])
//        {
//            [lyricSynTimer invalidate];
//            lyricSynTimer = nil;
//            [self setButtonImage:pauseImage];
//        }
//    }
//    [controller record];
//}

- (IBAction) playButtonPressed:(UIButton *)sender
{
    if (!player) {//#$$#
//        NSLog(@"生成播放器:%lld", nowTime.value);
        if (nowTime.value < 1) {
            nowTime = kCMTimeZero;
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            if (avSet.playable) {
                player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem  playerItemWithAsset:avSet] ];
                [player seekToTime:nowTime];
            } else {
                [avSet release];
                if (localFileExist) {
                    avSet = [AVAsset assetWithURL:[NSURL fileURLWithPath:userPath]];
                    [avSet retain];
                    //            playerItem = [AVPlayerItem playerItemWithAsset:avSet];
                    player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:avSet]];
                    [player seekToTime:nowTime];
                } else {
                    avSet = [AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://static.iyuba.com/sounds/voa%@", voa._sound]]];
                    [avSet retain];
                    if (avSet.playable) {
                        player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:avSet]];
                        [player seekToTime:nowTime];
                    } else {
//                        NSLog(@"Asset loading failed");
                    }
                }
            }
        } else {
            player = [[AVPlayer alloc] initWithURL:mp3Url];
            [player seekToTime:nowTime];
        }
        
//        afterRecord = NO;
    }
    if (localFileExist) {
//        NSLog(@"本地存在");
        playerFlag = 0;
        if(!readRecord && !isFixing && downloaded && !isInterupted){
            if (!notValid) {
                [lyricSynTimer invalidate];
                //            lyricSynTimer = nil;
                [sliderTimer invalidate];
                //            sliderTimer = nil;
                notValid = YES;
            }

            [loadProgress setProgress:1.0f];
            CMTime timeM = [player currentTime];
            [player pause];
            [player release];
            player = nil;
//            [localPlayer release];
            [playButton.layer removeAllAnimations];
            alert = [[UIAlertView alloc] initWithTitle:kPlayOne message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            
            [alert setBackgroundColor:[UIColor clearColor]];
            
            [alert setContentMode:UIViewContentModeScaleAspectFit];
            
            [alert show];
            
            NSTimer *timer = nil;
            timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(c) userInfo:nil repeats:NO];
            
            NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            //创建audio份目录在Documents文件夹下，not to back up
            NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
                avSet = [AVAsset assetWithURL:[NSURL fileURLWithPath:[audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%d.mp3", voa._voaid]]]];
                [avSet retain];
                player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:avSet]];
            } else {
                mp3Url = [NSURL fileURLWithPath:[audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%d.mp3", voa._voaid]]];
                [mp3Url retain];
                player = [[AVPlayer alloc] initWithURL:mp3Url];
            }
            
            [player seekToTime:timeM];
//            mp3Url = [NSURL fileURLWithPath:[audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%d.mp3", voa._voaid]]];
//            //            NSError *error = nil;
//            player = [[AVPlayer alloc] initWithURL:mp3Url];
            CMTime playerDuration = [self playerItemDuration];
            double duration = CMTimeGetSeconds(playerDuration);
            
            CMTime playerProgress = [player currentTime];
            double progress = CMTimeGetSeconds(playerProgress);
            //            NSLog(@"download wancheng");  
            //  获取mp3起止时间	
            if (!readRecord) {
                [totalTimeLabel setHidden:NO];
                [currentTimeLabel setHidden:NO];
            }
            currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
            //            NSLog(@"%@", [timeSwitchClass timeToSwitchAdvance:localPlayer.currentTime]);
            totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
            downloaded = NO;
        }
        if ([self isPlaying])
        {
            if (!notValid) {
                [lyricSynTimer invalidate];
                //            lyricSynTimer = nil;
                [sliderTimer invalidate];
                //            sliderTimer = nil;
                notValid = YES;
            }
            [self setButtonImage:pauseImage];
        }else {
            
            [self setButtonImage:playImage];
            
            if (notValid) {
                lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
                                                                 target:self 
                                                               selector:@selector(lyricSyn) 
                                                               userInfo:nil 
                                                                repeats:YES];
                sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                               target:self
                                                             selector:@selector(updateSlider)
                                                             userInfo:nil 
                                                              repeats:YES];
                 notValid = NO;
            }
           
//            if ([lyricSynTimer isValid]) {
//                
//            }else {
//            #if 1
//                lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
//                                                                 target:self 
//                                                               selector:@selector(lyricSyn) 
//                                                               userInfo:nil 
//                                                                repeats:YES];
//            #endif
//            }
//            
//            if ([sliderTimer isValid]) {
//                
//            }else {
//#if 1
//                sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
//                                                               target:self
//                                                             selector:@selector(updateSlider)
//                                                             userInfo:nil 
//                                                              repeats:YES];
//#endif
//            }

        }
        
        CMTime playerDuration = [self playerItemDuration];
        double duration = CMTimeGetSeconds(playerDuration);
        //  Set the maximum value of the UISlider
        timeSlider.maximumValue = duration > 0.1f ? duration : 0.f;
        
        //	Play the audio
        [MP3PlayerClass playButton:playButton 
                       localPlayer:player];
    }
    else
    {
//        NSLog(@"本地不存在");
        if ([self isExistenceNetwork:1]) {
            myStop = -1;
            playerFlag = 1;
            if (!readRecord) {
                [currentTimeLabel setHidden:NO];
            }
            if ([self isPlaying])
            {
                if (!notValid) {
                    [lyricSynTimer invalidate];
                    //                lyricSynTimer = nil;
                    [sliderTimer invalidate];
                    //                sliderTimer = nil;
                    notValid = YES;
                }
                
                [self setButtonImage:pauseImage];
            }else {
                if (avSet.playable) {
                    if (notValid) {
                        lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                                         target:self
                                                                       selector:@selector(lyricSyn)
                                                                       userInfo:nil
                                                                        repeats:YES];
                        sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                                       target:self
                                                                     selector:@selector(updateSlider)
                                                                     userInfo:nil
                                                                      repeats:YES];
                        notValid = NO;
                    }
//                    NSLog(@"Asset loading success");
                } else {
//                    NSLog(@"Asset loading failed");
                    [avSet release];
                    avSet = [AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://static.iyuba.com/sounds/voa%@", voa._sound]]];
                    [avSet retain];
                    if (avSet.playable) {
                        player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:avSet]];
//                        NSLog(@"Asset loading success");
                    } else {
//                        NSLog(@"Asset loading failed");
                    }
                }
                
                
//                if ([lyricSynTimer isValid]) {
//                    
//                }else {
//#if 1
//                    lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
//                                                                     target:self 
//                                                                   selector:@selector(lyricSyn) 
//                                                                   userInfo:nil 
//                                                                    repeats:YES];
//#endif
//                }
                
//                if ([sliderTimer isValid]) {
//                    
//                }else {
//#if 1
//                    sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
//                                                                   target:self
//                                                                 selector:@selector(updateSlider)
//                                                                 userInfo:nil 
//                                                                  repeats:YES];
//#endif
//                }
                [self setButtonImage:playImage];
            }
            
            CMTime playerProgress = [player currentTime];
            double progress = CMTimeGetSeconds(playerProgress);
            CMTime playerDuration = [self playerItemDuration];
            double duration = CMTimeGetSeconds(playerDuration);
            currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
//            NSLog(@"%@", [timeSwitchClass timeToSwitchAdvance:player.progress]);
            totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
            if (progress < duration ) {
                timeSlider.maximumValue = duration > 0.1f ? duration : 0.f;
            } 
            
            [MP3PlayerClass playButton:playButton 
                              localPlayer:player];
//            if ([self isPlaying]) {
//                #if 1
//                            lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
//                                                                            target:self 
//                                                                           selector:@selector(lyricSyn) 
//                                                                           userInfo:nil 
//                                                                            repeats:YES];
//                #endif
//            }
            
        }
    }
}

-(void)c
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert release];
}

- (void)setButtonImage:(UIImage *)image
{
	[playButton.layer removeAllAnimations];
	if (!image)
	{
		[playButton setImage:playImage forState:0];
	}
	else
	{
		[playButton setImage:image forState:0];
		
		if ([playButton.currentImage isEqual:loadingImage])
		{
			[self spinButton];
		}
	}
}

- (void)spinButton
{
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    CGRect frame = [playButton frame];
    playButton.layer.anchorPoint = CGPointMake(0.5, 0.5);
    playButton.layer.position = CGPointMake(frame.origin.x + 0.5 * frame.size.width, frame.origin.y + 0.5 * frame.size.height);
    [CATransaction commit];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setValue:[NSNumber numberWithFloat:120.0] forKey:kCATransactionAnimationDuration];
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:120 * M_PI];
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [playButton.layer addAnimation:animation forKey:@"rotationAnimation"];
    [CATransaction commit];
	
}

- (void)collectButtonPressed:(UIButton *)sender {
//    NSLog(@"%d,%@,%@",[voa _voaid],[voa _title],[voa _creatTime]);
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"autoDownload"]) {
        [self QueueDownloadVoa];
        [collectButton setHidden:YES];
        [downloadFlg setHidden:YES];
        [downloadingFlg setHidden:NO];
    } else {
        UIAlertView *downAlert = [[UIAlertView alloc] initWithTitle:kPlayTwo message:kPlayThree delegate:self cancelButtonTitle:kFeedbackFive otherButtonTitles:kPlayFour,nil];
        [downAlert setTag:1];
        [downAlert show];
    }
}

- (IBAction)showRepeat:(UIButton *)sender {
    if ([sender isSelected]) {
        [aBtn setHidden:YES];
        [bBtn setHidden:YES];
        [sender setSelected:NO];
    } else {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"haveScore"] && !readRecord) {
            double duration = CMTimeGetSeconds([self playerItemDuration]);
            if (duration > 0) {
                double duration = CMTimeGetSeconds([self playerItemDuration]);
                aValue = (aBtn.center.x - timeSlider.frame.origin.x) / timeSlider.frame.size.width * duration;
//                NSLog(@"aValue:%f", aValue);
                bValue = (bBtn.center.x - timeSlider.frame.origin.x) / timeSlider.frame.size.width * duration;
                [aBtn setHidden:NO];
                [bBtn setHidden:NO];
            }
            [sender setSelected:YES];
        } else if(!readRecord){
            UIAlertView *scoreAlert = [[UIAlertView alloc] initWithTitle:nil message:kPlayTwelve delegate:self cancelButtonTitle:kAppThree otherButtonTitles:kAppTwo,nil];
            [scoreAlert setTag:4];
            [scoreAlert show];
        }
    }
}

- (void)showSen:(UIButton *) sender {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showSen"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showSen"];
        [sender setImage:[UIImage imageNamed:@"senClose.png"] forState:UIControlStateNormal];
        if (isiPhone) {
            [explainView setFrame:CGRectMake(0, 100, 320, 50 + sender.tag) ];
            
        } else {
            [explainView setFrame:CGRectMake(144, 220, 480, 70 + sender.tag) ];
//            [sender setImage:[UIImage imageNamed:@"senClose-ipad.png"] forState:UIControlStateNormal];
        }
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showSen"];
        [sender setImage:[UIImage imageNamed:@"senOpen.png"] forState:UIControlStateNormal];
        if (isiPhone) {
            [explainView setFrame:CGRectMake(0, 100, 320, 240)];
            
        } else {
            [explainView setFrame:CGRectMake(144, 220, 480, 360)];
//            [sender setImage:[UIImage imageNamed:@"senOpen-ipad.png"] forState:UIControlStateNormal];
        }
    }
}

- (void)closeExplaView {
    [explainView setHidden:YES];
}

- (void) showChDefine {
//    NSLog(@"cao");
//    NSLog(@"selectWord:%@", selectWord);
    @try {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"catchPause"] && [self isPlaying]) {
            [self playButtonPressed:playButton];
//            [player pause];
//            [self setButtonImage:pauseImage];
//            NSLog(@"pause");
        }
        selectWord = [nowTextView.text substringWithRange:nowTextView.selectedRange];
        [selectWord retain];
        LocalWord *word = [LocalWord findByKey:selectWord];
        myWord.wordId = [VOAWord findLastId] + 1;
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kBePro"] && word) {
            //        if (word) {
            //            if (word) {
            //            myWord.wordId = [VOAWord findLastId] + 1;
            myWord.key = word.key;
            myWord.audio = word.audio;
            myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
            if (myWord.pron == nil) {
                myWord.pron = @" ";
            }
            myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
            [word release];
            [self wordExistDisplay];
            //            }
        } else {
            kNetTest;
            if (kNetIsExist) {
                //            NSLog(@"有网");
                [self catchWords:selectWord];
            } else {
                myWord.key = selectWord;
                myWord.audio = @"";
                myWord.pron = @" ";
                myWord.def = @"";
                [self wordNoDisplay];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"NSException");
    }
    @finally {
//        NSLog(@"selectWord:%@", selectWord);
    }
}

//- (void) showSpeed {}
//
//- (void) showAB {}

- (void) aniToPlay:(UITextView *) myTextView {
//    CGPoint windowPoint = [myTextView convertPoint:myTextView.bounds.origin toView:self.view];
//    CGRect senRect = [myTextView frame];
//    NSLog(@"text:%@", [myTextView text]);
//    shareStr = [myTextView text];
//    [shareStr retain];
//    NSLog(@"str:%@", shareStr);
    [self screenTouchWord: myTextView];
//    [self showSenShareBtn];
//    senImage = [[UIImageView alloc] initWithFrame:senRect];
//    [senImage setImage:[LyricSynClass screenshot:CGRectMake(windowPoint.x, windowPoint.y+ 20, senRect.size.width, senRect.size.height)]];
//    [textScroll addSubview:senImage];
//    [senImage release];
//    [UIView beginAnimations:@"SwitchOne" context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:1.5];
//    CATransition *animation = [CATransition animation];
//    animation.delegate = self;
//    animation.duration = 2.0;
//    //        animation.timingFunction = UIViewAnimationCurveEaseInOut;
//    animation.type = @"rippleEffect";
//    [[myTextView layer] addAnimation:animation forKey:@"animation"];
//    [senImage setFrame:CGRectMake(senRect.origin.x + senRect.size.width/2, senRect.origin.y + senRect.size.height/2, 1,1)];
//    //        [shareSenBtn setFrame:CGRectMake(620, 200, 20, 20)];
//    [UIView commitAnimations];
}

//必须实现这个函数才能显示需要出现的menuItem
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (isSpeedMenu) {
        if (action == @selector(showSpeed)) {
            return YES;
        }
    } else if (isAbMenu) {
        if (action == @selector(showAB)) {
            return YES;
        }
    } else {
        if (action == @selector(showChDefine)) {
            
//            UITextView *myText = sender;
//            if(myText.selectedRange.length>0) {
//                NSLog(@"%@", [myText.text substringWithRange:myText.selectedRange]);
//            }
            return YES;
            
        }
    }
    
    return NO;
}

//--------------拖动播放速度条
- (IBAction) speedDragBegin:(UISlider *)slider {
    //    [slider thumbRectForBounds:[self.view frame] trackRect:slider.frame value:slider.value];
    
    //    NSLog(@"%f %f", slider.value ,[slider thumbRectForBounds:[self.view frame] trackRect:slider.frame value:slider.value].origin.y);
    if (!isFree) {
        [self becomeFirstResponder];
        isSpeedMenu = YES;
        isAbMenu = NO;
        [[NSUserDefaults standardUserDefaults] setFloat:slider.value forKey:@"speed"];
        
        UIMenuItem *menuItem_1 = [[UIMenuItem alloc] initWithTitle:[NSString stringWithFormat:@"%.1fx", slider.value] action:@selector(showSpeed)];
        NSArray *menuItems = [NSArray arrayWithObjects:menuItem_1,nil];
        [menuItem_1 release];
        speedMenu.menuItems = nil;
        speedMenu.menuItems = menuItems;
        //    [slider thumbRectForBounds:[self.view frame] trackRect:slider.frame value:slider.value]
        [speedMenu setTargetRect:CGRectMake(slider.frame.origin.x + (slider.value - slider.minimumValue)/(slider.maximumValue - slider.minimumValue)*slider.frame.size.width, toolView.frame.origin.y+50, 1, 20) inView:self.view];
        [speedMenu setMenuVisible:YES animated:YES];
    } else {
        if (!isUpAlertShow) {
            isUpAlertShow = YES;
            UIAlertView *updateAlert = [[UIAlertView alloc] initWithTitle:nil message:kPlayEleven delegate:self cancelButtonTitle:kAppThree otherButtonTitles:kAppFour, nil];
            [updateAlert setTag:5];
            [updateAlert show];
        }
        
    }
}

- (IBAction) speedDragEnd:(UISlider *)slider {
    [self becomeFirstResponder];
    [speedMenu setMenuVisible:NO animated:YES];
    isSpeedMenu = NO;
    UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:@"中译" action:@selector(showChDefine)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObject:menuItem]];
    [menuItem release];
}
//--------------拖动播放进度条
- (IBAction) brightSliderChanged:(UISlider *)slider{
    [[UIScreen mainScreen] setBrightness:slider.value];
}

//--------------拖动播放进度条
- (IBAction) sliderChanged:(UISlider *)slider{
//    NSLog(@"sliderChanged");
    noBuffering = NO;
    seekTo = [slider value] - 1;//#$$#
    CMTime playerProgress = [player currentTime];
    double progress = CMTimeGetSeconds(playerProgress);
    [self setButtonImage:loadingImage];
    [MP3PlayerClass timeSliderChanged:slider 
                        timeSlider:timeSlider 
                        localPlayer:player 
                            button:playButton];
//    [timeSlider setEnabled:NO];
    int i = 0;
    for (; i < [timeArray count]; i++) {
        if ((int)progress < [[timeArray objectAtIndex:i] unsignedIntValue]) {
            sen_num = i;//跟读标识句子号
            return;
        }
    }
}

//--------------按下A、B按钮
//- (IBAction) abBtnPressed:(UIButton *)sender{
//    CGRect timeSliderFrame = [timeSlider frame];
//    NSLog(@"按下A、B按钮");
//}

- (NSInteger) indexOfArray:(NSMutableArray *) array bbcId:(NSInteger)bbcId
{
    NSInteger i = 0;
    for (i = 0; i < [array count]; i++) {
        if ([[array objectAtIndex:i] integerValue] == bbcId) {
            return i;
        }
    }
    return 0;
}

// Update the slider about the music time
- (void)updateSlider {
//    NSLog(@"666");
    CMTime playerProgress = [player currentTime];
    double progress = CMTimeGetSeconds(playerProgress);
    double duration = CMTimeGetSeconds([self playerItemDuration]);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.3){
//        NSLog(@"rate:%f", [player rate]);
//        [player setRate:2.0f];
//        [player setRate:0.5f];
    }else {
//        NSArray* seekRanges = [player.currentItem seekableTimeRanges];
//        if (seekRanges.count > 0)  
//        {  
//            CMTimeRange range = [[seekRanges objectAtIndex:0] CMTimeRangeValue];  
//            duration = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration);  
//            NSLog(@"duration2:%g", duration);  
        totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
        timeSlider.maximumValue = duration > 0.1f ? duration : 0.f;
//        }
    }
    
    NSArray* loadedRanges = player.currentItem.loadedTimeRanges;  
    if (loadedRanges.count > 0 && playerFlag == 1)  
    {  
        CMTimeRange range = [[loadedRanges objectAtIndex:0] CMTimeRangeValue];  
        double loaded = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration);  
//        NSLog(@"loaded:%g", loaded);
        if (duration>0.f) {
            [loadProgress setProgress:(loaded/duration)];
        }
    }
    
    if (!noBuffering && progress<seekTo && progress > 1) {
        
    }
    else {
        noBuffering = YES;
//        if (timeSlider.maximumValue >= progress) { //#$$#
//            timeSlider.value = progress;
//        } else {
//            timeSlider.value = timeSlider.maximumValue;
//        }
        
        if (progress > 0.f) {//#$$#
            [player setRate:[[NSUserDefaults standardUserDefaults] floatForKey:@"speed"]];
            [totalTimeLabel setHidden:NO];
            totalTimeLabel.text = [NSString stringWithFormat:@"%@", [timeSwitchClass timeToSwitchAdvance:duration]];
//            NSLog(@"duration:%f", duration);
            self.timeSlider.maximumValue = duration > 0.1f ? duration : 0.f;
            //        }
            //    }
            
            //        NSLog(@"当前进度:%f",progress);
            //        NSLog(@"数目:%i",[_timeArray count]);
            if (duration > 0.1f) {
                if (progress < duration) { //设置播放进度条和当前播放时间标签
                    self.timeSlider.value = progress;
                    currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
                } else {
                    self.timeSlider.value = duration;
                    currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
                }
            }
            if ([abBtn isSelected] && progress >= bValue - 0.3) {
//                NSLog(@"repeat: aValue:%f", aValue);
                [player seekToTime:CMTimeMakeWithSeconds(aValue, NSEC_PER_SEC)];
                return;
            }
        }
        
//        timeSlider.value = progress;
//        NSLog(@"当前进度:%f",progress);
//        currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
        if (progress == 0.f) {
            [player play];
            [playButton.layer removeAllAnimations];
            if (isiPhone) {
                [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
            } else {
                [playButton setImage:[UIImage imageNamed:@"PplayPressed-iPad.png"] forState:UIControlStateNormal];
            }
        }    
        if (timeSlider.maximumValue - 0.3 <= timeSlider.value) {
            if (playMode == 1) {
                [playButton.layer removeAllAnimations];
                [player seekToTime:kCMTimeZero];
                sen_num = 1;
            } else {
//                NSLog(@"contentMode-%d",contentMode);
                
                if (playMode == 3) {
                    NSInteger next = arc4random()%[listArray count];
                    //                    NSLog(@"结束index = %i",next);
                    NSInteger playId = [[listArray objectAtIndex:next] integerValue];
                    //                    if (contentMode == 1) {
                    //                        voa = [VOAView find:playId];
                    //                    } else if (contentMode == 2) {
                    voa = [VOAView find:playId];
                    //                    }
                    playIndex = [self indexOfArray:listArray bbcId:voa._voaid] ;
                } else {
                    //                    NSLog(@"playIndex = %i; count = %i", playIndex , [listArray count]);
                    if (playIndex + 1 == [listArray count]) {
                        
                        playIndex = 0;
                    } else {
                        playIndex++;
                        //                        NSLog(@"结束index = %i",playIndex);
                    }
                    NSInteger playId = [[listArray objectAtIndex:playIndex] integerValue];
                    //                    if (contentMode == 1) {
                    //                        voa = [VOAView find:playId];
                    //                    } else if (contentMode == 2) {
                    voa = [VOAView find:playId];
                    //                    }
                    
                }
                if (contentMode == 1 && ![VOADetail isExist:voa._voaid]) {
                    //                    if (![VOADetail isExist:voa._voaid]) {
                    //                        NSLog(@"内容不全-%d",voa._voaid);
                    [VOADetail deleteByVoaid: voa._voaid];
                    //                        NSLog(@"voaid:%i",voa._voaid);
                    voa._isRead = @"1";
                    kNetTest;
                    if (kNetIsExist) {
                        [self catchDetails:voa];
                    } else {
//                        timeSlider.value = 0.f;//#$$#
                        if (playIndex == 0) {
                            
                            playIndex = [listArray count] - 1;
                        } else {
                            playIndex--;
                            //                        NSLog(@"结束index = %i",playIndex);
                        }
                        if (!notValid) {
                            [lyricSynTimer invalidate];
                            //            lyricSynTimer = nil;
                            [sliderTimer invalidate];
                            //            sliderTimer = nil;
                            notValid = YES;
                        }
                        [self setButtonImage:pauseImage];
                        UIAlertView *netAlert = [[UIAlertView alloc] initWithTitle:kPlayEight message:kNewSix delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [netAlert show];
                        [netAlert release];
                    }
                    
                    //                    }
                } else {
                    HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
                    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
                    HUD.delegate = self;
                    HUD.labelText = @"Loading";
                    HUD.dimBackground = YES;
                    [HUD show:YES];
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self initialize];
                        });
                    });
                }
                
            }
//            timeSlider.value = 0.f;
//            [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
        }
        
        //跟读的判断
//        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"recordRead"]) {
        if (readRecord) {
            [totalTimeLabel setHidden:YES];
            if (sen_num < [timeArray count]+1 && progress >= [[timeArray objectAtIndex:sen_num-1] floatValue]) {
                sen_num++;
                if ([self isPlaying]) {
                    [self playButtonPressed:playButton];
                }
//                NSLog(@"进入断句");
                //开启录音
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"recordRead"] && [self hasMicphone]) {
                    [self startToRecord];
                    
                    //                    AudioServicesPlaySystemSound (soundFileObject);
                    //systemSoundID的取值范围在1000-2000
                    //                    [controller record:controller.btn_record];
                    
                }
                
//                [player pause];
//                if (isiPhone) {
//                    [playButton setImage:[UIImage imageNamed:@"PpausePressed.png"] forState:UIControlStateNormal];
//                } else {
//                    [playButton setImage:[UIImage imageNamed:@"PpausePressed@2x.png"] forState:UIControlStateNormal];
//                }
//                
//                //开启录音
//                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"recordRead"]) {
////                    AudioServicesPlaySystemSound (soundFileObject);
//                    //systemSoundID的取值范围在1000-2000
//                    [controller record:controller.btn_record];
//                }
                
            }
        }
    }
//    NSLog(@"777");
}

// 歌词同步
- (void)lyricSyn {
//    NSLog(@"888");
    CMTime playerDuration = [self playerItemDuration];
    double duration = CMTimeGetSeconds(playerDuration);
    
    CMTime playerProgress = [player currentTime];
    double progress = CMTimeGetSeconds(playerProgress);
    if (!noBuffering && progress<seekTo && progress > 1) {
//        NSLog(@"等待");
        [self setButtonImage:loadingImage];
    }
    else {
        noBuffering = YES;
        if ([self isPlaying])
        {
//            NSLog(@"播放");
            [self setButtonImage:playImage];
        }
        else if (player.status == AVPlayerItemStatusReadyToPlay)
        {
//            NSLog(@"暂停");
            [self setButtonImage:pauseImage];
        }else if (progress<duration&&!localFileExist)
        {
//            NSLog(@"等待");
            [self setButtonImage:loadingImage];
        }
    }
//    NSLog(@"同步");
    [LyricSynClass lyricSyn : (NSMutableArray *)lyricLabelArray
           lyricCnLabelArray: (NSMutableArray *)lyricCnLabelArray 
                      index : (NSMutableArray *)indexArray
                       time : (NSMutableArray *)timeArray
                localPlayer : (AVPlayer *)player 
                     scroll : (TextScrollView *)textScroll];    
//	NSLog(@"lyricLabelArrayretainnumber:%i", [self.lyricLabelArray retainCount]);
//    NSLog(@"999");
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
	
//	[playButton setTitle:@"播放" forState:UIControlStateNormal];
    //	Music completed 
    //	这段加上之后,播放结束时会自动退出，不知原因?
#if 0
	
	if (flag) {
		
        
		[sliderTimer invalidate];
	}
	
#endif
	
}

- (void)modalView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//点击确定下载为0，取消为1
        if (alertView.tag == 1) {
            [self QueueDownloadVoa];
            [collectButton setHidden:YES];
//            [downloadFlg setHidden:YES];
//            [downloadingFlg setHidden:NO];
        } else if (alertView.tag == 2){
            
            [myWord alterCollect];
        } else if (alertView.tag == 3)
        {
            LogController *myLog = [[LogController alloc]init];
            [self.navigationController pushViewController:myLog animated:YES];
            [myLog release], myLog = nil;
        }
        else if (alertView.tag == 5) {
            isUpAlertShow = NO;
        }
    } else if (buttonIndex == 1) {
        if (alertView.tag == 4){
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"haveScore"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=610242646"]];
        }
        if (alertView.tag == 5){
            isUpAlertShow = NO;
            InnerBuyController *myInner = [[InnerBuyController alloc] init];
            [self.navigationController pushViewController:myInner animated:YES];
        }
    }
    [alertView release];
}

-(BOOL) isExistenceNetwork:(NSInteger)choose
{
    UIAlertView *myalert = nil;
    kNetTest;
    switch (choose) {
        case 0:
            
            break;
        case 1:
            if (kNetIsExist) {
                
            }else {
                myalert = [[UIAlertView alloc] initWithTitle:kInfoTwo message:kRegNine delegate:nil cancelButtonTitle:kFeedbackFive otherButtonTitles:nil,nil];
                [myalert show];
                [myalert release];
            }
            break;
        default:
            break;
    }    
	return kNetIsExist;
}

/**
 *  取词时查到该单词释义时响应事件
 */
- (void)wordExistDisplay {
    for (UIView *sView in [explainView subviews]) {
        if (![sView isKindOfClass:[UIImageView class]]) {
            [sView removeFromSuperview];
        }
    }
    
    NSString *totalString = [[NSString alloc] init];
    for (int i = 0; i<myWord.engArray.count; i++) {
        //        NSLog(@"retain1: %i", [totalString retainCount]);
        totalString = [totalString stringByAppendingFormat:@"%d:%@\n%@\n",i+1,[myWord.engArray objectAtIndex:i],[myWord.chnArray objectAtIndex:i]];
        //        NSLog(@"retain2: %i", [totalString retainCount]);
        //        totalNum += ([[myWord.engArray objectAtIndex:i] length]+2)/34 + 2 + [[myWord.chnArray objectAtIndex:i] length]/34;
    }
    
    UIFont *Courier = [UIFont fontWithName:@"Arial" size:20];
    UIFont *CourierT = [UIFont fontWithName:@"Arial" size:16];
    UIFont *CourierTh = [UIFont fontWithName:@"Arial" size:14];
    UIFont *CourierP = [UIFont fontWithName:@"Arial" size:23];
    UIFont *CourierTP = [UIFont fontWithName:@"Arial" size:19];
    UIFont *CourierThP = [UIFont fontWithName:@"Arial" size:17];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    if ([myWord isExisit]) {
        if (isiPhone) {
            [addButton setImage:[UIImage imageNamed:@"addedWord.png"] forState:UIControlStateNormal];
        } else {
            [addButton setImage:[UIImage imageNamed:@"addedWord-iPad.png"] forState:UIControlStateNormal];
        }
        [addButton setSelected:YES];
    } else {
        if (isiPhone) {
            [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
        } else {
            [addButton setImage:[UIImage imageNamed:@"addWord-iPad.png"] forState:UIControlStateNormal];
        }
        [addButton setSelected:NO];
    }
    
    [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [addButton setFrame:CGRectMake(195, 0, 50, 50)];
    }else{
        [addButton setFrame:CGRectMake(315, 0, 50, 50)];
    }
    
    [explainView addSubview:addButton];
    
    UILabel *wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 180, 30)];
    [wordLabel setFont :isiPhone? Courier:CourierP];
    [wordLabel setTextAlignment:UITextAlignmentLeft];
    wordLabel.text = myWord.key;
    wordLabel.backgroundColor = [UIColor clearColor];
    [explainView addSubview:wordLabel];
    [wordLabel release];
    
    //    UILabel *pronLabel = [[UILabel alloc]initWithFrame:CGRectMake(40+[myWord.key sizeWithFont:Courier].width, 5, [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width+10, 20)];
    UILabel *pronLabel = [[UILabel alloc]initWithFrame:CGRectMake(15,(isiPhone?30:40), 180, 20)];
    [pronLabel setFont :isiPhone ?CourierT:CourierTP];
    [pronLabel setTextAlignment:UITextAlignmentLeft];
    if ([myWord.pron isEqualToString:@" "] || [myWord.pron isEqualToString:@""]) {
        pronLabel.text = @"";
    }else
    {
        pronLabel.text = [NSString stringWithFormat:@"[%@]", myWord.pron];
    }
    pronLabel.backgroundColor = [UIColor clearColor];
    [explainView addSubview:pronLabel];
    [pronLabel release];
    
    if (wordPlayer) {
        [wordPlayer release];
    }
    wordPlayer =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:myWord.audio]];
    [wordPlayer play];
    
    UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    if (isiPhone) {
        [audioButton setImage:[UIImage imageNamed:@"wordSound.png"] forState:UIControlStateNormal];
    } else {
        [audioButton setImage:[UIImage imageNamed:@"wordSound-iPad.png"] forState:UIControlStateNormal];
    }
    [audioButton addTarget:self action:@selector(playWord:) forControlEvents:UIControlEventTouchUpInside];
    //    [audioButton setFrame:CGRectMake(250, 10, 30, 30)];
    if (isiPhone) {
        [audioButton setFrame:CGRectMake(250,5, 30, 30)];

    } else {
        [audioButton setFrame:CGRectMake(385,5, 40, 40)];

    }
        //    [audioButton setFrame:CGRectMake(50+[myWord.key sizeWithFont:Courier].width + [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width, 5, 20, 20)];
    [explainView addSubview:audioButton];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    if (isiPhone) {
        [closeButton setImage:[UIImage imageNamed:@"wordClose.png"] forState:UIControlStateNormal];
    } else {
        [closeButton setImage:[UIImage imageNamed:@"wordClose-ipad.png"] forState:UIControlStateNormal];
    }
    [closeButton addTarget:self action:@selector(closeExplaView) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [closeButton setFrame:CGRectMake(285, 5, 30, 30)];

    } else {
        [closeButton setFrame:CGRectMake(435, 5, 40, 40)];

    }
        [explainView addSubview:closeButton];
    
    UIButton *senButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    if (isiPhone) {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showSen"]) {
        if (isiPhone) {
            [senButton setImage:[UIImage imageNamed:@"senOpen.png"] forState:UIControlStateNormal];
        } else {
            [senButton setImage:[UIImage imageNamed:@"senOpen-ipad.png"] forState:UIControlStateNormal];
        }
    
    } else {
        if (isiPhone) {
            [senButton setImage:[UIImage imageNamed:@"senClose.png"] forState:UIControlStateNormal];

        } else {
            [senButton setImage:[UIImage imageNamed:@"senClose-ipad.png"] forState:UIControlStateNormal];

        }
            }
    //    } else {
    //        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showSen"]) {
    //            [senButton setImage:[UIImage imageNamed:@"senOpen-ipad.png"] forState:UIControlStateNormal];
    //        } else {
    //            [senButton setImage:[UIImage imageNamed:@"senClose-ipad.png"] forState:UIControlStateNormal];
    //        }
    //    }
    [senButton addTarget:self action:@selector(showSen:) forControlEvents:UIControlEventTouchUpInside];
    //    [senButton setFrame:CGRectMake(285, 30, 30, 30)];
    if (isiPhone) {
        [senButton setFrame:CGRectMake(288, 55, 25, 25)];
    } else {
        [senButton setFrame:CGRectMake(440, 55, 30, 30)];
    }
    
    [explainView addSubview:senButton];
    
    MyTextView *defTextView = [[MyTextView alloc] init];
    //    defTextView.delegate = self;
    if ([myWord.def isEqualToString:@" "]) {
        defTextView.text = kPlaySeven;
        [defTextView setFrame:CGRectMake(5,(isiPhone?50:70), explainView.frame.size.width-35, 20)];
        //        [defTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, 20)];
        //                    NSLog(@"未联网无法查看释义!");
    }else{
        defTextView.text = myWord.def;
        CGSize enSize = [myWord.def sizeWithFont:(isiPhone?CourierTh:CourierThP) constrainedToSize:CGSizeMake(explainView.frame.size.width-50, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
        [defTextView setFrame:CGRectMake(5, (isiPhone?50:70), explainView.frame.size.width-35, (enSize.height+10 < 70? enSize.height+10: 70))];
        //        [defTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, enSize.height)];
    }
    [defTextView setTag:arc4random()%1000];
    [defTextView setEditable:NO];
    [defTextView setFont:isiPhone? CourierTh:CourierThP];
    defTextView.backgroundColor = [UIColor clearColor];
    [defTextView setContentOffset:CGPointMake(0, 5)];
    [explainView addSubview:defTextView];
    [defTextView release];
    [senButton setTag:defTextView.frame.size.height];//***
    //    [explainView setAlpha:1];
    
    MyTextView *senTextView = [[MyTextView alloc] initWithFrame:CGRectMake(5,(isiPhone?50:70) + defTextView.frame.size.height, explainView.frame.size.width-10,   (isiPhone?190:290) - defTextView.frame.size.height)];
    //    defTextView.delegate = self;
    //    CGSize senSize = [totalString sizeWithFont:Courier constrainedToSize:CGSizeMake(explainView.frame.size.width-25, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];
    [senTextView setFrame:CGRectMake(5, (isiPhone?50:70) + defTextView.frame.size.height, explainView.frame.size.width-10, (isiPhone?190:290) - defTextView.frame.size.height)];
    //    int nNum = [VOAView numberOfMatch:totalString search:@"\n"] + 5;
    //    [senTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, senSize.height + [@"赵松" sizeWithFont:CourierTh].height * nNum)];
    //    [senTextView setContentSize:CGSizeMake(explainView.frame.size.width-10, 500)];
    //    NSLog(@"nNum:%d height:%f totalheight:%f", nNum, [@"赵松" sizeWithFont:CourierTh].height, senSize.height + [@"赵松" sizeWithFont:CourierTh].height * nNum);
    senTextView.text = totalString;
    [senTextView setTag:arc4random()%1000];
    [senTextView setEditable:NO];
    [senTextView setFont: isiPhone? CourierTh:CourierThP];
    senTextView.backgroundColor = [UIColor clearColor];
    [senTextView setContentOffset:CGPointMake(0, 10)];
    [explainView addSubview:senTextView];
    [senTextView release];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"showSen"]) {
        if (isiPhone) {
            [explainView setFrame:CGRectMake(0, 100, 320, 240)];
        } else {
            [explainView setFrame:CGRectMake(144, 220, 480, 360)];
        }
        
    } else {
        if (isiPhone) {
            [explainView setFrame:CGRectMake(0, 100, 320, 50 + defTextView.frame.size.height) ];
        } else {
            [explainView setFrame:CGRectMake(144, 220, 480, 70 + defTextView.frame.size.height) ];
        }
    }
    [explainView setHidden:NO];
}

/**
 *  取词时未查到该词时响应事件
 */
- (void)wordNoDisplay {
    myWord.audio = @"";
    myWord.pron = @" ";
    myWord.def = @"";
    for (UIView *sView in [explainView subviews]) {
        if (![sView isKindOfClass:[UIImageView class]]) {
            [sView removeFromSuperview];
        }
    }
    UIFont *Courier = [UIFont fontWithName:@"Arial" size:20];
    //    UIFont *CourierT = [UIFont fontWithName:@"Arial" size:16];
    UIFont *CourierTh = [UIFont fontWithName:@"Arial" size:14];
    UIFont *CourierP = [UIFont fontWithName:@"Arial" size:23];
    //    UIFont *CourierT = [UIFont fontWithName:@"Arial" size:16];
    UIFont *CourierThP = [UIFont fontWithName:@"Arial" size:17];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    if ([myWord isExisit]) {
        if (isiPhone) {
            [addButton setImage:[UIImage imageNamed:@"addedWord.png"] forState:UIControlStateNormal];
        } else {
            [addButton setImage:[UIImage imageNamed:@"addedWord-iPad.png"] forState:UIControlStateNormal];
        }
        [addButton setSelected:YES];
    } else {
        if (isiPhone) {
            [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
        } else {
            [addButton setImage:[UIImage imageNamed:@"addWord-iPad.png"] forState:UIControlStateNormal];
        }
        [addButton setSelected:NO];
    }
    [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [addButton setFrame:CGRectMake(195, 0, 50, 50)];
    }else{
        [addButton setFrame:CGRectMake(315, 0, 50, 50)];
    }

    [explainView addSubview:addButton];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
    if (isiPhone) {
        [closeButton setImage:[UIImage imageNamed:@"wordClose.png"] forState:UIControlStateNormal];
    } else {
        [closeButton setImage:[UIImage imageNamed:@"wordClose-ipad.png"] forState:UIControlStateNormal];
    }
    [closeButton addTarget:self action:@selector(closeExplaView) forControlEvents:UIControlEventTouchUpInside];
    if (isiPhone) {
        [closeButton setFrame:CGRectMake(285, 5, 30, 30)];
        
    } else {
        [closeButton setFrame:CGRectMake(435, 5, 40, 40)];
        
    }    [explainView addSubview:closeButton];
    
    UILabel *wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 180, 30)];
    [wordLabel setFont :isiPhone? Courier:CourierP];
    [wordLabel setTextAlignment:UITextAlignmentLeft];
    wordLabel.text = myWord.key;
    wordLabel.backgroundColor = [UIColor clearColor];
    [explainView addSubview:wordLabel];
    [wordLabel release];
    
    UILabel *defLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 50, explainView.frame.size.width-10, 20)];
    [defLabel setFont :isiPhone? CourierTh:CourierThP];
    defLabel.backgroundColor = [UIColor clearColor];
    [defLabel setLineBreakMode:UILineBreakModeWordWrap];
    [defLabel setNumberOfLines:1];
    defLabel.text = kWordEight;
    //                NSLog(@"无查找结果!");
    [explainView addSubview:defLabel];
    [defLabel release];
    //    [explainView setAlpha:1];
    
    if (isiPhone) {
        [explainView setFrame:CGRectMake(0, 100, 320, 70)];
    } else {
        [explainView setFrame:CGRectMake(144, 220, 480, 70)];
    }
    
    [explainView setHidden:NO];
    
}

/**
 *  屏幕取词
 */
-(void)screenTouchWord:(UITextView *)mylabel{
    int lineHeight = [@"a" sizeWithFont:mylabel.font].height;
    int LineStartlocation = 0;
    if (mylabel.tag == 2000) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
        return;
    }
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
    //    NSLog(@"取词:%@",mylabel.text);
    NSString * WordIFind = nil;
    UITouch *touch = [wordTouches anyObject];
    CGPoint point = [touch locationInView:self.textScroll];
    int tagetline = ceilf((point.y- mylabel.frame.origin.y)/lineHeight);
    CGSize maxSize = CGSizeMake(textScroll.frame.size.width-(isiPhone? 16: 18), CGFLOAT_MAX);
    if (readRecord) {
        point = [touch locationInView:self.myScroll];
        if (isiPhone) {
            tagetline = ceilf((point.y- 20)/lineHeight);
            maxSize = CGSizeMake(260, CGFLOAT_MAX);
        } else {
            tagetline = ceilf((point.y- 50)/lineHeight);
            maxSize = CGSizeMake(568, CGFLOAT_MAX);
        }
        
    }
    //    NSLog(@"x:%f,y:%f",point.x,point.y);
    //    int fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowValueFont"];
    //    NSLog(@"nowValueFont:%d",fontSize);
    //    UIFont *Courier = [UIFont fontWithName:@"Courier" size:fontSize];
    
    //    int numberoflines = self.frame.size.height / lineHeight;
    //    int tagetline = ceilf((point.y- mylabel.frame.origin.y)/lineHeight);
    NSString * sepratorString = @", ，。.?!:\"“”-()'‘";
    //    NSString * text = @"...idowrhu wpe gre dddd.. 'eow.ei, we u";
    NSCharacterSet * sepratorSet = [NSCharacterSet characterSetWithCharactersInString:sepratorString];
    NSArray * splitStr = [mylabel.text componentsSeparatedByCharactersInSet:sepratorSet];
    //    NSArray * splitStr = [self.text componentsSeparatedByString:@" "];
    int WordIndex = 0;
    int count = [splitStr count];
    BOOL WordFound = NO;
    NSString * string = @"";
    NSString * string2 = @"";
    
    for (int i = 0; i < count && !WordFound; i++) {
        @try {//??
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
            
            NSString * substr = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string length])];
            CGSize mysize = [substr sizeWithFont:mylabel.font constrainedToSize:maxSize];
            
            if (mysize.height/lineHeight == tagetline && !WordFound) {
                LineStartlocation = [string length] - [[splitStr objectAtIndex:i] length] - 1;
                for (; i < count; i++) {
                    
                    string2 = [string2 stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
                    NSString * substr2 = nil;
                    @try {
                        substr2 = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string2 length])];
                    }
                    @catch (NSException *exception) {
                        
                        return;
                    }
                    
                    
                    CGSize thissize = [substr2 sizeWithFont:mylabel.font constrainedToSize:maxSize];
                    if (thissize.height/lineHeight > 1) {
                        return;
                    }
                    
                    if (thissize.width > (readRecord? (isiPhone? point.x-670:point.x-1636):point.x)) {
                        
                        WordIndex = i;
                        WordFound = YES;
                        break;
                    }
                }
            }
        }
        @catch (NSException *exception) {
        }
    }
    if (WordFound) {
        WordIFind = [splitStr objectAtIndex:WordIndex];
        if ([WordIFind isEqualToString:@""] || WordIFind == nil) {//??
            return ;
        }
        CGFloat pointY = (tagetline -1 ) * lineHeight;
        CGFloat width = [[splitStr objectAtIndex:WordIndex] sizeWithFont:mylabel.font].width;
        
        NSRange Range1 = [string2 rangeOfString:[splitStr objectAtIndex:WordIndex] options:NSBackwardsSearch];
        
        
        NSString * str = [string2 substringToIndex:Range1.location];
        int i = 0;
        while ([[str substringToIndex:i] isEqual:@"."]) {
            str = [str substringFromIndex:i+1];
            i++;
            
        }
        
        CGFloat pointX = [str sizeWithFont:mylabel.font].width;
        //        if (readRecord) {
        //            pointX = [str sizeWithFont:mylabel.font].width;
        //        }
        
        //        if (wordBack) {
        //            [wordBack removeFromSuperview];
        //            wordBack = nil;
        //        }
        LocalWord *word = [LocalWord findByKey:WordIFind];
        myWord.wordId = [VOAWord findLastId] + 1;
        nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
        myWord.userId = nowUserId;
//        NSLog(@"%@", WordIFind);
        kNetTest;
        if (kNetIsExist) {
            //            NSLog(@"有网");
            [self catchWords:WordIFind];
        } else {
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kBePro"] && word) {
                //        if (word) {
                //            if (word) {
                //            myWord.wordId = [VOAWord findLastId] + 1;
                myWord.key = word.key;
                myWord.audio = word.audio;
                myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
                if (myWord.pron == nil) {
                    myWord.pron = @" ";
                }
                myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                [word release];
                [self wordExistDisplay];
                //            }
            } else {
                myWord.key = WordIFind;
                myWord.audio = @"";
                myWord.pron = @" ";
                myWord.def = @"";
                [self wordNoDisplay];
            }
        }
        
        //        [self catchWords:WordIFind];
        
        if (readRecord) {
            [myHighLightWord setFrame:CGRectMake(pointX, pointY, width, lineHeight)];
            [myHighLightWord setHidden:NO];
        }else {
            [myHighLightWord setFrame:CGRectMake(pointX + 7, mylabel.frame.origin.y + pointY, width, lineHeight)];
//            [myHighLightWord setHidden:NO];
        }
        [myHighLightWord setAlpha:0.5];
        [myHighLightWord setHighlighted:YES];
        [myHighLightWord setHighlightedTextColor:[UIColor whiteColor]];
        [myHighLightWord setBackgroundColor:[UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1]];
        if (readRecord) {
            [mylabel addSubview:myHighLightWord];
        }else {
            [textScroll addSubview:myHighLightWord];
        }
        
    [myHighLightWord setHidden:NO];
        
        //        wordBack = [[UIView alloc] initWithFrame:CGRectMake(pointX, pointY, width, lineHeight)];
        //        wordBack.backgroundColor = [UIColor colorWithRed:1.0 green:0.651 blue:0.098 alpha:0.5];
        //        [self insertSubview:wordBack atIndex:0];
        //        [self GetExplain:WordIFind];
    }
}

/*检测声音输入设备(即有无麦克风)*/
- (BOOL)hasMicphone {  
    return [[AVAudioSession sharedInstance] inputIsAvailable];  
} 

/*检测是否有插耳机*/
- (BOOL)hasHeadset {  
#if TARGET_IPHONE_SIMULATOR  
    //#warning *** Simulator mode: audio session code works only on a device  
    return NO;  
#else   
    CFStringRef route;  
    UInt32 propertySize = sizeof(CFStringRef);  
    AudioSessionGetProperty(kAudioSessionProperty_AudioRoute, &propertySize, &route);  
    if((route == NULL) || (CFStringGetLength(route) == 0)){  
        // Silent Mode  
        //        NSLog(@"AudioRoute: SILENT, do nothing!");  
    } else {  
        NSString* routeStr = (NSString*)route;  
        //        NSLog(@"AudioRoute: %@", routeStr);  
        /* Known values of route:  
         * "Headset"  
         * "Headphone"  
         * "Speaker"  
         * "SpeakerAndMicrophone"  
         * "HeadphonesAndMicrophone"  
         * "HeadsetInOut"  
         * "ReceiverAndMicrophone"  
         * "Lineout"  
         */  
        NSRange headphoneRange = [routeStr rangeOfString : @"Headphone"];  
        NSRange headsetRange = [routeStr rangeOfString : @"Headset"];  
        if (headphoneRange.location != NSNotFound) {  
            return YES;  
        } else if(headsetRange.location != NSNotFound) {  
            return YES;  
        }  
    }  
    return NO;  
#endif  
} 

#pragma mark - View lifecycle
-(id)init
{
	self = [super init];
	if(self){
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillShow:) 
													 name:UIKeyboardWillShowNotification 
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillHide:) 
													 name:UIKeyboardWillHideNotification 
												   object:nil];		
	}
	
	return self;
}

/*
-(void)modifySpeedOf:(CFURLRef)inputURL byFactor:(float)factor andWriteTo:(CFURLRef)outputURL {
    
    ExtAudioFileRef inputFile = NULL;
    ExtAudioFileRef outputFile = NULL;
    AudioStreamBasicDescription streamDescription;
    UInt32 size;
    
//    streamDescription.mFormatID = kAudioFormatLinearPCM;
//    streamDescription.mFormatFlags = kAudioFormatFlagsCanonical;
//    streamDescription.mSampleRate = 44100 * factor;
//    streamDescription.mBytesPerPacket = 2;
//    streamDescription.mFramesPerPacket = 1;
//    streamDescription.mBytesPerFrame = 2;
//    streamDescription.mChannelsPerFrame = 1;
//    streamDescription.mBitsPerChannel = 16;
//    streamDescription.mReserved = 0;
//    ExtAudioFileOpenURL(inputURL, &inputFile);
    
    ExtAudioFileOpenURL(inputURL, &inputFile);
    size = sizeof(AudioStreamBasicDescription);
    ExtAudioFileGetProperty(inputFile,
                            kExtAudioFileProperty_FileDataFormat,
                            &size,
                            &streamDescription);
    
    streamDescription.mFormatID = kAudioFormatLinearPCM;
    streamDescription.mFormatFlags = kAudioFormatFlagsNativeEndian |
    kAudioFormatFlagIsPacked | kAudioFormatFlagIsSignedInteger;
//    streamDescription.mFormatFlags = kAudioFormatFlagsCanonical;
//    streamDescription.mSampleRate = 44100 * factor;
    streamDescription.mSampleRate = streamDescription.mSampleRate * factor;
//    streamDescription.mBytesPerPacket = 2;
//    streamDescription.mFramesPerPacket = 1;
//    streamDescription.mBytesPerFrame = 2;
//    streamDescription.mChannelsPerFrame = 1;
//    streamDescription.mBitsPerChannel = 16;
//    streamDescription.mReserved = 0;
    
    
    ExtAudioFileCreateWithURL(outputURL, kAudioFileCAFType,
                              &streamDescription, NULL, kAudioFileFlags_EraseFile, &outputFile);
    
    
    
    //find out how many frames is this file long
    SInt64 length = 0;
    UInt32 dataSize2 = (UInt32)sizeof(length);
    ExtAudioFileGetProperty(inputFile,
                            kExtAudioFileProperty_FileLengthFrames, &dataSize2, &length);
    
    SInt16 *buffer = (SInt16*)malloc(kBufferSize * sizeof(SInt16));
    
    UInt32 totalFramecount = 0;
    
    AudioBufferList bufferList;
    bufferList.mNumberBuffers = 1;
    bufferList.mBuffers[0].mNumberChannels = 1;
    bufferList.mBuffers[0].mData = buffer; // pointer to buffer of audio data
    bufferList.mBuffers[0].mDataByteSize = kBufferSize *
    sizeof(SInt16); // number of bytes in the buffer
    
    while(true) {
        
        UInt32 frameCount = kBufferSize * sizeof(SInt16) / 2;
        // Read a chunk of input
        ExtAudioFileRead(inputFile, &frameCount, &bufferList);
        totalFramecount += frameCount;
        
        if (!frameCount || totalFramecount >= length) {
            //termination condition
            break;
        }
        ExtAudioFileWrite(outputFile, frameCount, &bufferList);
    }
    
    free(buffer);
    
    ExtAudioFileDispose(inputFile);
    ExtAudioFileDispose(outputFile);
    
}*/

- (void) initialize
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:contentMode] forKey:@"contentMode"];
    //    NSLog(@"%@",[[UIDevice currentDevice] model]);
    
    [btn_record setEnabled:YES];
    switch (playMode) {
        case 1:
            if (isiPhone) {
                [modeBtn setImage:[UIImage imageNamed:@"sin.png"] forState:UIControlStateNormal];
            } else {
                [modeBtn setImage:[UIImage imageNamed:@"sin-iPad.png"] forState:UIControlStateNormal];
            }
            
            //            [displayModeBtn setTitle:@"单曲循环" forState:UIControlStateNormal]; 
            break;
        case 2:
            if (isiPhone) {
                [modeBtn setImage:[UIImage imageNamed:@"seq.png"] forState:UIControlStateNormal];
            } else {
                [modeBtn setImage:[UIImage imageNamed:@"seq-iPad.png"] forState:UIControlStateNormal];
            }
            
            //            [displayModeBtn setTitle:@"顺序播放" forState:UIControlStateNormal];
            break;
        case 3:
            if (isiPhone) {
                [modeBtn setImage:[UIImage imageNamed:@"ran.png"] forState:UIControlStateNormal];
            } else {
                [modeBtn setImage:[UIImage imageNamed:@"ran-iPad.png"] forState:UIControlStateNormal];
            }
            
            //            [displayModeBtn setTitle:@"随机播放" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
//    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"]) {
//        //        [self.lvlMeter_in setFrame:CGRectMake(150.0f, 420.0f, 92.0f, 32.0f)];
//        [self.btn_record setFrame:CGRectMake(35.0f, 375.0f, 40.0f, 40.0f)];
//        [self.btn_play setFrame:CGRectMake(75.0f, 375.0f, 40.0f, 40.0f)];
//    }
    
    if (![self hasMicphone]) {
        [btn_record setEnabled:NO];
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"recordRead"];
        [btn_play setEnabled:NO];
    }
    
    sen_num = 1;
    //        time_total = 0.f;
    needFlush = NO;
    noBuffering = YES;
//    commNumber = 0;
    nowPage = 1;
    totalPage = 1;
    [self catchComments:1];
    [btn_play setHidden:YES];
    [btn_record setHidden:YES];
    //        [controller.lvlMeter_in setHidden:YES];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:self.voa._voaid] forKey:@"lastPlay"];
    //        [[NSNotificationCenter defaultCenter]removeObserver:self name:ASStatusChangedNotification object:player];
    [playButton.layer removeAllAnimations];
    
    [VOAView alterRead:voa._voaid];
    if (kNetIsExist) {
        [self updateReadCount:voa._voaid];
    } else {
        NSMutableArray *myArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"waitReadCount"]] ;
        NSNumber *a;
        for (a in myArray) {
//            NSLog(@"array %@", a);
        }
        [myArray addObject:[NSNumber numberWithInteger:voa._voaid]];
        [[NSUserDefaults standardUserDefaults] setObject:myArray forKey:@"waitReadCount"];
        [myArray release];
    }
    downloaded = NO;
    
    if (player) {
        [player pause];
        [player release];
        player = nil;
    }
//    NSLog(@"retain count1:%i", [player retainCount]);
    if (!notValid) {
        [lyricSynTimer invalidate];
        [sliderTimer invalidate];
        notValid = YES;
    }
    timeSlider.maximumValue = 1.0f;//#$$#
    timeSlider.value = 0;
    [loadProgress setProgress:0.f];
    self.navigationController.navigationBarHidden = YES;
    //初始化字体大小
    int fontSize = 15;
    if ([Constants isPad]) {
        fontSize = 20;
    }
    int mulValueFont = [[NSUserDefaults standardUserDefaults] integerForKey:@"mulValueFont"];
    if (mulValueFont > 0) {
        fontSize = mulValueFont;
    }
    CourierOne = [UIFont systemFontOfSize:fontSize];//初始15
    CourierTwo = [UIFont systemFontOfSize:fontSize-2]; 
    [lyricLabel setFont:CourierOne];
    [lyricCnLabel setFont:CourierTwo];
    
    CGPoint startOffet = CGPointMake(0, 0);
    //        UIFont *Courier = [UIFont fontWithName:@"Arial" size:24];
    //        [titleWords setFont:Courier];
    [titleWords setText:voa._title];
    [titleWords setContentOffset:startOffet];
    NSURL *url = [NSURL URLWithString: voa._pic];
    [myImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
//    [imgWords setTextColor:[UIColor darkTextColor]];
//    [imgWords setTextAlignment:UITextAlignmentCenter];
    [imgWords setContentOffset:startOffet];
    [imgWords setText:([voa._descCn isEqualToString:@" null"]? @"": voa._descCn)];
    //刚进入页面时让歌词显示在开头
    [textScroll setContentOffset:startOffet];
    [myScroll setContentOffset:startOffet];
    [timeSlider addTarget:self 
                   action:@selector(sliderChanged:) 
         forControlEvents:UIControlEventValueChanged];
    [playButton addTarget:self 
                   action:@selector(playButtonPressed:) 
         forControlEvents:UIControlEventTouchUpInside];
    //        [playButton addTarget:self 
    //                       action:@selector(playButtonPressed:) 
    //             forControlEvents:UIEventSubtypeMotionShake];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //创建audio份目录在Documents文件夹下，not to back up
    NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];;
//    userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%d.wav", voa._voaid]];
    userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%d.mp3", voa._voaid]];
    localFileExist = [[NSFileManager defaultManager] fileExistsAtPath:userPath];
    //        mp3Url = [NSURL fileURLWithPath:userPath];
    player = nil;
//    NSLog(@"retain count2:%i", [player retainCount]);
    if (localFileExist) {
        [loadProgress setProgress:1.f];
        
//        mp3Url = [NSURL fileURLWithPath:userPath];
//        NSString *testPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/00%d.wav", voa._voaid]];
//        NSURL *testUrl = [NSURL fileURLWithPath:testPath];
//        NSFileManager *deleteFile = [NSFileManager defaultManager];
//        NSError *error = nil;
//        [deleteFile removeItemAtPath:testPath error:&error];
//        [mp3Url retain];
//        [self modifySpeedOf:(__bridge CFURLRef)mp3Url byFactor:1.2 andWriteTo:(__bridge CFURLRef)testUrl];
        
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            avSet = [AVAsset assetWithURL:[NSURL fileURLWithPath:userPath]];
//            avSet = [AVAsset assetWithURL:[NSURL fileURLWithPath:testPath]];
            [avSet retain];
//            playerItem = [AVPlayerItem playerItemWithAsset:avSet];
            player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:avSet]];
//            NSLog(@"retain count3:%i", [player retainCount]);
            
        } else {
            mp3Url = [NSURL fileURLWithPath:userPath];
            [mp3Url retain];
//            playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:userPath]];
            player = [[AVPlayer alloc] initWithURL:mp3Url];
//            NSLog(@"retain count3:%i", [player retainCount]);
        }
//        player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
        //            player = [[AVPlayer alloc] initWithURL:mp3Url];
        
        //            AudioSessionInitialize(NULL, NULL, NULL, NULL);
        //            [[AVAudioSession sharedInstance] setDelegate: self];
        playerFlag = 0;
        //            [player release];
        //            player = nil;
        [downloadFlg setHidden:NO];
        [collectButton setHidden:YES];
        [downloadingFlg setHidden:YES];
        //            NSLog(@"cunzai");  
        //  获取mp3起止时间	
        [totalTimeLabel setHidden:NO];
        [currentTimeLabel setHidden:NO];
        CMTime playerDuration = [self playerItemDuration];
        double duration = CMTimeGetSeconds(playerDuration);
        
        CMTime playerProgress = [player currentTime];
        double progress = CMTimeGetSeconds(playerProgress);
        currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];
        //            NSLog(@"%@", [timeSwitchClass timeToSwitchAdvance:localPlayer.currentTime]);
        totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
//        timeSlider.maximumValue = duration;
        [self setButtonImage:loadingImage];
        
        [player play];
//        [player setRate:2.0f];
        //            [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
    }else
    {
        
            
//            NSError * error;
//            AVKeyValueStatus status = [avSet statusOfValueForKey:@"track" error:&error];
//            
//            
//            if(status != AVKeyValueStatusLoaded) {
//                AVPlayerItem * playerItem = [AVPlayerItem playerItemWithAsset:avSet];
//                [[NSNotificationCenter defaultCenter] addObserver:self
//                                                         selector:@selector(playerItemDidReachEnd:)
//                                                             name:AVPlayerItemDidPlayToEndTimeNotification
//                                                           object:playerItem];
//                
//                player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
//            }
//            else
//            {
//                //                NSLog(@"Asset loading failed : %@", [error localizedDescription]);
//            }
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            //            NSLog(@"> 5.0");
            avSet = [AVAsset assetWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://static.iyuba.com/sounds/voa%@", voa._sound]]];
            [avSet retain];
            if (avSet.playable) {
                player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem playerItemWithAsset:avSet]];
//                NSLog(@"retain count4:%i", [player retainCount]);
                NSLog(@"Asset loading success");
            } else {
                NSLog(@"Asset loading failed");
            }
            
            //
        } else {
            mp3Url = [NSURL URLWithString:[NSString stringWithFormat:@"http://static.iyuba.com/sounds/voa%@", voa._sound]];
            [mp3Url retain];
            player = [[AVPlayer alloc] initWithURL:mp3Url];
//            NSLog(@"retain count4:%i", [player retainCount]);
            //            AVPlayerItem * playerItem = [AVPlayerItem playerItemWithURL:mp3Url];
            //            [[NSNotificationCenter defaultCenter] addObserver:self
            //                                                     selector:@selector(playerItemDidReachEnd:)
            //                                                         name:AVPlayerItemDidPlayToEndTimeNotification
            //                                                       object:playerItem];
            //
            //            player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
        }
        
        //            NSLog(@"1");
        
        //            player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://static.iyuba.com/sounds/voa%@", voa._sound]]];
        playerFlag = 1;
        //            NSLog(@"2");
        int i=0;
        for (; i<[downLoadList count]; i++) {
            int downloadid = [[downLoadList objectAtIndex:i]intValue];
            if (downloadid ==voa._voaid) {
                break;
            }
        }
        if (i<[downLoadList count])  {
            [downloadFlg setHidden:YES];
            [collectButton setHidden:YES];
            [downloadingFlg setHidden:NO];
        } else {
            [downloadFlg setHidden:YES];
            [collectButton setHidden:NO];
            [downloadingFlg setHidden:YES];
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"autoDownload"]) {
                [self collectButtonPressed:collectButton];
            }
        }
        //            NSLog(@"3");
        [totalTimeLabel setHidden:YES];
        [currentTimeLabel setHidden:YES];
        
        //            NSLog(@"开始取时间");
        //            CMTime playerDuration = [self playerItemDuration];
        //            double duration = CMTimeGetSeconds(playerDuration);
        ////            double duration = CMTimeGetSeconds([[player currentItem] duration]);
        //            NSLog(@"duration1:%lf",duration);
        
        //            NSArray* loadedRanges = player.currentItem.loadedTimeRanges;  
        //            if (loadedRanges.count > 0)  
        //            {  
        //                CMTimeRange range = [[loadedRanges objectAtIndex:0] CMTimeRangeValue];  
        //                double duration = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration);  
        //                NSLog(@"duration2:%g", duration);  
        //            }
        //
        //            CMTime playerProgress = [player currentTime];
        //            double progress = CMTimeGetSeconds(playerProgress);
        ////            NSLog(@"progress:%lf",progress);
        kNetTest;
        if (kNetIsExist) {
            [player play];
            //                NSArray* loadedRanges = player.currentItem.seekableTimeRanges; 
            //                double duration;
            //                if (loadedRanges.count > 0)  
            //                {  
            //                    CMTimeRange range = [[loadedRanges objectAtIndex:0] CMTimeRangeValue];  
            //                    duration = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration);  
            //                    NSLog(@"duration2:%g", duration);  
            //                }
            
//            CMTime playerProgress = [player currentTime];
//            double progress = CMTimeGetSeconds(playerProgress);
            double progress = 0;//#$$#
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.3){
                //                    NSLog(@"Version>=4.3");
                CMTime playerDuration = [self playerItemDuration];
                double duration = CMTimeGetSeconds(playerDuration);
                if (duration > 0.1f) {//#$$#
                    totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
                    timeSlider.maximumValue = duration;
                    timeSlider.value = progress;
                }
            }else {
                
            }
            //            NSLog(@"progress:%lf",progress);
            
            [totalTimeLabel setHidden:NO];
            [currentTimeLabel setHidden:NO];
            currentTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:progress];//#$$#
            //                totalTimeLabel.text = [timeSwitchClass timeToSwitchAdvance:duration];
            //                timeSlider.maximumValue = duration;
//            timeSlider.value = progress;
            [self setButtonImage:loadingImage];
        }else
        {
            needFlush = YES;
        }
        downloaded = NO;
    }
    //缓冲进度显示
    
    //时间可调
    sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.3
                                                   target:self
                                                 selector:@selector(updateSlider)
                                                 userInfo:nil 
                                                  repeats:YES];
    [lyricArray removeAllObjects];
    [timeArray removeAllObjects];
    [indexArray removeAllObjects];
    [lyricCnArray removeAllObjects];
    [DataBaseClass querySQL:(NSMutableArray *)lyricArray 
            lyricCnResultIn:(NSMutableArray *)lyricCnArray 
               timeResultIn:(NSMutableArray *)timeArray 
              indexResultIn:(NSMutableArray *)indexArray
                voaResultIn:(VOAView *)voa];
//    NSLog(@"lyricArraynumber:%i", [lyricArray count]);
    
    for (UIView *deleteView in [textScroll subviews]) {
        [deleteView removeFromSuperview];
    }
    
    //        NSLog(@"重复1");
    //        NSLog(@"lyricLabelArrayretainnumber:%i", [self.lyricLabelArray retainCount]);
    
    
    /*
     *  清空lyricLabelArray与lyricCnLabelArray两个数组
     */
    for (UIView *deleteView in lyricLabelArray) {
        [deleteView removeFromSuperview];
    }
    for (UIView *deleteView in lyricCnLabelArray) {
        [deleteView removeFromSuperview];
    }
    [lyricLabelArray removeAllObjects];
    [lyricCnLabelArray removeAllObjects];
    
    
    //
    //        NSLog(@"lyricLabelArrayretainnumber:%i", [self.lyricLabelArray retainCount]);
    /*
     *  释放lyricLabelArray与lyricCnLabelArray两个数组，重新创建。
     */
    //        [lyricLabelArray release], lyricLabelArray = nil;
    //        [lyricCnLabelArray release], lyricCnLabelArray = nil;
    //        lyricLabelArray = [[NSMutableArray alloc] init];
    //        lyricCnLabelArray = [[NSMutableArray alloc] init];
    
    //        NSLog(@"重复2");
    
    int setY = [LyricSynClass lyricView : (NSMutableArray *)lyricLabelArray
                       lyricCnLabelArray: (NSMutableArray *)lyricCnLabelArray 
                                  index : (NSMutableArray *)indexArray 
                                  lyric : (NSMutableArray *)lyricArray
                                lyricCn : (NSMutableArray *)lyricCnArray
                                   time : (NSMutableArray *)timeArray
                            localPlayer : (AVPlayer *)player
                                 scroll : (TextScrollView *)textScroll];
//                         myLabelDelegate: (id <UITextViewDelegate>) self
//                               engLines : (int *)&engLines
//                                cnLines : (int *)&cnLines];
    //        NSLog(@"lyricLabelArrayretainnumber:%i", [self.lyricLabelArray retainCount]);
//    NSLog(@"retain count4:%i", [player retainCount]);
    nowTextView = [lyricLabelArray objectAtIndex:0];
    CGSize newSize = CGSizeMake(textScroll.frame.size.width, setY); 
    [textScroll setContentSize:newSize]; 
    //        NSLog(@"lyricLabelArraynumber:%i", [lyricLabelArray count]);
    //        NSLog(@"lyricLabelArray:%@", lyricLabelArray);
    
    BOOL engChn = [[NSUserDefaults standardUserDefaults] boolForKey:@"synContext"] ;
    //        NSLog(@"同步设置:%d",engChn);
    if (engChn) {
        //            NSLog(@"no ......");
//        self.switchFlg = NO;
//        [switchBtn setTitle:@"开" forState:UIControlStateNormal] ;
        for (UIView *hideView in textScroll.subviews) {
            if (hideView.tag < 200) {
                [hideView setHidden:NO]; 
                //                    NSLog(@"hide1");
            }
        }
    }else
    {
        //            NSLog(@"1");
//        self.switchFlg = YES;
//        [switchBtn setTitle:@"关" forState:UIControlStateNormal] ;
        for (UIView *hideView in textScroll.subviews) {
            if (hideView.tag < 200) {
                [hideView setHidden:YES]; 
                //                    NSLog(@"show1");
            }
        }
    }
    //        NSLog(@"2");
    kNetTest;
    if (needFlushAdv && kNetIsExist) {
        needFlushAdv = NO;
        [bannerView_ loadRequest:[GADRequest request]];
    }
    //        NSLog(@"3");
    //  歌词同步的实现
#if 1
    lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
                                                     target:self 
                                                   selector:@selector(lyricSyn) 
                                                   userInfo:nil 
                                                    repeats:YES];
#endif
    notValid = NO;
    //        NSLog(@"4");
    [HUD hide:YES]; 
    
    if (isInforComm) {
        isInforComm = NO;
        CGRect frame = myScroll.frame;
        frame.origin.x = frame.size.width * 3;
        frame.origin.y = 0;
        [myScroll scrollRectToVisible:frame animated:YES];
    } else {
        int page = pageControl.currentPage ;
        CGRect frame = myScroll.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        [myScroll scrollRectToVisible:frame animated:YES];
    }
//    NSLog(@"eee");
//    NSLog(@"retain count5:%i", [player retainCount]);
//    [textScroll setContentOffset:CGPointMake(0, 50) animated:YES];
//    [textScroll scrollRectToVisible:CGRectMake(0, 0, 0, 0) animated:NO];
//    if (!isiPhone && ) {

//    }

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    kNetTest;
    [self becomeFirstResponder];

//    NSLog(@"字体大小：%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"mulValueFont"]);
//    NSLog(@"字体颜色：%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"mulValueColor"]);
//    NSLog(@"app");
//    //开启外部控制音频播放
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];  
//    [self becomeFirstResponder]; 
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:[[NSUserDefaults standardUserDefaults] boolForKey:@"keepScreenLight"]];
//    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"nightMode"];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"nightMode"]) {
        [self.view setBackgroundColor:[UIColor colorWithRed:0.196f green:0.31f blue:0.521f alpha:5.0]];
    } else {
        [self.view setBackgroundColor:[UIColor clearColor]];
    }
    isInterupted = NO;
    nowUserId = 0;
    nowUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    
    if ([VOAFav isCollected:voa._voaid]) {
        [downloadFlg setHidden:NO];
        [collectButton setHidden:YES];
        [downloadingFlg setHidden:YES];
    } else
    {
        int i=0;
        for (; i<[downLoadList count]; i++) {
            int downloadid = [[downLoadList objectAtIndex:i]intValue];
            if (downloadid ==voa._voaid) {
                break;
            }
        }
        if (i<[downLoadList count])  {
            [downloadFlg setHidden:YES];
            [collectButton setHidden:YES];
            [downloadingFlg setHidden:NO];
            localFileExist = NO;
        } else {
            [downloadFlg setHidden:YES];
            [collectButton setHidden:NO];
            [downloadingFlg setHidden:YES];
            localFileExist = NO;
        }
    }
    
    NSInteger myColor = [[NSUserDefaults standardUserDefaults] integerForKey:@"mulValueColor"];
    UIColor *swColor = [UIColor redColor];
    switch (myColor) {
        case 1:
            swColor = [UIColor colorWithRed:0.78f green:0.078f blue:0.11f alpha:1.0];
            break;
        case 2:
            swColor = [UIColor colorWithRed:0.153f green:0.012f blue:0.518f alpha:1.0];
            break;
        case 3:
            swColor = [UIColor colorWithRed:0.384f green:0.247f blue:0.157f alpha:1.0];                    
            break;
        case 4:
            swColor = [UIColor colorWithRed:1.0f green:0.4f blue:0.192 alpha:1.0];
            break;
        case 5:
            swColor = [UIColor colorWithRed:0.435f green:0.106f blue:0.361f alpha:1.0];
            break;
        case 6:
            swColor = [UIColor colorWithRed:0.421f green:0.753f blue:0.173f alpha:1.0];
            break;
        default:
            break;
    }
    [lyricLabel setTextColor:swColor];
    if (flushList) {
//        NSLog(@"开始刷新:%d", contentMode);
        if (contentMode == 1) {
            //            if (playMode == 2) {
            //                [listArray removeAllObjects];
            //                [VOAView getListBeforeVoaid:voa._voaid listArray:listArray];
            //            } else if (playMode == 3) {
            //            [listArray removeAllObjects];
            [VOAView getList:listArray category:category];
            //            }
        } else if (contentMode == 2) {
            //            if (playMode == 2) {
            //                [listArray removeAllObjects];
            //                [VOAFav getListBeforeVoaid:voa._voaid listArray:listArray];
            //            } else if (playMode == 3) {
            //            [listArray removeAllObjects];
            [VOAFav getList:listArray];
            //            }
        }
        flushList = NO;
        
        //        int i = 0;
        //        for (NSString *str in listArray) {
        //            NSLog(@"%i:%@",i++,str);
        //        }
        //        NSLog(@"flushList playIndex=%i",playIndex);
    }
    playIndex = [self indexOfArray:listArray bbcId:voa._voaid];
    kNetTest;
    if (newFile == NO && (needFlush == NO || (needFlush == YES && kNetIsExist == NO))) {
        UILabel *test = [lyricLabelArray objectAtIndex:0];
        int fontSize = 15;
        if ([Constants isPad]) {
            fontSize = 20;
        }
        int mulValueFont = [[NSUserDefaults standardUserDefaults] integerForKey:@"mulValueFont"];
        if (mulValueFont > 0) {
            fontSize = mulValueFont;
        }
        //    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:fontSize] forKey:@"nowValueFont"];
        //    UIFont *Courier = [UIFont fontWithName:@"Courier" size:fontSize];//初始15
        UIFont *Courier = [UIFont systemFontOfSize:fontSize];//初始15
        
        if (test.font == Courier) {
//            NSLog(@"same!!");
            
        } else {
//            NSLog(@"not same!!");
            for (UIView *deleteView in [textScroll subviews]) {
                [deleteView removeFromSuperview];
            }
            
            /*
             *  清空lyricLabelArray与lyricCnLabelArray两个数组
             */
            for (UIView *deleteView in lyricLabelArray) {
                [deleteView removeFromSuperview];
            }
            for (UIView *deleteView in lyricCnLabelArray) {
                [deleteView removeFromSuperview];
            }
            [lyricLabelArray removeAllObjects];
            [lyricCnLabelArray removeAllObjects];
            int setY = [LyricSynClass lyricView : (NSMutableArray *)lyricLabelArray
                               lyricCnLabelArray: (NSMutableArray *)lyricCnLabelArray
                                          index : (NSMutableArray *)indexArray
                                          lyric : (NSMutableArray *)lyricArray
                                        lyricCn : (NSMutableArray *)lyricCnArray
                                           time : (NSMutableArray *)timeArray
                                    localPlayer : (AVPlayer *)player
                                         scroll : (TextScrollView *)textScroll];
//                                 myLabelDelegate: (id <UITextViewDelegate>) self
//                                       engLines : (int *)&engLines
//                                        cnLines : (int *)&cnLines];
            //        NSLog(@"lyricLabelArrayretainnumber:%i", [self.lyricLabelArray retainCount]);
            nowTextView = [lyricLabelArray objectAtIndex:0];
            CGSize newSize = CGSizeMake(textScroll.frame.size.width, setY);
            [textScroll setContentSize:newSize];
        }
        if (notValid) {
            lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                             target:self
                                                           selector:@selector(lyricSyn)
                                                           userInfo:nil
                                                            repeats:YES];
            sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                           target:self
                                                         selector:@selector(updateSlider)
                                                         userInfo:nil
                                                          repeats:YES];
            notValid = NO;
        }
        self.navigationController.navigationBarHidden = YES;
    }else{
        [self initialize];
    }
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated]; 
    newFile = NO;
//    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
//    //有关外部控制音频播放
//    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];  
    [self resignFirstResponder]; 
}

- (void)viewDidLoad
{
    isInterupted = NO;
    notValid = YES;
//    isExisitNet = YES;
    readRecord = NO;
    isFixing = NO;
    flushList = YES;
    isShareSen = NO;
    isFive = isiPhone5;
    isSpeedMenu = NO;
    isAbMenu = NO;
    isResponse = NO;
    isUpAlertShow = NO;
//    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:kBePro];
    isFree = ![[NSUserDefaults standardUserDefaults] boolForKey:@"kBePro"];
//    isFree = NO;
//    afterRecord = NO;
    [[fixButton layer] setCornerRadius:8.0f];
    [[fixButton layer] setMasksToBounds:YES];
    [btn_play setEnabled:NO];
    [speedSlider setValue:[[NSUserDefaults standardUserDefaults] floatForKey:@"speed"]];
    [lightSlider setValue:[UIScreen mainScreen].brightness];
    
    UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:@"中译" action:@selector(showChDefine)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObject:menuItem]];
    [menuItem release];
    
//    UIMenuItem *menuItem_1 = [[UIMenuItem alloc] initWithTitle:[timeSwitchClass timeToSwitchAdvance:nowValue] action:@selector(showAB)];
//    NSArray *menuItems = [NSArray arrayWithObjects:menuItem_1,nil];
//    [menuItem_1 release];
//    speedMenu.menuItems = nil;
//    speedMenu.menuItems = menuItems;
    
    playMode = [[NSUserDefaults standardUserDefaults] integerForKey:@"playMode"];
    if (playMode == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:1] forKey:@"playMode"];
        playMode = 1;
    }
//    AVAudioSession *session = [AVAudioSession sharedInstance];
//    [session setDelegate:self];
//    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//    [session setActive:YES error:nil];
    
    m_isRecording = NO;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone || UIUserInterfaceIdiomPad)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        NSError *error;
        if ([audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error])
        {
            if ([audioSession setActive:YES error:&error]) 
            {
                //        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
            }
            else
            {
                NSLog(@"Failed to set audio session category: %@", error);
            }
        }
        else
        {
            NSLog(@"Failed to set audio session category: %@", error);
        }
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,sizeof(audioRouteOverride),&audioRouteOverride);
    }
    audioRecoder = [[CL_AudioRecorder alloc] initWithFinishRecordingBlock:^(CL_AudioRecorder *recorder, BOOL success) {
        //NSLog(@"%@,%@",success?@"YES":@"NO",recorder.recorderingPath);
    } encodeErrorRecordingBlock:^(CL_AudioRecorder *recorder, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    } receivedRecordingBlock:^(CL_AudioRecorder *recorder, float peakPower, float averagePower, float currentTime) {
//        NSLog(@"%f,%f,%f",peakPower,averagePower,currentTime);
    }];
    
    //此种模式下无法播放的同时录音
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //该代码是设置手机喇叭与麦克风同时工作 iphone 3.0以上版本 播放类型
//    UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
//    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
    
//    //设置采样率的
//    Float64 smpl=kAudioSessionProperty_CurrentHardwareSampleRate;
//    AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, sizeof(smpl), &smpl);
//    //设置声音输出扬声器 还是默认的接收器kAudioSessionOverrideAudioRoute_None
//    UInt32 audioRoute = kAudioSessionOverrideAudioRoute_Speaker; 
//    AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(UInt32), &audioRoute);
    
    //开启外部控制音频播放
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];  
    [self becomeFirstResponder]; 
    
    [[AVAudioSession sharedInstance] setDelegate:self];
    
//    //进入后台前的提醒
//    [[NSNotificationCenter defaultCenter]        
//     addObserver:self        
//     selector:@selector(applicationWillResignActive:)        
//     name:UIApplicationWillResignActiveNotification
//     object:nil];
    
//    // Create the URL for the source audio file. The URLForResource:withExtension: method is
//    //    new in iOS 4.0.
//    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"begin_record"
//                                                withExtension: @"caf"];
////    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap"
////                                                withExtension: @"aif"];
//    
//    // Store the URL as a CFURLRef instance
//    soundFileURLRef = (CFURLRef) [tapSound retain];
//    
//    // Create a system sound object representing the sound file.
//    AudioServicesCreateSystemSoundID (
//                                      
//                                      soundFileURLRef,
//                                      &soundFileObject
//                                      );
    
    localFileExist = NO;
//    switchFlg = YES;
//    [shareButton setBackgroundImage:[UIImage imageNamed:@"sinaLogo.png"] forState:UIControlStateNormal];
    
    isiPhone = ![Constants isPad];
    
    aBtn.dragEnable = YES;
    bBtn.dragEnable = YES;
    aBtn.delegate = self;
    bBtn.delegate = self;
    
    
    speedMenu = [UIMenuController sharedMenuController];
    
    if (isiPhone) {
        if (isFive) {
            if (isFree) {
                [bottomView setFrame:CGRectMake(0, 370, 320, 40)];
                [timeSlider setFrame:CGRectMake(85, 393 + 88, 150, 12)];
            } else {
                [aBtn setFrame:CGRectMake(aBtn.frame.origin.x, aBtn.frame.origin.y + 50, aBtn.frame.size.width, aBtn.frame.size.height)];
                [bBtn setFrame:CGRectMake(bBtn.frame.origin.x, bBtn.frame.origin.y + 50, bBtn.frame.size.width, bBtn.frame.size.height)];
                [bottomView setFrame:CGRectMake(0, 420 , 320, 40)];
                [timeSlider setFrame:CGRectMake(85, 443 + 88, 150, 12)];
            }
        } else {
            if (isFree) {
                [bottomView setFrame:CGRectMake(0, 370, 320, 40)];
                [timeSlider setFrame:CGRectMake(85, 393, 150, 12)];
            } else {
                [aBtn setFrame:CGRectMake(aBtn.frame.origin.x, aBtn.frame.origin.y + 50, aBtn.frame.size.width, aBtn.frame.size.height)];
                [bBtn setFrame:CGRectMake(bBtn.frame.origin.x, bBtn.frame.origin.y + 50, bBtn.frame.size.width, bBtn.frame.size.height)];
                [bottomView setFrame:CGRectMake(0, 420, 320, 40)];
                [timeSlider setFrame:CGRectMake(85, 443, 150, 12)];
            }
        }
        
    } else {
        if (isFree) {
            [bottomView setFrame:CGRectMake(0, 835, 768, 79)];
            [timeSlider setFrame:CGRectMake(187, 866, 380, 12)];
        } else {
            [aBtn setFrame:CGRectMake(aBtn.frame.origin.x, aBtn.frame.origin.y + 90, aBtn.frame.size.width, aBtn.frame.size.height)];
            [bBtn setFrame:CGRectMake(bBtn.frame.origin.x, bBtn.frame.origin.y + 90, bBtn.frame.size.width, bBtn.frame.size.height)];
            [bottomView setFrame:CGRectMake(0, 925, 768, 79)];
            [timeSlider setFrame:CGRectMake(187, 956, 380, 12)];
        }
    }
    
    aBtn.leftMargin = timeSlider.frame.origin.x;
    aBtn.rightMargin = bBtn.center.x;
    bBtn.leftMargin = aBtn.center.x;
    bBtn.rightMargin = timeSlider.frame.origin.x + timeSlider.frame.size.width;
    
    if (isiPhone) {
//        loadProgress = [[SevenProgressBar alloc] initWithFrame:CGRectMake(42, (isFree? 390:440), 187, 12) andbackImg:[UIImage imageNamed:@"slider.png"] frontimg:[UIImage imageNamed:@"sliderMin.png"]];
        loadProgress = [[SevenProgressBar alloc] initWithFrame:CGRectMake(87,(isFree?393: 443) + kFiveAdd, 146, 12) andbackImg:[UIImage imageNamed:@"slider.png"] frontimg:[UIImage imageNamed:@"sliderMin.png"]];
    }else {
//        loadProgress = [[SevenProgressBar alloc] initWithFrame:CGRectMake(87, (isFree? 866:956), 450, 12) andbackImg:[UIImage imageNamed:@"slider.png"] frontimg:[UIImage imageNamed:@"sliderMin.png"]];
        loadProgress = [[SevenProgressBar alloc] initWithFrame:CGRectMake(189,(isFree?866:956), 376,12) andbackImg:[UIImage imageNamed:@"slider.png"] frontimg:[UIImage imageNamed:@"sliderMin-iPad.png"]];
    }
    
    [self.view insertSubview:loadProgress belowSubview:timeSlider];
    [loadProgress release];
//    [timeSlider setFrame:CGRectMake(55, 360, 204, 9)];
    
    pageControl.backgroundColor = [UIColor clearColor];
	[pageControl setImagePageStateNormal:[UIImage imageNamed:@"BluePoint.png"]];
	[pageControl setImagePageStateHightlighted:[UIImage imageNamed:@"RedPoint.png"]];
    
//    [loadProgress setTrackImage:[UIImage imageNamed:@"slider.png"]];
//    [loadProgress setProgressImage:[UIImage imageNamed:@"sliderMin.png"]];

//    if (isiPhone) {
//        [timeSlider setMaximumTrackImage:[UIImage imageNamed:@"sliderMin.png"] forState:UIControlStateNormal];
//        [timeSlider setMinimumTrackImage:[UIImage imageNamed:@"sliderLu.png"] forState:UIControlStateNormal];
//        [timeSlider setThumbImage:[UIImage imageNamed:@"dragPoint.png"] forState:UIControlStateNormal];
//
//    } else {
//        [timeSlider setMaximumTrackImage:[UIImage imageNamed:@"sliderMin-iPad.png"] forState:UIControlStateNormal];
//        [timeSlider setMinimumTrackImage:[UIImage imageNamed:@"sliderLu-iPad.png"] forState:UIControlStateNormal];
//        [timeSlider setThumbImage:[UIImage imageNamed:@"dragPoint.png"] forState:UIControlStateNormal];
//
//    }
    
    [timeSlider setMaximumTrackImage:[UIImage imageNamed:@"sliderTran.png"] forState:UIControlStateNormal];
    [timeSlider setMinimumTrackImage:[UIImage imageNamed:@"sliderLu.png"] forState:UIControlStateNormal];
    [timeSlider setThumbImage:[UIImage imageNamed:@"dragPoint.png"] forState:UIControlStateNormal];
    
//    UIFont *CourierOne = [UIFont systemFontOfSize:15];
//    UIFont *CourierTwo = [UIFont systemFontOfSize:20];
//    UIFont *tFont = [UIFont fontWithName:[[UIFont fontNamesForFamilyName:@"AppleGothic"] objectAtIndex:0] size:20];
    
    int fontSize = 15;
    if ([Constants isPad]) {
        fontSize = 20;
    }
    int mulValueFont = [[NSUserDefaults standardUserDefaults] integerForKey:@"mulValueFont"];
    if (mulValueFont > 0) {
        fontSize = mulValueFont;
    }
    CourierOne = [UIFont systemFontOfSize:fontSize];//初始15
    CourierTwo = [UIFont systemFontOfSize:fontSize-2]; 
    
//    double engHight = 0.f;
//    double cnHight = 0.f;
//    engHight = [@"a" sizeWithFont:CourierOne].height;
//    cnHight = [@"赵" sizeWithFont:CourierTwo].height;
//    lyEn = [[NSString alloc] initWithFormat:@"%@", [lyricArray objectAtIndex:sen_num-1]];
//    lyCn = [[NSString alloc] initWithFormat:@"%@", [lyricCnArray objectAtIndex:sen_num-1]];
    
    lyricScroll = [[TextScrollView alloc] initWithFrame:CGRectMake(320, 300, 320, 40)];
    [lyricScroll setBackgroundColor:[UIColor clearColor]];
    lyricCnScroll = [[TextScrollView alloc] initWithFrame:CGRectMake(320, 300, 320, 40)];
    [lyricCnScroll setBackgroundColor:[UIColor clearColor]];
    
    if (isiPhone) {
        [myScroll setFrame:CGRectMake(0, 70, 320, (isFree?300:350) + kFiveAdd)];
        textScroll = [[TextScrollView alloc]initWithFrame:CGRectMake(354, 10, 260, (isFree?280:330) + kFiveAdd)];
        [textScroll setTag:1];
        [textScroll setDelegate:self];
        myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 25, 240, 160)];
        imgWords = [[MyTextView alloc] initWithFrame:CGRectMake(35, 190, 250, (isFree?110:160) + kFiveAdd)];
        [imgWords setTag:401];
        [imgWords setFont:[UIFont systemFontOfSize:15]];
        [myScroll setContentSize:CGSizeMake(1280,(isFree?300:350) + kFiveAdd)];
//        [myScroll setContentSize:CGSizeMake(960+320, 288)];
        
        collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [collectButton setImage:[UIImage imageNamed:@"PcollectPressedBBC.png"] forState:UIControlStateNormal];
        [collectButton setFrame:CGRectMake(40, 145, 40, 40)];
        [collectButton addTarget:self action:@selector(collectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        shareSenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareSenBtn setImage:[UIImage imageNamed:@"shareSen.png"] forState:UIControlStateNormal];
        [shareSenBtn setFrame:CGRectMake(935, 165, 65, 50)];
        [shareSenBtn addTarget:self action:@selector(shareSen:) forControlEvents:UIControlEventTouchUpInside];
//        [shareSenBtn setEnabled:NO];
//        [shareSenBtn setHidden:YES];
        [shareSenBtn setShowsTouchWhenHighlighted:YES];
        [shareSenBtn setTag:0];
        
        colSenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [colSenBtn setImage:[UIImage imageNamed:@"addSen.png"] forState:UIControlStateNormal];
        [colSenBtn setFrame:CGRectMake(935,80, 65, 40)];
        [colSenBtn addTarget:self action:@selector(collectSentence:) forControlEvents:UIControlEventTouchUpInside];
        [colSenBtn setTag:0];
        [colSenBtn setShowsTouchWhenHighlighted:YES];
        
        downloadFlg = [UIButton buttonWithType:UIButtonTypeCustom];
        [downloadFlg setImage:[UIImage imageNamed:@"downloadedBBC.png"] forState:UIControlStateNormal];
        [downloadFlg setFrame:CGRectMake(40, 145, 40, 40)];
        //        downloadingFlg  = [[UIButton alloc]init];
        downloadingFlg = [UIButton buttonWithType:UIButtonTypeCustom];
        [downloadingFlg setImage:[UIImage imageNamed:@"downloadingBBC.png"] forState:UIControlStateNormal];
        //        [downloadingFlg.titleLabel setTextColor:[UIColor whiteColor]];
        [downloadingFlg setFrame:CGRectMake(40, 145, 40, 40)];
        
        clockButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [clockButton setImage:[UIImage imageNamed:@"clockBBC.png"] forState:UIControlStateNormal];
        [clockButton setFrame:CGRectMake(240, 145, 40, 40)];
        [clockButton addTarget:self action:@selector(showFix:) forControlEvents:UIControlEventTouchUpInside];
        [clockButton setBackgroundColor:[UIColor clearColor]];
        
//        int eLines = [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(260, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight;
//        int cLines = (288-eLines * engHight-70) / engHight;
        lyricLabel = [[MyLabel alloc] initWithFrame:
                      CGRectMake(670, 20, 260, (isFree?144:164))];
        lyricCnLabel = [[UILabel alloc] initWithFrame:
                        CGRectMake(670, (isFree?164:184), 260, (isFree?144:164))];
//        lyricLabel.text = lyEn;
//        lyricLabel.text = @"2012-07-17 17:08:57.955 VOA[8614:11603] appVersion:2.100000";
        //    lyricLabel.tag = 200 + i;
        [lyricLabel setFont:CourierOne];
        [lyricLabel setDelegate:self];
        [lyricLabel setTextColor:[UIColor purpleColor]];
        lyricLabel.backgroundColor = [UIColor clearColor];
        [lyricLabel setLineBreakMode:UILineBreakModeWordWrap];
        [lyricLabel setNumberOfLines:0];
        
//        lyricCnLabel.text = [[NSString alloc] initWithFormat:@"%@", [lyricCnArray objectAtIndex:sen_num-1]];
//        lyricCnLabel.text = lyCn;
//        lyricCnLabel.text = @"2012-07-17 17:08:57.994 VOA[8614:11603] deviceToken:(null)";
//        lyricCnLabel.tag = 199;
//        [lyricCnLabel setDelegate:self];
        [lyricCnLabel setFont:CourierTwo];
        [lyricCnLabel setTextColor:[UIColor grayColor]];
        lyricCnLabel.backgroundColor = [UIColor clearColor];
        [lyricCnLabel setLineBreakMode:UILineBreakModeWordWrap];
        [lyricCnLabel setNumberOfLines:0];
        
        [lyricScroll setFrame:CGRectMake(670, 10, 260, (isFree? 170: 200) + kFiveAddHalf)];
        [lyricCnScroll setFrame:CGRectMake(670, (isFree? 190: 220) + kFiveAddHalf, 260, (isFree? 100: 120) + kFiveAddHalf)];
        
        myView = [[UIView alloc] initWithFrame:CGRectMake(320*3, 0, 320, (isFree?300:350) + kFiveAdd)];
        commTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, (isFree?260:310) + kFiveAdd) style:UITableViewStylePlain];
        
//        shareButton = [[UIButton alloc] initWithFrame:CGRectMake(260, 10, 40, 40)];
    }else {
        [myScroll setFrame:CGRectMake(0, 130, 768, (isFree?705:795))];
        textScroll = [[TextScrollView alloc]initWithFrame:CGRectMake(808, 0, 688,(isFree?705: 795))];
        [textScroll setTag:1];
        [textScroll setDelegate:self];
        myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(114, 25, 540, 400)];
        imgWords = [[MyTextView alloc] initWithFrame:CGRectMake(114, 450, 540, (isFree?250:290))];
        [imgWords setTag:401];
        [imgWords setFont:[UIFont systemFontOfSize:18]];
        [myScroll setContentSize:CGSizeMake(3072, (isFree?705:795))];
//        [myScroll setContentSize:CGSizeMake(2304+768, 665)];
        
        collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [collectButton setImage:[UIImage imageNamed:@"PcollectPressedBBCP.png"] forState:UIControlStateNormal];
        [collectButton setFrame:CGRectMake(114, 355, 70, 70)];
        [collectButton addTarget:self action:@selector(collectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        shareSenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareSenBtn setImage:[UIImage imageNamed:@"shareSenP.png"] forState:UIControlStateNormal];
        [shareSenBtn setFrame:CGRectMake(2249, 400, 130, 100)];
        [shareSenBtn addTarget:self action:@selector(shareSen:) forControlEvents:UIControlEventTouchUpInside];
//        [shareSenBtn setEnabled:NO];
//        [shareSenBtn setHidden:YES];
        [shareSenBtn setShowsTouchWhenHighlighted:YES];
        [shareSenBtn setTag:0];
        
        colSenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [colSenBtn setImage:[UIImage imageNamed:@"addSenP.png"] forState:UIControlStateNormal];
        [colSenBtn setFrame:CGRectMake(2249,200, 130, 100)];
        [colSenBtn addTarget:self action:@selector(collectSentence:) forControlEvents:UIControlEventTouchUpInside];
        [colSenBtn setTag:0];
        [colSenBtn setShowsTouchWhenHighlighted:YES];
        
        
        downloadFlg = [UIButton buttonWithType:UIButtonTypeCustom];
        [downloadFlg setImage:[UIImage imageNamed:@"downloadedBBCP.png"] forState:UIControlStateNormal];
        [downloadFlg setFrame:CGRectMake(114, 355, 70, 70)];
        //        downloadingFlg  = [[UIButton alloc]init];
        downloadingFlg = [UIButton buttonWithType:UIButtonTypeCustom];
        [downloadingFlg setImage:[UIImage imageNamed:@"downloadingBBCP.png"] forState:UIControlStateNormal];
        //        [downloadingFlg.titleLabel setTextColor:[UIColor whiteColor]];
        [downloadingFlg setFrame:CGRectMake(114, 355, 70, 70)];
        
        clockButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [clockButton setImage:[UIImage imageNamed:@"clockBBCP.png"] forState:UIControlStateNormal];
        [clockButton setFrame:CGRectMake(584, 355, 70, 70)];
        [clockButton addTarget:self action:@selector(showFix:) forControlEvents:UIControlEventTouchUpInside];
        [clockButton setBackgroundColor:[UIColor clearColor]];
        
        lyricLabel = [[MyLabel alloc] initWithFrame:
                      CGRectMake(1636, 50, 568, 300)];
        lyricCnLabel = [[UILabel alloc] initWithFrame:
                        CGRectMake(1636, 350, 568, 300)];

        [lyricLabel setFont:CourierOne];
        [lyricLabel setDelegate:self];
        [lyricLabel setTextColor:[UIColor purpleColor]];
        lyricLabel.backgroundColor = [UIColor clearColor];
        [lyricLabel setLineBreakMode:UILineBreakModeWordWrap];
        [lyricLabel setNumberOfLines:0];
        
        [lyricCnLabel setFont:CourierTwo];
        [lyricCnLabel setTextColor:[UIColor grayColor]];
        lyricCnLabel.backgroundColor = [UIColor clearColor];
        [lyricCnLabel setLineBreakMode:UILineBreakModeWordWrap];
        [lyricCnLabel setNumberOfLines:0];
        
        [lyricScroll setFrame:CGRectMake(1636, 50, 568, 350)];
        [lyricCnScroll setFrame:CGRectMake(1636, 450, 568, 250)];
        
        myView = [[UIView alloc] initWithFrame:CGRectMake(768*3, 0, 768, (isFree?705:795))];
        commTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 768, (isFree?665:755)) style:UITableViewStylePlain];
    }
    
    [commTableView setBackgroundColor:[UIColor clearColor]];
    [commTableView setDelegate:self];
    [commTableView setDataSource:self];
    //    [inputText setPlaceholder:@"写下您的评论。\"轻松学外语,快乐交朋友\""];
    [myView addSubview:commTableView];
    [commTableView release];
    //    [myView addSubview:inputText];
    [myScroll addSubview:myView];
    [myView release];
    commArray = [[NSMutableArray alloc]init];
    isNewComm = NO;
    
    [lyricScroll addSubview:lyricLabel];
    [lyricLabel release];
    [lyricCnScroll addSubview:lyricCnLabel];
    [lyricCnLabel release];
    
    [myScroll addSubview:lyricScroll];
    [lyricScroll release];
    [myScroll addSubview:lyricCnScroll];
    [lyricCnScroll release];
    
    [imgWords setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
    [imgWords setBackgroundColor:[UIColor clearColor]];
    [imgWords setTextAlignment:UITextAlignmentLeft];
    [imgWords setEditable:NO];
    textScroll.showsVerticalScrollIndicator = NO;
    [textScroll setBackgroundColor:[UIColor clearColor]];
    
    [myScroll addSubview:myImageView];
    [myImageView release];
    [myScroll addSubview:imgWords];
    [imgWords release];
    [myScroll addSubview:shareSenBtn];
    [myScroll addSubview:colSenBtn];
    [myScroll addSubview:collectButton];
    [myScroll addSubview:downloadFlg];
    [myScroll addSubview:downloadingFlg];
    [myScroll addSubview:clockButton];
    
//    [imgWords setTextAlignment:UITextAlignmentCenter];
    [myScroll addSubview:textScroll];
    [textScroll release];
    
    if (isiPhone) {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(3*320, self.myScroll.frame.size.height - 40, 320, 40)];
        
        textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, 240, 40)];
    } else {
        containerView = [[UIView alloc] initWithFrame:CGRectMake(3*768, self.myScroll.frame.size.height - 40, 768, 40)];
        
        textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, 650, 40)];
    }
    
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
	textView.minNumberOfLines = 1;
	textView.maxNumberOfLines = 6;
    [textView setText:@"写评论"];
	textView.returnKeyType = UIReturnKeyNext; //just as an example
	textView.font = [UIFont systemFontOfSize:15.0f];
	textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    
    // textView.text = @"test\n\ntest";
	// textView.animateHeightChange = NO; //turns off animation
    
    [self.myScroll addSubview:containerView];
	
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
    if (isiPhone) {
        entryImageView.frame = CGRectMake(5, 0, 248, 40);
    } else {
        entryImageView.frame = CGRectMake(5, 0, 658, 40);
    }
    
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // view hierachy
    [containerView addSubview:imageView];
    [containerView addSubview:textView];
    [containerView addSubview:entryImageView];
    
    UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    
//	UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//	doneBtn.frame = CGRectMake(containerView.frame.size.width - 69, 8, 63, 27);
//    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
//	[doneBtn setTitle:@"发表" forState:UIControlStateNormal];
//    
//    [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
//    doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
//    doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
//    
//    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[doneBtn addTarget:self action:@selector(doSend) forControlEvents:UIControlEventTouchUpInside];
//    [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
//    [doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
//	[containerView addSubview:doneBtn];
    
    sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	sendBtn.frame = CGRectMake(containerView.frame.size.width - 69, 8, 63, 27);
    sendBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
	[sendBtn setTitle:@"发表" forState:UIControlStateNormal];
    
    [sendBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    sendBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    sendBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[sendBtn addTarget:self action:@selector(doSend) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
	[containerView addSubview:sendBtn];
    
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    if (isiPhone) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PplayPressed" ofType:@"png"];
        playImage = [[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"PpausePressed" ofType:@"png"];
        pauseImage = [[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"Ploading" ofType:@"png"];
        loadingImage = [[UIImage alloc] initWithContentsOfFile:path];
    } else {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PplayPressed-iPad" ofType:@"png"];
        playImage = [[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"PpausePressed-iPad" ofType:@"png"];
        pauseImage = [[UIImage alloc] initWithContentsOfFile:path];
        path = [[NSBundle mainBundle] pathForResource:@"Ploading-iPad" ofType:@"png"];
        loadingImage = [[UIImage alloc] initWithContentsOfFile:path];
    }
    lyCn = [[NSString alloc]init];
    lyEn = [[NSString alloc]init];
    selectWord = [[NSString alloc]init];
    myWord = [[VOAWord alloc]init];
    mySentence =[[VOASentence alloc]init];
    userPath = [[NSString alloc] init];
    mp3Data = [[NSMutableData alloc] initWithLength:0];
    lyricArray = [[NSMutableArray alloc] init];
    lyricCnArray = [[NSMutableArray alloc] init];
	timeArray = [[NSMutableArray alloc] init];
	indexArray = [[NSMutableArray alloc] init];
    explainView = [[MyLabel alloc]init];
    lyricLabelArray = [[NSMutableArray alloc] init];
    lyricCnLabelArray = [[NSMutableArray alloc] init];
    listArray = [[NSMutableArray alloc] init];
//    shareStr = [[NSString alloc] init];
    wordTouches = [[NSSet alloc] init];
    
    NSArray *myHrsArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23", nil];
    self.hoursArray = myHrsArray;
    [myHrsArray release];
    
    NSArray *myMesArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil];
    self.minsArray = myMesArray;
    [myMesArray release];
    
    NSArray *mySesArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",nil];
    self.secsArray = mySesArray;
    [mySesArray release];
    
//    NSLog(@"lyricLabelArrayretainnumber:%i", [lyricLabelArray retainCount]);
    explainView.tag = 2000;
    explainView.delegate = self;
    if (isiPhone) {
        [explainView setFrame:CGRectMake(0, 100, 320, 240)];
//        explainView.layer.cornerRadius = 10.0;
    }else {
        [explainView setFrame:CGRectMake(144, 220, 480, 360)];
        explainView.layer.cornerRadius = 20.0;
    }
    
//    [explainView setBackgroundColor:[UIColor clearColor]];
//    [explainView setAlpha:0.8f];
//    wordFrame = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, explainView.frame.size.width, explainView.frame.size.height)];
//    if (isiPhone) {
//        [wordFrame setImage:[UIImage imageNamed:@"PwordFrame.png"]];
//    } else {
//        [wordFrame setImage:[UIImage imageNamed:@"PwordFrame-iPad.png"]];
//    }
    
//    [explainView addSubview:wordFrame];
//    [wordFrame release];
    [explainView setHidden:YES];
    [self.view addSubview:explainView];
    [explainView release];
    myHighLightWord = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    [myHighLightWord setHidden:YES];
    [myHighLightWord setTag:1000];
    [myHighLightWord setAlpha:0.5];
    
    if (isFree) {
    // Create a view of the standard size at the bottom of the screen.
        if (isiPhone) {
            bannerView_ = [[GADBannerView alloc]
                           initWithFrame:CGRectMake(0.0,
                                                    self.view.frame.size.height -
                                                    GAD_SIZE_320x50.height + kFiveAdd,
                                                    GAD_SIZE_320x50.width,
                                                    GAD_SIZE_320x50.height)];
        }else{
            //        bannerView_ = [[GADBannerView alloc]
            //                       initWithFrame:CGRectMake(20.0,
            //                                                self.view.frame.size.height -
            //                                                90,
            //                                                GAD_SIZE_728x90.width,
            //                                                GAD_SIZE_728x90.height)];
            bannerView_ = [[GADBannerView alloc]
                           initWithFrame:CGRectMake(20.0,
                                                    self.view.frame.size.height -
                                                    GAD_SIZE_728x90.height,
                                                    GAD_SIZE_728x90.width,
                                                    GAD_SIZE_728x90.height)];
        }
        
        
        // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
        bannerView_.adUnitID = @"a14f752011a39fd";
        
        // Let the runtime know which UIViewController to restore after taking
        // the user wherever the ad goes and add it to the view hierarchy.
        bannerView_.rootViewController = self;
        [self.view addSubview:bannerView_];
        [bannerView_ release];
        
        // Initiate a generic request to load it with an ad.
        [bannerView_ loadRequest:[GADRequest request]];
        //    [bannerView_ setBackgroundColor:[UIColor blueColor]];
        kNetTest;
        if (!kNetIsExist) {
            needFlushAdv = YES;
        }
        [bannerView_ setHidden:NO];
    }
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];//开启接受外部控制音频播放
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
//    NSLog(@"bbbb");
    //有关外部控制音频播放
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];  
    [self resignFirstResponder]; 
//    self.controller = nil;
    self.collectButton = nil;
    self.preButton = nil;
    self.nextButton = nil;
	self.myScroll = nil;
	self.pageControl = nil;
    self.totalTimeLabel = nil;
    self.currentTimeLabel = nil;
    self.timeSlider = nil;
    self.playButton = nil;
    self.downloadFlg = nil;
    self.downloadingFlg = nil;
    self.titleWords = nil;
    self.RoundBack = nil;
    self.btnOne = nil;
    self.btnTwo = nil;
    self.btnThree = nil;
    self.btnFour = nil;
}

/**
 * 外部控制音频播放所需重置
 */
- (BOOL)canBecomeFirstResponder  
{  
    return YES;  
} 

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
//    NSLog(@"aaaa");
//    self.controller = nil;
    self.collectButton = nil;
    self.preButton = nil;
    self.nextButton = nil;
	self.myScroll = nil;
	self.pageControl = nil;
    self.totalTimeLabel = nil;
    self.currentTimeLabel = nil;
    self.timeSlider = nil;
    self.playButton = nil;
    self.downloadFlg = nil;
    self.downloadingFlg = nil;
    self.titleWords = nil;
    
    [self.wordPlayer release], wordPlayer = nil;
    [self.lyEn release], lyEn = nil;
    [self.lyCn release], lyCn = nil;
    [self.player release], player = nil;
    [self.playImage release], playImage = nil;
    [self.pauseImage release], pauseImage = nil;
    [self.loadingImage release], loadingImage = nil;
    [self.myWord release], myWord = nil;
    [self.userPath release], userPath = nil;
    [self.mp3Data release], mp3Data = nil;
    [self.lyricArray release], lyricArray = nil;
    [self.lyricCnArray release], lyricCnArray = nil;
    [self.lyricLabelArray release], lyricLabelArray = nil;
    [self.lyricCnLabelArray release], lyricCnLabelArray = nil;
    [self.timeArray release], timeArray = nil;
    [self.indexArray release], indexArray = nil;
    [self.myHighLightWord release], myHighLightWord = nil;
    [self.bannerView_ release], bannerView_ = nil;
    
    [self.RoundBack release], RoundBack = nil;
    [self.btnFour release], btnFour = nil;
    [self.btnOne release], btnOne = nil;
    [self.btnThree release], btnThree = nil;
    [self.btnTwo release], btnTwo = nil;
    [self.colSenBtn release],colSenBtn = nil;
    [shareSenBtn release],shareSenBtn = nil;
    
    [self.mySentence release],mySentence = nil;
    [super dealloc];
}

#pragma mark - Http connect
- (void)updateReadCount:(NSInteger) voaid   {
    NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/UnicomApi?protocol=70001&voaids=%d&counts=1&format=xml",voaid];
//    NSLog(@"url:%@",url);
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:@"readCount"];
    [request startSynchronous];
}


- (void)catchDetails:(VOAView *) voaid
{
    //    NSLog(@"获取内容-%d",voaid._voaid);
    NSString *url = [NSString stringWithFormat:@"http://voa.iyuba.com/voa/textWordstoryApi.jsp?voaid=%d&format=xml",voaid._voaid];
    //    NSLog(@"catch:%d",voaid._voaid);
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    request.delegate = self;
    [request setUsername:@"detail"];
    [request setTag:voaid._voaid];
    [request startSynchronous];
    //    [request release];
}

- (void)QueueDownloadVoa
{
//    NSLog(@"Queue 预备: %d",voa._voaid);
    NSOperationQueue *myQueue = [PlayViewController sharedQueue];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://static.iyuba.com/sounds/voa%@", voa._sound]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    if (request.tag == voa._voaid) {
        [downloadFlg setHidden:YES];
        [collectButton setHidden:YES];
        [downloadingFlg setHidden:NO];
//    }
    [request setDelegate:self];
    [request setTag:voa._voaid];
    [request setDidStartSelector:@selector(requestSoundStarted:)];
    [request setDidFinishSelector:@selector(requestSoundDone:)];
    [request setDidFailSelector:@selector(requestSoundWentWrong:)];
    [request setTimeOutSeconds:10];
    [myQueue addOperation:request]; //queue is an NSOperationQueue
    [VOAView alterDownload:request.tag];
    [downLoadList addObject:[NSNumber numberWithInt:request.tag]];

}

- (void)requestSoundStarted:(ASIHTTPRequest *)request
{
    nowrequest = request;
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //创建audio份目录在Documents文件夹下，not to back up
	NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];;
    userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%d.mp3", request.tag]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:userPath]) {
        [request cancel];
    }
//    [VOAView alterDownload:request.tag];
//    if (request.tag == voa._voaid) {
//        [downloadFlg setHidden:YES];
//        [collectButton setHidden:YES];
//        [downloadingFlg setHidden:NO];
//    }
//    NSLog(@"Queue 开始: %d",request.tag);
}

- (void)requestSoundDone:(ASIHTTPRequest *)request{
    kNetEnable;
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //创建audio份目录在Documents文件夹下，not to back up
	NSString *audioPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"audio"]];
	NSFileManager *fm = [NSFileManager defaultManager];
    userPath = [audioPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.mp3", request.tag]];
    NSData *responseData = [request responseData]; 
//    NSLog(@"requestFinished。大小：%d", [responseData length]);
    if(responseData.length < 2000){
        [VOAView clearDownload:request.tag];
        for (int i =0; i<[downLoadList count]; i++) {
            if ([[downLoadList objectAtIndex:i]intValue]==request.tag) {
                [downLoadList removeObjectAtIndex:i];
                break;
            }
        }
        UIAlertView *netAlert = [[UIAlertView alloc] initWithTitle:kPlayFive message:[NSString stringWithFormat:@"音频%@, 可能暂无此音频", kPlayFive] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        if (request.tag == voa._voaid) {
            [collectButton setHidden:NO];
            [downloadingFlg setHidden:YES];
            [downloadFlg setHidden:YES];
        }
        [netAlert show];
        [netAlert release];
    } else {
        if ([fm createFileAtPath:userPath contents:responseData attributes:nil]) {
        }
        if (request.tag == voa._voaid) {
            localFileExist = YES;
            downloaded = YES;
            //        if (!(pageControl.currentPage == 2)) {
            [downloadFlg setHidden:NO];
            //        }
            [collectButton setHidden:YES];
            [downloadingFlg setHidden:YES];
        }
        [VOAFav alterCollect:request.tag];
        if (contentMode == 2 && playMode == 3) {
            flushList = YES;
        }
        [fm release];
        [VOAView clearDownload:request.tag];
        for (int i =0; i<[downLoadList count]; i++) {
            if ([[downLoadList objectAtIndex:i]intValue]==request.tag) {
                [downLoadList removeObjectAtIndex:i];
                break;
            }
        }
    }
}

- (void)requestSoundWentWrong:(ASIHTTPRequest *)request
{
    kNetTest;
    [VOAView clearDownload:request.tag];
    for (int i =0; i<[downLoadList count]; i++) {
        if ([[downLoadList objectAtIndex:i]intValue]==request.tag) {
            [downLoadList removeObjectAtIndex:i];
            break;
        }
    }
    UIAlertView *netAlert = [[UIAlertView alloc] initWithTitle:kPlayFive message:[NSString stringWithFormat:@"音频%@, 可能暂无此音频", kPlayFive] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    if (request.tag == voa._voaid) {
        [collectButton setHidden:NO];
        [downloadingFlg setHidden:YES];
        [downloadFlg setHidden:YES];
    }
    [netAlert show];
    [netAlert release];
}

//- (void)catchNetA
//{
////    NSString *url = @"http://www.baidu.com";
////    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
////    request.delegate = self;
////    [request setUsername:@"catchnet"];
////    [request startAsynchronous];
//    
//    NSOperationQueue *myQueue = [PlayViewController sharedQueue];
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    [request setDelegate:self];
//    [request setUsername:@"catchnet"];
////    [request setDidStartSelector:@selector(requestStarted:)];
//    [request setDidFinishSelector:@selector(requestDone:)];
//    [request setDidFailSelector:@selector(requestWentWrong:)];
//    [myQueue addOperation:request]; //queue is an NSOperationQueue
//}


- (void)catchWords:(NSString *) word
{
//    NSString *url = [NSString stringWithFormat:@"http://word.iyuba.com/words/apiWord.jsp?q=%@",word];
//    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    request.delegate = self;
//    [request setUsername:word];
//    [request startAsynchronous];
    
    NSOperationQueue *myQueue = [PlayViewController sharedQueue];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://word.iyuba.com/words/apiWord.jsp?q=%@",[ROUtility encodeString:word urlEncode:NSUTF8StringEncoding]]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request setUsername:word];
//    [request setDidStartSelector:@selector(requestStarted:)];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
    [myQueue addOperation:request]; //queue is an NSOperationQueue
}

- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    kNetTest;
    if ([request.username isEqualToString:@"catchnet"]) {
//        NSLog(@"有网络");
//        isExisitNet = NO;
        return;
    }
    [myWord init];
    LocalWord *word = [LocalWord findByKey:request.username];
    myWord.wordId = [VOAWord findLastId] + 1;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kBePro"] && word) {
        //        if (word) {
        //            if (word) {
        //            myWord.wordId = [VOAWord findLastId] + 1;
        myWord.key = word.key;
        myWord.audio = word.audio;
        myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
        if (myWord.pron == nil) {
            myWord.pron = @" ";
        }
        myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
        [word release];
        [self wordExistDisplay];
        //            }
    } else {
        myWord.key = request.username;
        myWord.audio = @"";
        myWord.pron = @" ";
        myWord.def = @"";
        [self wordNoDisplay];
    }
}

- (void)requestDone:(ASIHTTPRequest *)request{
    kNetEnable;
    if ([request.username isEqualToString:@"catchnet"]) {
//        NSLog(@"有网络");
//        isExisitNet = YES;
        return;
    }
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];;
    [myWord init];
    int result = 0;
    NSArray *items = [doc nodesForXPath:@"data" error:nil];
    if (items) {
        for (DDXMLElement *obj in items) {
            NSMutableArray *eng = [[NSMutableArray alloc] init];
            NSMutableArray *chi = [[NSMutableArray alloc] init];
            myWord.wordId = [VOAWord findLastId]+1;
            myWord.checks = 0;
            myWord.remember = 0;
            myWord.userId = nowUserId;
            result = [[obj elementForName:@"result"] stringValue].intValue;
            if (result) {
                myWord.key = [[obj elementForName:@"key"] stringValue];
                myWord.audio = [[obj elementForName:@"audio"] stringValue];
                myWord.pron = [[obj elementForName:@"pron"] stringValue];
                if (myWord.pron == nil) {
                    myWord.pron = @" ";
                }
                myWord.def = [[[[obj elementForName:@"def"] stringValue] stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                NSArray *itemsOne = [doc nodesForXPath:@"data/sent" error:nil];
                if (itemsOne) {
                    //                        NSLog(@"4");
                    for (DDXMLElement *objOne in itemsOne) {
                        NSString *orig = [[[[[objOne elementForName:@"orig"] stringValue]stringByReplacingOccurrencesOfString:@"<em>" withString:@""] stringByReplacingOccurrencesOfString:@"</em>" withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//                        NSString * decodedText = [[NSString alloc] initWithUTF8String:[_feedback.text UTF8String]];
                        [eng addObject:orig.URLDecodedString];
                        NSString *trans = [[[objOne elementForName:@"trans"] stringValue] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                        [chi addObject:trans];
                        //                            NSLog(@"orig:%@", orig);
                        //                            NSLog(@"trans:%@", trans);
                    }
                }
                myWord.engArray = eng;
                [eng release], eng = nil;
                myWord.chnArray = chi;
                [chi release], chi = nil;
                [self wordExistDisplay];
//                for (UIView *sView in [explainView subviews]) {
//                    if (![sView isKindOfClass:[UIImageView class]]) {
//                        [sView removeFromSuperview];
//                    }
//                }
//
//                UIFont *Courier = [UIFont fontWithName:@"Arial" size:15];
//                UIFont *CourierT = [UIFont fontWithName:@"Arial" size:14];
//                
//                UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//                [addButton setImage:[UIImage imageNamed:@"addWord.png"] forState:UIControlStateNormal];
//                [addButton addTarget:self action:@selector(addWordPressed:) forControlEvents:UIControlEventTouchUpInside];
//                [addButton setFrame:CGRectMake(10, 5, 20, 20)];
//                [explainView addSubview:addButton];
//                
//                UILabel *wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, [myWord.key sizeWithFont:Courier].width+10, 20)];
//                [wordLabel setFont :Courier];
//                [wordLabel setTextAlignment:UITextAlignmentCenter];
//                wordLabel.text = myWord.key;
//                wordLabel.backgroundColor = [UIColor clearColor];
//                [explainView addSubview:wordLabel];
//                [wordLabel release];
//                
//                UILabel *pronLabel = [[UILabel alloc]initWithFrame:CGRectMake(40+[myWord.key sizeWithFont:Courier].width, 5, [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width+10, 20)];
//                [pronLabel setFont :CourierT];
//                [pronLabel setTextAlignment:UITextAlignmentLeft];
//                if ([myWord.pron isEqualToString:@" "]) {
//                    pronLabel.text = @"";
//                }else
//                {
//                    pronLabel.text = [NSString stringWithFormat:@"[%@]", myWord.pron];
//                }
//                pronLabel.backgroundColor = [UIColor clearColor];
//                [explainView addSubview:pronLabel];
//                [pronLabel release];
//                
//                if (wordPlayer) {
//                    [wordPlayer release];
//                }
//                wordPlayer =[[AVPlayer alloc]initWithURL:[NSURL URLWithString:myWord.audio]];
//                [wordPlayer play];
//                
//                UIButton *audioButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
//                [audioButton setImage:[UIImage imageNamed:@"wordSound.png"] forState:UIControlStateNormal];
//                [audioButton addTarget:self action:@selector(playWord:) forControlEvents:UIControlEventTouchUpInside];
//                [audioButton setFrame:CGRectMake(50+[myWord.key sizeWithFont:Courier].width + [[NSString stringWithFormat:@"[%@]", myWord.pron] sizeWithFont:Courier].width, 5, 20, 20)];
//                [explainView addSubview:audioButton];
//                
//                UITextView *defTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 22, explainView.frame.size.width, 80)];
//                if ([myWord.def isEqualToString:@" "]) {
//                    defTextView.text = kPlaySeven;
////                    NSLog(@"未联网无法查看释义!");             
//                }else{
//                    defTextView.text = myWord.def;
//                }
//                [defTextView setEditable:NO];
//                [defTextView setFont :CourierT];
//                defTextView.backgroundColor = [UIColor clearColor];
//                [explainView addSubview:defTextView];  
//                [defTextView release];
//                [explainView setAlpha:1];
//                [explainView setHidden:NO];
                
            }else
            {
                [myWord init];
                LocalWord *word = [LocalWord findByKey:request.username];
                myWord.wordId = [VOAWord findLastId] + 1;
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kBePro"] && word) {
                    //        if (word) {
                    //            if (word) {
                    //            myWord.wordId = [VOAWord findLastId] + 1;
                    myWord.key = word.key;
                    myWord.audio = word.audio;
                    myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
                    if (myWord.pron == nil) {
                        myWord.pron = @" ";
                    }
                    myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
                    [word release];
                    [self wordExistDisplay];
                    //            }
                } else {
                    myWord.key = request.username;
                    myWord.audio = @"";
                    myWord.pron = @" ";
                    myWord.def = @"";
                    [self wordNoDisplay];
                }
            }
        }
    }
    [doc release];
}

- (void)catchComments:(NSInteger)pages{
    NSString *url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/updateShuoShuo.jsp?groupName=iyuba&mod=select&topicId=%i&pageNumber=%i&pageCounts=15",voa._voaid,pages];
    NSLog(@"url：%@", url);
    //    ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [sendBtn setUserInteractionEnabled:NO];
    request.delegate = self;
    [request setUsername:@"comment"];
    [request startAsynchronous];
}

- (void)sendComments{
    
    NSInteger uid = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowUser"];
    //    NSLog(@"$$$:%d", uid);
    if (uid>0) {
        NSString *url;
        if (isResponse) {
            url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/updateShuoShuo.jsp?userId=%i&groupName=ios&mod=insert&topicId=%i&comment=%@&toId=%i",uid, voa._voaid, [[textView text] URLEncodedString], [textView tag]];
        } else {
            url = [NSString stringWithFormat:@"http://apps.iyuba.com/voa/updateShuoShuo.jsp?userId=%i&groupName=ios&mod=insert&topicId=%i&comment=%@",uid, voa._voaid, [[textView text] URLEncodedString]];
        }
        
        //        ASIHTTPRequest * request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:url]];
        ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
        request.delegate = self;
        [request setUsername:@"send"];
        [request startAsynchronous];
    } else {
        LogController *myLog = [[LogController alloc]init];
        [self.navigationController  pushViewController:myLog animated:YES];
        
        //        id nextResponder = [self.view nextResponder];
        //        UIView *test = [[UIView alloc] init];
        //        tes
        //        [[(UIView *)self.view firstViewController:self.view] presentModalViewController:myLog animated:YES];
        [myLog release];
        //        PlayViewController *player = [PlayViewController sharedPlayer];
        //        [player.navigationController pushViewController:myLog animated:YES];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    kNetTest;
    if ([request.username isEqualToString:@"comment"]) {
        [sendBtn setUserInteractionEnabled:YES];
        [self.commTableView setFrame:(isiPhone? CGRectMake(0, 0, 320, 0) : CGRectMake(0, 0, 768, 0))];
    }
    else if ([request.username isEqualToString:@"send"]) {
        isResponse = NO;
    }
    else if ([request.username isEqualToString:@"detail"]) {
//        timeSlider.value = 0.f;
        if (playIndex == 0) {
            
            playIndex = [listArray count] - 1;
        } else {
            playIndex--;
            //                        NSLog(@"结束index = %i",playIndex);
        }
        if (!notValid) {
            [lyricSynTimer invalidate];
            //            lyricSynTimer = nil;
            [sliderTimer invalidate];
            //            sliderTimer = nil;
            notValid = YES;
        }
        UIAlertView *netAlert = [[UIAlertView alloc] initWithTitle:kPlayEight message:kNewSix delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [netAlert show];
        [netAlert release];
    }
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    kNetEnable;
    NSData *myData = [request responseData];
    DDXMLDocument *doc = [[DDXMLDocument alloc] initWithData:myData options:0 error:nil];
    if ([request.username isEqualToString:@"comment" ]) {
        /////解析
        [sendBtn setUserInteractionEnabled:YES];
        NSArray *items = [doc nodesForXPath:@"response" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                nowPage = [[[obj elementForName:@"pageNumber"] stringValue] integerValue] ;
                
//                    NSLog(@"pageNumber:%d",pageNumber);
                
                
                if (nowPage == 1) {
                    [commArray removeAllObjects];
//                    NSInteger commcount = [[[obj elementForName:@"counts"] stringValue] integerValue] ;
                    totalPage = [[[obj elementForName:@"totalPage"] stringValue] integerValue] ;
//                    NSLog(@"commcount:%d",commcount);
                    //                    commArray = [[NSMutableArray alloc]initWithCapacity:4*commcount];
                    //                    struct comment comms[commNumber];
                }
            }
        }
        items = [doc nodesForXPath:@"response/row" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                [commArray addObject:[[obj elementForName:@"id"] stringValue]];
                [commArray addObject:[[[obj elementForName:@"userName"] stringValue]stringByReplacingOccurrencesOfRegex:@"null" withString:@""]];
                [commArray addObject:[[obj elementForName:@"imgSrc"] stringValue]];
                [commArray addObject:[[obj elementForName:@"shuoShuo"] stringValue]];
                [commArray addObject:[[obj elementForName:@"createDate"] stringValue]];
                [commArray addObject:[[obj elementForName:@"userId"] stringValue]];
                //                comms[commNumber].userName = [[obj elementForName:@"userName"] stringValue];
                //                VOAView *newVoa = [[VOAView alloc] init];
                //                newVoa._voaid = [[[obj elementForName:@"voaid"] stringValue] integerValue] ;
                //                if (lastId<newVoa._voaid) {
                //                    lastId = newVoa._voaid;
                //                }
            }
        }
        //         NSLog(@"评论数：%i---表高:%f", [commArray count], [commArray count]*kCommTableHeightPh);
        if (isiPhone) { //动态改变表的大小，防止背景出现灰色
            if ([commArray count]/6<(isFree?(isFive?6:5):(isFive?7:6))) {
                [self.commTableView setFrame:CGRectMake(0, 0, 320, [commArray count]/6*kCommTableHeightPh)];
                //                NSLog(@"表高:%f", [commArray count]/4*kCommTableHeightPh);
            }
            else {
                [self.commTableView setFrame:CGRectMake(0, 0, 320, (isFree?260:310) + kFiveAdd)];
            }
        } else {
            if ([commArray count]/6<(isFree?9:10)) {
                [self.commTableView setFrame:CGRectMake(0, 0, 768, [commArray count]/6*80.0f)];
                //                NSLog(@"表高:%f", [commArray count]/4*80.0f);
            }
            else {
                [self.commTableView setFrame:CGRectMake(0, 0, 768,(isFree?665:755))];
            }
        }
        
        [commTableView reloadData];
        if (isNewComm) {
            [self.commTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            isNewComm = NO;
        } 
        //        int i = 0;
        //        NSLog(@"count：%i",[commArray count]);
        //        for (; i< [commArray count]; i++) {
        //            NSLog(@"%i:%@",i,[commArray objectAtIndex:i]);
        //        }
    } else if ([request.username isEqualToString:@"send" ]) {
        //        [commArray removeAllObjects];
        isNewComm = YES;
        //        NSLog(@"1111");
        [textView setText:@""];
        isResponse = NO;
        [self catchComments:1];
    } else if ([request.username isEqualToString:@"detail"]) {
        NSArray *items = [doc nodesForXPath:@"data/voatext" error:nil];
        if (items) {
            
            for (DDXMLElement *obj in items) {
                //                    NSLog(@"222");
                VOADetail *newVoaDetail = [[VOADetail alloc] init];
                newVoaDetail._voaid = request.tag;
                //                    NSLog(@"id:%d",newVoaDetail._voaid);
                newVoaDetail._paraid = [[[obj elementForName:@"ParaId"] stringValue]integerValue];
                newVoaDetail._idIndex = [[[obj elementForName:@"IdIndex"] stringValue]integerValue];             
                newVoaDetail._timing = [[[obj elementForName:@"Timing"] stringValue]integerValue];
                newVoaDetail._sentence = [[[[obj elementForName:@"Sentence"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"]stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
                newVoaDetail._imgWords = [[[obj elementForName:@"ImgWords"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"];
                newVoaDetail._imgPath = [[obj elementForName:@"ImgPath"] stringValue];
                newVoaDetail._sentence_cn = [[[[[obj elementForName:@"sentence_cn"] stringValue]stringByReplacingOccurrencesOfString:@"\"" withString:@"”"] stringByReplacingOccurrencesOfString:@"<b>" withString:@""] stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
                if ([newVoaDetail insert]) {
                    //                        NSLog(@"插入%d成功",newVoaDetail._voaid);
                }
                [newVoaDetail release],newVoaDetail = nil;
                
            }
            
        }
        HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow ];
        [[UIApplication sharedApplication].keyWindow addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"Loading";
        HUD.dimBackground = YES;
        [HUD show:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self initialize];
            });
        });
    } else if ([request.username isEqualToString:@"readCount"]) {
        NSArray *items = [doc nodesForXPath:@"data/Row" error:nil];
        if (items) {
            for (DDXMLElement *obj in items) {
                NSInteger nowCount = [[[obj elementForName:@"ReadCount"] stringValue]integerValue];
                if (nowCount > [[VOAView find:[[[obj elementForName:@"VoaId"] stringValue]integerValue]] _readCount].integerValue) {
                    
                    [VOAView alterReadCount:[[[obj elementForName:@"VoaId"] stringValue]integerValue] count:nowCount];
                }
            
            }
            
        }
    }
    [doc release], doc = nil;
}


#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    if (fixTimeView.alpha > 0.5) {
        [UIView beginAnimations:@"Switch" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:.5];
        [fixTimeView setAlpha:0];
        [UIView commitAnimations];
    }
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }else
    {
//        if (switchFlg) {
//            self.switchFlg = NO;
////            [switchBtn setTitle:@"开" forState:UIControlStateNormal] ;
//            for (UIView *hideView in textScroll.subviews) {
//                if (hideView.tag < 200) {
//                    [hideView setHidden:YES]; 
//                }
//            }
//            [lyricCnLabel setHidden:YES];
//        }else{
//            self.switchFlg = YES;
////            [switchBtn setTitle:@"关" forState:UIControlStateNormal] ;
//            for (UIView *hideView in textScroll.subviews) {
//                if (hideView.tag < 200) {
//                    [hideView setHidden:NO]; 
//                }
//            }
//            [lyricCnLabel setHidden:NO];
//        }
    }
}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"Moving");
////    //设置动画效果
////	[UIView beginAnimations:@"classAniTwo" context:nil];
////	[UIView setAnimationDuration:0.5];
////	[UIView setAnimationCurve:UIViewAnimationOptionCurveEaseInOut];
////    //设置你要运行的代码
////    UITouch *touch = [touches anyObject];
////    CGPoint touchPoint = [touch locationInView:self.view];
////    float x = touchPoint.x;
////    float y = touchPoint.y;
////    //    NSLog(@"拖动:%f,%f", x, y);
////    [myMove setFrame:CGRectMake(x-100, y-100, 200, 200)];
////    
////    [UIView commitAnimations];
//}


#pragma mark - Background Player Control
/**
 * 接受外部音频控制
 */
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {  
    if (event.type == UIEventTypeRemoteControl) {  
        
        switch (event.subtype) {  
                
            case UIEventSubtypeRemoteControlTogglePlayPause: 
                if (!readRecord) {
                    [self playButtonPressed:playButton];
                }
                break;  
                
            case UIEventSubtypeRemoteControlPreviousTrack:  
                [self prePlay:preButton];  
                break;  
                
            case UIEventSubtypeRemoteControlNextTrack:  
                [self aftPlay:nextButton];  
                break;  
                
            default:  
                break;  
        }  
    } 
    
}

#pragma mark - HSCButtonDelegate
- (void) dragMove:(HSCButton *)myButton {
    isAbMenu = YES;
    isSpeedMenu = NO;
    [self becomeFirstResponder];
    double duration = CMTimeGetSeconds([self playerItemDuration]);
    float nowValue = (myButton.center.x - timeSlider.frame.origin.x) / timeSlider.frame.size.width * duration;
    if (myButton.tag == 1) {
        bBtn.leftMargin = aBtn.center.x;
        aValue = nowValue;
        [timeSlider setValue:nowValue];
        [self sliderChanged:timeSlider];
    } else if (myButton.tag == 2) {
        aBtn.rightMargin = bBtn.center.x;
        bValue = nowValue;
    }
//    NSLog(@"拖动中 %@", [timeSwitchClass timeToSwitchAdvance:nowValue]);
    UIMenuItem *menuItem_1 = [[UIMenuItem alloc] initWithTitle:[timeSwitchClass timeToSwitchAdvance:nowValue] action:@selector(showAB)];
    NSArray *menuItems = [NSArray arrayWithObjects:menuItem_1,nil];
    [menuItem_1 release];
    speedMenu.menuItems = nil;
    speedMenu.menuItems = menuItems;
    //    [slider thumbRectForBounds:[self.view frame] trackRect:slider.frame value:slider.value]
    [speedMenu setTargetRect:myButton.frame inView:self.view];
    [speedMenu setMenuVisible:YES animated:YES];
}

- (void) dragEnd:(HSCButton *)myButton {
//    NSLog(@"拖动结束");
    [self becomeFirstResponder];
    [speedMenu setMenuVisible:NO animated:YES];
//    if (myButton.tag == 1) {
//        noBuffering = NO;
//        seekTo = [timeSlider value] - 1;//#$$#
//        CMTime playerProgress = [player currentTime];
//        double progress = CMTimeGetSeconds(playerProgress);
//        [self setButtonImage:loadingImage];
//        [MP3PlayerClass timeSliderChanged:timeSlider
//                               timeSlider:timeSlider
//                              localPlayer:player
//                                   button:playButton];
//        //    [timeSlider setEnabled:NO];
//        int i = 0;
//        for (; i < [timeArray count]; i++) {
//            if ((int)progress < [[timeArray objectAtIndex:i] unsignedIntValue]) {
//                sen_num = i;//跟读标识句子号
//                return;
//            }
//        }
//    }
    isAbMenu = NO;
    UIMenuItem *menuItem = [[UIMenuItem alloc]initWithTitle:@"中译" action:@selector(showChDefine)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObject:menuItem]];
    [menuItem release];
}

#pragma mark - MyLabelDelegate
- (void)touchUpInside: (NSSet *)touches mylabel:(MyLabel *)mylabel {
    int lineHeight = [@"a" sizeWithFont:mylabel.font].height;
    int LineStartlocation = 0;
    if (mylabel.tag == 2000) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
        return;
    }
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
//    NSLog(@"取词:%@",mylabel.text);
    NSString * WordIFind = nil;
    UITouch *touch = [touches anyObject]; 
    CGPoint point = [touch locationInView:self.textScroll];
    int tagetline = ceilf((point.y- mylabel.frame.origin.y)/lineHeight);
    CGSize maxSize = CGSizeMake(textScroll.frame.size.width, CGFLOAT_MAX);
    if (readRecord) {
        point = [touch locationInView:self.myScroll];
        if (isiPhone) {
            tagetline = ceilf((point.y- 20)/lineHeight);
            maxSize = CGSizeMake(260, CGFLOAT_MAX);
        } else {
            tagetline = ceilf((point.y- 50)/lineHeight);
            maxSize = CGSizeMake(568, CGFLOAT_MAX);
        }
        
    }
//    NSLog(@"x:%f,y:%f",point.x,point.y);
//    int fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowValueFont"];
//    NSLog(@"nowValueFont:%d",fontSize);
//    UIFont *Courier = [UIFont fontWithName:@"Courier" size:fontSize];
    
    //    int numberoflines = self.frame.size.height / lineHeight;
//    int tagetline = ceilf((point.y- mylabel.frame.origin.y)/lineHeight);
    NSString * sepratorString = @", ，。.?!:\"“”-()'‘";
    //    NSString * text = @"...idowrhu wpe gre dddd.. 'eow.ei, we u";
    NSCharacterSet * sepratorSet = [NSCharacterSet characterSetWithCharactersInString:sepratorString];
    NSArray * splitStr = [mylabel.text componentsSeparatedByCharactersInSet:sepratorSet];
    //    NSArray * splitStr = [self.text componentsSeparatedByString:@" "];
    int WordIndex = 0;
    int count = [splitStr count];
    BOOL WordFound = NO;
    NSString * string = @"";
    NSString * string2 = @"";
    
    for (int i = 0; i < count && !WordFound; i++) {
        @try {//??
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
            
            NSString * substr = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string length])];
            CGSize mysize = [substr sizeWithFont:mylabel.font constrainedToSize:maxSize lineBreakMode:mylabel.lineBreakMode];
            
            if (mysize.height/lineHeight == tagetline && !WordFound) {
                LineStartlocation = [string length] - [[splitStr objectAtIndex:i] length] - 1;
                for (; i < count; i++) {
                    
                    string2 = [string2 stringByAppendingString:[NSString stringWithFormat:@"%@.",[splitStr objectAtIndex:i]]];
                    NSString * substr2 = nil;
                    @try {
                        substr2 = [mylabel.text substringWithRange:NSMakeRange(LineStartlocation, [string2 length])];
                    }
                    @catch (NSException *exception) {
                        
                        return;
                    }
                    
                    
                    CGSize thissize = [substr2 sizeWithFont:mylabel.font constrainedToSize:maxSize lineBreakMode:mylabel.lineBreakMode];
                    if (thissize.height/lineHeight > 1) {
                        return;
                    }
                    
                    if (thissize.width > (readRecord? (isiPhone? point.x-670:point.x-1636):point.x)) {
                        
                        WordIndex = i;
                        WordFound = YES;
                        break;
                    }
                }
            }
        }
        @catch (NSException *exception) {
        }
    }
    if (WordFound) {
        WordIFind = [splitStr objectAtIndex:WordIndex];
        if ([WordIFind isEqualToString:@""] || WordIFind == nil) {//??
            return ;
        }
        CGFloat pointY = (tagetline -1 ) * lineHeight;
        CGFloat width = [[splitStr objectAtIndex:WordIndex] sizeWithFont:mylabel.font].width;
        
        NSRange Range1 = [string2 rangeOfString:[splitStr objectAtIndex:WordIndex] options:NSBackwardsSearch];
        
        
        NSString * str = [string2 substringToIndex:Range1.location];
        int i = 0;
        while ([[str substringToIndex:i] isEqual:@"."]) {
            str = [str substringFromIndex:i+1];
            i++;
            
        }
        
        CGFloat pointX = [str sizeWithFont:mylabel.font].width;
//        if (readRecord) {
//            pointX = [str sizeWithFont:mylabel.font].width;
//        }
        
//        if (wordBack) {
//            [wordBack removeFromSuperview];
//            wordBack = nil;
//        }
        LocalWord *word = [LocalWord findByKey:WordIFind];
        myWord.wordId = [VOAWord findLastId] + 1;

        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"kBePro"] && word) {
        //        if (word) {
//            if (word) {
//            myWord.wordId = [VOAWord findLastId] + 1;
            myWord.key = word.key;
            myWord.audio = word.audio;
            myWord.pron = [NSString stringWithFormat:@"%@",word.pron] ;
            if (myWord.pron == nil) {
                myWord.pron = @" ";
            }
            myWord.def = [[word.def stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@""]stringByReplacingOccurrencesOfString:@"null" withString:@""];
            [word release];
            [self wordExistDisplay];
//            }
        } else {
            kNetTest;
            if (kNetIsExist) {
                //            NSLog(@"有网");
                [self catchWords:WordIFind];
            } else {
                myWord.key = WordIFind;
                myWord.audio = @"";
                myWord.pron = @" ";
                myWord.def = @"";
                [self wordNoDisplay];
            }
        }
        
//        [self catchWords:WordIFind];
        
        if (readRecord) {
            [myHighLightWord setFrame:CGRectMake(pointX, pointY, width, lineHeight)];
        }else {
            [myHighLightWord setFrame:CGRectMake(pointX, mylabel.frame.origin.y + pointY, width, lineHeight)];
        }
        [myHighLightWord setAlpha:0.5];
        [myHighLightWord setHighlighted:YES];
        [myHighLightWord setHighlightedTextColor:[UIColor whiteColor]];
        [myHighLightWord setBackgroundColor:[UIColor colorWithRed:1.0/255 green:151.0/255 blue:211.0/255 alpha:1]];
        if (readRecord) {
            [mylabel addSubview:myHighLightWord];
        }else {
            [textScroll addSubview:myHighLightWord];
        }
        
        [myHighLightWord setHidden:NO];
//        wordBack = [[UIView alloc] initWithFrame:CGRectMake(pointX, pointY, width, lineHeight)];
//        wordBack.backgroundColor = [UIColor colorWithRed:1.0 green:0.651 blue:0.098 alpha:0.5];
//        [self insertSubview:wordBack atIndex:0];
//        [self GetExplain:WordIFind];
    }   
    
}

- (void)touchUpInsideLong: (NSSet *)touches mylabel:(MyLabel *)mylabel {
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
    /*CGPoint windowPoint = [mylabel convertPoint:mylabel.bounds.origin toView:self.view];
    //    NSLog(@"x:%f, y:%f", windowPoint.x, windowPoint.y);
//    NSLog(@"tag:%d",mylabel.tag);
    if (mylabel.tag > 199 && mylabel.tag < 2000) {
        [player seekToTime:CMTimeMakeWithSeconds([[timeArray objectAtIndex:mylabel.tag - 200] unsignedIntValue], NSEC_PER_SEC)];
        shareStr = [mylabel text];
        CGRect senRect = [mylabel frame];
        
        VOADetail *myVoaDetail=[VOADetail findByVoaidAndTime:self.voa._voaid timing:[[timeArray objectAtIndex:mylabel.tag - 200]unsignedIntValue]];
        [mySentence init];
       
        mySentence.SentenceId=[VOASentence findLastId]+1;
        mySentence.VoaId = myVoaDetail._voaid;
        mySentence.ParaId = myVoaDetail._paraid;
        mySentence.IdIndex = myVoaDetail._idIndex;
        mySentence.Sentence = myVoaDetail._sentence;
        mySentence.Sentence_cn = myVoaDetail._sentence_cn;
         NSLog(@"%d,%d,%d,%d",mySentence.SentenceId,mySentence.VoaId,mySentence.ParaId,mySentence.IdIndex);
        NSLog(@"%d,%d,%d,%d,%d",self.voa._voaid,[[timeArray objectAtIndex:mylabel.tag - 200]unsignedIntValue],myVoaDetail._voaid,myVoaDetail._paraid,myVoaDetail._idIndex);
        mySentence.StartTime = [[timeArray objectAtIndex:mylabel.tag -200]unsignedIntValue];
        if ([timeArray count]>mylabel.tag -199) {
            mySentence.EndTime = [[timeArray objectAtIndex:mylabel.tag -199]unsignedIntValue];
        }else{
            mySentence.EndTime = 1800 ;//默认30分钟
        }
        
        
        for (UIView *sView in [textScroll subviews]) {
            if ([sView isKindOfClass:[UIImageView class]]) {
                [sView removeFromSuperview];
            }
        }
        //        CATransition *animation = [CATransition animation];
        //        animation.delegate = self;
        //        animation.duration = 0.5;
        //        //        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        //        animation.type = @"rippleEffect";
        //        [[mylabel layer] addAnimation:animation forKey:@"animation"];
        
        
        //        UIImageView *senImage = [[UIImageView alloc] initWithFrame:senRect];
        senImage = [[UIImageView alloc] initWithFrame:senRect];
        [senImage setImage:[LyricSynClass screenshot:CGRectMake(windowPoint.x, windowPoint.y+ 20, senRect.size.width, senRect.size.height)]];
        [textScroll addSubview:senImage];
        [senImage release];
        
        for (UIView *sView in [myScroll subviews]) {
            if (sView.tag == 1111) {
                [sView removeFromSuperview];
            }
        }
        CGPoint scrollPoint = [mylabel convertPoint:mylabel.bounds.origin toView:myScroll];
        starImage = [[UIImageView alloc] initWithImage:(isiPhone? [UIImage imageNamed:@"starMy.png"]: [UIImage imageNamed:@"starMyP.png"])];
        [starImage setFrame:(isiPhone? CGRectMake(scrollPoint.x+senRect.size.width/2-25, scrollPoint.y+senRect.size.height/2-25, 50, 50): CGRectMake(scrollPoint.x+senRect.size.width/2-40, scrollPoint.y+senRect.size.height/2-40, 80, 80))];
        [shareSenBtn setHidden:NO];
        [starImage setAlpha:0.0];
        [starImage setTag:1111];
        [myScroll addSubview:starImage];
        [starImage release];
        
        [UIView beginAnimations:@"SwitchOne" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.5];
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 2.0;
        //        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"rippleEffect";
        [[mylabel layer] addAnimation:animation forKey:@"animation"];
        [senImage setFrame:CGRectMake(senRect.origin.x + senRect.size.width/2, senRect.origin.y + senRect.size.height/2, 1,1)];
        //        [shareSenBtn setFrame:CGRectMake(620, 200, 20, 20)];
        [UIView commitAnimations];
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(starAni) userInfo:nil repeats:NO];
    }*/
}

- (void)starAni {
    //    NSLog(@"xingxinglaile");
    //    for (UIView *sView in [myScroll subviews]) {
    //        if (sView.tag == 1111) {
    //            [sView removeFromSuperview];
    //        }
    //    }
    //
    //    starImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"starMy.png"]];
    //    [starImage setFrame:(isiPhone? CGRectMake(320+myScroll.frame.size.width/3, myScroll.frame.size.height/3, 1, 1): CGRectMake(768+myScroll.frame.size.width/3, myScroll.frame.size.height/3, 1, 1))];
    //    [starImage setTag:1111];
    //    [myScroll addSubview:starImage];
    //    [starImage release];
    [UIView beginAnimations:@"SwitchTwo" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    [starImage setAlpha:0.5];
    //    [starImage setFrame:(isiPhone? CGRectMake(320+myScroll.frame.size.width/3-25, myScroll.frame.size.height/3-25, 50, 50): CGRectMake(768+myScroll.frame.size.width/3-40, myScroll.frame.size.height/3-40, 80, 80))];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    starImage.layer.anchorPoint = CGPointMake(0.5, 0.5);
    starImage.layer.position = CGPointMake(starImage.frame.origin.x + 0.5 * starImage.frame.size.width, starImage.frame.origin.y + 0.5 * starImage.frame.size.height);
    [CATransaction commit];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanFalse forKey:kCATransactionDisableActions];
    [CATransaction setValue:[NSNumber numberWithFloat:120.0] forKey:kCATransactionAnimationDuration];
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:120 * M_PI];
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.delegate = self;
    [starImage.layer addAnimation:animation forKey:@"rotationAnimation"];
    [CATransaction commit];
    
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(starMoveAni) userInfo:nil repeats:NO];
    //    [starImage setFrame:CGRectMake(380, 100, 50, 50)];
}

- (void)starMoveAni {
    [UIView beginAnimations:@"SwitchThree" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.2];
    [starImage setFrame:(isiPhone? CGRectMake(608, 140, 20, 20): CGRectMake(1475, 335, 30, 30))];
    [UIView commitAnimations];
    [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(showSenShareBtn) userInfo:nil repeats:NO];
}

- (void)showSenShareBtn {
    
    [UIView beginAnimations:@"SwitchFive" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [shareSenBtn setFrame:(isiPhone? CGRectMake(900, 165, 65, 50): CGRectMake(2179, 400, 130, 100))];
//    [starImage setFrame:(isiPhone? CGRectMake(573, 140, 20, 20): CGRectMake(1405, 335, 30, 30))];
    [UIView commitAnimations];
//    [shareSenBtn setEnabled:YES];
    [shareSenBtn setTag:1];
    [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(hideSenShareBtn) userInfo:nil repeats:NO];
}

- (void)hideSenShareBtn {
    [starImage.layer removeAllAnimations];
    [UIView beginAnimations:@"SwitchSix" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [shareSenBtn setFrame:(isiPhone? CGRectMake(935, 165, 65, 50): CGRectMake(2249, 400, 130, 100))];
//    [starImage setFrame:(isiPhone? CGRectMake(608, 140, 20, 20): CGRectMake(1475, 335, 30, 30))];
//    [starImage setAlpha:0.0];
    [UIView commitAnimations];
    [shareSenBtn setTag:0];
//    [shareSenBtn setEnabled:NO];
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(setShareBtnInvalid) userInfo:nil repeats:NO];
}

//- (void)setShareBtnInvalid {
////    [shareSenBtn setHidden:YES];
//}

//- (void)touchUpInside: (NSSet *)touches mylabel:(MyLabel *)mylabel {
//    if (mylabel.tag == 2000) {
//        [explainView setHidden:YES];
//        [myHighLightWord setHidden:YES];
//        return;
//    }
//    if (![explainView isHidden]) {
//        [explainView setHidden:YES];
//        [myHighLightWord setHidden:YES];
//    }
//    UITouch *touch = [touches anyObject];    
//    CGPoint touchPoint = [touch locationInView:self.textScroll];
//    int fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:@"nowValueFont"];
//    NSLog(@"nowValueFont:%d",fontSize);
//    UIFont *Courier = [UIFont fontWithName:@"Courier" size:fontSize];
//    //    if (!isiPhone) {
//    //        Courier = [UIFont fontWithName:@"Courier" size:fontSize];
//    //    }
//    double engHight = [@"a" sizeWithFont:Courier].height;
//    float single = [@" " sizeWithFont:Courier].width ;//每个字符宽度，为9
//    NSLog(@"single:%f single:%f",single,[@" " sizeWithFont:Courier constrainedToSize:CGSizeMake(textScroll.frame.size.width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].width);
//    //    float enHeight = [@"a" sizeWithFont:Courier].height - 1;
//    float space = 0.f;
//    //    NSLog(@"space:%f",space);
//    //    NSLog(@"single:%f",single);
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
//        //        space = 9;
//        space = [@" " sizeWithFont:Courier].width-1;
//    }else {
//        space = [@" " sizeWithFont:Courier].width+1;
//    }
//    int rowOne = (touchPoint.y - mylabel.frame.origin.y)/engHight + 1;
//    
//    //    NSLog(@"row:%d",rowOne);
//    //    NSLog(@"触摸：%f %f", touchPoint.x,touchPoint.y);
//    int rowTwo = 1;
//    int location = 0;
//    
//    float total = textScroll.frame.size.width;
////    NSLog(@"total:%f",textScroll.frame.size.width);
//    float myWith =-space;
//    float compare = -space;
//    float add = -space;
//    BOOL flg = YES;
//    BOOL firstFlg = NO;
//    int i = 0;
//    NSString *regEx = @"\\S+";
//    NSString *wordEx = @"\\w+";
//    NSString *nonWordEx = @"\\W+";
//    for(NSString *matchOne in [mylabel.text componentsMatchedByRegex:regEx]) {
//        //        NSLog(@"正则后one： %@ %d", matchOne,[matchOne length]);
//        i  = 0;
//        location = 0;
//        add = matchOne.length*single + space;
//        firstFlg = NO;
//        if ([matchOne isEqualToString:@"--"]&&(myWith+2*single)>(total-space)&&(myWith+2*single)<(total)) {
//            rowTwo++;
//            myWith=space;
//            continue;
//        }
//        for(NSString *matchTwo in [matchOne componentsMatchedByRegex:wordEx]) {
//            firstFlg = YES;
//            NSRange substr = [matchOne rangeOfString:matchTwo];
//            flg = (matchTwo.length == matchOne.length);
//            for(NSString *matchThree in [matchOne componentsMatchedByRegex:nonWordEx]) {
//                if (([matchThree isEqualToString:@"‘"]||[matchThree isEqualToString:@"’"]||[matchThree isEqualToString:@"“"]||[matchThree isEqualToString:@"”"])&&(myWith+single+matchOne.length*single>total)) {
//                    rowTwo++;
//                    //                        NSLog(@"0myWith:%f", myWith);
//                    myWith=-space;
//                    break;
//                }
//            }   
//            //                NSLog(@"flg:%d",flg);
//            if (flg) {
//                if ((myWith+space+matchTwo.length*single)>total) {
//                    rowTwo++;
//                    //                    NSLog(@"1width:%f", myWith);
//                    myWith = -space;
//                    //                    NSLog(@"1width:%f", myWith);
//                }
//                add = matchTwo.length*single + space;
//                compare = myWith + space;
//            }
//            else{
//                if (i==0) {
//                    myWith += substr.location*single+ space;
//                    //                    NSLog(@"width:%f, %d %d",myWith, location, substr.location);
//                }
//                else
//                {
//                    //                    NSLog(@"width1.%d:%f", i,myWith);
//                    //                    NSLog(@"hahahah : %c",[matchOne characterAtIndex:(substr.location-1)]);
//                    if ([matchOne characterAtIndex:(substr.location-1)] == '-') {
//                        myWith += (substr.location - location-1)*single+space;
//                    }else
//                    {
//                        myWith += (substr.location - location)*single;
//                    }
//                    //                    NSLog(@"width1.%d:%f, %d %d",i,myWith, location, substr.location);
//                }
//                char cc;
//                if ((substr.location+matchTwo.length)<matchOne.length) {
//                    cc = [matchOne characterAtIndex:(substr.location+matchTwo.length)];
//                    if ((cc=='.'||cc=='-'||cc==',')&&(myWith+matchTwo.length*single+space) > total)
//                    {
//                        rowTwo++;
//                        myWith=0;
//                    }
//                }
//                if ((myWith + matchTwo.length*single) > total) 
//                {
//                    rowTwo++;
//                    //                    NSLog(@"3width:%f", myWith);
//                    myWith=0;
//                }
//                location = substr.location;
//                compare = myWith;
//            }
//            i++;
//            if ((rowOne==rowTwo)&&(touchPoint.x>compare)&&(touchPoint.x<(compare+matchTwo.length*single))) {
//                //                NSLog(@"正则后two： %@ %d", matchTwo,[matchTwo length]);
//                //                NSLog(@"我找到了！词为:%@,x:%f,y:%f,width:%f,height:20.0", matchTwo, compare, mylabel.frame.origin.y + (rowTwo-1)*19.0, [matchTwo length] * single);
//                [self catchWords:matchTwo];
//                
//                
//                [myHighLightWord setFrame:CGRectMake(compare, mylabel.frame.origin.y + (rowTwo-1)*engHight, [matchTwo length] * single, engHight)];
//                [myHighLightWord setAlpha:0.5];
//                [myHighLightWord setHighlighted:YES];
//                [myHighLightWord setHighlightedTextColor:[UIColor whiteColor]];
//                [myHighLightWord setBackgroundColor:[UIColor blueColor]];
//                [textScroll addSubview:myHighLightWord];
//                [myHighLightWord setHidden:NO];
//                return;
//            }
//            if (rowTwo > rowOne) {
//                return;
//            }
//            
//        }
//        if (firstFlg) {
//            if (flg) {
//                
//                myWith+=add;
//                //                NSLog(@"5width:%f", myWith);
//            }
//            else
//            {
//                myWith += (matchOne.length - location)*single;
//                //                NSLog(@"6width:%f", myWith);
//            }
//        } else{
//            myWith += matchOne.length*single + space;
//        }
//        
//    }    
//    
//}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (![myHighLightWord isHidden]) {
        //        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
    
    if (scrollView.tag != 1) {
        [self.view endEditing:YES];
        if (![explainView isHidden]) {
            [explainView setHidden:YES];
            [myHighLightWord setHidden:YES];
        }
        [self.view endEditing:YES];
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = myScroll.frame.size.width;
        int page = floor((myScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        //    if (page == 3) {
        //        //该代码是设置手机喇叭与麦克风同时工作 iphone 3.0以上版本 播放类型
        //        UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
        //        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
        //        //设置采样率的
        //        Float64 smpl=kAudioSessionProperty_CurrentHardwareSampleRate;
        //        AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, sizeof(smpl), &smpl);
        //        //设置声音输出扬声器 还是默认的接收器kAudioSessionOverrideAudioRoute_None
        //        UInt32 audioRoute = kAudioSessionOverrideAudioRoute_Speaker; 
        //        AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(UInt32), &audioRoute);
        ////        page = 1;
        //        if (isiPhone) {
        //            [myScroll scrollRectToVisible:CGRectMake(640, 0, 320, 288) animated:YES];
        //        } else {
        //            [myScroll scrollRectToVisible:CGRectMake(1536, 0, 768, 665) animated:NO];
        //        }
        //        [self aftPlay:nextButton];
        //        return;
        //    }
        if (page == 2) {
             [shareSenBtn setHidden:NO];
            [colSenBtn setHidden:NO];
        } else {
            [shareSenBtn setHidden:YES];
            [colSenBtn setHidden:YES];
        }
        
        if (page == 2) {
            //        [lyricCnLabel setNumberOfLines:cLines];
            //        [lyricLabel setNumberOfLines:eLines];
            //        NSLog(@"progress:%f",progress);
            //        NSLog(@"sen_num2:%d",sen_num);
            //        int cLines = (288-eLines * engHight-70) / engHight;
            
            //该代码是设置手机喇叭与麦克风同时工作 iphone 3.0以上版本 播放类型
//            UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
//            AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
//            //设置采样率的
//            Float64 smpl=kAudioSessionProperty_CurrentHardwareSampleRate;
//            AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, sizeof(smpl), &smpl);
//            //设置声音输出扬声器 还是默认的接收器kAudioSessionOverrideAudioRoute_None
//            UInt32 audioRoute = kAudioSessionOverrideAudioRoute_Speaker; 
//            AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(UInt32), &audioRoute);
            if ([self hasMicphone]) {
                //该代码是设置手机喇叭与麦克风同时工作 iphone 3.0以上版本 播放类型
                UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
                AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
                //设置采样率的
                Float64 smpl=kAudioSessionProperty_CurrentHardwareSampleRate;
                AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, sizeof(smpl), &smpl);
            }
            if (![self hasHeadset]) {
                //设置声音输出扬声器 还是默认的接收器kAudioSessionOverrideAudioRoute_None
                UInt32 audioRoute = kAudioSessionOverrideAudioRoute_Speaker; 
                AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(UInt32), &audioRoute);
            }
            
            double engHight = [@"a" sizeWithFont:CourierOne].height;
            double cnHight = [@"赵" sizeWithFont:CourierOne].height;
            //        NSLog(@"sen_num1:%d",sen_num);
            CMTime playerProgress = [player currentTime];
            double progress = CMTimeGetSeconds(playerProgress);
            int i = 0;
            for (; i < [timeArray count]; i++) {
                if ((int)progress < [[timeArray objectAtIndex:i] unsignedIntValue]) {
                    sen_num = i+1;//跟读标识句子号
                    recordTime = (i > 0 ? [[timeArray objectAtIndex:i] unsignedIntValue] - [[timeArray objectAtIndex:i-1] unsignedIntValue] : [[timeArray objectAtIndex:i] unsignedIntValue]) ;
                    break;
                }
            }
            //        NSLog(@"lyCnretain1:%i", [lyCn retainCount]);
            [lyCn release];
            [lyEn release];
            lyEn = [[NSString alloc] initWithFormat:@"%@", [lyricArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
            lyCn = [[NSString alloc] initWithFormat:@"%@", [lyricCnArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
            
            int eLines = 0;
            int cLines = 0;
            if (isiPhone) {
                eLines = lyEn != Nil ? [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(260, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight : 0;
                cLines = lyCn != Nil ? [lyCn sizeWithFont:CourierTwo constrainedToSize:CGSizeMake(260, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / cnHight + 1 : 0;
                [lyricScroll setContentSize:CGSizeMake(260, eLines * engHight)];
                [lyricCnScroll setContentSize:CGSizeMake(260, cLines * cnHight)];
                [lyricLabel setFrame:CGRectMake(0, 0, 260, eLines * engHight)];
                [lyricCnLabel setFrame:CGRectMake(0, 0, 260, cLines * cnHight)];
                
                //                if ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"]) {
                //                    [preButton setFrame:CGRectMake(5, 10, 30, 30)];
                //                    [nextButton setFrame:CGRectMake(115, 10, 30, 30)];
                //                } else {
                [preButton setFrame:CGRectMake(35, 10, 30, 30)];
                [nextButton setFrame:CGRectMake(255, 10, 30, 30)];
                //                }
                //                if (isiPhone) {
                
                //                }
            }else {
                eLines = lyEn != Nil ? [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(568, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight : 0;
                cLines = lyCn != Nil ? [lyCn sizeWithFont:CourierTwo constrainedToSize:CGSizeMake(568, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / cnHight + 1 : 0;
                [lyricScroll setContentSize:CGSizeMake(568, eLines * engHight)];
                [lyricCnScroll setContentSize:CGSizeMake(568, cLines * cnHight)];
                [lyricLabel setFrame:CGRectMake(0, 0, 568, eLines * engHight)];
                [lyricCnLabel setFrame:CGRectMake(0, 0, 568, cLines * cnHight)];
                
                [preButton setFrame:CGRectMake(50, 10, 70, 60)];
                [nextButton setFrame:CGRectMake(648, 10, 70, 60)];
                [preButton setImage:[UIImage imageNamed:@"preSen-iPad.png"] forState:UIControlStateNormal];
                [nextButton setImage:[UIImage imageNamed:@"nextSen-iPad.png"] forState:UIControlStateNormal];
            }
            
            lyricLabel.text = lyEn;
            //        [lyEn release];
            
            if (![lyCn isEqualToString:@"null"] && ![lyCn isEqualToString:@""] && ![lyCn isEqualToString:@"test"]) {
                lyricCnLabel.text = lyCn;
                //            [lyCn release];
            }else{
                lyricCnLabel.text = @"";
            }
            //        NSLog(@"lyCnretain2:%i", [lyCn retainCount]);
            readRecord = YES;
            [playButton setHidden:YES];
            [timeSlider setHidden:YES];
            [currentTimeLabel setHidden:YES];
            [totalTimeLabel  setHidden:YES];
            [loadProgress setHidden:YES];
//            [downloadFlg setHidden:YES];
//            [collectButton setHidden:YES];
//            [downloadingFlg setHidden:YES];
            [btn_play setHidden:NO];
            [btn_record setHidden:NO];
            [recordLabel setHidden:NO];
//            [modeBtn setHidden:YES];
            
            if ([abBtn isSelected]) {
                [self showRepeat:abBtn];
            }
            
            if ([self hasMicphone]) {
                [btn_play setEnabled:YES];
                [btn_record setEnabled:YES];
            }
            if (sen_num>1) {
                VOADetail *myVoaDetail=[VOADetail findByVoaidAndTime:self.voa._voaid timing:[[timeArray objectAtIndex:sen_num-2]unsignedIntValue]];
                [mySentence init];
                
                mySentence.SentenceId=[VOASentence findLastId]+1;
                mySentence.VoaId = myVoaDetail._voaid;
                mySentence.ParaId = myVoaDetail._paraid;
                mySentence.IdIndex = myVoaDetail._idIndex;
                mySentence.Sentence = myVoaDetail._sentence;
//                shareStr = myVoaDetail._sentence;
                mySentence.Sentence_cn = myVoaDetail._sentence_cn;
//                shareStr = myVoaDetail._sentence;
//                NSLog(@"%d,%d",sen_num,[timeArray count]);
//                NSLog(@"%d,%d,%d,%d",mySentence.SentenceId,mySentence.VoaId,mySentence.ParaId,mySentence.IdIndex);
                mySentence.StartTime = [[timeArray objectAtIndex:sen_num-2]unsignedIntValue];
                if ([timeArray count]>sen_num) {
                    mySentence.EndTime = [[timeArray objectAtIndex:sen_num-1]unsignedIntValue];
                }else{
                    mySentence.EndTime = 1800 ;//默认30分钟
                }
//                NSLog(@"%d,%d,%d,%d,%d,%d,%d,%@",self.voa._voaid,[[timeArray objectAtIndex:sen_num-2]unsignedIntValue],myVoaDetail._voaid,myVoaDetail._paraid,myVoaDetail._idIndex,mySentence.StartTime,mySentence.EndTime,mySentence.Sentence);
            } else {
                VOADetail *myVoaDetail=[VOADetail findByVoaidAndTime:self.voa._voaid timing:[[timeArray objectAtIndex:0]unsignedIntValue]];
                [mySentence init];
                
                mySentence.SentenceId=[VOASentence findLastId]+1;
                mySentence.VoaId = myVoaDetail._voaid;
                mySentence.ParaId = myVoaDetail._paraid;
                mySentence.IdIndex = myVoaDetail._idIndex;
                mySentence.Sentence = myVoaDetail._sentence;
//                shareStr = myVoaDetail._sentence;
                mySentence.Sentence_cn = myVoaDetail._sentence_cn;
//                NSLog(@"%d,%d",sen_num,[timeArray count]);
//                NSLog(@"%d,%d,%d,%d",mySentence.SentenceId,mySentence.VoaId,mySentence.ParaId,mySentence.IdIndex);
                mySentence.StartTime = [[timeArray objectAtIndex:0]unsignedIntValue];
                if ([timeArray count]>sen_num-1) {
                    mySentence.EndTime = [[timeArray objectAtIndex:sen_num]unsignedIntValue];
                }else{
                    mySentence.EndTime = 1800 ;//默认30分钟
                }
//                NSLog(@"%d,%d,%d,%d,%d,%d,%d,%@",self.voa._voaid,[[timeArray objectAtIndex:0]unsignedIntValue],myVoaDetail._voaid,myVoaDetail._paraid,myVoaDetail._idIndex,mySentence.StartTime,mySentence.EndTime,mySentence.Sentence);
            }
            
            

            //        [controller.lvlMeter_in setHidden:NO];
        }else {
            
            //此种模式下无法播放的同时录音
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
            if (isiPhone) {
                [preButton setFrame:CGRectMake(245, 10, 25, 25)];
                [nextButton setFrame:CGRectMake(285, 10, 25, 25)];
                [preButton setImage:[UIImage imageNamed:@"preSen.png"] forState:UIControlStateNormal];
                [nextButton setImage:[UIImage imageNamed:@"nextSen.png"] forState:UIControlStateNormal];
            
            } else {
                [preButton setFrame:CGRectMake(588, 10, 70, 60)];
                [nextButton setFrame:CGRectMake(678, 10, 70, 60)];
                [preButton setImage:[UIImage imageNamed:@"preSen-iPad.png"] forState:UIControlStateNormal];
                [nextButton setImage:[UIImage imageNamed:@"nextSen-iPad.png"] forState:UIControlStateNormal];
            }
            
            [self myStopRecord];
            [self stopPlayRecord];
            
            if ([self isPlaying]) {
                if (notValid) {
                    lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
                                                                     target:self 
                                                                   selector:@selector(lyricSyn) 
                                                                   userInfo:nil 
                                                                    repeats:YES];
                    sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                                   target:self
                                                                 selector:@selector(updateSlider)
                                                                 userInfo:nil 
                                                                  repeats:YES];
                    notValid = NO;
                }
//                if ([lyricSynTimer isValid]) {
//                    
//                }else {
//#if 1
//                    lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
//                                                                     target:self 
//                                                                   selector:@selector(lyricSyn) 
//                                                                   userInfo:nil 
//                                                                    repeats:YES];
//#endif
//                }
//                
//                if ([sliderTimer isValid]) {
//                    
//                }else {
//#if 1
//                    sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
//                                                                   target:self
//                                                                 selector:@selector(updateSlider)
//                                                                 userInfo:nil 
//                                                                  repeats:YES];
//#endif
//                }

            }
            readRecord = NO;
            [playButton setHidden:NO];
            [timeSlider setHidden:NO];
            [currentTimeLabel setHidden:NO];
            [totalTimeLabel  setHidden:NO];
            [loadProgress setHidden:NO];
            [btn_play setHidden:YES];
            [btn_record setHidden:YES];
            [recordLabel setHidden:YES];
//            [modeBtn setHidden:NO];
            if ([self hasMicphone]) {
                [btn_play setEnabled:NO];
                [btn_record setEnabled:NO];
            }
            //        [controller.lvlMeter_in setHidden:YES];
            if (localFileExist) {
                [downloadFlg setHidden:NO];
            } else{
                int i=0;
                for (; i<[downLoadList count]; i++) {
                    int downloadid = [[downLoadList objectAtIndex:i]intValue];
                    if (downloadid ==voa._voaid) {
                        break;
                    }
                }
                if (i<[downLoadList count])  {
                    [downloadingFlg setHidden:NO];
                } else {
                    [collectButton setHidden:NO];
                }

            }
                
        }
        [UIView beginAnimations:@"Switch" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:.5];
        switch (page) {
            case 0:
                [RoundBack setCenter:CGPointMake(btnOne.center.x, btnOne.center.y)];
                //                NSLog(@"page:%d",page);
                break;
            case 1:
                [RoundBack setCenter:CGPointMake(btnTwo.center.x, btnTwo.center.y)];
                //                NSLog(@"page:%d",page);
                break;
            case 2:
                [RoundBack setCenter:CGPointMake(btnThree.center.x, btnThree.center.y)];
                //                NSLog(@"page:%d",page);
                break;
            case 3:
                [RoundBack setCenter:CGPointMake(btnFour.center.x, btnFour.center.y)];
                //                NSLog(@"page:%d",page);
                break;
            default:
                break;
        }
        
//        int deviation = 5;
//        if (isiPhone) {
//            [RoundBack setImage:[UIImage imageNamed:@"RoundBack.png"]];
//            
//        } else {
//            [RoundBack setImage:[UIImage imageNamed:@"RoundBack-iPad.png"]];
//            
//        }
//        if (pageControl.currentPage>page) {
////            if (isiPhone) {
////                [RoundBack setImage:[UIImage imageNamed:@"RoundBackTwo.png"]];
////
////            } else {
////                [RoundBack setImage:[UIImage imageNamed:@"RoundBackTwo-iPad.png"]];
////
////            }
//                        deviation = 0;
//        } else {
////            if (isiPhone) {
////                [RoundBack setImage:[UIImage imageNamed:@"RoundBack.png"]];
////            } else {
////                [RoundBack setImage:[UIImage imageNamed:@"RoundBack-iPad.png"]];
////            }
//            
//            deviation = 5;
//        }
//        switch (page) {
//            case 0:
//                [RoundBack setCenter:CGPointMake(btnOne.center.x-deviation, btnOne.center.y)];
////                NSLog(@"page:%d",page);
//                break;
//            case 1:
//                [RoundBack setCenter:CGPointMake(btnTwo.center.x-deviation, btnTwo.center.y)];
////                NSLog(@"page:%d",page);
//                break;
//            case 2:
//                [RoundBack setCenter:CGPointMake(btnThree.center.x-deviation, btnThree.center.y)];
////                NSLog(@"page:%d",page);
//                break;
//            case 3:
//                [RoundBack setCenter:CGPointMake(btnFour.center.x-deviation, btnFour.center.y)];
////                NSLog(@"page:%d",page);
//                break;
//            default:
//                break;
//        }
        
        [UIView commitAnimations];
        
        pageControl.currentPage = page;
        [pageControl updateAfterScroll];
        
        
        /**
         *  更新系统的pageControl图片时用如下方法.
         */
        /*NSArray *subView = pageControl.subviews;     // UIPageControl的每个点
         for (int i = 0; i < [subView count]; i++) {
         UIImageView *dot = [subView objectAtIndex:i];
         dot.image = (pageControl.currentPage == i ? [UIImage imageNamed:@"RedPoint.png"] : [UIImage imageNamed:@"BluePoint.png"]);
         }*/
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (![explainView isHidden]) {
        //        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
    
    if (scrollView.tag != 1) {
        [self.view endEditing:YES];
        if (![explainView isHidden]) {
            [explainView setHidden:YES];
            [myHighLightWord setHidden:YES];
        }
        [self.view endEditing:YES];
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = myScroll.frame.size.width;
        int page = floor((myScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        //    if (page == 3) {
        //        //该代码是设置手机喇叭与麦克风同时工作 iphone 3.0以上版本 播放类型
        //        UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
        //        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
        //        //设置采样率的
        //        Float64 smpl=kAudioSessionProperty_CurrentHardwareSampleRate;
        //        AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, sizeof(smpl), &smpl);
        //        //设置声音输出扬声器 还是默认的接收器kAudioSessionOverrideAudioRoute_None
        //        UInt32 audioRoute = kAudioSessionOverrideAudioRoute_Speaker; 
        //        AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(UInt32), &audioRoute);
        ////        page = 1;
        //        if (isiPhone) {
        //            [myScroll scrollRectToVisible:CGRectMake(640, 0, 320, 288) animated:YES];
        //        } else {
        //            [myScroll scrollRectToVisible:CGRectMake(1536, 0, 768, 665) animated:NO];
        //        }
        //        [self aftPlay:nextButton];
        //        return;
        //    }
        if (page == 2) {
            [shareSenBtn setHidden:NO];

            [colSenBtn setHidden:NO];
        } else {
            [shareSenBtn setHidden:YES];

            [colSenBtn setHidden:YES];
        }
        
        if (page == 2) {
            //        [lyricCnLabel setNumberOfLines:cLines];
            //        [lyricLabel setNumberOfLines:eLines];
            //        NSLog(@"progress:%f",progress);
            //        NSLog(@"sen_num2:%d",sen_num);
            //        int cLines = (288-eLines * engHight-70) / engHight;
            
            //该代码是设置手机喇叭与麦克风同时工作 iphone 3.0以上版本 播放类型
//            UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
//            AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
//            //设置采样率的
//            Float64 smpl=kAudioSessionProperty_CurrentHardwareSampleRate;
//            AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, sizeof(smpl), &smpl);
//            //设置声音输出扬声器 还是默认的接收器kAudioSessionOverrideAudioRoute_None
//            UInt32 audioRoute = kAudioSessionOverrideAudioRoute_Speaker; 
//            AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(UInt32), &audioRoute);
            
            if ([self hasMicphone]) {
                //该代码是设置手机喇叭与麦克风同时工作 iphone 3.0以上版本 播放类型
                UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
                AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
                //设置采样率的
                Float64 smpl=kAudioSessionProperty_CurrentHardwareSampleRate;
                AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, sizeof(smpl), &smpl);
            }
            if (![self hasHeadset]) {
                //设置声音输出扬声器 还是默认的接收器kAudioSessionOverrideAudioRoute_None
                UInt32 audioRoute = kAudioSessionOverrideAudioRoute_Speaker; 
                AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(UInt32), &audioRoute);
            }
            
            double engHight = [@"a" sizeWithFont:CourierOne].height;
            
            //        NSLog(@"sen_num1:%d",sen_num);
            CMTime playerProgress = [player currentTime];
            double progress = CMTimeGetSeconds(playerProgress);
            double cnHight = [@"赵" sizeWithFont:CourierOne].height;
            int i = 0;
            for (; i < [timeArray count]; i++) {
                if ((int)progress < [[timeArray objectAtIndex:i] unsignedIntValue]) {
                    sen_num = i+1;//跟读标识句子号
                    recordTime = (i > 0 ? [[timeArray objectAtIndex:i] unsignedIntValue] - [[timeArray objectAtIndex:i-1] unsignedIntValue] : [[timeArray objectAtIndex:i] unsignedIntValue]) ;
                    break;
                }
            }
            //        NSLog(@"lyCnretain1:%i", [lyCn retainCount]);
            [lyCn release];
            [lyEn release];
            lyEn = [[NSString alloc] initWithFormat:@"%@", [lyricArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
            lyCn = [[NSString alloc] initWithFormat:@"%@", [lyricCnArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
            
            int eLines = 0;
            int cLines = 0;
            if (isiPhone) {
                eLines = lyEn != Nil ? [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(260, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight : 0;
                cLines = lyCn != Nil ? [lyCn sizeWithFont:CourierTwo constrainedToSize:CGSizeMake(260, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / cnHight + 1 : 0;
                [lyricScroll setContentSize:CGSizeMake(260, eLines * engHight)];
                [lyricCnScroll setContentSize:CGSizeMake(260, cLines * cnHight)];
                [lyricLabel setFrame:CGRectMake(0, 0, 260, eLines * engHight)];
                [lyricCnLabel setFrame:CGRectMake(0, 0, 260, cLines * cnHight)];
                
                //                if ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"]) {
                //                    [preButton setFrame:CGRectMake(5, 10, 30, 30)];
                //                    [nextButton setFrame:CGRectMake(115, 10, 30, 30)];
                //                } else {
                [preButton setFrame:CGRectMake(35, 10, 30, 30)];
                [nextButton setFrame:CGRectMake(255, 10, 30, 30)];
                //                }
                [preButton setImage:[UIImage imageNamed:@"preSen.png"] forState:UIControlStateNormal];
                [nextButton setImage:[UIImage imageNamed:@"nextSen.png"] forState:UIControlStateNormal];
            }else {
                eLines = lyEn != Nil ? [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(568, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight : 0;
                cLines = lyCn != Nil ? [lyCn sizeWithFont:CourierTwo constrainedToSize:CGSizeMake(568, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / cnHight + 1 : 0;
                [lyricScroll setContentSize:CGSizeMake(568, eLines * engHight)];
                [lyricCnScroll setContentSize:CGSizeMake(568, cLines * cnHight)];
                [lyricLabel setFrame:CGRectMake(0, 0, 568, eLines * engHight)];
                [lyricCnLabel setFrame:CGRectMake(0, 0, 568, cLines * cnHight)];
                
                [preButton setFrame:CGRectMake(50, 10, 70, 60)];
                [nextButton setFrame:CGRectMake(648, 10, 70, 60)];
                [preButton setImage:[UIImage imageNamed:@"preSen-iPad.png"] forState:UIControlStateNormal];
                [nextButton setImage:[UIImage imageNamed:@"nextSen-iPad.png"] forState:UIControlStateNormal];
                
            }
            
            lyricLabel.text = lyEn;
            //        [lyEn release];
            
            if (![lyCn isEqualToString:@"null"] && ![lyCn isEqualToString:@""] && ![lyCn isEqualToString:@"test"]) {
                lyricCnLabel.text = lyCn;
                //            [lyCn release];
            }else{
                lyricCnLabel.text = @"";
            }
            //        NSLog(@"lyCnretain2:%i", [lyCn retainCount]);
            readRecord = YES;
            [playButton setHidden:YES];
            [timeSlider setHidden:YES];
            [currentTimeLabel setHidden:YES];
            [totalTimeLabel  setHidden:YES];
            [loadProgress setHidden:YES];
            [downloadFlg setHidden:YES];
            [collectButton setHidden:YES];
            [downloadingFlg setHidden:YES];
            [btn_play setHidden:NO];
            [btn_record setHidden:NO];
            [recordLabel setHidden:NO];
//            [modeBtn setHidden:YES];
            
            if ([abBtn isSelected]) {
                [self showRepeat:abBtn];
            }
            
            if ([self hasMicphone]) {
                [btn_play setEnabled:YES];
                [btn_record setEnabled:YES];
            }
            if (sen_num>1) {
                VOADetail *myVoaDetail=[VOADetail findByVoaidAndTime:self.voa._voaid timing:[[timeArray objectAtIndex:sen_num-2]unsignedIntValue]];
                [mySentence init];
                
                mySentence.SentenceId=[VOASentence findLastId]+1;
                mySentence.VoaId = myVoaDetail._voaid;
                mySentence.ParaId = myVoaDetail._paraid;
                mySentence.IdIndex = myVoaDetail._idIndex;
                mySentence.Sentence = myVoaDetail._sentence;
//                shareStr = myVoaDetail._sentence;
                    mySentence.Sentence_cn = myVoaDetail._sentence_cn;
//                NSLog(@"%d,%d",sen_num,[timeArray count]);
//                NSLog(@"%d,%d,%d,%d",mySentence.SentenceId,mySentence.VoaId,mySentence.ParaId,mySentence.IdIndex);
                mySentence.StartTime = [[timeArray objectAtIndex:sen_num-2]unsignedIntValue];
                if ([timeArray count]>sen_num) {
                    mySentence.EndTime = [[timeArray objectAtIndex:sen_num-1]unsignedIntValue];
                }else{
                    mySentence.EndTime = 1800 ;//默认30分钟
                }
//                NSLog(@"%d,%d,%d,%d,%d,%d,%d,%@",self.voa._voaid,[[timeArray objectAtIndex:sen_num-2]unsignedIntValue],myVoaDetail._voaid,myVoaDetail._paraid,myVoaDetail._idIndex,mySentence.StartTime,mySentence.EndTime,mySentence.Sentence);
            } else {
                VOADetail *myVoaDetail=[VOADetail findByVoaidAndTime:self.voa._voaid timing:[[timeArray objectAtIndex:0]unsignedIntValue]];
                [mySentence init];
                
                mySentence.SentenceId=[VOASentence findLastId]+1;
                mySentence.VoaId = myVoaDetail._voaid;
                mySentence.ParaId = myVoaDetail._paraid;
                mySentence.IdIndex = myVoaDetail._idIndex;
                mySentence.Sentence = myVoaDetail._sentence;
//                shareStr = myVoaDetail._sentence;
                mySentence.Sentence_cn = myVoaDetail._sentence_cn;
//                NSLog(@"%d,%d",sen_num,[timeArray count]);
//                NSLog(@"%d,%d,%d,%d",mySentence.SentenceId,mySentence.VoaId,mySentence.ParaId,mySentence.IdIndex);
                mySentence.StartTime = [[timeArray objectAtIndex:0]unsignedIntValue];
                if ([timeArray count]>sen_num-1) {
                    mySentence.EndTime = [[timeArray objectAtIndex:sen_num]unsignedIntValue];
                }else{
                    mySentence.EndTime = 1800 ;//默认30分钟
                }
//                NSLog(@"%d,%d,%d,%d,%d,%d,%d,%@",self.voa._voaid,[[timeArray objectAtIndex:0]unsignedIntValue],myVoaDetail._voaid,myVoaDetail._paraid,myVoaDetail._idIndex,mySentence.StartTime,mySentence.EndTime,mySentence.Sentence);
            }
            //        [controller.lvlMeter_in setHidden:NO];
        }else {
            //此种模式下无法播放的同时录音
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
            if (isiPhone) {
                [preButton setFrame:CGRectMake(245, 10, 25, 25)];
                [nextButton setFrame:CGRectMake(285, 10, 25, 25)];
                [preButton setImage:[UIImage imageNamed:@"preSen.png"] forState:UIControlStateNormal];
                [nextButton setImage:[UIImage imageNamed:@"nextSen.png"] forState:UIControlStateNormal];
            } else {
                [preButton setFrame:CGRectMake(588, 10, 70, 60)];
                [nextButton setFrame:CGRectMake(678, 10, 70, 60)];
                [preButton setImage:[UIImage imageNamed:@"preSen-iPad.png"] forState:UIControlStateNormal];
                [nextButton setImage:[UIImage imageNamed:@"nextSen-iPad.png"] forState:UIControlStateNormal];
            }
            
            [self myStopRecord];
            [self stopPlayRecord];
            if ([self isPlaying]) {
                if (notValid) {
                    lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
                                                                     target:self 
                                                                   selector:@selector(lyricSyn) 
                                                                   userInfo:nil 
                                                                    repeats:YES];
                    sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                                   target:self
                                                                 selector:@selector(updateSlider)
                                                                 userInfo:nil 
                                                                  repeats:YES];
                    notValid = NO;
                }
//                if ([lyricSynTimer isValid]) {
//                    
//                }else {
//#if 1
//                    lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
//                                                                     target:self 
//                                                                   selector:@selector(lyricSyn) 
//                                                                   userInfo:nil 
//                                                                    repeats:YES];
//#endif
//                }
//                
//                if ([sliderTimer isValid]) {
//                    
//                }else {
//#if 1
//                    sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
//                                                                   target:self
//                                                                 selector:@selector(updateSlider)
//                                                                 userInfo:nil 
//                                                                  repeats:YES];
//#endif
//                }

            }
            readRecord = NO;
            [playButton setHidden:NO];
            [timeSlider setHidden:NO];
            [currentTimeLabel setHidden:NO];
            [totalTimeLabel  setHidden:NO];
            [loadProgress setHidden:NO];
            [btn_play setHidden:YES];
            [btn_record setHidden:YES];
            [recordLabel setHidden:YES];
//            [modeBtn setHidden:NO];
            if ([self hasMicphone]) {
                [btn_play setEnabled:NO];
                [btn_record setEnabled:NO];
            }
            //        [controller.lvlMeter_in setHidden:YES];
            if (localFileExist) {
                [downloadFlg setHidden:NO];
            } else if ([VOAView isDownloading:voa._voaid]) {
                [downloadingFlg setHidden:NO];
            } else {
                [collectButton setHidden:NO];
            }
        }
        
//        float deviation = 5.0;
//        if (isiPhone) {
//            [RoundBack setImage:[UIImage imageNamed:@"RoundBack.png"]];
//            
//        } else {
//            [RoundBack setImage:[UIImage imageNamed:@"RoundBack-iPad.png"]];
//            
//        }
//        if (pageControl.currentPage>page) {
////            if (isiPhone) {
////                [RoundBack setImage:[UIImage imageNamed:@"RoundBackTwo.png"]];
////
////            } else {
////                [RoundBack setImage:[UIImage imageNamed:@"RoundBackTwo-iPad.png"]];
////
////            }
//                        deviation = 0.0;
//        }else{
////            if (isiPhone) {
////                [RoundBack setImage:[UIImage imageNamed:@"RoundBack.png"]];
////
////            } else {
////                [RoundBack setImage:[UIImage imageNamed:@"RoundBack-iPad.png"]];
////
////            }
//                        deviation = 5.0;
//        }
        pageControl.currentPage = page;
        [UIView beginAnimations:@"Switch" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:.5];
        switch (page) {
            case 0:
                [RoundBack setCenter:CGPointMake(btnOne.center.x, btnOne.center.y)];
                //                NSLog(@"page:%d",page);
                break;
            case 1:
                [RoundBack setCenter:CGPointMake(btnTwo.center.x, btnTwo.center.y)];
                //                NSLog(@"page:%d",page);
                break;
            case 2:
                [RoundBack setCenter:CGPointMake(btnThree.center.x, btnThree.center.y)];
                //                NSLog(@"page:%d",page);
                break;
            case 3:
                [RoundBack setCenter:CGPointMake(btnFour.center.x, btnFour.center.y)];
                //                NSLog(@"page:%d",page);
                break;
            default:
                break;
        }
//        switch (page) {
//            case 0:
//                [RoundBack setCenter:CGPointMake(btnOne.center.x-deviation, btnOne.center.y)];
//                break;
//            case 1:
//                [RoundBack setCenter:CGPointMake(btnTwo.center.x-deviation, btnTwo.center.y)];
//                break;
//            case 2:
//                [RoundBack setCenter:CGPointMake(btnThree.center.x-deviation, btnThree.center.y)];
//                break;
//            case 3:
//                [RoundBack setCenter:CGPointMake(btnFour.center.x-deviation, btnFour.center.y)];
//                break;
//            default:
//                break;
//        }
        
        [UIView commitAnimations];
        [pageControl updateAfterScroll];

        
        /**
         *  更新系统的pageControl图片时用如下方法.
         */
        /*NSArray *subView = pageControl.subviews;     // UIPageControl的每个点
         for (int i = 0; i < [subView count]; i++) {
         UIImageView *dot = [subView objectAtIndex:i];
         dot.image = (pageControl.currentPage == i ? [UIImage imageNamed:@"RedPoint.png"] : [UIImage imageNamed:@"BluePoint.png"]);
         }*/
    }
    //    NSLog(@"222");
}


//- (void)scrollViewDidScroll:(UIScrollView *)sender
//{
//    // Switch the indicator when more than 50% of the previous/next page is visible
//    CGFloat pageWidth = myScroll.frame.size.width;
//    int page = floor((myScroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
////    if (page == 3) {
////        //该代码是设置手机喇叭与麦克风同时工作 iphone 3.0以上版本 播放类型
////        UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
////        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
////        //设置采样率的
////        Float64 smpl=kAudioSessionProperty_CurrentHardwareSampleRate;
////        AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, sizeof(smpl), &smpl);
////        //设置声音输出扬声器 还是默认的接收器kAudioSessionOverrideAudioRoute_None
////        UInt32 audioRoute = kAudioSessionOverrideAudioRoute_Speaker; 
////        AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(UInt32), &audioRoute);
//////        page = 1;
////        if (isiPhone) {
////            [myScroll scrollRectToVisible:CGRectMake(640, 0, 320, 288) animated:YES];
////        } else {
////            [myScroll scrollRectToVisible:CGRectMake(1536, 0, 768, 665) animated:NO];
////        }
////        [self aftPlay:nextButton];
////        return;
////    }
//    if (page == 2) {
//        //        [lyricCnLabel setNumberOfLines:cLines];
//        //        [lyricLabel setNumberOfLines:eLines];
//        //        NSLog(@"progress:%f",progress);
//        //        NSLog(@"sen_num2:%d",sen_num);
//        //        int cLines = (288-eLines * engHight-70) / engHight;
//        
//        //该代码是设置手机喇叭与麦克风同时工作 iphone 3.0以上版本 播放类型
//        UInt32 audioCategory = kAudioSessionCategory_PlayAndRecord;
//        AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(audioCategory), &audioCategory);
//        //设置采样率的
//        Float64 smpl=kAudioSessionProperty_CurrentHardwareSampleRate;
//        AudioSessionSetProperty(kAudioSessionProperty_PreferredHardwareSampleRate, sizeof(smpl), &smpl);
//        //设置声音输出扬声器 还是默认的接收器kAudioSessionOverrideAudioRoute_None
//        UInt32 audioRoute = kAudioSessionOverrideAudioRoute_Speaker; 
//        AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(UInt32), &audioRoute);
//        
//        double engHight = [@"a" sizeWithFont:CourierOne].height;
//        
////        NSLog(@"sen_num1:%d",sen_num);
//        CMTime playerProgress = [player currentTime];
//        double progress = CMTimeGetSeconds(playerProgress);
//        int i = 0;
//        for (; i < [timeArray count]; i++) {
//            if ((int)progress < [[timeArray objectAtIndex:i] unsignedIntValue]) {
//                sen_num = i+1;//跟读标识句子号
//                recordTime = (i > 0 ? [[timeArray objectAtIndex:i] unsignedIntValue] - [[timeArray objectAtIndex:i-1] unsignedIntValue] : [[timeArray objectAtIndex:i] unsignedIntValue]) ;
//                break;
//            }
//        }
////        NSLog(@"lyCnretain1:%i", [lyCn retainCount]);
//        [lyCn release];
//        [lyEn release];
//        lyEn = [[NSString alloc] initWithFormat:@"%@", [lyricArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
//        lyCn = [[NSString alloc] initWithFormat:@"%@", [lyricCnArray objectAtIndex:(sen_num>2?sen_num-2:0)]];
//        
//        int eLines = 0;
//        
//        if (isiPhone) {
//            eLines = [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(260, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight;
//            [lyricLabel setFrame:CGRectMake(670, 20, 260, eLines * engHight)];
//            [lyricCnLabel setFrame:CGRectMake(670, 20+eLines * engHight, 260, 268-eLines * engHight)];
//            
//            [preButton setFrame:CGRectMake(15, 353, 45, 35)];
//            [nextButton setFrame:CGRectMake(260, 353, 45, 35)];
//            if (isiPhone) {
//                [preButton setImage:[UIImage imageNamed:@"preSen@2x.png"] forState:UIControlStateNormal];
//                [nextButton setImage:[UIImage imageNamed:@"nextSen@2x.png"] forState:UIControlStateNormal];
//            }
//        }else {
//            eLines = [lyEn sizeWithFont:CourierOne constrainedToSize:CGSizeMake(568, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight;
//            [lyricLabel setFrame:CGRectMake(1636, 50, 568, eLines * engHight)];
//            [lyricCnLabel setFrame:CGRectMake(1636, 50+eLines * engHight, 568, 615-eLines * engHight)];
//            
//            [preButton setFrame:CGRectMake(41, 841, 120, 58)];
//            [nextButton setFrame:CGRectMake(583, 841, 120, 58)];
//        }
//        
//        lyricLabel.text = lyEn;
////        [lyEn release];
//        
//        if (![lyCn isEqualToString:@"null"] && ![lyCn isEqualToString:@""] && ![lyCn isEqualToString:@"test"]) {
//            lyricCnLabel.text = lyCn;
////            [lyCn release];
//        }else{
//            lyricCnLabel.text = @"";
//        }
////        NSLog(@"lyCnretain2:%i", [lyCn retainCount]);
//        readRecord = YES;
//        [playButton setHidden:YES];
//        [timeSlider setHidden:YES];
//        [currentTimeLabel setHidden:YES];
//        [totalTimeLabel  setHidden:YES];
//        [loadProgress setHidden:YES];
//        [downloadFlg setHidden:YES];
//        [collectButton setHidden:YES];
//        [downloadingFlg setHidden:YES];
////        [controller.btn_play setHidden:NO];
////        [controller.btn_record setHidden:NO];
////        [controller.lvlMeter_in setHidden:NO];
//    }else {
//        //此种模式下无法播放的同时录音
//        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//        if (isiPhone) {
//            [preButton setFrame:CGRectMake(70, 380, 50, 29)];
//            [nextButton setFrame:CGRectMake(200, 380, 50, 29)];
//            if (isiPhone) {
//                [preButton setImage:[UIImage imageNamed:@"preSen.png"] forState:UIControlStateNormal];
//                [nextButton setImage:[UIImage imageNamed:@"nextSen.png"] forState:UIControlStateNormal];
//            }
//        } else {
//            [preButton setFrame:CGRectMake(192, 855, 120, 58)];
//            [nextButton setFrame:CGRectMake(445, 855, 120, 58)];
//        }
//        
//        [self stopRecord];
//        if ([self isPlaying]) {
//            if ([lyricSynTimer isValid]) {
//                
//            }else {
//#if 1
//                lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
//                                                                 target:self 
//                                                               selector:@selector(lyricSyn) 
//                                                               userInfo:nil 
//                                                                repeats:YES];
//#endif
//            }
//        }
//        readRecord = NO;
//        [playButton setHidden:NO];
//        [timeSlider setHidden:NO];
//        [currentTimeLabel setHidden:NO];
//        [totalTimeLabel  setHidden:NO];
//        [loadProgress setHidden:NO];
//        [btn_play setHidden:YES];
//        [btn_record setHidden:YES];
////        [controller.lvlMeter_in setHidden:YES];
//        if (localFileExist) {
//            [downloadFlg setHidden:NO];
//        } else if ([VOAView isDownloading:voa._voaid]) {
//            [downloadingFlg setHidden:NO];
//        } else {
//            [collectButton setHidden:NO];
//        }
//    }
//    
//    pageControl.currentPage = page;
//    [pageControl updateAfterScroll];
//    
//    /**
//     *  更新系统的pageControl图片时用如下方法.
//     */
//    /*NSArray *subView = pageControl.subviews;     // UIPageControl的每个点
//    for (int i = 0; i < [subView count]; i++) {
//		UIImageView *dot = [subView objectAtIndex:i];
//		dot.image = (pageControl.currentPage == i ? [UIImage imageNamed:@"RedPoint.png"] : [UIImage imageNamed:@"BluePoint.png"]);
//	}*/
//}

#pragma mark - AVAudioSessionDelegate
- (void)beginInterruption
{
//    NSLog(@"beginInterruption");
    isInterupted = YES;
//    if (localFileExist) {
//    [player pause];
//    if (isiPhone) {
//        [playButton setImage:[UIImage imageNamed:@"PpausePressed.png"] forState:UIControlStateNormal];
//    } else {
//        [playButton setImage:[UIImage imageNamed:@"PpausePressed-iPad.png"] forState:UIControlStateNormal];
//    }
    
//    if (readRecord) {
//        NSLog(@"后台");
//        [controller stopRecord];
//    }
//    }
//    else {
//        [player pause];
////        [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
//    }
//    [playButton setImage:[UIImage imageNamed:@"PpausePressed.png"] forState:UIControlStateNormal];
//    [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
}

- (void)endInterruption
{
//    if (readRecord) {
//        [player play];
//        if (isiPhone) {
//            [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
//        } else {
//            [playButton setImage:[UIImage imageNamed:@"PplayPressed-iPad.png"] forState:UIControlStateNormal];
//        }
//    }
//     NSLog(@"endInterruption");
//    if (localFileExist) {
//        [playButton setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];
//        [localPlayer play];
//    }else {
////        [player pause];
//    }
}

#pragma mark - Motion
/*
 * 检测振动，控制播放
 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
//    NSLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:@"shakeCtrlPlay"]);
    if ((motion == UIEventSubtypeMotionShake)&&([[NSUserDefaults standardUserDefaults] boolForKey:@"shakeCtrlPlay"]))
    {
//        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"title" message:@"this is a test." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [servicesDisabledAlert show];
//        [servicesDisabledAlert release];
        if (readRecord) {
//            [player pause];
//            [playButton setImage:[UIImage imageNamed:@"PpausePressed.png"] forState:UIControlStateNormal];
        } else {
            [self playButtonPressed:playButton]; 
        }
    }
}

//- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//    if (motion == UIEventSubtypeMotionShake)
//    {
//        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"title" message:@"this is a test." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [servicesDisabledAlert show];
//        [servicesDisabledAlert release];
//    }
//}
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
//    if (isShareSen) {
//        switch (buttonIndex) {
//            case 0:
//                [self collectThisSentence];
//                break;
//            case 1://新浪微博
//                // 微博分享：
//                [self shareAll];
//                break;
//            case 2:
//                //人人分享：
//                [self ShareThisQuestion];
//                break;
//            default:
//                break;
//        }
//
//        
//    } else {
        switch (buttonIndex) {
            case 0://新浪微博
                // 微博分享：
//                NSLog(@"weibo");
                [self shareAll];
                break;
            case 1:
                //人人分享：
                [self ShareThisQuestion];
                break;
            default:
                break;
        }

//    }
    }

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
 numberOfRowsInSection:(NSInteger)section {
    return ([commArray count]/6 + 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
//    if (tableView.tag==1) {
//        if (![explainView isHidden]) {
//            [explainView setHidden:YES];
//            [myHighLightWord setHidden:YES];
//        }
//        UIFont *defFo = [UIFont systemFontOfSize:14];
//        UIFont *defFoPad = [UIFont systemFontOfSize:18];
//        UIFont *wordFo = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
//        UIFont *wordFoPad = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:20];
//        static NSString *FirstLevelCell= @"AnswerCell";
//        UITableViewCell *tablecell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
//        if (!tablecell) {
//            tablecell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstLevelCell] autorelease];
//            //            UILabel *defLabel = [[UILabel alloc] init];
//            //            UILabel *wordLabel = [[UILabel alloc] init];
//            MyLabel *defLabel = [[MyLabel alloc] init];
//            MyLabel *wordLabel = [[MyLabel alloc] init];
//            defLabel.delegate = self;
//            wordLabel.delegate = self;
//            if (isiPhone) {
//                [wordLabel setFrame:CGRectMake(30, 0, 290, 20)];
//                [defLabel setFrame:CGRectMake(30, 20, 290, 40)];
//                [wordLabel setFont:wordFo];
//                [defLabel setFont:defFo];
//            } else {
//                [wordLabel setFrame:CGRectMake(100, 0, 568, 30)];
//                [defLabel setFrame:CGRectMake(100, 30, 568, 70)];
//                [wordLabel setFont:wordFoPad];
//                [defLabel setFont:defFoPad];
//            }
//            
//            [wordLabel setBackgroundColor:[UIColor clearColor]];
//            [wordLabel setTag:1];
//            [wordLabel setTextColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
//            //            [wordLabel setTextColor:[UIColor colorWithRed:0.112f green:0.112f blue:0.112f alpha:1.0f]];
//            [wordLabel  setLineBreakMode:UILineBreakModeClip];
//            [wordLabel setNumberOfLines:1];
//            [tablecell addSubview:wordLabel];
//            [wordLabel release];
//            
//            [defLabel setBackgroundColor:[UIColor clearColor]];
//            [defLabel setTag:2];
//            [defLabel setTextColor:[UIColor colorWithRed:0.28f green:0.28f blue:0.28f alpha:1.0f]];
//            [defLabel setLineBreakMode:UILineBreakModeClip];
//            [defLabel setNumberOfLines:3];
//            [tablecell addSubview:defLabel];
//            [defLabel release];
//            
//        }
//        
//        for (UIView *nLabel in [tablecell subviews]) {
//            
//            if (nLabel.tag == 1) {
//                [(MyLabel*)nLabel setText:[listData objectAtIndex:row*2]];
//            }
//            if (nLabel.tag == 2) {
//                MyLabel *myDef = (MyLabel*)nLabel ;
//                NSString *que = [listData objectAtIndex:1+row*2];
//                [myDef setText:que];
//                [myDef setBackgroundColor:[UIColor clearColor]];
//                int engHight = [@"a" sizeWithFont:myDef.font].height;
//                int eLines = [que sizeWithFont:myDef.font constrainedToSize:CGSizeMake(myDef.frame.size.width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap].height / engHight;
//                [myDef setNumberOfLines:eLines];
//                if (isiPhone) {
//                    [myDef setFrame:CGRectMake(30, 20, 290, eLines * engHight)];
//                }else {
//                    [myDef setFrame:CGRectMake(100, 30, 568, eLines * engHight)];
//                }
//                
//                [(UILabel*)nLabel setText:[listData objectAtIndex:1+row*2]];
//            }
//            
//        }
//        [tablecell setBackgroundColor:[UIColor clearColor]];
//        [tablecell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        return tablecell;
//    } else {
        if (row == [commArray count]/6) {
            static NSString *ThirdLevelCell= @"NewCellTwo";
            UITableViewCell *cellThree = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:ThirdLevelCell];
            if (!cellThree) {
                cellThree = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ThirdLevelCell] autorelease];
            }
            [cellThree setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cellThree setHidden:YES];
            if (nowPage < totalPage) {
                [self catchComments:++nowPage];
            }
            return cellThree;
        } else {
            UIFont *Courier = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:12];
            UIFont *CourierF = [UIFont systemFontOfSize:12];
            UIFont *Couriera = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:15];
            UIFont *CourieraF = [UIFont systemFontOfSize:15];
            static NSString *FirstLevelCell= @"CommentCell";
            UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
            if (!cell) {
                if (isiPhone) {
                    cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstLevelCell] autorelease];
                    
                    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 120, 15)];
                    [nameLabel setBackgroundColor:[UIColor clearColor]];
                    [nameLabel setFont:Courier];
                    [nameLabel setTag:1];
                    [nameLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
                    [nameLabel setNumberOfLines:2];
                    [cell addSubview:nameLabel];
                    [nameLabel release];
                    
                    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 65, 15)];
                    [dateLabel setBackgroundColor:[UIColor clearColor]];
                    [dateLabel setFont:CourierF];
                    [dateLabel setTag:2];
                    [dateLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
                    [dateLabel setNumberOfLines:2];
                    [cell addSubview:dateLabel];
                    [dateLabel release];
                    
                    UILabel *comLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, 240, 45)];
                    [comLabel setBackgroundColor:[UIColor clearColor]];
                    [comLabel setFont:CourierF];
                    [comLabel setTag:3];
                    [comLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
                    [comLabel setNumberOfLines:4];
                    [comLabel setLineBreakMode:UILineBreakModeWordWrap];
                    [cell addSubview:comLabel];
                    [comLabel release];
                    
                    UIImageView *userImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
                    [userImg setTag:4];
                    [userImg whenTapped:^{
//                        NSLog(@"发信 %i", userImg.superview.tag);
                        for (int i = 0; i < [commArray count]/6; i++) {
                            if (((NSString*)[commArray objectAtIndex:i*6]).integerValue == userImg.superview.tag) {
                                int fromUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
                                UserMessage *userMsg = [[UserMessage alloc] initWithFromUserId:fromUserId fromUserName:[MyUser findNameById:fromUserId] toUserId:[[commArray objectAtIndex:i*6+5] integerValue] toUserName:(NSString *) [commArray objectAtIndex:i*6+1] comment:[commArray objectAtIndex:i*6+3] topicId:voa._voaid];
                                SendMessageController *sendMsgController = [[SendMessageController alloc] init];
                                sendMsgController.userMsg = userMsg;
                                [self.navigationController pushViewController:sendMsgController animated:YES];
//                                NSLog(@"发信 %@", [NSString stringWithFormat:@"回复%@:", [commArray objectAtIndex:i*6+1]]);
                            }
                        }
//                        NSLog(@"发信 %@", [commArray objectAtIndex:row*6+1]);
                    }];
                    [cell addSubview:userImg];
                    [userImg release];
                    
                    UIButton *reponseBtn = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 30, 20)];
                    [reponseBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
//                    [reponseBtn.titleLabel setTextColor:[UIColor blackColor]];
                    [reponseBtn setTitleColor:[UIColor colorWithRed:0.216f green:0.471f blue:0.686f alpha:1.0f] forState:UIControlStateNormal];
                    [reponseBtn setTitle:kPlayNine forState:UIControlStateNormal];
//                    [reponseBtn setBackgroundColor:[UIColor whiteColor]];
                    [reponseBtn addTarget:self action:@selector(doResponse:) forControlEvents:UIControlEventTouchUpInside];
                    [reponseBtn setTag:5];
                    [cell addSubview:reponseBtn];
                    [reponseBtn release];
                    
                }else {
                    cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstLevelCell] autorelease];
                    
                    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, 120, 20)];
                    [nameLabel setBackgroundColor:[UIColor clearColor]];
                    [nameLabel setFont:Couriera];
                    [nameLabel setTag:1];
                    [nameLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
                    [nameLabel setNumberOfLines:2];
                    [cell addSubview:nameLabel];
                    [nameLabel release];
                    
                    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(648, 0, 120, 20)];
                    [dateLabel setBackgroundColor:[UIColor clearColor]];
                    [dateLabel setFont:CourieraF];
                    [dateLabel setTag:2];
                    [dateLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
                    [dateLabel setNumberOfLines:2];
                    [cell addSubview:dateLabel];
                    [dateLabel release];
                    
                    UILabel *comLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 648, 60)];
                    [comLabel setBackgroundColor:[UIColor clearColor]];
                    [comLabel setFont:CourieraF];
                    [comLabel setTag:3];
                    [comLabel setTextColor:[UIColor colorWithRed:71.0/255 green:71.0/255 blue:72.0/255 alpha:1.0f]];
                    [comLabel setNumberOfLines:4];
                    [comLabel setLineBreakMode:UILineBreakModeWordWrap];
                    [cell addSubview:comLabel];
                    [comLabel release];
                    
                    UIImageView *userImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
                    [userImg setTag:4];
                    [userImg whenTapped:^{
                        //                        NSLog(@"发信 %i", userImg.superview.tag);
                        for (int i = 0; i < [commArray count]/6; i++) {
                            if (((NSString*)[commArray objectAtIndex:i*6]).integerValue == userImg.superview.tag) {
                                int fromUserId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
                                UserMessage *userMsg = [[UserMessage alloc] initWithFromUserId:fromUserId fromUserName:[MyUser findNameById:fromUserId] toUserId:[[commArray objectAtIndex:i*6+5] integerValue] toUserName:(NSString *) [commArray objectAtIndex:i*6+1] comment:[commArray objectAtIndex:i*6+3] topicId:voa._voaid];
                                SendMessageController *sendMsgController = [[SendMessageController alloc] init];
                                sendMsgController.userMsg = userMsg;
                                [self.navigationController pushViewController:sendMsgController animated:YES];
//                                NSLog(@"发信 %@", [NSString stringWithFormat:@"回复%@:", [commArray objectAtIndex:i*6+1]]);
                            }
                        }
                        //                        NSLog(@"发信 %@", [commArray objectAtIndex:row*6+1]);
                    }];
                    [cell addSubview:userImg];
                    [userImg release];
                    
                    UIButton *reponseBtn = [[UIButton alloc] initWithFrame:CGRectMake(718, 10, 40, 30)];
                    [reponseBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
                    //                    [reponseBtn.titleLabel setTextColor:[UIColor blackColor]];
                    [reponseBtn setTitleColor:[UIColor colorWithRed:55.0/255 green:120.0/255 blue:175.0/255 alpha:1.0f] forState:UIControlStateNormal];
                    [reponseBtn setTitle:kPlayNine forState:UIControlStateNormal];
                    //                    [reponseBtn setBackgroundColor:[UIColor whiteColor]];
                    [reponseBtn addTarget:self action:@selector(doResponse:) forControlEvents:UIControlEventTouchUpInside];
                    [reponseBtn setTag:5];
                    [cell addSubview:reponseBtn];
                    [reponseBtn release];
                }
            }
            for (UIView *nLabel in [cell subviews]) {
                if (nLabel.tag == 1) {
                    [(UILabel*)nLabel setText:[commArray objectAtIndex:row*6+1]];
                }
                if (nLabel.tag == 2) {
                    [(UILabel*)nLabel setText:[commArray objectAtIndex:row*6+4]];
                }
                if (nLabel.tag == 3) {
                    [(UILabel*)nLabel setText:[commArray objectAtIndex:row*6+3]];
                }
                if (nLabel.tag == 4) {
                    [(UIImageView*)nLabel setImageWithURL:[commArray objectAtIndex:row*6+2] placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
                }
            }
            
//            [cell.imageView setImageWithURL:[commArray objectAtIndex:row*5+2] placeholderImage:[UIImage imageNamed:@"acquiesce.png"]];
            [cell setTag:[[commArray objectAtIndex:row*6] integerValue]];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
//    }
    
    return nil;
}

#pragma mark -
#pragma mark TableView Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([indexPath row] < [commArray count]/6 ? (isiPhone?kCommTableHeightPh:80.0f) : 1);
}

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    if ([keyCommFd isFirstResponder]) {
    [self.view endEditing:YES];
    //    }
    if (![explainView isHidden]) {
        [explainView setHidden:YES];
        [myHighLightWord setHidden:YES];
    }
}

//#pragma mark - TableViewDelegate and DataSource
//- (NSInteger)tableView:(UITableView *)tableView //明确cell数目
// numberOfRowsInSection:(NSInteger)section {
//    return listData.count/2;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
//    NSInteger row = [indexPath row];
//    UIFont *defFo = [UIFont systemFontOfSize:14];
//    UIFont *wordFo = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:16];
//    static NSString *FirstLevelCell= @"AnswerCell";
//    UITableViewCell *tablecell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:FirstLevelCell];
//    if (!tablecell) {
//        tablecell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FirstLevelCell] autorelease];
//        
//        UILabel *wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 290, 20)];
//        [wordLabel setBackgroundColor:[UIColor clearColor]];
//        [wordLabel setFont:wordFo];
//        [wordLabel setTag:1];
//        [wordLabel setTextColor:[UIColor blackColor]];
//        [wordLabel  setLineBreakMode:UILineBreakModeClip];
//        [wordLabel setNumberOfLines:1];
//        [tablecell addSubview:wordLabel];
//        [wordLabel release];
//        
//        UILabel *defLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 290, 40)];
//        [defLabel setBackgroundColor:[UIColor clearColor]];
//        [defLabel setFont:defFo];
//        [defLabel setTag:2];
//        [defLabel setTextColor:[UIColor blackColor]];
//        [defLabel setLineBreakMode:UILineBreakModeClip];
//        [defLabel setNumberOfLines:3];
//        [tablecell addSubview:defLabel];
//        [defLabel release];
//        
//    }
//    
//    for (UIView *nLabel in [tablecell subviews]) {
//        
//        if (nLabel.tag == 1) {
//            [(UILabel*)nLabel setText:[listData objectAtIndex:row*2]];
//        }
//        if (nLabel.tag == 2) {
//            [(UILabel*)nLabel setText:[listData objectAtIndex:1+row*2]];
//        }
//        
//    }
//    [tablecell setBackgroundColor:[UIColor clearColor]];
//    [tablecell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    return tablecell;
//    
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60.0f;
//}

#pragma mark - HPGrowingTextViewDelegate
//-(void)resignTextView
//{
//	[textView resignFirstResponder];
//}

//Code from Brett Schumann
-(void) keyboardWillShow:(NSNotification *)note{
    // get keyboard size and loctaion
//    NSLog(@"键盘出");
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.myScroll convertRect:keyboardBounds toView:nil];
    
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.myScroll.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height) + (isiPhone? (isFree?90.0f:40.0f):(isFree?169.0f:79.0f));
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    //    [UIView setAnimationCurve:[curve intValue]];
	
	// set views with new info
	containerView.frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.myScroll.bounds.size.height - containerFrame.size.height;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    //    [UIView setAnimationCurve:[curve intValue]];
    
	// set views with new info
	containerView.frame = containerFrame;
	
	// commit animations
	[UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	containerView.frame = r;
}

- (void)growingTextViewDidBeginEditing:(HPGrowingTextView *)growingTextView {
    int nowUserID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"nowUser"] integerValue];
    if ([[growingTextView text] isEqualToString:@"写评论"]) {
        [growingTextView setText:@""];
    }
    if (nowUserID > 0) {
        if ([[growingTextView text] length] > 0 && [[growingTextView text] rangeOfString:@"回复"].location == NSNotFound) {
            [self sendComments];
        }
    } else {
        [growingTextView setText:@""];
    }
    
}

//- (BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView {
//    [growingTextView setText:@""];
//    return YES;
//}

//#pragma mark - UITextFieldDelegate
//- (void)textFieldDidBeginEditing:(UITextField *)textField  
//{ //当点触textField内部，开始编辑都会调用这个方法。textField将成为first responder   
//    /*
//    //    NSDictionary *info = [notification userInfo];  
//    //    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;  
//    //    CGFloat distanceToMove = kbSize.height - normalKeyboardHeight; 
//    NSTimeInterval animationDuration = 0.30f;      
//    CGRect frame = myView.frame; 
//    if (isiPhone) {
//        //        frame.origin.y -=216;        
//        //        frame.size. height +=216; 
////        frame.origin.y -=246;        
////        frame.size. height +=246; 
//        frame.origin.y -=124;        
//        frame.size. height +=124; 
//    } else {
//        //        frame.origin.y -=264;        
//        //        frame.size. height +=264; 
//        //        frame.origin.y -=294;        
//        //        frame.size. height +=294; 
//        frame.origin.y -=94;        
//        frame.size. height +=94; 
//    }  
//    myView.tag = 1;
////    self.view.frame = frame;  
//    [UIView beginAnimations:@"ResizeView" context:nil];  
//    [UIView setAnimationDuration:animationDuration];  
//    myView.frame = frame;                  
//    [UIView commitAnimations];    
//     */
////    [inputText resignFirstResponder];
////    [keyCommFd becomeFirstResponder];
//}  
//
- (BOOL)textFieldShouldReturn:(UITextField *)textField   
{//当用户按下ruturn，把焦点从textField移开那么键盘就会消失了  
    //    NSTimeInterval animationDuration = 0.30f;  
    //    CGRect frame = self.view.frame; 
    //    if (isiPhone) {
    //        frame.origin.y +=216;        
    //        frame.size. height -=216; 
    //    } else {
    //        frame.origin.y +=264;        
    //        frame.size. height -=264; 
    //    }     
    //    self.view.frame = frame;  
    //    //self.view移回原位置    
    //    [UIView beginAnimations:@"ResizeView" context:nil];  
    //    [UIView setAnimationDuration:animationDuration];  
    //    self.view.frame = frame;                  
    //    [UIView commitAnimations];  
    //    [textField resignFirstResponder]; 
    [self.view endEditing:YES];
    return YES;
}


#pragma mark - Picker Data Source Methods
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return component == kHourComponent?[self.hoursArray count]:(component == kMinComponent?[self.minsArray count]:[self.secsArray count]);
}

#pragma mark - Picker Delegate Methods
- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return component == kHourComponent?[self.hoursArray objectAtIndex:row]:(component == kMinComponent?[self.minsArray objectAtIndex:row]:[self.secsArray objectAtIndex:row]);
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    [HUD release];
	HUD = nil;
}

//#pragma mark - UITextDelegate Methods
//- (void)textViewDidChangeSelection:(UITextView *)textViewOne {
//    if(textViewOne.selectedRange.length>0) {
//        selectWord = [textViewOne.text substringWithRange:textViewOne.selectedRange];
//        [selectWord retain];
//        NSLog(@"ChangeSelection:%@", selectWord);
//    }
//}

//- (BOOL)textViewShouldBeginEditing:(UITextView *)textViewOne {
//    if(textViewOne.selectedRange.length>0) {
////        selectWord = [textViewOne.text substringWithRange:textViewOne.selectedRange];
////        [selectWord retain];
//        NSLog(@"BeginEditing:%@", [textViewOne.text substringWithRange:textViewOne.selectedRange]);
//    }
//    return NO;
//}


#pragma mark background
//- (void)applicationWillResignActive:(UIApplication *)application
//{
//    /*
//     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//     */
//    NSLog(@"EnterBackground");
////    [lyricSynTimer invalidate];
////    [sliderTimer invalidate];
//    //    PlayViewController *play = [PlayViewController sharedPlayer];
//    //    [play stopRecord];
////    NSLog(@"appplicationWillResignActive");
//////    [controller stopRecord];
//////    [controller myStopRecord];
////    if ([controller isRecording]) {
//////        controller.recorder->StopRecord();
////        [controller stopRecord];
////    }
////    controller.recorder->StopRecord();
//}

#pragma mark Record action

- (IBAction)recordTouch:(UIButton *)sender
{
//    NSLog(@"录音");
    if ([sender.titleLabel.text isEqualToString:@"recording"]) {
        [btn_record setTitle:@"record" forState:UIControlStateNormal];
        
        [self stopRecord];
    } else {
        [btn_record setTitle:@"recording" forState:UIControlStateNormal];
        [self startToRecord];
    }
}

- (void) myStopRecord {
    if (m_isRecording) {
        m_isRecording = NO;
        if (isiPhone) {
            [btn_record setImage:[UIImage imageNamed:@"startRecord.png"] forState:UIControlStateNormal];
        } else {
            [btn_record setImage:[UIImage imageNamed:@"startRecord-iPad.png"] forState:UIControlStateNormal];
        }
        
        //    [self changeRecordTimer];
        [self stopRecordTimer];
        dispatch_queue_t stopQueue;
        stopQueue = dispatch_queue_create("stopQueue", NULL);
        dispatch_async(stopQueue, ^(void){
            //run in main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [audioRecoder stopRecord];
                [btn_play setEnabled:YES];
                
            });
        });    
        dispatch_release(stopQueue);
    }
}

- (void) stopRecord {
//    NSLog(@"结束录音");
    if (m_isRecording) {
        m_isRecording = NO;
        //    if (isiPhone) {
        //        [btn_record setImage:[UIImage imageNamed:@"startRecordBBC.png"] forState:UIControlStateNormal];
        //    } else {
        //        [btn_record setImage:[UIImage imageNamed:@"startRecordBBCP.png"] forState:UIControlStateNormal];
        //    }
        if (isiPhone) {
            [btn_record setImage:[UIImage imageNamed:@"startRecord.png"] forState:UIControlStateNormal];
        } else {
            [btn_record setImage:[UIImage imageNamed:@"startRecord-iPad.png"] forState:UIControlStateNormal];
        }
        
        
        [self stopRecordTimer];
        dispatch_queue_t stopQueue;
        stopQueue = dispatch_queue_create("stopQueue", NULL);
        dispatch_async(stopQueue, ^(void){
            //run in main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [audioRecoder stopRecord];
                [btn_play setEnabled:YES];
            });
        });    
        dispatch_release(stopQueue);
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"recordRead"]) {
            [btn_play setTitle:@"stop" forState:UIControlStateNormal];
            [self performSelector:@selector(playRecord) withObject:nil afterDelay:0.5f];
            //        [self playRecord];
        }
//#if 1
//        lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
//                                                         target:self 
//                                                       selector:@selector(lyricSyn) 
//                                                       userInfo:nil 
//                                                        repeats:YES];
//#endif
//#if 1
//        sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
//                                                       target:self
//                                                     selector:@selector(updateSlider)
//                                                     userInfo:nil 
//                                                      repeats:YES];
//#endif
    }
//    if ([lyricSynTimer isValid]) {
//        
//    }else {
//#if 1
//        lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
//                                                         target:self 
//                                                       selector:@selector(lyricSyn) 
//                                                       userInfo:nil 
//                                                        repeats:YES];
//#endif
//    }
//    
//    if ([sliderTimer isValid]) {
//        
//    }else {
//#if 1
//        sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
//                                                       target:self
//                                                     selector:@selector(updateSlider)
//                                                     userInfo:nil 
//                                                      repeats:YES];
//#endif
//    }
    //    AVAudioSession *session = [AVAudioSession sharedInstance];
    //    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //    
    //    player = [[AVPlayer alloc] initWithPlayerItem:[AVPlayerItem  playerItemWithAsset:avSet] ];
    
}

//- (void) stopRecordPlay {
//    //    [controller stopPlayQueue];
//}

- (void)startToRecord
{
//    NSLog(@"开始录音");
    if (player) {
//        NSLog(@"干掉播放器");
        nowTime = [player currentTime];
//        for (int  i = [player retainCount]; i > 0; i--) {
            [player release];
//        }
//        NSLog(@"干掉播放器:%i", [player retainCount]);
        player = nil;
    }
//    [player pause];
    if (wordPlayer) {
        [wordPlayer release];
        wordPlayer = nil;
    }
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord error:nil];
    
    if (m_isRecording == NO)
    {
        if (!notValid) {
            //        if ([lyricSynTimer isValid]) {
            [lyricSynTimer invalidate];
            //        }
            //        if ([sliderTimer isValid]) {
            [sliderTimer invalidate];
            //        }
            notValid = YES;
        }

        m_isRecording = YES;
        NSString *recordAudioFullPath = [kRecorderDirectory stringByAppendingPathComponent:
                                         [NSString stringWithFormat:@"recordAudio.wav"]];
        //        NSString *recordAudioFullPath = [kRecorderDirectory stringByAppendingPathComponent:
        //                                         [NSString stringWithFormat:@"recordAudio.caf"]];
        NSLock* tempLock = [[NSLock alloc]init];
        [tempLock lock];
        if ([[NSFileManager defaultManager] fileExistsAtPath:recordAudioFullPath]) 
        {
            [[NSFileManager defaultManager] removeItemAtPath:recordAudioFullPath error:nil];
        }
        [tempLock unlock];
//        afterRecord = YES;
//        if (isiPhone) {
//            [btn_record setImage:[UIImage imageNamed:@"stopRecordBBC.png"] forState:UIControlStateNormal];
//        } else {
//            [btn_record setImage:[UIImage imageNamed:@"stopRecordBBCP.png"] forState:UIControlStateNormal];
//        }
        if (isiPhone) {
            [btn_record setImage:[UIImage imageNamed:@"stopRecord.png"] forState:UIControlStateNormal];

        } else {
            [btn_record setImage:[UIImage imageNamed:@"stopRecord-iPad.png"] forState:UIControlStateNormal];

        }
        dispatch_queue_t stopQueue;
        stopQueue = dispatch_queue_create("stopQueue", NULL);
        dispatch_async(stopQueue, ^(void){
            //run in main thread
            dispatch_async(dispatch_get_main_queue(), ^{
        
                
                [self changeRecordTimer];
                [audioRecoder startRecord];
                [btn_play setEnabled:NO];
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"recordRead"]) {
                    NSTimer *timer = nil;
                    timer = [NSTimer scheduledTimerWithTimeInterval:(isiPhone?(recordTime*1.3):((recordTime*1.3)>7?(recordTime*1.3):8)) target:self selector:@selector(stopRecord) userInfo:nil repeats:NO];
                }
                if (!isiPhone) { //ipad版本需要最少录制八秒才可播放
                    [btn_record setEnabled:NO];
                    NSTimer *timer = nil;
                    timer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(recordEnable) userInfo:nil repeats:NO];
                }
            });
        });
        dispatch_release(stopQueue);

    }
    
}

- (void)recordEnable
{
    [btn_record setEnabled:YES];
}

- (IBAction)recordPlayTouch:(UIButton *)sender
{
//    NSLog(@"播放录音");
    if ([sender.titleLabel.text isEqualToString:@"stop"]) {
        [btn_play setTitle:@"play" forState:UIControlStateNormal];
        [self stopPlayRecord];
    } else {
        [btn_play setTitle:@"stop" forState:UIControlStateNormal];
        [self playRecord];
    }
}

- (void)playRecord
{
//    NSLog(@"play");
    NSString *recordAudioFullPath = [kRecorderDirectory stringByAppendingPathComponent:
                                     [NSString stringWithFormat:@"recordAudio.wav"]];
    ////    NSLock* tempLock = [[NSLock alloc]init];
    ////    [tempLock lock];
    if ([[NSFileManager defaultManager] fileExistsAtPath:recordAudioFullPath]) 
    {
//        NSLog(@"文件存在");
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        if (wordPlayer) {
            [wordPlayer release];
            wordPlayer = nil;
        }
        
        wordPlayer = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:[kRecorderDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"recordAudio.wav"]]]];
        [self changePlayRecordTimer];
        [wordPlayer play];
        
//        if (isiPhone) {
//            [btn_play setImage:[UIImage imageNamed:@"PplayPressedBBC.png"] forState:UIControlStateNormal];
//        } else {
//            [btn_play setImage:[UIImage imageNamed:@"PplayPressedBBCP.png"] forState:UIControlStateNormal];
//        }
        if (isiPhone) {
            [btn_play setImage:[UIImage imageNamed:@"PplayPressed.png"] forState:UIControlStateNormal];

        } else {
            [btn_play setImage:[UIImage imageNamed:@"PplayPressed-iPad.png"] forState:UIControlStateNormal];

        }
    
    }else {
//        NSLog(@"文件不存在");
    }
    //    [tempLock unlock];
    //    player = [AVPlayer playerWithURL:[NSURL URLWithString:[kRecorderDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"recordAudio.aac"]]]];
    
}

- (void)stopPlayRecord
{
//    if (isiPhone) {
//        [btn_play setImage:[UIImage imageNamed:@"playingBBC.png"] forState:UIControlStateNormal];
//        
//    } else {
//        [btn_play setImage:[UIImage imageNamed:@"playingBBCP.png"] forState:UIControlStateNormal];
//    }
    if (isiPhone) {
        [btn_play setImage:[UIImage imageNamed:@"playRecord.png"] forState:UIControlStateNormal];

    } else {
        [btn_play setImage:[UIImage imageNamed:@"return-iPad.png"] forState:UIControlStateNormal];

    }
    
    [self stopPlayRecordTimer];
    [wordPlayer pause];
//    if ([lyricSynTimer isValid]) {
//        
//    }else {
//#if 1
//        lyricSynTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 
//                                                         target:self 
//                                                       selector:@selector(lyricSyn) 
//                                                       userInfo:nil 
//                                                        repeats:YES];
//#endif
//    }
////    
//    if ([sliderTimer isValid]) {
//        
//    }else {
//#if 1
//        sliderTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
//                                                       target:self
//                                                     selector:@selector(updateSlider)
//                                                     userInfo:nil 
//                                                      repeats:YES];
//#endif
//    }
}

-(void)changeRecordTimer
{
    //    //时间间隔
    //    NSTimeInterval timeInterval =1.0 ;
    //定时器
    if ([recordTimer isValid]) {
        [recordTimer invalidate];
//        recordTimer = nil;
    } else {
        [self stopPlayRecord];
        recordSeconds = 0 ;
        [recordLabel setText:[timeSwitchClass timeToSwitchAdvance:0]];
        recordTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                       target:self
                                                     selector:@selector(handleRecordTimer)
                                                     userInfo:nil
                                                      repeats:YES];
    }
}

-(void)stopRecordTimer
{
    //    //时间间隔
    //    NSTimeInterval timeInterval =1.0 ;
    //定时器
    if ([recordTimer isValid]) {
        [recordTimer invalidate];
        recordTimer = nil;
    } 
}

-(void) handleRecordTimer {
    recordSeconds++;
    [recordLabel setText:[timeSwitchClass timeToSwitchAdvance:recordSeconds]];
}

-(void)changePlayRecordTimer
{
    //    //时间间隔
    //    NSTimeInterval timeInterval =1.0 ;
    //定时器
    if ([playRecordTimer isValid]) {
        [playRecordTimer invalidate];
        playRecordTimer = nil;
        [recordLabel setText:[timeSwitchClass timeToSwitchAdvance:0]];
    } 
    nowRecordSeconds = recordSeconds;
    [recordLabel setText:[timeSwitchClass timeToSwitchAdvance:nowRecordSeconds]];
    playRecordTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                   target:self
                                                 selector:@selector(handlePlayRecordTimer)
                                                 userInfo:nil
                                                  repeats:YES];
}

-(void)stopPlayRecordTimer
{
    //    //时间间隔
    //    NSTimeInterval timeInterval =1.0 ;
    //定时器
    if ([playRecordTimer isValid]) {
        [playRecordTimer invalidate];
        playRecordTimer = nil;
        [recordLabel setText:[timeSwitchClass timeToSwitchAdvance:0]];
    } 
}

-(void) handlePlayRecordTimer {
    
    nowRecordSeconds--;
    //    NSLog(@"%d", recordSeconds);
    [recordLabel setText:[timeSwitchClass timeToSwitchAdvance:nowRecordSeconds]];
    if (nowRecordSeconds < 1) {
//        if (isiPhone) {
//            [btn_play setImage:[UIImage imageNamed:@"playingBBC.png"] forState:UIControlStateNormal];
//        } else {
//            [btn_play setImage:[UIImage imageNamed:@"playingBBCP.png"] forState:UIControlStateNormal];
//        }
        if (isiPhone) {
            [btn_play setImage:[UIImage imageNamed:@"playRecord.png"] forState:UIControlStateNormal];
        } else {
            [btn_play setImage:[UIImage imageNamed:@"return-iPad.png"] forState:UIControlStateNormal];
        }
        
        if ([playRecordTimer isValid]) {
            [playRecordTimer invalidate];
            playRecordTimer = nil;
            [recordLabel setText:[timeSwitchClass timeToSwitchAdvance:0]];
        }
    }
}

//#pragma mark - debug
//#ifdef _FOR_DEBUG_  
//-(BOOL) respondsToSelector:(SEL)aSelector {  
//    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);  
//    return [super respondsToSelector:aSelector];  
//}  
//#endif 


@end
