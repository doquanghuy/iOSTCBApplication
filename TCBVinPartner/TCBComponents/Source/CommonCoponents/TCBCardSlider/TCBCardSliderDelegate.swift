//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import UIKit

/// Protocol to delegate events in CardSlider
public protocol TCBCardSliderDelegate: AnyObject {
    func didSelectItem(item: TCBCardSliderItem)
}

/// Protocol for view factory that creates/retais views for specific CardSliderItem's
public protocol TCBCardSliderViewBuilder: AnyObject {
    func createViewFor(item: TCBCardSliderItem) -> UIView?
}

/// This is ViewModel protocol for CardSlider Item
public protocol TCBCardSliderItem {}
