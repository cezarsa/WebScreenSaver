#import <ScreenSaver/ScreenSaver.h>
#import <WebKit/WebKit.h>

@interface WebScreenSaverView : ScreenSaverView
{
	WebView *webView;
    IBOutlet NSWindow* configSheet;
    IBOutlet NSTextField *urlField;
}

@property (strong, nonatomic) ScreenSaverDefaults *defaults;

@end
