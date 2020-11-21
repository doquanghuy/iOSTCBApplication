//
//  Created by Backbase R&D B.V. on 13/09/2019.
//

#import <CommonUtils/CommonUtils.h>
#import <ProductsClient/TypeDefinitions.h>

/// Protocol that enables to access all public client methods of accounts end points.
@protocol AccountsProtocol <NSObject>

/**
 * Retrieve a single arrangement with details.
 * @param identifier Id of the arrangement to be retrieved
 * @param completionHandler A callback that contains either an ArrangementItem object, or an NSError describing what went wrong.
 */
-(void)retrieveArrangementWithIdentifier:(nonnull NSString*)identifier
                       completionHandler:(void (^_Nullable)(BBArrangementItem * _Nullable arrangement,
                                                            NSError * _Nullable error))completionHandler;

/**
 * Updates limited set of fields for an arrangement by an arrangement id.
 * @param userPreferences BBUserPreferencesItem to be updated.
 * @param completionHandler A callback that contains either success as yes or an NSError describing what went wrong.
 */
-(void)updateUserPreferencesWithUserPreferences:(nonnull BBUserPreferencesItem *)userPreferences
                              completionHandler:(void (^_Nullable)(BOOL success,
                                                                   NSError * _Nullable error))completionHandler;
/**
 * Retrieve user defined preferences for arrangement id
 * @param identifier Id of the arrangement to be retrieved
 * @param completionHandler A callback that contains either an user preference object, or an NSError describing what went wrong.
 */
-(void)retrieveUserPreferencesWithIdentifier:(nonnull NSString*)identifier
                           completionHandler:(void (^_Nullable)(BBUserPreferencesItem * _Nullable userPreferences,
                                                                NSError * _Nullable error))completionHandler;
/**
 * Retrieve balance history per arrangement for given arrangement ids.
 * @param identifiers Array of Arrangement Ids.
 * @param params accepts following optional parameters with keys: 'dateFrom' : Bottom value of date range.
 * 'dateTo' : Top value of date range.
 * 'timePeriod' : Defined time period for showing graph oscillations (one of lastDay, lastWeek, lastMonth, lastYear).
 * 'format' : Format of the response (one of json, csv).
 * @param completionHandler A callback that contains either BalanceHistoryResponseObject as a response or
 * an NSError describing what went wrong.
 */
-(void)retrieveBalanceHistoryWithIdentifiers:(nonnull NSArray<NSString*>*)identifiers
                                   andParams:(NSDictionary<NSString*, NSString*> * _Nullable)params
                           completionHandler:(void (^_Nullable)(BBArrangementsWithBalanceHistory * _Nullable response,
                                                                NSError * _Nullable error))completionHandler;

@end
