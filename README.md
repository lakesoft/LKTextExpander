LKTextExpander
==============

TextExpander Wrapper

## Usage

### 1. In AppDelegate

    #import "LKTextExpander.h"
    
    - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
    {
      BOOL result = [LKTextExpander.sharedInstance handleURL:url];
      return result;
    }
    
### 2. Setup UITextView (or UITextField)

    - (void)viewDidLoad
    {
      [LKTextExpander.sharedInstance setTextView:self.textView nextDelegate:self];
    }

### 3. Setup action for getting snippets

    - (IBAction)getSnippets:(id)sender {
        [LKTextExpander.sharedInstance getSnippetsWithScheme:@"LKTextExpanderDemo-get-snippets-xc"];
        // <-- put your URL Scheme
    }

