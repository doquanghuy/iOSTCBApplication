//
//  Created by Backbase R&D B.V. on 28/06/2018.
//

#import <UIKit/UIKit.h>
#import <Backbase/Backbase.h>

//! Project version number for NotificationsClient.
FOUNDATION_EXPORT double NotificationsClientVersionNumber;

//! Project version string for NotificationsClient.
FOUNDATION_EXPORT const unsigned char NotificationsClientVersionString[];

#import <NotificationsClient/TypeDefinitions.h>

@protocol NotificationsClientProtocol <NSObject>

/**
 * Retrieves list of notifications for current user.
 * List size and content can be controlled by paging parameters.
 * Ordering of elements in the list is driven by 'orderBy' and 'direction' parameters
 * @param params Extra parameters to filter out of all notifications
 * @param completionHandler A completion handler that contains either an array of notifications,
 * or an error object with information if the request failed.
 */
- (void)retrieveNotificationsWithParams:(nullable NSDictionary <NSString *, NSString* > *)params
                      completionHandler:(nullable void (^)(NSArray<BBNotification *> * _Nullable notifications,
                                                           NSError * _Nullable error))completionHandler;

/**
 * Retrieves list of notifications for current user.
 * List size and content can be controlled by paging parameters.
 * Ordering of elements in the list is driven by 'orderBy' and 'direction' parameters
 * @param params Extra parameters to filter all notifications.
 * @param completionHandler A completion handler that contains either an array of notifications
 * or an error object with information if the request failed.
 */
- (void)retrieveNotificationsWithNotificationParameters:(nullable BBNotificationParameters *)params
                                      completionHandler:(nullable void (^)(NSArray<BBNotification *> * _Nullable,
                                                                           NSError * _Nullable))completionHandler;

/**
 * Provides the count of non-sticky, valid and unread notifications
 * The endpoint is meant to be used for notification badge on UI to get the count on the badge.
 * The count does not include sticky notifications (the ones with expiration date) and
 * the notifications with validFrom date in the future (they not valid so far).
 * @param completionHandler A completion handler that contains count of unread notifications,
 * or an error object with information if the request failed.
 */
- (void)retrieveUnreadNotificationsCountWithCompletionHandler:(nullable void (^)(NSNumber * _Nullable unreadNotificationCount,
                                                                                 NSError * _Nullable error))completionHandler;

/**
 * Get latest unread notifications for current user.
 * Client provides maximum age of notifications he's interested in.
 * E.g. client requests latest notifications within 30 seconds.
 * @param interval Age of notifications that will be retrieved from stream (milliseconds). Default: 30000. Minimum: 15000. Smaller than Minimum value will cause default value to be set.
 * @param completionHandler A completion handler that contains either an array of notifications,
 * or an error object with information if the request failed.
 */
- (void)retrieveNotificationsStreamWithInterval:(nonnull NSNumber *)interval
                          withCompletionHandler:(nullable void (^)(NSArray<BBNotificationStream *> * _Nullable notificationsStream,
                                                                   NSError * _Nullable error))completionHandler;
/**
 * Delete a notification.
 * @param completionHandler A completion handler that contains success boolean,
 * or an error object with information if the request failed.
 */
- (void)deleteNotification:(nonnull NSString *)notificationId
     withCompletionHandler:(nullable void (^)(BOOL success, NSError * _Nullable error))completionHandler;
/**
 * Mark notification as read/unread.
 * @param notificationId Id of a notification to be marked
 * @param read Whether notification is read or not
 * @param completionHandler A completion handler that contains success boolean,
 * or an error object with information if the request failed.
 */
- (void)markReadNotification:(nonnull NSString *)notificationId
                        read:(BOOL)read
       withCompletionHandler:(nullable void (^)(BOOL success, NSError * _Nullable error))completionHandler;

/**
 * Mark all notifications as read.
 * @param completionHandler A completion handler that contains an error object with information if the request failed.
 */

- (void)markReadAllNotificationsWithCompletionHandler:(nullable void (^)(NSError * _Nullable))completionHandler;
    
@end

#pragma mark - NotificationsClient interface

@interface NotificationsClient: BBBaseClient <DBSClient, NotificationsClientProtocol>
@end

