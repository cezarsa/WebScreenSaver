#import <ScreenSaver/ScreenSaver.h>
#import <WebKit/WebKit.h>

@interface WebScreenSaverView : ScreenSaverView
{
	WebView *webView;
    IBOutlet id configSheet;
    IBOutlet NSTextField *urlField;
}

@end
