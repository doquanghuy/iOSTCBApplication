//
//  Created by Backbase R&D B.V. on 08/05/2019.
//

#ifndef ProductsClient_BBTimePeriod_h
#define ProductsClient_BBTimePeriod_h

#import <CommonUtils/CommonUtils.h>

/// Time period indicator for an arrangement item.
typedef NSString * BBTimePeriod NS_TYPED_ENUM;

extern BBTimePeriod const kBBTimePeriodLastDay;
extern BBTimePeriod const kBBTimePeriodLastWeek;
extern BBTimePeriod const kBBTimePeriodLastMonth;
extern BBTimePeriod const kBBTimePeriodLastYear;
extern BBTimePeriod const kBBTimePeriodAll;

#endif /* ProductsClient_BBTimePeriod_h */
