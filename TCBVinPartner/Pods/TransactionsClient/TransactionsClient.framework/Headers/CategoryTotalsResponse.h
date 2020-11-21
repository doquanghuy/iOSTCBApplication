//
//  Created by Backbase R&D B.V. on 23/07/2018.
//

#import <CommonUtils/CommonUtils.h>

#ifndef CategoryTotalsResponse_h
#define CategoryTotalsResponse_h

@class CategoryTotalsItem;

@interface CategoryTotalsResponse : Additions

/// The aggregate amount of all returned categories
@property (nonatomic, strong, nullable, readonly) BBCurrency *total;

@property (nonatomic, strong, nullable, readonly) NSArray<__kindof CategoryTotalsItem *> *items;

@end

#endif
