//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import Foundation
import UIKit

public enum TCBNudgeType {
    case error
    case info
    case warning
    case success
    
    var icon: UIImage {
        switch self {
        case .error:
            return  #imageLiteral(resourceName: "ic_warning")
        case .info:
            return #imageLiteral(resourceName: "ic_error")
        case .success:
            return  #imageLiteral(resourceName: "ic_check_circle")
        case .warning:
            return #imageLiteral(resourceName: "ic_error")
        }
    }
}
