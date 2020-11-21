//
//  Created by Backbase R&D B.V. on 26/05/2020.
//

#import <CommonUtils/CommonUtils.h>

#ifndef BBLegacyNotificationProperties_h
#define BBLegacyNotificationProperties_h

/// DTO for translation of a notification.
@interface BBLegacyNotificationProperties : Additions

/// Title of notification message
@property (strong, nonatomic, nullable, readonly) NSString* title;

/// Text of notification message
@property (strong, nonatomic, nonnull, readonly) NSString* message;

/// Http(s) link where user will be directed when clicking notification
@property (strong, nonatomic, nullable, readonly) NSString* link;

@end

#endif
