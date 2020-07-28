#import "AppInterface.h"
#import <React/RCTUtils.h>

@implementation AppInterface

RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(closeWindow,
	withResolver:(RCTPromiseResolveBlock)resolve
	withRejecter:(RCTPromiseRejectBlock)reject
) {
	UIApplication *app = RCTSharedApplication();
	for (NSWindow *window in app.windows) {
		if (window.isMainWindow) {
			[window close];
		}
	}
	resolve(nil);
}

- (NSArray<NSString *> *)supportedEvents {
	return @[@"notification", @"stderr", @"terminate"];
}

- (void)startObserving {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowShouldClose:) name:@"windowShouldClose" object:nil];
}

- (void)stopObserving {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)windowShouldClose:(NSNotification *)notification {
	NSLog(@"windowShouldClose");

	[self sendEventWithName:@"notification" body:@{@"type": @"windowShouldClose"}];
}

@end
