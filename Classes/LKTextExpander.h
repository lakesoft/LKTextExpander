//
//  LKTextExpander.h
//
//  Created by Hiroshi Hashiguchi on 2014/06/05
//
//

#import <Foundation/Foundation.h>
#import <TextExpander/SMTEDelegateController.h>

@class SMTEDelegateController;
@interface LKTextExpander : NSObject

@property (nonatomic, strong, readonly) SMTEDelegateController *textExpander;

+ (instancetype)sharedInstance;
+ (void)setExpansionEnabled:(BOOL)expansionEnabled;
+ (BOOL)expansionEnabled;

// update snippets
- (void)getSnippetsWithScheme:(NSString*)scheme;

// put into application:openURL:sourceApplication:
- (BOOL)handleURL:(NSURL *)url;

// for Client
- (void)setTextView:(UITextView*)textView nextDelegate:(id <UITextViewDelegate>)nextDelegate;
- (void)setTextField:(UITextField*)textField nextDelegate:(id <UITextFieldDelegate>)nextDelegate;


@end
