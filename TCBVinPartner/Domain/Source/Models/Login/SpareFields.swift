//
//  SpareFields.swift
//  MBTest
//
//  Created by Huy TO. Nguyen Van on 9/30/20.
//

import Foundation

public struct SpareFields: TCBAutoCodable {

    public var spareString1: String?
    public var spareString2: String?
    public var spareString3: String?
    public var spareString4: String?
    public var spareString5: String?
    public var spareString6: String?
    public var spareString7: String?
    public var spareString8: String?
    public var spareString9: String?
    public var spareString10: String?
    public var spareDate1: Int?
    public var spareDate2: Int?
    public var spareDate3: Int?
    public var spareDate4: Int?
    public var spareDate5: Int?
    public var spareInteger1: Int64?
    public var spareInteger2: Int64?
    public var spareInteger3: Int64?
    public var spareInteger4: Int64?
    public var spareInteger5: Int64?
    public var spareBoolean1: Bool?
    public var spareBoolean2: Bool?
    public var spareBoolean3: Bool?
    public var spareBoolean4: Bool?
    public var spareBoolean5: Bool?
    public var spareCLOB1: String?

    public init(spareString1: String?, spareString2: String?, spareString3: String?, spareString4: String?, spareString5: String?, spareString6: String?, spareString7: String?, spareString8: String?, spareString9: String?, spareString10: String?, spareDate1: Int?, spareDate2: Int?, spareDate3: Int?, spareDate4: Int?, spareDate5: Int?, spareInteger1: Int64?, spareInteger2: Int64?, spareInteger3: Int64?, spareInteger4: Int64?, spareInteger5: Int64?, spareBoolean1: Bool?, spareBoolean2: Bool?, spareBoolean3: Bool?, spareBoolean4: Bool?, spareBoolean5: Bool?, spareCLOB1: String?) {
        self.spareString1 = spareString1
        self.spareString2 = spareString2
        self.spareString3 = spareString3
        self.spareString4 = spareString4
        self.spareString5 = spareString5
        self.spareString6 = spareString6
        self.spareString7 = spareString7
        self.spareString8 = spareString8
        self.spareString9 = spareString9
        self.spareString10 = spareString10
        self.spareDate1 = spareDate1
        self.spareDate2 = spareDate2
        self.spareDate3 = spareDate3
        self.spareDate4 = spareDate4
        self.spareDate5 = spareDate5
        self.spareInteger1 = spareInteger1
        self.spareInteger2 = spareInteger2
        self.spareInteger3 = spareInteger3
        self.spareInteger4 = spareInteger4
        self.spareInteger5 = spareInteger5
        self.spareBoolean1 = spareBoolean1
        self.spareBoolean2 = spareBoolean2
        self.spareBoolean3 = spareBoolean3
        self.spareBoolean4 = spareBoolean4
        self.spareBoolean5 = spareBoolean5
        self.spareCLOB1 = spareCLOB1
    }
}
