#import "WebScreenSaverView.h"
#import <WebKit/WebKit.h>

@implementation WebScreenSaverView

static NSString * const WebScreenSaverModuleName = @"com.github.cezarsa.WebScreenSaver";

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (!self) {
        NSLog(@"Failed to init frame.");
        return self;
    }
    [self.defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                    @"http://google.com", @"Url",
                                    nil]];
	webView = [[WebView alloc] initWithFrame:[self bounds] frameName:nil groupName:nil];
	[webView setMainFrameURL:[self.defaults stringForKey:@"Url"]];
	[self addSubview:webView];
    return self;
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (ScreenSaverDefaults *)defaults
{
    if(!_defaults)
    {
        _defaults = [ScreenSaverDefaults defaultsForModuleWithName:WebScreenSaverModuleName];
    }
    return _defaults;
}

- (NSWindow *)configureSheet
{
    if (!configSheet)
    {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        if (![bundle loadNibNamed:@"ConfigureSheet" owner:self topLevelObjects:nil])
        {
            NSLog(@"Failed to load configure sheet.");
            NSBeep();
        }
    }
    [urlField setStringValue:[self.defaults valueForKey:@"Url"]];
    return configSheet;
}

- (IBAction)cancelClick:(id)sender
{
    [[NSApplication sharedApplication] endSheet:configSheet];
}

- (IBAction) okClick: (id)sender
{
    [self.defaults setValue:[urlField stringValue] forKey:@"Url"];
    [self.defaults synchronize];
    [[NSApplication sharedApplication] endSheet:configSheet];
    if (webView) {
        [webView setMainFrameURL:[self.defaults stringForKey:@"Url"]];
    }
}

@end
