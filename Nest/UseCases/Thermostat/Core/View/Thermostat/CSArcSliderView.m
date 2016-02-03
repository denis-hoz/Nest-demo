//
// CSArcSliderView.m
// Nest
//
// Created by Denis Kapusta on 1/18/16.
// Copyright (c) 2016 Appko. All rights reserved.
//

#import "CSArcSliderView.h"
#import <Nimbus/NimbusCore.h>

@interface CSArcSliderView()
@property (nonatomic, readonly) CGFloat radius;
@property (nonatomic, readonly) CGFloat disabledRange;
@end

@implementation CSArcSliderView

/** Helper Functions **/
#define ToRad(deg) 		( (M_PI * (deg)) / 180.0f )
#define ToDeg(rad)		( (180.0f * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )

/** Parameters **/
#define TB_DISABLED_RANGE 45.0f
#define TB_SAFEAREA_PADDING 31.0f
#define TB_LINE_WIDTH 5.f

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.angle = TB_DISABLED_RANGE;
		self.selectorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ThermostatSelector"]];
		self.selectorSelectedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ThermostatSelectorSelected"]];
		self.selectorSelectedImageView.hidden = YES;
		[self addSubview:self.selectorImageView];
		[self addSubview:self.selectorSelectedImageView];
	}

	return self;
}


#pragma mark - Properties

- (CGFloat)radius {
	return self.frame.size.width/2 - TB_SAFEAREA_PADDING;
}

- (CGFloat)disabledRange {
	return TB_DISABLED_RANGE + [self _deltaAngleFromValue:self.range];
}

- (void)setAngle:(CGFloat)angle {
	BOOL angleIsMin = fabs(_angle - self.disabledRange) < 0.001;
	BOOL angleIsMax = fabs(_angle - 360 + self.disabledRange) < 0.001;
	BOOL newAngleIsFarFromMin = fabs(angle - self.disabledRange) > 10;
	BOOL newAngleIsFarFromMax = fabs(angle - 360 + self.disabledRange) > 10;
	if ((angleIsMin && newAngleIsFarFromMin) ||
		(angleIsMax && newAngleIsFarFromMax)) {
		
		return;
	}
	
	_angle = angle;
	[self setNeedsDisplay];
}

- (CGFloat)value {
	CGFloat proportion = (self.angle - TB_DISABLED_RANGE) / (360.0f - 2.0f * TB_DISABLED_RANGE);
	CGFloat range = self.maxValue - self.minValue;

	return self.minValue + range * proportion;
}

- (void)setValue:(CGFloat)value {
	if (fabs(value - self.value) < 0.5) {
		return;
	}
	
	_angle = [self _angleFromValue:value];

	[self setNeedsDisplay];
}

- (void)setRange:(CGFloat)range {
	_range = range;

	[self setNeedsDisplay];
}

#pragma mark - UIControl Override

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
	[super beginTrackingWithTouch:touch withEvent:event];
	self.selectorImageView.hidden = YES;
	self.selectorSelectedImageView.hidden = NO;

	return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
	[super continueTrackingWithTouch:touch withEvent:event];
	
	CGPoint lastPoint = [touch locationInView:self];
	[self _movehandle:lastPoint];
	[self sendActionsForControlEvents:UIControlEventValueChanged];
	
	return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
	[super endTrackingWithTouch:touch withEvent:event];
	
	self.selectorImageView.hidden = NO;
	self.selectorSelectedImageView.hidden = YES;
}


#pragma mark - Draw

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[self _drawTheHandle:context];
}

- (void)_drawTheHandle:(CGContextRef)context {
	CGPoint handleCenter =  [self _pointFromAngle: self.angle];

	self.selectorImageView.center = handleCenter;
	self.selectorSelectedImageView.center = handleCenter;
	
	if (self.range > 0.001) {
		CGFloat displayAngle = self.angle + 90;
		CGFloat fromAngle = [self _angleFromValue:self.value - self.range] + 90;
		UIColor *coldColor = RGBACOLOR(59, 172, 217, 1);
		[self _drawArcFromAngle:fromAngle toAngle:displayAngle withColor:coldColor inContext:context];
		
		CGFloat toAngle = [self _angleFromValue:self.value + self.range] + 90;
		UIColor *warmColor = RGBACOLOR(242, 34, 51, 1);
		[self _drawArcFromAngle:displayAngle toAngle:toAngle withColor:warmColor inContext:context];
	}
}

- (void)_drawArcFromAngle:(CGFloat)fromAngle toAngle:(CGFloat)toAngle withColor:(UIColor *)color inContext:(CGContextRef)context {
	CGContextSaveGState(context);
	
	CGFloat radius = self.bounds.size.height / 2 - TB_SAFEAREA_PADDING;
	CGContextAddArc(context, self.frame.size.width/2  , self.frame.size.height/2,  radius, ToRad(fromAngle), ToRad(toAngle), 0);
	[color set];
 
	//Use shadow to create the Blur effect
	CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 5, color.CGColor);
 
	//define the path
	CGContextSetLineWidth(context, TB_LINE_WIDTH);
	CGContextDrawPath(context, kCGPathStroke);
 
	//save the context content into the image mask
	CGImageRef mask = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
	CGContextClipToMask(context, self.bounds, mask);
	UIGraphicsEndImageContext();
	
	CGContextRestoreGState(context);
}


#pragma mark - Helpers

- (CGFloat)_angleFromValue:(CGFloat)value {
	return [self _deltaAngleFromValue:value - self.minValue] + TB_DISABLED_RANGE;
}

- (CGFloat)_deltaAngleFromValue:(CGFloat)value {
	CGFloat range = self.maxValue - self.minValue;
	if (range < 0.001) {
		return 0;
	}

	CGFloat proportion = value / range;
	CGFloat angle = (360.0f - 2.0f * TB_DISABLED_RANGE) * proportion ;

	return angle;
}

- (CGPoint)_pointFromAngle:(CGFloat)angle {
	angle = angle + 90;
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

    CGPoint result;
    result.y = centerPoint.y + self.radius * sin(ToRad(angle));
    result.x = centerPoint.x + self.radius * cos(ToRad(angle));

    return result;
}

- (void)_movehandle:(CGPoint)lastPoint{
	CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
	CGFloat currentAngle = AngleFromNorth(centerPoint, lastPoint, NO);
	
	CGFloat actualAngle = (currentAngle - 90 + 360);
	if (actualAngle > 360) {
		actualAngle -= 360;
	}
	
	if (actualAngle < self.disabledRange) {
		actualAngle = self.disabledRange;
	}
	
	if (actualAngle > (360 - self.disabledRange)) {
		actualAngle = 360 - self.disabledRange;
	}
	
	self.angle = actualAngle;
}

static inline CGFloat AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
	CGPoint v = CGPointMake(p2.x - p1.x, p2.y - p1.y);
	CGFloat vmag = sqrtf(SQR(v.x) + SQR(v.y));
	CGFloat result = 0;
	v.x /= vmag;
	v.y /= vmag;
	CGFloat radians = atan2f(v.y, v.x);
	result = ToDeg(radians);
	return (result >=0  ? result : result + 360.0f);
}

@end