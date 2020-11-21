//
//  Created by Backbase R&D B.V. on 18.03.2020.
//

#ifndef BBTransactionCheckImageSide_h
#define BBTransactionCheckImageSide_h

#import <CommonUtils/CommonUtils.h>

/// Transaction check image side indicator. Raw values for front: FRONT, for back: BACK
typedef NSString* BBTransactionCheckImageSide NS_TYPED_ENUM;

extern BBTransactionCheckImageSide const kBBTransactionCheckImageSideFront;
extern BBTransactionCheckImageSide const kBBTransactionCheckImageSideBack;

#endif
