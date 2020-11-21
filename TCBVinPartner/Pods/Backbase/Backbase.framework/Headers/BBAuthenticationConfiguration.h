// 
//  BBAuthenticationConfiguration.h
//  Backbase
//
//  Created by Backbase B.V. on 12/03/2018.
//  Copyright © 2018 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>
#import "BBAuthenticationFieldNamesConfiguration.h"

#ifndef BBAUTHENTICATIONCONFIGURATION_CLASS
#define BBAUTHENTICATIONCONFIGURATION_CLASS

/// Authentication related configurations
@interface BBAuthenticationConfiguration : NSObject
/// Names of fields to be used on the requests.
@property (strong, nonatomic) BBAuthenticationFieldNamesConfiguration* fieldNames;
@end

#endif
