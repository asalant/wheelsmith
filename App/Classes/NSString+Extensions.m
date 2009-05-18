//
//  String+Helpers.m
//  Qfly
//
//  Created by Alon J Salant on 4/23/09.
//  Copyright 2009 Carbon Five. All rights reserved.
//

#import "NSString+Extensions.h"


@implementation NSString (Extensions)

- (BOOL) notEmpty {
    return ![@"" isEqualToString:[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

@end
