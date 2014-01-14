#import "WebScreenSaverView.h"
#import <WebKit/WebKit.h>

@implementation WebScreenSaverView

static NSString * const WebScreenSaverModuleName = @"com.github.cezarsa.WebScreenSaver";

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    
    if (self) {
        ScreenSaverDefaults *defaults;
        defaults = [ScreenSaverDefaults defaultsForModuleWithName:WebScreenSaverModuleName];
        
        [defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                    @"http://google.com", @"Url",
                                    nil]];
        
		webView = [[WebView alloc] initWithFrame:[self bounds] frameName:nil groupName:nil];
        
		[webView setMainFrameURL:[defaults stringForKey:@"Url"]];
		[self addSubview:webView];
    }
    return self;
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow *)configureSheet
{
    ScreenSaverDefaults *defaults;
    
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:WebScreenSaverModuleName];
    
    if (!configSheet)
    {
        if (![NSBundle loadNibNamed:@"ConfigureSheet" owner:self])
        {
            NSLog( @"Failed to load configure sheet." );
            NSBeep();
        }
    }
    
    [urlField setStringValue:[defaults valueForKey:@"Url"]];
    
    return configSheet;
}

- (IBAction)cancelClick:(id)sender
{
    [[NSApplication sharedApplication] endSheet:configSheet];
}

- (IBAction) okClick: (id)sender
{
    ScreenSaverDefaults *defaults;
    
    defaults = [ScreenSaverDefaults defaultsForModuleWithName:WebScreenSaverModuleName];
    
    [defaults setValue:[urlField stringValue] forKey:@"Url"];
    
    [defaults synchronize];
    
    [[NSApplication sharedApplication] endSheet:configSheet];
}

@end
