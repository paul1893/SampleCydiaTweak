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


%hook SBApplicationIcon
-(void)launchFromLocation:(long long)arg1 context:(id)arg2 activationSettings:(id)arg3 actions:(id)arg4
{	
	SBApplication *application = [self application];
	SBApplicationInfo *info = [application info];
	NSString *appName = [info displayName];

	NSString *message = [NSString stringWithFormat:@"The app %@ has been launched by %@", appName, @"PBA", nil];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:appName message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    %orig;
}
%end