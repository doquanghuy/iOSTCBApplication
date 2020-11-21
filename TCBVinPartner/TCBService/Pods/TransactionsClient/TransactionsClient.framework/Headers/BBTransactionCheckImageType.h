//
//  Created by Backbase R&D B.V. on 18.03.2020.
//

#ifndef BBTransactionCheckImageType_h
#define BBTransactionCheckImageType_h

#import <CommonUtils/CommonUtils.h>

/// Transaction check image type indicator. Raw values for PNG: image/png, for JPEG: image/jpeg
typedef NSString* BBTransactionCheckImageType NS_TYPED_ENUM;

extern BBTransactionCheckImageType const kBBTransactionCheckImageTypePNG;
extern BBTransactionCheckImageType const kBBTransactionCheckImageTypeJPEG;

#endif
