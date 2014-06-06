//
//  LKTextExpander.m
//
//  Created by Hiroshi Hashiguchi on 2014/06/05
//
//

#import "LKTextExpander.h"

@interface LKTextExpander()
@property (nonatomic, strong) SMTEDelegateController *textExpander;
@end

@implementation LKTextExpander

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textExpander = SMTEDelegateController.new;
        self.textExpander.clientAppName = NSBundle.mainBundle.infoDictionary[(NSString*)kCFBundleNameKey];
        self.textExpander.nextDelegate = self;
    }
    return self;
}

+ (instancetype)sharedInstance
{
    static LKTextExpander* _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = self.new;
    });
    return _sharedInstance;
}


- (void)getSnippetsWithScheme:(NSString *)scheme
{
    if ([SMTEDelegateController isTextExpanderTouchInstalled]) {
        self.textExpander.getSnippetsScheme = scheme;
        [self.textExpander getSnippets];
    } else {
        // Note: This only works on the device, not in the Simulator, as the Simulator does
        // not include the App Store app
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://smilesoftware.com/cgi-bin/redirect.pl?product=tetouch&cmd=itunes"]];
    }
}

- (BOOL)handleURL:(NSURL *)url
{
    if ([self.textExpander.getSnippetsScheme isEqualToString: url.scheme]) {
        NSError *error = nil;
        BOOL cancel = NO;
        if ([self.textExpander handleGetSnippetsURL:url error:&error cancelFlag:&cancel] == NO) {
            NSLog(@"[LKTextExpander] Failed to handle URL: user canceled: %@, error: %@", cancel ? @"yes" : @"no", error);
        } else {
            if (cancel) {
                NSLog(@"[LKTextExpander] User cancelled get snippets");
			} else if (error != nil) {
				NSLog(@"[LKTextExpander] Error updating TextExpander snippets: %@", error);
	        } else {
                NSLog(@"[LKTextExpander] Successfully updated TextExpander Snippets");
            }
        }
        return YES;
    }
    return NO;
}

- (void)setTextView:(UITextView*)textView nextDelegate:(id <UITextViewDelegate>)nextDelegate
{
    textView.delegate = self.textExpander;
    self.textExpander.nextDelegate = nextDelegate;
}
- (void)setTextField:(UITextField*)textField nextDelegate:(id <UITextFieldDelegate>)nextDelegate
{
    textField.delegate = self.textExpander;
    self.textExpander.nextDelegate = nextDelegate;
}

static BOOL _expansionEnabled = YES;

+ (BOOL)expansionEnabled
{
    return _expansionEnabled;
}

+ (void)setExpansionEnabled:(BOOL)expansionEnabled
{
    _expansionEnabled = expansionEnabled;
    SMTEDelegateController.expansionEnabled = expansionEnabled;
}

+ (BOOL)isInstalled
{
    return SMTEDelegateController.isTextExpanderTouchInstalled;
}


@end
