//
//  Created by Backbase R&D B.V. on 12/09/2017.
//

#import <UIKit/UIKit.h>
#import <Backbase/Backbase.h>

//! Project version number for TransactionsClient.
FOUNDATION_EXPORT double TransactionsClientVersionNumber;

//! Project version string for TransactionsClient.
FOUNDATION_EXPORT const unsigned char TransactionsClientVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <TransactionsClient/PublicHeader.h>
#import <TransactionsClient/TypeDefinitions.h>

@protocol TransactionsClientProtocol <NSObject>

/**
 * Retrieves a list of transaction pages limited in size and number by the page selection parameters, sorted and filtered
 * @see load:completionHandler: for information about potential parameters.
 * @param params An NSDictionary object containing all string:string key/value pair parameters of the request.
 * @param completionHandler A callback returning either an NSArray of TransactionItem objects,
 * or an NSError detailing what went wrong with the request.
 */
- (void)retrieveTransactionsWithParams:(NSDictionary<NSString *, NSString *> *_Nullable)params
                     completionHandler:(void (^_Nullable)(NSArray<TransactionItem *> *_Nullable transactions,
                                                          NSError *_Nullable error))completionHandler;

/**
 Retrieve periodic incoming/outgoing aggregated transaction amounts (turnovers).
 @param turnoversRequest A TurnoversRequest object in behalve of request params.
 @param completionHandler A callback method containing either a TurnoversResponse object, or an NSError detailing what went wrong with the
 request.
 */
- (void)retrieveTurnoversWithTurnoversRequest:(nonnull TurnoversRequest *)turnoversRequest
                            completionHandler:(void (^_Nullable)(TurnoversResponse * _Nullable turnoversResponse,
                                                                 NSError *_Nullable error))completionHandler;

/**
 * Retrieve a list of aggregated transactions by income or spending category and the total amount of all returned categories.
 * @param categoryTotalsRequest A CategoryTotalsRequest object in behalve of request params.
 * @param completionHandler A callback method containing either a CategoryTotalsResponse object,
 * or an NSError detailing what went wrong with the request.
 */
- (void)retrieveCategoryTotalsWithCategoryTotalsRequest:(nonnull CategoryTotalsRequest *)categoryTotalsRequest
                                      completionHandler:(void (^_Nullable)(CategoryTotalsResponse * _Nullable categoryTotalsResponse,
                                                                           NSError *_Nullable error))completionHandler;

/**
 * Update list of banking transactions
 * @param transactions Array of transactions to be updated.
 * @param completionHandler A handler to be notified if the transactions has
 * successfully been updated.
 */
- (void)updateTransactions:(NSArray<BBTransactionPatchItem *> *_Nonnull)transactions
         completionHandler:(void (^_Nullable)(NSError *_Nullable error))completionHandler;

/**
 * Retrieves a list of transaction check images by the given transaction id.
 * @param transactionId The identifier of the transaction to retrieve the check images for.
 * @param timeoutInterval The time out interval for the method call to the backend.
 * @param completionHandler A callback returning either a BBTransactionCheckImages object,
 * or an NSError detailing what went wrong with the request.
 */
- (void)retrieveCheckImagesByTransactionId:(nonnull NSString*)transactionId
                           timeoutInterval:(NSTimeInterval)timeoutInterval
                         completionHandler:(void (^_Nonnull)(BBTransactionCheckImages *_Nullable images,
                                                             NSError *_Nullable error))completionHandler;

/**
 * Retrieves a list of transaction check images by the given transaction id.
 * @discussion The default timeout interval is 30 seconds.
 * @param transactionId The identifier of the transaction to retrieve the check images for.
 * @param completionHandler A callback returning either a BBTransactionCheckImages object,
 * or an NSError detailing what went wrong with the request.
 */
- (void)retrieveCheckImagesByTransactionId:(nonnull NSString*)transactionId
                         completionHandler:(void (^_Nonnull)(BBTransactionCheckImages *_Nullable images,
                                                             NSError *_Nullable error))completionHandler;

/**
 * Retrieves a list of enum types of given attribute name
 * @param attributeName Attribute name of enum types. The default implementation of the DBS supports following values: type, typeGroup, currency, instructedCurrency, billingStatus.
 * If more enums, needed, this needs to be supported by the used DBS.
 * @param completionHandler A callback returning either a list of enum types object,
 * or an NSError detailing what went wrong with the request.
 */
- (void)retrieveEnumValuesForAttributeName:(nonnull NSString*)attributeName
                         completionHandler:(void (^_Nonnull)(NSArray<BBTransactionEnumValue*> *_Nullable items,
                                                             NSError *_Nullable error))completionHandler;


/**
 * Retrieves a list of transactions types of given attribute name
 * @param completionHandler A callback returning either a list of transaction types,
 * or an NSError detailing what went wrong with the request.
 */
- (void)retrieveTransactionTypes:(void (^_Nonnull)(NSArray<BBTransactionEnumValue*> *_Nullable items,
                                                   NSError *_Nullable error))completionHandler;

@end

@interface TransactionsClient : BBBaseClient <DBSClient, TransactionsClientProtocol>

@end
