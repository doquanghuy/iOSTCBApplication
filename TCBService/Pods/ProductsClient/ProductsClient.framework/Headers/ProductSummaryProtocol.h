//
//  Created by Backbase R&D B.V. on 10/09/2019.
//

#import <CommonUtils/CommonUtils.h>
#import <ProductsClient/TypeDefinitions.h>

/// Protocol when conformed, it enables to access all public product summary methods.
@protocol ProductSummaryProtocol <NSObject>

/**
 * Retrieves the product summary of the authenticated user.
 * @param params Query params to retrieve the product summary with.
 * @param completionHandler A handler to be notified after the product summary is retrieved from the client.
 */
- (void)retrieveProductSummaryWithParams:(nullable BBProductSummaryParams *)params
                       completionHandler:(void (^_Nullable)(BBProductSummary *_Nullable productSummary,
                                                            NSError *_Nullable error))completionHandler;

/**
 * Retrieves the product summary of the authenticated user.
 * @param parameters Query params to retrieve the product summary with.
 * @discussion The parameters can be one of the following keys:
 *
 * debitAccount: (Boolean)
 * Whether the type of accounts to be retrieved should be Debit account.
 *
 * creditAccount: (Boolean)
 * Whether the type of accounts to be retrieved should be Credit account.
 *
 * maskIndicator: (Boolean)
 * Whether the card numbers should be Masked/Unmasked.
 *
 * @param completionHandler A handler to be notified after the product summary is retrieved from the client.
 */
- (void)retrieveProductSummaryWithParameters:(nullable NSDictionary<NSString *, NSString *> *)parameters
                           completionHandler:(void (^_Nullable)(BBProductSummary *_Nullable productSummary,
                                                                NSError *_Nullable error))completionHandler;

/**
 * Retrieve an array of arrangements.
 * @param params parameters needed for the call
 * @param completionHandler A callback that contains either an an array of ArrangementItem objects, or an NSError describing what went wrong.
 */
-(void)retrieveContextualArrangementsWithParams:(BBContextualArrangementsParams*_Nonnull)params
                       completionHandler:(nullable void (^)(NSArray<BBArrangementItem *> * _Nullable arrangement,
                                                            NSError * _Nullable error))completionHandler;

@end
