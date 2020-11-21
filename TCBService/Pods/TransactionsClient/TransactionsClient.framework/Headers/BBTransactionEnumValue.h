//
//  Created by Backbase R&D B.V. on 25.03.2020.
//

#ifndef BBTransactionEnumValue_h
#define BBTransactionEnumValue_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// This is a response class that represents an enum item.
@interface BBTransactionEnumValue : Additions

/// Value of an enum item.
@property (nonatomic, strong, nonnull, readonly) NSString *value;

@end

NS_ASSUME_NONNULL_END

#endif
