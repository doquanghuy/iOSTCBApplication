//
// Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

import Foundation

public enum CellType: String {
    case dropDown = "DropdownCell"
    case accountSummary = "AccountSummaryCell"
    case productSummaryHeader = "SummarySectionHeaderCell"
    case deposits = "RDCHistoryWidgetViewCell"
    case conversations = "MessageTableViewCell"
    case notifications = "NotificationTableViewCell"
    case transactions = "TransactionsWidgetViewCell"
    case categories = "CategoryItemCell"
    case transactionDetail = "TransactionDetailCell"
    case transactionDetailHeader = "TransactionDetailHeaderCell"
    case amountInput = "AmountInputTableViewCell"
    case dailyLimit = "CustomDailyLimitTableViewCell"
    case captureImages = "CustomCaptureImagesTableViewCell"
    case checkImages = "CustomCheckImagesTableViewCell"
    case depositData = "CustomDepositDataTableViewCell"
    case depositDataPictures = "CustomDepositDataPicturesTableViewCell"
    case contacts = "ContactsWidgetViewCell"
    case contactDetails = "ContactDetailsTableViewCell"
    case billPayments = "BillPaymentsTableViewCell"
    case formInput = "FormInputTableViewCell"
    case formLabel = "FormTableViewCell" //
    case reviewLabel = "ReviewLabelTableViewCell"
    case payees = "BillPayPayeesTableViewCell"
    case menuItem = "MenuItemCell"
    case menuSubtitledItem = "MenuItemSubtitledCell"
    case menuSubtitledWithIconItem = "MenuItemSubtitledWithIconCell"
    case empty = ""
    case spendingOverviewChartCell
    case spendingOverviewCategoryCell
    case payeeFormCell = "PayeeFormTableViewCell"
    case productDetailCell = "ProductDetailTableViewCell"
    case placeDetailCell = "PlaceDetailTableViewCell"
    case placeDetailButtonCell = "PlaceDetailButtonTableViewCell"
}
