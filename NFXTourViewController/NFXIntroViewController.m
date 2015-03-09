//
//  NFXIntroViewController.m
//  NFXTourViewControllerDEMO
//
//  Created by Tomoya_Hirano on 2014/10/04.
//  Copyright (c) 2014年 Tomoya_Hirano. All rights reserved.
//

#import "NFXIntroViewController.h"
#import "ChikkaColor.h"
#define nextText @"Next"
#define startText @"Start Messaging!"

@interface NFXIntroViewController ()<UIScrollViewDelegate>{
    UIScrollView*_scrollview;
    UIButton*_button;
    UIPageControl*_pgcontrol;
    UILabel *_tourTitle;
    NSArray*_images;
    NSArray*_titles;
    NSArray*_captions;
    UIImageView*_backgroundimageview;
}

@end

@implementation NFXIntroViewController

-(id)initWithViews:(NSArray*)images withTitles:(NSArray *)titles withCaptions:(NSArray *)captions{
    self = [super init];
    if (self) {
        //check views length
        NSAssert(images.count!=0, @".views's length is zero.");
        if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]){
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        /**
         *  setup viewcontroller
         */
        self.view.backgroundColor = [UIColor whiteColor];
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        _images = images;
        _captions = captions;
        _titles = titles;
        
        
        /**
         *  positions
         */
        CGRect svrect_ = CGRectZero;
       
        svrect_.size.height = self.view.bounds.size.height/3*2 - 20;
        svrect_.size.width = self.view.bounds.size.width/5*4;
        CGPoint svcenter_ = CGPointZero;
        svcenter_.x = self.view.center.x;
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (version < 7.0)
        {
            // iOS 6 code here
            svcenter_.y = self.view.center.y-50;
        }
        else {
            // iOS 7 code here
            svcenter_.y = self.view.center.y-30;
        }
        
        CGSize svconsize = CGSizeZero;
        svconsize.height = svrect_.size.height;
        svconsize.width = svrect_.size.width * images.count;
        
        CGPoint pgconcenter_ = CGPointZero;
        pgconcenter_.x = self.view.center.x;
        pgconcenter_.y = svcenter_.y + (svrect_.size.height/2);
        
        CGRect btnrect_ = CGRectZero;
        btnrect_.size.width = 250;
        btnrect_.size.height = 50;
        CGPoint btncenter_ = CGPointZero;
        btncenter_.x = self.view.center.x;
        btncenter_.y = self.view.bounds.size.height-65;
    
        
        
        /*
         Views
         */
        _backgroundimageview = [[UIImageView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_backgroundimageview];
        
        _scrollview = [[UIScrollView alloc] initWithFrame:svrect_];
        _scrollview.center = svcenter_;
//        _scrollview.backgroundColor = [UIColor redColor];
        _scrollview.contentSize = svconsize;
        _scrollview.pagingEnabled = true;
        _scrollview.bounces = false;
        _scrollview.delegate = self;
        _scrollview.showsHorizontalScrollIndicator = false;
        _scrollview.layer.cornerRadius = 2;
        [self.view addSubview:_scrollview];
        
        _pgcontrol = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pgcontrol.pageIndicatorTintColor = [UIColor colorWithWhite:0.8 alpha:1];
        _pgcontrol.currentPageIndicatorTintColor = [ChikkaColor orangeColor];
        _pgcontrol.numberOfPages = _images.count;
        _pgcontrol.currentPage = 0;
        [_pgcontrol sizeToFit];
        _pgcontrol.center = pgconcenter_;
        [self.view addSubview:_pgcontrol];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(ButtonPushed:) forControlEvents:UIControlEventTouchDown];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button setTitle:nextText forState:UIControlStateNormal];
//        [_button setBackgroundImage:fill forState:UIControlStateHighlighted];
        _button.backgroundColor = [ChikkaColor blueColor];
        _button.clipsToBounds = true;
        _button.frame = btnrect_;
        _button.center = btncenter_;
        _button.layer.cornerRadius = 4;
//        
        [self.view addSubview:_button];
        
        _tourTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, _scrollview.frame.origin.y-30, self.view.frame.size.width, 30)];
#if CTM_OLD
        _tourTitle.textAlignment = UITextAlignmentCenter;
#else
        _tourTitle.textAlignment = NSTextAlignmentCenter;
#endif
        _tourTitle.text = TITLE_TOUR;
        [_tourTitle setFont:[UIFont boldSystemFontOfSize:16]];
        [self.view addSubview:_tourTitle];
        int index_ = 0;
        for (int i = 0; i < [_images count]; i++) {
//            NSAssert([image_ isKindOfClass:[UIImage class]],@".views are not only UIImage.");
            CGRect ivrect_ = CGRectMake(_scrollview.bounds.size.width * index_,
                                        0,
                                        _scrollview.bounds.size.width,
                                        _scrollview.bounds.size.height/2);
            UIImageView*iv_ = [[UIImageView alloc] initWithFrame:ivrect_];
            iv_.contentMode = UIViewContentModeScaleAspectFit;
            iv_.clipsToBounds = true;
            iv_.image = images[i];
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(_scrollview.bounds.size.width * index_, _scrollview.bounds.size.height/2, _scrollview.bounds.size.width, 30)];
            title.text = _titles[i];
//            title.backgroundColor = [UIColor purpleColor];
            [title setFont:[UIFont boldSystemFontOfSize:16]];
#if CTM_OLD
            title.textAlignment = UITextAlignmentCenter;
#else
            title.textAlignment = NSTextAlignmentCenter;
#endif
            
            
            UITextView *caption = [[UITextView alloc] initWithFrame:CGRectMake(_scrollview.bounds.size.width * index_, _scrollview.bounds.size.height/2 + 30, _scrollview.bounds.size.width, 90)];
            caption.text = _captions[i];
#if CTM_OLD
            caption.textAlignment = UITextAlignmentCenter;
#else
            caption.textAlignment = NSTextAlignmentCenter;
#endif
            caption.font = [UIFont systemFontOfSize:14];
            [_scrollview addSubview:iv_];
            [_scrollview addSubview:title];
            [_scrollview addSubview:caption];
            index_++;
        }
    }
    return self;
}

-(void)ButtonPushed:(UIButton*)button{
    int page_ = (int)round(_scrollview.contentOffset.x / _scrollview.bounds.size.width);
    /**
     *  scroll or finish
     */
    if (page_!=(_images.count-1)) {
        CGRect rect = _scrollview.bounds;
        rect.origin.x = rect.size.width * (page_+1);
        [_scrollview scrollRectToVisible:rect animated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page_ = (int)round(scrollView.contentOffset.x / scrollView.bounds.size.width);
    if (page_==_images.count-1) {
        [_button setTitle:startText forState:UIControlStateNormal];
    }else{
        [_button setTitle:nextText forState:UIControlStateNormal];
    }
    _pgcontrol.currentPage = page_;
}

- (void)viewDidLoad {
   self.navigationController.navigationBar.translucent = NO;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

UIImage *(^createImageFromUIColor)(UIColor *) = ^(UIColor *color)
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, [color CGColor]);
    CGContextFillRect(contextRef, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
};

@end
