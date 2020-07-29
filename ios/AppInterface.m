#import "AppInterface.h"
#import <React/RCTUtils.h>

@implementation AppInterface

RCT_EXPORT_MODULE()

RCT_REMAP_METHOD(closeWindow,
		withResolver:
		(RCTPromiseResolveBlock) resolve
		withRejecter:
		(RCTPromiseRejectBlock) reject
) {
	UIApplication *app = RCTSharedApplication();
	for (NSWindow *window in app.windows) {
		if (window.isMainWindow) {
			[window close];
		}
	}
	resolve(nil);
}

RCT_REMAP_METHOD(setCursor,
		setCursorWithType:
		(NSString *) type
		withResolver:
		(RCTPromiseResolveBlock) resolve
		withRejecter:
		(RCTPromiseRejectBlock) reject
) {
	[[NSCursor valueForKey:[type stringByAppendingString:@"Cursor"]] performSelector:@selector(set)];
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
