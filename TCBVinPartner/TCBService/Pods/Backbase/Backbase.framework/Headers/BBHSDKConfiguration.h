//
//  BBHSDKConfiguration.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 15/10/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBHSDKTemplateConfiguration.h"

#ifndef BBHSDKConfiguration_h
#define BBHSDKConfiguration_h

/// HSDK  configuration
@interface BBHSDKConfiguration : NSObject

///  HSDK template configuration for pages
@property (nonatomic, strong) NSDictionary<NSString*, BBHSDKTemplateConfiguration*>* templates;

@end

#endif /* BBHSDKConfiguration_h */
