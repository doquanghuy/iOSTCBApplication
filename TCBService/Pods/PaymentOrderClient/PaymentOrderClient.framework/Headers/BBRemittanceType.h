//
//  Created by Backbase R&D B.V. on 04/09/2018.
//

#ifndef BBRemittanceType_h
#define BBRemittanceType_h

#import <Foundation/NSString.h>

/// When type is structured it consists of some XML tags used when the transaction was uploaded.
typedef NSString *BBRemittanceType NS_TYPED_ENUM;

extern BBRemittanceType const kBBRemittanceTypeStructured;
extern BBRemittanceType const kBBRemittanceTypeUnstructured;

#endif
