//
//  ViewController.m
//  DelayedSearch
//
//  Created by Przemyslaw Malak on 23.05.2017.
//  Copyright © 2017 Przemyslaw Malak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UISearchBarDelegate>
{
    NSTimer *timer_;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchWithDelay:searchText];
}

- (void)searchWithDelay:(NSString*)searchString
{
    if (searchString == nil)
    {
        return;
    }
    
    if (timer_ != nil)
    {
        [timer_ invalidate];
    }
    
    if (searchString.length > 0)
    {
        NSString *settingTimerString = [NSString stringWithFormat:@"setting timer for: %@", searchString];
        [self appendText:settingTimerString];
        timer_ = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(invokeSearch:) userInfo:searchString repeats:NO];
    }
}

- (void)invokeSearch:(NSTimer*)timer
{
    id userInfo_ = [timer userInfo];
    
    if (userInfo_)
    {
        NSString *settingTimerString = [NSString stringWithFormat:@"invoking search for: %@", timer.userInfo];
        [self appendText:settingTimerString];
    }
}

- (void)appendText:(NSString*)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *newString_ = [NSString stringWithFormat:@"%@\n%@ %@", self.textView.text, [NSDate date], text];
        self.textView.text = newString_;
    });
}
@end
