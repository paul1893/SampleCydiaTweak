#line 1 "Tweak.x"
#import<SpringBoard/SpringBoard.h>

@interface SBApplicationInfo
	- (NSString*) displayName;
@end

@interface SBApplication
	- (SBApplicationInfo*) info;
@end

@interface SBApplicationIcon
	- (SBApplication*) application;
@end



#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBApplicationIcon; 
static void (*_logos_orig$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$)(_LOGOS_SELF_TYPE_NORMAL SBApplicationIcon* _LOGOS_SELF_CONST, SEL, long long, id, id, id); static void _logos_method$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$(_LOGOS_SELF_TYPE_NORMAL SBApplicationIcon* _LOGOS_SELF_CONST, SEL, long long, id, id, id); 

#line 16 "Tweak.x"


static void _logos_method$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$(_LOGOS_SELF_TYPE_NORMAL SBApplicationIcon* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, long long arg1, id arg2, id arg3, id arg4) {	
	SBApplication *application = [self application];
	SBApplicationInfo *info = [application info];
	NSString *appName = [info displayName];

	NSString *message = [NSString stringWithFormat:@"The app %@ has been launched by %@", appName, @"PBA", nil];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:appName message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    _logos_orig$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$(self, _cmd, arg1, arg2, arg3, arg4);
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBApplicationIcon = objc_getClass("SBApplicationIcon"); MSHookMessageEx(_logos_class$_ungrouped$SBApplicationIcon, @selector(launchFromLocation:context:activationSettings:actions:), (IMP)&_logos_method$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$, (IMP*)&_logos_orig$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$);} }
#line 29 "Tweak.x"
