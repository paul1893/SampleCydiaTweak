#line 1 "Tweak.xm"
#import<SpringBoard/SpringBoard.h>
#import<CoreGraphics/CoreGraphics.h>



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

@class SBIcon; @class SBIconImageView; @class SBIconView; @class SBApplicationIcon; 
static void (*_logos_orig$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$)(_LOGOS_SELF_TYPE_NORMAL SBApplicationIcon* _LOGOS_SELF_CONST, SEL, long long, id, id, id); static void _logos_method$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$(_LOGOS_SELF_TYPE_NORMAL SBApplicationIcon* _LOGOS_SELF_CONST, SEL, long long, id, id, id); static UIImage * _logos_method$_ungrouped$SBIcon$convertImageToGrayScale$(_LOGOS_SELF_TYPE_NORMAL SBIcon* _LOGOS_SELF_CONST, SEL, UIImage *); static id (*_logos_orig$_ungrouped$SBIcon$getIconImage$)(_LOGOS_SELF_TYPE_NORMAL SBIcon* _LOGOS_SELF_CONST, SEL, int); static id _logos_method$_ungrouped$SBIcon$getIconImage$(_LOGOS_SELF_TYPE_NORMAL SBIcon* _LOGOS_SELF_CONST, SEL, int); static id (*_logos_orig$_ungrouped$SBIcon$getGenericIconImage$)(_LOGOS_SELF_TYPE_NORMAL SBIcon* _LOGOS_SELF_CONST, SEL, int); static id _logos_method$_ungrouped$SBIcon$getGenericIconImage$(_LOGOS_SELF_TYPE_NORMAL SBIcon* _LOGOS_SELF_CONST, SEL, int); static double (*_logos_meta_orig$_ungrouped$SBIconImageView$cornerRadius)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static double _logos_meta_method$_ungrouped$SBIconImageView$cornerRadius(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$SBIconView$didMoveToWindow)(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL); static void _logos_method$_ungrouped$SBIconView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL); 

#line 19 "Tweak.xm"


static void _logos_method$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$(_LOGOS_SELF_TYPE_NORMAL SBApplicationIcon* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, long long arg1, id arg2, id arg3, id arg4) {	
	SBApplication *application = [self application];
	SBApplicationInfo *info = [application info];
	NSString *appName = [info displayName];

	NSString *message = [NSString stringWithFormat:@"The app %@ has been launched by %@", appName, @"PBA", nil];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:appName message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    _logos_orig$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$(self, _cmd, arg1, arg2, arg3, arg4);
}




@interface SBIcon
- (id)getUnmaskedIconImage:(int)arg1;
- (id)getIconImage:(int)arg1;
- (id)getGenericIconImage:(int)arg1;
- (UIImage *)convertImageToGrayScale:(UIImage *)image;
@end


static UIImage * _logos_method$_ungrouped$SBIcon$convertImageToGrayScale$(_LOGOS_SELF_TYPE_NORMAL SBIcon* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIImage * image) {
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
static id _logos_method$_ungrouped$SBIcon$getIconImage$(_LOGOS_SELF_TYPE_NORMAL SBIcon* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, int arg1) {
	UIImage *unmaskedImage = [self getUnmaskedIconImage:arg1];
	return [self convertImageToGrayScale:unmaskedImage];
}
static id _logos_method$_ungrouped$SBIcon$getGenericIconImage$(_LOGOS_SELF_TYPE_NORMAL SBIcon* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, int arg1) {
	UIImage *unmaskedImage = [self getUnmaskedIconImage:arg1];
	return [self convertImageToGrayScale:unmaskedImage];
}



@interface SBIconImageView : UIView
	+ (double) cornerRadius;
@end


static double _logos_meta_method$_ungrouped$SBIconImageView$cornerRadius(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	return 0;
}



@protocol SBIconLabelView
@end
@interface SBIconView : UIView
	- (UIView<SBIconLabelView> *) labelView;
@end

static void _logos_method$_ungrouped$SBIconView$didMoveToWindow(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
	_logos_orig$_ungrouped$SBIconView$didMoveToWindow(self, _cmd);
	self.labelView.hidden = YES;
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBApplicationIcon = objc_getClass("SBApplicationIcon"); MSHookMessageEx(_logos_class$_ungrouped$SBApplicationIcon, @selector(launchFromLocation:context:activationSettings:actions:), (IMP)&_logos_method$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$, (IMP*)&_logos_orig$_ungrouped$SBApplicationIcon$launchFromLocation$context$activationSettings$actions$);Class _logos_class$_ungrouped$SBIcon = objc_getClass("SBIcon"); { const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$_ungrouped$SBIcon, @selector(convertImageToGrayScale:), (IMP)&_logos_method$_ungrouped$SBIcon$convertImageToGrayScale$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$SBIcon, @selector(getIconImage:), (IMP)&_logos_method$_ungrouped$SBIcon$getIconImage$, (IMP*)&_logos_orig$_ungrouped$SBIcon$getIconImage$);MSHookMessageEx(_logos_class$_ungrouped$SBIcon, @selector(getGenericIconImage:), (IMP)&_logos_method$_ungrouped$SBIcon$getGenericIconImage$, (IMP*)&_logos_orig$_ungrouped$SBIcon$getGenericIconImage$);Class _logos_class$_ungrouped$SBIconImageView = objc_getClass("SBIconImageView"); Class _logos_metaclass$_ungrouped$SBIconImageView = object_getClass(_logos_class$_ungrouped$SBIconImageView); MSHookMessageEx(_logos_metaclass$_ungrouped$SBIconImageView, @selector(cornerRadius), (IMP)&_logos_meta_method$_ungrouped$SBIconImageView$cornerRadius, (IMP*)&_logos_meta_orig$_ungrouped$SBIconImageView$cornerRadius);Class _logos_class$_ungrouped$SBIconView = objc_getClass("SBIconView"); MSHookMessageEx(_logos_class$_ungrouped$SBIconView, @selector(didMoveToWindow), (IMP)&_logos_method$_ungrouped$SBIconView$didMoveToWindow, (IMP*)&_logos_orig$_ungrouped$SBIconView$didMoveToWindow);} }
#line 91 "Tweak.xm"
