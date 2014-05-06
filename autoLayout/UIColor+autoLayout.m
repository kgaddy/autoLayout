//
//  UIColor+autoLayout.m
//  autoLayout
//
//  Created by kgaddy on 5/5/14.
//  Copyright (c) 2014 com.ehi. All rights reserved.
//

#import "UIColor+autoLayout.h"

@implementation UIColor (autoLayout)


+ (UIColor *)hLightGreen {
    return [self colorWithHexValue:@"D6DF22"];
}

+ (UIColor *)liptonYellow {
    return [self colorWithHexValue:@"FEE101"];
}

+ (UIColor *)trophy {
    return [self colorWithHexValue:@"E6E0D3"];
}

+ (UIColor *)hitched {
    return [self colorWithHexValue:@"F78D1F"];
}

+ (UIColor *)offWhite {
    return [self colorWithHexValue:@"FFFEF2"];
}



+ (UIColor *)colorWithHexValue:(NSString *)hexValue {
    UIColor *defaultResult = [UIColor blackColor];
    
    // Strip leading # if there is one
    if ([hexValue hasPrefix:@"#"] && [hexValue length] > 1) {
        hexValue = [hexValue substringFromIndex:1];
    }
    
    NSUInteger componentLength = 0;
    
    if ([hexValue length] == 3) componentLength = 1;
    else if ([hexValue length] == 6) componentLength = 2;
    else return defaultResult;
    
    BOOL isValid = YES;
    CGFloat components[3];
    
    for (NSUInteger i = 0; i < 3; i++) {
        NSString *component = [hexValue substringWithRange:NSMakeRange(componentLength * i, componentLength)];
        
        if (componentLength == 1) {
            component = [component stringByAppendingString:component];
        }
        
        NSScanner *scanner = [NSScanner scannerWithString:component];
        unsigned int value;
        isValid &= [scanner scanHexInt:&value];
        components[i] = (CGFloat)value / 256.0;
    }
    
    if (!isValid) {
        return defaultResult;
    }
    
    return [UIColor colorWithRed:components[0]
                           green:components[1]
                            blue:components[2]
                           alpha:1.0];
}

@end
