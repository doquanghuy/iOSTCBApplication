//
//  Created by Backbase R&D B.V. on 19/07/2018.
//

#import <CommonUtils/CommonUtils.h>
#import <NotificationsClient/BBNotificationSeverityLevel.h>

#ifndef BBNotificationParameters_h
#define BBNotificationParameters_h

@interface BBNotificationParameters : Additions

/**
 * As an alternative for specifying 'from' this allows to point to the record to start the selection from.
 * Example: 1483006260
 **/
@property (strong, nonatomic, nullable, readonly) NSString* cursor;

/**
 * Skip over a page of elements by specifying a start value for the query
 * Default: 0
 * Minimum: 0
 * Example: 20
 **/
@property (assign, nonatomic, nullable, readonly) NSNumber* from;

/**
 * Limit the number of elements on the response.
 * Default: 10
 * Minimum: 1
 * Example: 80
 **/
@property (assign, nonatomic, nullable, readonly) NSNumber* size;

/**
 * Date from which the notifications should be retrieved.
 * Example: 2017-02-12T14:15:12+00:00
 **/
@property (strong, nonatomic, nullable, readonly) NSString* fromDate;

/**
 * Date from which the notifications should be retrieved.
 * Example: 2017-04-11T15:14:33+00:00
 **/
@property (strong, nonatomic, nullable, readonly) NSString* toDate;

/**
 * Array of severity levels notifications should be filtered by.
 * Severity levels : "GLOBAL", "CUSTOMER", "USER"
 **/
@property (strong, nonatomic, nullable, readonly) NSArray<BBNotificationSeverityLevel> *levels;

/**
 * Fetch only read or not read notifications
 * Example: read
 **/
@property (strong, nonatomic, nullable, readonly) NSString* read;

/**
 * A sequense of symbols/words entered by user
 **/
@property (strong, nonatomic, nullable, readonly) NSString* originTerm;

/**
 * A sequense of symbols/words entered by user
 **/
@property (strong, nonatomic, nullable, readonly) NSString* messageTerm;

/**
 * Initializes a NotificationParameters object to pass the params to notifications call.
 * @param cursor As an alternative for specifying 'from' this allows to point to the record to start the selection from. Example: 1483006260.
 * @param from Skip over a page of elements by specifying a start value for the query. Default: 0. Minimum: 0. Example: 20.
 * @param size Limit the number of elements on the response. Default: 10. Minimum: 1. Example: 80.
 * @param fromDate Date from which the notifications should be retrieved. Example: 2017-02-12T14:15:12+00:00
 * @param toDate Date from which the notifications should be retrieved. Example: 2017-04-11T15:14:33+00:00
 * @param levels  Array of severity levels notifications should be filtered by.Severity levels : "GLOBAL", "CUSTOMER", "USER".
 * @param read Fetch only read or not read notifications. Example: read.
 * @param originTerm A sequense of symbols/words entered by user.
 * @param messageTerm A sequense of symbols/words entered by user.
 * @return The initialized NotificationParameters object
 */
- (instancetype _Nonnull)initWithCursor:(NSString * _Nullable)cursor
                                   from:(NSNumber * _Nullable)from
                                   size:(NSNumber * _Nullable)size
                               fromDate:(NSString * _Nullable)fromDate
                                 toDate:(NSString * _Nullable)toDate
                                 levels:(NSArray<BBNotificationSeverityLevel> * _Nullable)levels
                                   read:(NSString * _Nullable)read
                             originTerm:(NSString * _Nullable)originTerm
                            messageTerm:(NSString * _Nullable)messageTerm;

/// An NSDictionary representation of the object. This method is used to post parameters to DBS.
/// Therefore it pre-processes the properties according to default DBS specs.
- (nonnull NSDictionary *)dictionary;

@end

#endif /* BBNotificationParameters_h */
