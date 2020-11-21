//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef BBTransferFrequency_h
#define BBTransferFrequency_h

#import <Foundation/NSString.h>

typedef NSString *BBTransferFrequency NS_TYPED_ENUM;

extern BBTransferFrequency const kBBTransferFrequencyOnce;
extern BBTransferFrequency const kBBTransferFrequencyDaily;
extern BBTransferFrequency const kBBTransferFrequencyWeekly;
extern BBTransferFrequency const kBBTransferFrequencyBiWeekly;
extern BBTransferFrequency const kBBTransferFrequencyMonthly;
extern BBTransferFrequency const kBBTransferFrequencyQuarterly;
extern BBTransferFrequency const kBBTransferFrequencyYearly;

#endif
