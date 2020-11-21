//
//  Created by Backbase R&D B.V. on 16/07/2018.
//

#import <CommonUtils/CommonUtils.h>
#import <NotificationsClient/BBNotificationSeverityLevel.h>
#import "BBLegacyNotificationProperties.h"
#import "BBRouting.h"

#ifndef BBNotificationStream_h
#define BBNotificationStream_h

@interface BBNotificationStream : Additions
    
/// Uniquely identifies this notification
@property (strong, nonatomic, nonnull, readonly) NSString* identifier;
/// Title of notification message
@property (strong, nonatomic, nullable, readonly) NSString* title;
/// Text of notification message
@property (strong, nonatomic, nonnull, readonly) NSString* message;

@property (strong, nonatomic, nonnull, readonly) BBNotificationSeverityLevel level;
/// Date and time when notification was created
@property (strong, nonatomic, nonnull, readonly) NSString* createdOn;
/// Link where user will be directed when clicks notification
@property (strong, nonatomic, nullable, readonly) NSString* link;
/// Date and time when notification becomes valid and should be shown
@property (strong, nonatomic, nullable, readonly) NSString* validFrom;
/// Date until which notification will be shown. Notification will not be displayed after this date.
@property (strong, nonatomic, nullable, readonly) NSString* expiresOn;
/// The object that contains information about routing from this notification to the target page
@property (strong, nonatomic, nonnull, readonly) BBRouting* routing;
/// Translations of this notification
@property (strong, nonatomic, nonnull, readonly) NSDictionary<NSString*, BBLegacyNotificationProperties*>* translations;

/**
 * Initializes a NotificationStream object.
 * @param identifier Uniquely identifies this notification. Min Length : 1.
 * @param message Text of this notification.
 * @param level Notification severity level which may be: "ALERT", "WARNING", "SUCCESS", "INFO".
 * @param createdOn  Date and time when notification was created.
 * @return The initialized NotificationsStream object
 */
- (instancetype _Nonnull)initWithIdentifier:(NSString * _Nonnull)identifier
                                    message:(NSString * _Nonnull)message
                                      level:(BBNotificationSeverityLevel _Nonnull)level
                                  createdOn:(NSString * _Nonnull)createdOn;

/**
 * Initializes a NotificationStream object.
 * @param identifier Uniquely identifies this notification. Min Length : 1.
 * @param message Text of this notification.
 * @param level Notification severity level which may be: "ALERT", "WARNING", "SUCCESS", "INFO".
 * @param createdOn  Date and time when notification was created.
 * @param title Title of this notification message.
 * @param link Link where user will be directed when clicks notification. Max Length: 512.
 * @param validFrom Date and time when notification becomes valid and should be shown.
 * @param expiresOn Date until which notification will be shown. Notification will not be displayed after this date.
 * @return The initialized NotificationsStream object
 */
- (instancetype _Nonnull)initWithIdentifier:(NSString * _Nonnull)identifier
                                    message:(NSString * _Nonnull)message
                                      level:(BBNotificationSeverityLevel _Nonnull)level
                                  createdOn:(NSString * _Nonnull)createdOn
                                      title:(NSString * _Nullable)title
                                       link:(NSString * _Nullable)link
                                  validFrom:(NSString * _Nullable)validFrom
                                  expiresOn:(NSString * _Nullable)expiresOn;

/// Deprecated, please use other JSON parsing methods.
+ (NSArray<BBNotificationStream *> * _Nullable)notificationStreamFromJSONArray:(NSArray <NSDictionary*> * _Nonnull)array
__deprecated_msg("This helper function is going to be removed in 3.3.0");
    
@end

#endif /* BBNotificationStream_h */
