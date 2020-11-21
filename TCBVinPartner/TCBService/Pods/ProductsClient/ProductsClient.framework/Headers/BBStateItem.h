//
//  Created by Backbase R&D B.V. on 11/09/2019.
//

#ifndef ProductsClient_BBStateItem_h
#define ProductsClient_BBStateItem_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// State class for the product.
@interface BBStateItem : Additions

/// An external unique identifier for the arrangement state object.
@property (strong, nonatomic, readonly, nullable) NSString *externalStateId;

/// Name that describes the specific arrangement state.
@property (strong, nonatomic, readonly, nullable) NSString *state;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBStateItem_h */
