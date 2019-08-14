#import<SpringBoard/SpringBoard.h>
#import<CoreGraphics/CoreGraphics.h>

// ------- ALERT VIEW -----

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


// ------- SPRINGBOARD ICON -----
@interface SBIcon
- (id)getUnmaskedIconImage:(int)arg1;
- (id)getIconImage:(int)arg1;
- (id)getGenericIconImage:(int)arg1;
- (UIImage *)convertImageToGrayScale:(UIImage *)image;
@end
%hook SBIcon
%new(v@:)
- (UIImage *)convertImageToGrayScale:(UIImage *)image {
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);

    CGContextDrawImage(context, imageRect, [image CGImage]);
  
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
	
	CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    return newImage; 
}
- (id)getIconImage:(int)arg1 {
	UIImage *unmaskedImage = [self getUnmaskedIconImage:arg1];
	return [self convertImageToGrayScale:unmaskedImage];
}
- (id)getGenericIconImage:(int)arg1 {
	UIImage *unmaskedImage = [self getUnmaskedIconImage:arg1];
	return [self convertImageToGrayScale:unmaskedImage];
}


%end
@interface SBIconImageView : UIView
	+ (double) cornerRadius;
@end

%hook SBIconImageView
+ (double) cornerRadius {
	return 0;
}
%end


@protocol SBIconLabelView
@end
@interface SBIconView : UIView
	- (UIView<SBIconLabelView> *) labelView;
@end
%hook SBIconView
- (void)didMoveToWindow {
	%orig;
	self.labelView.hidden = YES;
}
%end