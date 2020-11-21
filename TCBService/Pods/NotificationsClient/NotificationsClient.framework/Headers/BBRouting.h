//
//  Created by Backbase R&D B.V. on 06/04/2020.
//

#import <CommonUtils/CommonUtils.h>

#ifndef BBRouting_h
#define BBRouting_h

@interface BBRouting : Additions

/// String representing the target screen. [whereTo] constitutes a naming convention between backend and frontend/mobile.
@property (strong, nonatomic, nullable, readonly) NSString* whereTo;

/// Object to populate the target screen. Target screen is expected to know how to handle this [data] object. The following are some of the use-cases by this object:
/// - routing to an existing resource providing the identifier
/// - pre-populate the target screen when there is no existing resource
@property (strong, nonatomic, nullable, readonly) NSDictionary* data;

@end

#endif
