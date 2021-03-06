//
//  PlayViewControl.h
//  VOA
//  “播放”容器
//  Created by song zhao on 12-2-6.
//  Copyright (c) 2012年 buaa. All rights reserved.
//

#import "VOAView.h"
#import "VOAFav.h"
#import "VOADetail.h"
#import "UIImageView+WebCache.h" //联网图片缓存
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h> 
#import "timeSwitchClass.h"
#import "DataBaseClass.h"
#import "LyricSynClass.h"
#import "MP3PlayerClass.h"
#import "VOAContent.h"
#import "ASIFormDataRequest.h"
#import "TextScrollView.h"
#import "MyLabel.h"
#import "DDXML.h"
#import "DDXMLElementAdditions.h"
#import "VOAWord.h"
#import "MBProgressHUD.h"
//#import "AudioStreamer.h"
#import "Reachability.h"//isExistenceNetwork
#import "LogController.h"
#import "MyPageControl.h" //自定义页面控制组件
#import "GADBannerView.h" //内置广告
#import "SevenProgressBar.h" //自定义缓冲进度条
#import "ShareToCNBox.h"
#import "SVShareTool.h"
#include <AudioToolbox/AudioToolbox.h>
//#import "CommentViewController.h"
#import "HPGrowingTextView.h"   //评论的自动放大的输入框
#import "NSString+URLEncoding.h" //字符串的URL编解码
#import "CL_AudioRecorder.h"
#import "LocalWord.h"
#import "VOASentence.h"
#import "HSCButton.h" //可拖动的按钮
//#import "MyPickerView.h"
//#import "MyTextView.h"
#import "JMWhenTapped.h"    //给视图添加事件
#import "UserMessage.h"
#import "SendMessageController.h"
#import "InnerBuyController.h" 
//#include <sys/xattr.h>

@class timeSwitchClass;
//@class SpeakHereController;
@class CL_AudioRecorder;

//pickerView的三个编号
#define kHourComponent 0 
#define kMinComponent 1
#define kSecComponent 2
#define kCommTableHeightPh 60.0
#define kRecorderDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]  stringByAppendingPathComponent:@"Recorders"]
#define kBufferSize 8192

@interface PlayViewController : UIViewController <UIAlertViewDelegate, AVAudioPlayerDelegate,ASIHTTPRequestDelegate,MyLabelDelegate,MBProgressHUDDelegate,UIScrollViewDelegate,AVAudioSessionDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,MBProgressHUDDelegate,HPGrowingTextViewDelegate,HSCButtonDelegate, UITextViewDelegate>
{
    CL_AudioRecorder* audioRecoder;
    BOOL              m_isRecording;
    AVAsset *avSet;
    CMTime nowTime;
    
    VOAView *voa;
    
    UIImageView     *myImageView;
//    UIImageView     *wordFrame;
    
    UITableView *commTableView;
    
    HPGrowingTextView *textView;
    
//    UIPickerView *myPick;
    UIPickerView *myPick;
    
    UIView     *viewOne;
    UIView     *viewTwo;
    UIView     *myView;
    UIView *containerView;
    UIView *fixTimeView;
    UIView *bottomView;
    UIImageView *senImage;
    UIImageView *starImage;
    
    UIImage     *playImage;
    UIImage     *pauseImage;
    UIImage     *loadingImage;
    
    UIButton		*collectButton;
    UIButton		*playButton;
    UIButton        *preButton;
    UIButton        *nextButton;
    UIButton        *fixButton;
    UIButton        *clockButton;
    UIButton		*btn_record;
    UIButton		*btn_play;
    UIButton		*downloadFlg;
    UIButton        *downloadingFlg;
    UIButton        *modeBtn;
    UIButton        *displayModeBtn;
    UIButton        *shareSenBtn;
    UIButton        *colSenBtn;
    
//    UILabel      *downloadFlg;
//    UILabel      *downloadingFlg;
    UILabel			*totalTimeLabel;//总时间
	UILabel			*currentTimeLabel;//当前时间
    UILabel     *myHighLightWord;
    UILabel *recordLabel;
    MyLabel *explainView;
    MyLabel *lyricLabel;
    UILabel *lyricCnLabel; 
    
    TextScrollView	*textScroll;
    TextScrollView	*myScroll;
    
    timeSwitchClass *timeSwitch;
    
	UISlider		*timeSlider;//时间滑块
    SevenProgressBar  *loadProgress;//缓冲进度
    
    NSTimer			*sliderTimer;
	NSTimer			*lyricSynTimer;
    NSTimer         *fixTimer;
    NSTimer         *recordTimer;
    NSTimer         *playRecordTimer;
    
//    NSTimer         *loadTimer;
    
    NSMutableArray	*lyricArray;
    NSMutableArray	*lyricCnArray;
	NSMutableArray	*timeArray;
	NSMutableArray	*indexArray;
	NSMutableArray	*lyricLabelArray;
    NSMutableArray	*lyricCnLabelArray;
    NSMutableArray    *listArray;
    NSMutableArray *commArray;
    NSMutableData* mp3Data;
    NSArray         *hoursArray;
    NSArray         *minsArray;
    NSArray         *secsArray;
    
//	int				engLines;
//    int				cnLines;
    int             playerFlag;
    int             fixSeconds;
    int             recordSeconds;
    int             nowRecordSeconds;
    int             recordTime;
    
    NSInteger nowPage;
    NSInteger nowUserId;
    NSInteger totalPage;
//    NSInteger commNumber;
    
    AVPlayer	*player;
//    AVPlayer	*localPlayer;
    AVPlayer	*wordPlayer;
    
	NSURL			*mp3Url;
    
    BOOL localFileExist;
    BOOL downloaded;
    BOOL newFile;
//    BOOL switchFlg;
    BOOL needFlush;
    BOOL needFlushAdv;
//    BOOL isExisitNet;
    BOOL noBuffering;
    BOOL isiPhone;
    BOOL readRecord;
    BOOL isNewComm;
//    BOOL afterRecord;
    BOOL isFixing;
    BOOL flushList;
    BOOL isFree;
    BOOL notValid;
    BOOL isShareSen;
    
    NSString *userPath;
    
    VOAWord *myWord;
    
    MBProgressHUD *HUD;
    
    UITextView *imgWords;
    UITextView *titleWords;
    
    double myStop;
    double seekTo;
    
    UIAlertView *alert;
    
    NSNotificationCenter *myCenter;
    
    MyPageControl *pageControl;
    
    GADBannerView *bannerView_;
    
//    SpeakHereController *controller;
    
    NSInteger sen_num;
    NSInteger contentMode;
    NSInteger playMode;
    NSInteger playIndex;
    NSInteger category;
    
    NSString *lyEn;
    NSString *lyCn;
//    NSString *category;
    NSString *shareStr;
    
    UIFont *CourierOne;
    UIFont *CourierTwo;
    
    VOASentence *mySentence;
//    CFURLRef		soundFileURLRef;
//	SystemSoundID	soundFileObject;
//    
//    float time_total;
}
//@property (nonatomic, retain) IBOutlet SpeakHereController *controller;
@property (nonatomic, retain) UIButton		*collectButton; //下载按钮
@property (nonatomic, retain) IBOutlet UIButton        *preButton;  //上一句按钮
@property (nonatomic, retain) IBOutlet UIButton        *nextButton; //下一句按钮
//四个页面按钮
@property (nonatomic, retain) IBOutlet UIButton        *btnOne; 
@property (nonatomic, retain) IBOutlet UIButton        *btnTwo;
@property (nonatomic, retain) IBOutlet UIButton        *btnThree;
@property (nonatomic, retain) IBOutlet UIButton        *btnFour;
@property (nonatomic, retain) IBOutlet UIButton		*btn_record;    //录音按钮
@property (nonatomic, retain) IBOutlet UIButton		*btn_play;  //播放录音按钮

@property (nonatomic, retain) IBOutlet UIButton        *toolBtn;    //工具按钮
@property (nonatomic, retain) IBOutlet UIButton        *abBtn;  //复读按钮
@property (nonatomic, retain) IBOutlet HSCButton        *aBtn;  //复读a按钮
@property (nonatomic, retain) IBOutlet HSCButton        *bBtn;  //复读b按钮
@property (nonatomic, retain) IBOutlet UISlider		*lightSlider;   //屏幕亮度调节
@property (nonatomic, retain) IBOutlet UISlider		*speedSlider;   //播放速度调节
@property (nonatomic, retain) IBOutlet UIView       *toolView;  //工具栏视图

@property (nonatomic, retain) IBOutlet TextScrollView	*myScroll;
@property (nonatomic, retain) IBOutlet MyPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UILabel			*totalTimeLabel;//总时间
@property (nonatomic, retain) IBOutlet UILabel			*currentTimeLabel;//当前时间
@property (nonatomic, retain) IBOutlet UILabel *recordLabel;
@property (nonatomic, retain) IBOutlet UISlider		*timeSlider;//时间滑块

@property (nonatomic, retain) IBOutlet UIButton		*playButton;    //播放按钮
//@property (nonatomic, retain) IBOutlet UILabel      *downloadFlg;
//@property (nonatomic, retain) IBOutlet UILabel      *downloadingFlg;
@property (nonatomic, retain) IBOutlet UITextView *titleWords;  //新闻标题
@property (nonatomic, retain) IBOutlet UIImageView *RoundBack;  //四个页面按钮的标识图片
@property (nonatomic, retain) IBOutlet UIView *fixTimeView; //定时视图
@property (nonatomic, retain) IBOutlet UIView *bottomView;  //界面底栏
@property (nonatomic, retain) IBOutlet UIPickerView *myPick;    //设置定时的滑轮
@property (nonatomic, retain) IBOutlet UIButton  *fixButton;    //开启定时按钮
@property (nonatomic, retain) IBOutlet UIButton    *modeBtn;    //播放模式选择按钮
@property (nonatomic, retain) IBOutlet UIButton  *displayModeBtn;   //播放模式展示

@property (nonatomic, retain) UITextView        *nowTextView; //
@property (nonatomic, retain) UIMenuController	*speedMenu; //拖动语速栏时显示语速的控件
@property (nonatomic, retain) NSString	*selectWord;    //选择的字符串
@property (nonatomic) float	aValue; //复读区间a点值
@property (nonatomic) float	bValue; //幅度区间b点值
@property (nonatomic) BOOL isSpeedMenu; //标识当前UIMenuController显示的是否语速值
@property (nonatomic) BOOL isAbMenu; //标识当前UIMenuController显示的是否复读区间ab值
@property (nonatomic) BOOL isResponse; //标识当前评论是否是回复
@property (nonatomic) BOOL isInforComm; //标识当前的播放界面是否从消息内容处点击进来的
@property (nonatomic) BOOL isInterupted;   //标记是否有外部打断事件

@property (nonatomic, retain) TextScrollView	*lyricScroll; //跟读界面显示英文的滚动文本框
@property (nonatomic, retain) TextScrollView	*lyricCnScroll; //跟读界面显示中文的滚动文本框

@property (nonatomic, retain) CL_AudioRecorder* audioRecoder;   //录音实例
@property (nonatomic) BOOL              m_isRecording; //标识是否正在录音
@property (nonatomic) CMTime nowTime;   //当前播放到的时间点
@property (nonatomic, retain) AVAsset *avSet; //保存当前播放的文件路径信息的对象
@property (nonatomic, retain) NSURL			*mp3Url; //保存当前播放的文件的URL路径
//@property (readwrite)	CFURLRef		soundFileURLRef;
//@property (readonly)	SystemSoundID	soundFileObject;
@property (nonatomic, retain) SevenProgressBar  *loadProgress;//缓冲进度条
@property (nonatomic, retain) GADBannerView *bannerView_; //广告条
@property (nonatomic, retain) VOAView *voa; //正在播放的voa
@property (nonatomic, retain) UIImageView     *myImageView; //显示新闻图片的视图
@property (nonatomic, retain) UIImageView *senImage;    //点击句子时截屏的句子图片
@property (nonatomic, retain) UIImageView *starImage;   //星星图片,暂未用
//@property (nonatomic, retain) UIImageView     *wordFrame;
@property (nonatomic, retain) UIButton        *shareSenBtn; //
@property (nonatomic, retain) UIButton        *colSenBtn;
@property (nonatomic, retain) UIButton        *sendBtn;
@property (nonatomic, retain) timeSwitchClass *timeSwitch;
@property (nonatomic, retain) NSTimer			*sliderTimer;
@property (nonatomic, retain) NSTimer			*lyricSynTimer;
@property (nonatomic, retain) NSTimer         *fixTimer;
@property (nonatomic, retain) NSTimer         *recordTimer;
//@property (nonatomic, retain) NSTimer			*updateTimer;
@property (nonatomic, retain) NSMutableArray	*lyricArray;
@property (nonatomic, retain) NSMutableArray	*lyricCnArray;
@property (nonatomic, retain) NSMutableArray	*timeArray;
@property (nonatomic, retain) NSMutableArray	*indexArray;
@property (nonatomic, retain) NSMutableArray	*lyricLabelArray;
@property (nonatomic, retain) NSMutableArray	*lyricCnLabelArray;
@property (nonatomic, retain) NSMutableArray    *listArray;
@property (nonatomic, retain) NSArray         *hoursArray;
@property (nonatomic, retain) NSArray         *minsArray;
@property (nonatomic, retain) NSArray         *secsArray;
//@property int				engLines;
//@property int				cnLines;
@property int				playerFlag;//0:local 1:net
@property (nonatomic) int             recordSeconds;
@property (nonatomic) int             nowRecordSeconds;
@property (nonatomic) int             recordTime;
@property (nonatomic) int             fixSeconds;
//@property (nonatomic, retain) NSString *category;
@property (nonatomic) NSInteger category;
@property (nonatomic) NSInteger nowPage;
@property (nonatomic) NSInteger totalPage;
//@property (nonatomic) NSInteger commNumber;
@property (nonatomic) NSInteger contentMode;
@property (nonatomic) NSInteger playMode;
@property (nonatomic) NSInteger playIndex;
//@property (nonatomic, retain) AVPlayer	*localPlayer;
@property (nonatomic, retain) AVPlayer	*player;
@property (nonatomic, retain) AVPlayer	*wordPlayer;
@property (nonatomic, retain) UILabel     *myHighLightWord;
@property (nonatomic, retain) UIView      *myView;
@property (nonatomic, retain) NSMutableData* mp3Data;
@property (nonatomic, retain) NSString *userPath;
@property (nonatomic, retain) UIButton        *clockButton;
@property (nonatomic, retain) UIButton      *downloadFlg;
@property (nonatomic, retain) UIButton      *downloadingFlg;
@property BOOL localFileExist;
@property BOOL downloaded;
@property BOOL newFile;
//@property BOOL switchFlg;
@property (nonatomic) BOOL isNewComm;
//@property (nonatomic) BOOL afterRecord;
@property (nonatomic) BOOL isFixing;
@property (nonatomic) BOOL flushList;
@property (nonatomic) BOOL isFree;
@property (nonatomic) BOOL isFive;
@property (nonatomic) BOOL isUpAlertShow;

@property (nonatomic, retain) MyLabel *explainView;
@property (nonatomic, retain) VOAWord *myWord;
@property (nonatomic, retain) MBProgressHUD *HUD;
@property (nonatomic, retain) UIView *viewOne;
@property (nonatomic, retain) UIView *viewTwo;
@property (nonatomic, retain) TextScrollView	*textScroll;
@property (nonatomic, retain) UITextView *imgWords;
@property double myStop;
@property (nonatomic, retain) UIImage *playImage;
@property (nonatomic, retain) UIImage *pauseImage;
@property (nonatomic, retain) UIImage *loadingImage;
@property (nonatomic, retain) UIAlertView *alert;
@property (nonatomic, retain) NSNotificationCenter *myCenter;
@property (nonatomic, retain) NSString *lyEn;
@property (nonatomic, retain) NSString *lyCn;
@property (nonatomic, retain) UITableView *commTableView;
@property (nonatomic, retain) NSMutableArray *commArray;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) HPGrowingTextView *textView;
@property (nonatomic, retain) NSSet *wordTouches;
@property NSInteger nowUserId;
//@property BOOL isExisitNet;
@property (nonatomic, retain) VOASentence *mySentence;

void RouteChangeListener(	void *                  inClientData,
                         AudioSessionPropertyID	inID,
                         UInt32                  inDataSize,
                         const void *            inData);
- (IBAction) playButtonPressed:(UIButton *)sender;
- (void) collectButtonPressed:(UIButton *)sender;
- (IBAction) sliderChanged:(UISlider *)sender;
- (IBAction) goBack:(UIButton *)sender;
- (IBAction) prePlay:(id)sender;
- (IBAction) aftPlay:(id)sender;
- (void) shareTo;
- (IBAction)shareNew:(id)sender;
- (void)shareSen:(id)sender;
- (IBAction)changeView:(id)sender;
- (void)collectSentence:(id)sender;

//- (IBAction) shareText;
//- (void) shareAll;
//- (IBAction) showComments:(id)sender;
- (void) QueueDownloadVoa;
- (void)catchWords:(NSString *) word;
+ (PlayViewController *)sharedPlayer;
+ (NSOperationQueue *)sharedQueue;
-(BOOL) isExistenceNetwork:(NSInteger)choose;
//-(void)updateCurrentTimeForPlayer:(AVPlayer *)p;
- (void)setButtonImage:(UIImage *)image;
- (void)spinButton;
- (IBAction)changePage:(UIPageControl *)sender;
- (CMTime)playerItemDuration;
- (void) stopRecord;
- (void) aniToPlay:(UITextView *) myTextView ;
- (BOOL)isPlaying;

//- (void) stopRecordPlay;
//- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
//- (IBAction) recordButtonPressed:(UIButton *)sender;
@end
