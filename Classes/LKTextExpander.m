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

- (NSString*)_localizedStringWithKey:(NSString*)key
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LKTextExpander-Resources" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    return NSLocalizedStringFromTableInBundle(key, nil, bundle, nil);
}

- (void)getSnippetsWithScheme:(NSString *)scheme
{
    if ([SMTEDelegateController isTextExpanderTouchInstalled]) {
        self.textExpander.getSnippetsScheme = scheme;
        [self.textExpander getSnippets];
    } else {
        [self _showAlertWithMessage:[self _localizedStringWithKey:@"Alert.NotInstalled"]];
    }
}

- (void)_showAlertWithMessage:(NSString*)message
{
    [[[UIAlertView alloc] initWithTitle:[self _localizedStringWithKey:@"Result.Title"]
                                message:message
                               delegate:nil
                      cancelButtonTitle:nil
                      otherButtonTitles:@"OK", nil] show];
}

- (BOOL)handleURL:(NSURL *)url
{
    if ([self.textExpander.getSnippetsScheme isEqualToString: url.scheme]) {
        NSError *error = nil;
        BOOL cancel = NO;
        NSString* message = nil;
        if ([self.textExpander handleGetSnippetsURL:url error:&error cancelFlag:&cancel] == NO) {
            message = [NSString stringWithFormat:[self _localizedStringWithKey:@"Result.FailedURL"], cancel ? @"yes" : @"no", error];
        } else {
            if (cancel) {
                message = [self _localizedStringWithKey:@"Result.UserCancelled"];
			} else if (error != nil) {
				message = [NSString stringWithFormat:[self _localizedStringWithKey:@"Result.Error"], error];
	        } else {
                message = [self _localizedStringWithKey:@"Result.Success"];
            }
        }
        [self _showAlertWithMessage:message];
        NSLog(@"[LKTextExpander] %@", message);
        return YES;
    }
    return NO;
}

- (void)setTextView:(UITextView*)textView nextDelegate:(id <UITextViewDelegate>)nextDelegate
{
    if (SMTEDelegateController.isTextExpanderTouchInstalled) {
        textView.delegate = self.textExpander;
        self.textExpander.nextDelegate = nextDelegate;
    }
}
- (void)setTextField:(UITextField*)textField nextDelegate:(id <UITextFieldDelegate>)nextDelegate
{
    if (SMTEDelegateController.isTextExpanderTouchInstalled) {
        textField.delegate = self.textExpander;
        self.textExpander.nextDelegate = nextDelegate;
    }
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

static BOOL _shouldShowResultAlert = YES;

+ (void)setShouldShowResultAlert:(BOOL)shouldShowResultAlert
{
    _shouldShowResultAlert = shouldShowResultAlert;
}
+ (BOOL)shouldShowResultAlert
{
    return _shouldShowResultAlert;
}



@end
