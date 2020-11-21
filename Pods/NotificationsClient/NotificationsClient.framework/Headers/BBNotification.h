//
//  Created by Backbase R&D B.V. on 13/07/2018.
//

#import <CommonUtils/CommonUtils.h>
#import "BBNotificationSeverityLevel.h"
#import "BBRouting.h"
#import "BBLegacyNotificationProperties.h"

#ifndef BBNotification_h
#define BBNotification_h

@interface BBNotification : Additions

/// Uniquely identifies this notification
@property (strong, nonatomic, nonnull, readonly) NSString* identifier;

/// Title of notification message
@property (strong, nonatomic, nullable, readonly) NSString* title;

/// Text of notification message
@property (strong, nonatomic, nonnull, readonly) NSString* message;

/// Notification severity level which may be: "ALERT", "WARNING", "SUCCESS", "INFO".
@property (strong, nonatomic, nonnull, readonly) BBNotificationSeverityLevel level;

/// Date and time when notification was created
@property (strong, nonatomic, nonnull, readonly) NSString* createdOn;

/// Link where user will be directed when clicks notification
@property (strong, nonatomic, nullable, readonly) NSString* link;

/// Date and time when notification becomes valid and should be shown
@property (strong, nonatomic, nullable, readonly) NSString* validFrom;

/// Date until which notification will be shown. Notification will not be displayed after this date.
@property (strong, nonatomic, nullable, readonly) NSString* expiresOn;

/// Was notification already seen by user
@property (assign, nonatomic, readonly) BOOL read;

/// Name of notification creator
@property (strong, nonatomic, nonnull, readonly) NSString* origin;

/// The object that contains information about routing from this notification to the target page
@property (strong, nonatomic, nonnull, readonly) BBRouting* routing;

/// Translations of this notification
@property (strong, nonatomic, nonnull, readonly) NSDictionary<NSString*, BBLegacyNotificationProperties*>* translations;

#pragma mark - Deprecated

/**
 * Initializes a Notification object.
 * @param identifier Uniquely identifies this notification. Min Length : 1.
 * @param message Text of this notification.
 * @param level Notification severity level which may be: "ALERT", "WARNING", "SUCCESS", "INFO".
 * @param read Was notification already seen by user.
 * @param origin Name of notification creator.  Min Length : 1. Max Length : 200.
 * @param createdOn  Date and time when notification was created.
 * @return The initialized Notification object
 */
- (instancetype _Nonnull)initWithIdentifier:(NSString * _Nonnull)identifier
                                    message:(NSString * _Nonnull)message
                                      level:(BBNotificationSeverityLevel _Nonnull)level
                                       read:(BOOL)read
                                     origin:(NSString * _Nonnull)origin
                                  createdOn:(NSString * _Nonnull)createdOn
__deprecated_msg("This initializer is deprecated and will be removed. As this class is a response DTO, no need to construct it using initializer method");


/**
 * Initializes a Notification object.
 * @param identifier Uniquely identifies this notification. Min Length : 1.
 * @param message Text of this notification.
 * @param level Notification severity level which may be: "ALERT", "WARNING", "SUCCESS", "INFO".
 * @param read Was notification already seen by user.
 * @param origin Name of notification creator.  Min Length : 1. Max Length : 200.
 * @param createdOn  Date and time when notification was created.
 * @param title Title of this notification message.
 * @param link Link where user will be directed when clicks notification. Max Length: 512.
 * @param validFrom Date and time when notification becomes valid and should be shown.
 * @param expiresOn Date until which notification will be shown. Notification will not be displayed after this date.
 * @return The initialized Notification object
 */
- (instancetype _Nonnull)initWithIdentifier:(NSString * _Nonnull)identifier
                                    message:(NSString * _Nonnull)message
                                      level:(BBNotificationSeverityLevel _Nonnull)level
                                       read:(BOOL)read
                                     origin:(NSString * _Nonnull)origin
                                  createdOn:(NSString * _Nonnull)createdOn
                                      title:(NSString * _Nullable)title
                                       link:(NSString * _Nullable)link
                                  validFrom:(NSString * _Nullable)validFrom
                                  expiresOn:(NSString * _Nullable)expiresOn
__deprecated_msg("This initializer is deprecated and will be removed. As this class is a response DTO, no need to construct it using initializer method");



/// Helper for parsing notification objects from a JSON array
+ (NSArray<BBNotification *> * _Nullable)notificationsFromJSONArray:(NSArray <NSDictionary*> * _Nonnull)array
__deprecated_msg("This helper method is going to be removed in next major release");

@end

#endif /* BBNotification_h */
