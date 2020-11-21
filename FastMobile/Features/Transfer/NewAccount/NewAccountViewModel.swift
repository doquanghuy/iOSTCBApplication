//
//  NewAccountViewModel.swift
//  FastMobile
//
//  Created by Pham Thanh Hoa on 9/25/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import Domain
import TCBService

final class NewAccountViewModel: NSObject {
    
    private var accountDataSource: NewAccountDataSource?
    private let useCase = TCBUseCasesProvider().makeContactUseCase()
    
    private var beneficiaries: [Beneficiary] = []
    private let userCase = TCBAccountUseCase()
    
    private var shouldSaveBeneficiary: Bool = false
    private var usingBankAccount: Bool = true
    private var hasLikedBeneficiary: Bool = false
    
    @objc dynamic var isValidParameters: Bool = false
    @objc dynamic var reloadDataSections: IndexSet = []
    
    private weak var container: UIViewController?
    
    var currentDataSources: [DataSource] {
        guard let accountDataSource = accountDataSource  else {
            return []
        }
        
        return usingBankAccount ? accountDataSource.bankDataSources : accountDataSource.cardDataSources
    }
    
    override init() {
        super.init()
    }
    
    convenience init(dataSource: NewAccountDataSource, container: UIViewController) {
        self.init()
        self.accountDataSource = dataSource
        self.container = container
    }
    
    func confirmTransfer(_ completion: @escaping (Beneficiary?) -> Void) {
        
        guard isValidParameters else {
            completion(nil)
            return
        }
        
        let beneficiary: Beneficiary
        
        let savedName: String?
        if shouldSaveBeneficiary {
            let savedNameSource = currentDataSources.last(where: { $0.type == .textField })
            let item = savedNameSource?.items?.first as? TextFieldConfig
            savedName = item?.text
        }
        else {
            savedName = nil
        }
        
        if usingBankAccount {
            let bankSource = currentDataSources.first(where: { $0.type == .dropList })
            let bank = (bankSource?.items?.first as? DropItem)?.text
            
            let accountSource = currentDataSources.first(where: { $0.type == .textField })
            let accountItems = accountSource?.items as? [TextFieldConfig]
            
            let accountId = accountItems?.first?.text
            let accountName = accountItems?.last?.text
            
            beneficiary = Beneficiary(accountName: accountName ?? "",
                                      bankName: bank ?? "",
                                      accountId: accountId ?? "",
                                      isFavorited: hasLikedBeneficiary,
                                      bankIcon: "group",
                                      receiver: nil,
                                      name: accountName,
                                      contactId: nil)
        } else {
            let cardSource = currentDataSources.first(where: { $0.type == .textField })
            let cardId = (cardSource?.items?.first as? TextFieldConfig)?.text
            
            beneficiary = Beneficiary(accountName: "",
                                      bankName: "",
                                      accountId: cardId ?? "",
                                      isFavorited: hasLikedBeneficiary,
                                      bankIcon: "group",
                                      receiver: nil,
                                      name: nil,
                                      contactId: nil)
        }
        
        guard shouldSaveBeneficiary else {
            completion(beneficiary)
            return
        }
        
        useCase.addContact(accountName: beneficiary.accountName,
                           accountNumber: beneficiary.accountId,
                           name: savedName ?? beneficiary.accountName,
                           bank: Bank(name: beneficiary.bankName,
                                      logo: beneficiary.bankIcon,
                                      description: "")) { (status, error) in
            guard error == nil else {
                completion(nil)
                return
            }
            completion(beneficiary)
        }
    }
    
    func fillBeneficiary(with beneficiary: Beneficiary) {
        let dataSource = DataSource(type: .textField,
                                    items: [TextFieldConfig(text: beneficiary.accountId,
                                                            placeHolder: "Enter bank account",
                                                            keyboardType: .numberPad,
                                                            inputHandler: TextInputHandler.accountId,
                                                            editable: false),
                                            TextFieldConfig(text: beneficiary.accountName,
                                                            placeHolder: "Enter beneficiary name",
                                                            editable: false)])
        accountDataSource?.updateBankDataSource(at: 1, element: dataSource)
        
        let bank = DataSource(type: .dropList,
                              items: [DropItem(text: beneficiary.bankName,
                                               image: UIImage(named: beneficiary.bankIcon),
                                               placeHolder: "Select the beneficiary bank")])
        accountDataSource?.updateBankDataSource(at: 0, element: bank)
        isValidParameters = validateParameters()
    }
}

// MARK: Private methods

extension NewAccountViewModel {
    
    private func validateParameters() -> Bool {
        var isValid: Bool = true
        
        if usingBankAccount {
            let bankSource = currentDataSources.first(where: { $0.type == .dropList })
            let bank = bankSource?.items?.first as? DropItem
            if bank?.text?.isEmpty ?? true { isValid = false }
        }
        
        let accountSource = currentDataSources.first(where: { $0.type == .textField })
        let accountItems = accountSource?.items as? [TextFieldConfig]
        accountItems?.forEach({
            if $0.text?.isEmpty ?? true { isValid = false }
        })
        
        if shouldSaveBeneficiary {
            let beneficiarySource = currentDataSources.last(where: { $0.type == .textField })
            let beneficiaryItems = beneficiarySource?.items as? [TextFieldConfig]
            beneficiaryItems?.forEach({
                if $0.text?.isEmpty ?? true { isValid = false }
            })
        }
        
        return isValid
    }
    
    private func parseLikeStatus(with config: TextFieldConfig) -> DataSource {
        
        guard shouldSaveBeneficiary else {
            hasLikedBeneficiary = false
            return DataSource(type: .textField)
        }
        
        let image: UIImage? = hasLikedBeneficiary ? UIImage(named: "ic_heart_filled") : UIImage(named: "ic_heart")
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 58, height: 27))
        let imageView = UIImageView(image: image)
        
        rightView.addSubview(imageView)
        imageView.center = rightView.center
        
        var newConfig = config
        newConfig.rightView = rightView
        
        let new = DataSource(type: .textField,
                             items: [newConfig])
        
        return new
    }
}

// MARK: UICollectionViewDelegate

extension NewAccountViewModel: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDataSource

extension NewAccountViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return currentDataSources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = currentDataSources[safe: section] else { return 0 }
        
        if section.isHorizontal { return 1 }
        
        return section.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = currentDataSources[safe: indexPath.section],
            let cell = collectionView.dequeueReusableCell(of: section.type.cellClass,
                                                          indexPath: indexPath) else { return UICollectionViewCell() }
        
        cell.setup(with: section, index: indexPath, actionHandler: self)
        cell.accessibilityIdentifier = "\(indexPath.section) - \(indexPath.item)"
        
        return cell
    }
}

// MARK: GridLayoutProtocol

extension NewAccountViewModel: GridLayoutProtocol {
    
    func sizeForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        guard let section = currentDataSources[safe: indexPath.section] else { return .zero }
        
        return CGSize(width: collectionView.bounds.width / CGFloat(section.type.numberOfColumns),
                      height: section.type.height)
    }
    
    func insetForItemAt(_ collectionView: UICollectionView, indexPath: IndexPath) -> UIEdgeInsets {
        guard let section = currentDataSources[safe: indexPath.section] else { return .zero }
        
        switch section.type {
        case .segment:
            return UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        case .textField:
            return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        case .switchItem:
            return UIEdgeInsets(top: 35, left: 0, bottom: 0, right: 0)
        default:
            return .zero
        }
    }
    
    func numberOfColumnsAt(_ collectionView: UICollectionView, section: Int) -> Int {
        1
    }
}

// MARK: CellActionProtocol

extension NewAccountViewModel: CellActionProtocol {
    
    func textValueChanged(_ text: String?, at indexPath: IndexPath) {
        
        guard let accountDataSource = accountDataSource,
              var dataSource = currentDataSources[safe: indexPath.section],
            var config = dataSource.items?[safe: indexPath.item] as? TextFieldConfig else { return }
        
        config.text = text
        dataSource.items?.remove(at: indexPath.item)
        dataSource.items?.insert(config, at: indexPath.item)
        
        if usingBankAccount {
            accountDataSource.updateBankDataSource(at: indexPath.section, element: dataSource)
            if indexPath.section == currentDataSources.count - 1 {
                accountDataSource.updateCardDataSource(at: indexPath.section, element: dataSource)
            }
        } else {
            accountDataSource.updateCardDataSource(at: indexPath.section, element: dataSource)
            if indexPath.section == currentDataSources.count - 1 {
                accountDataSource.updateBankDataSource(at: indexPath.section, element: dataSource)
            }
        }
        
        isValidParameters = validateParameters()
    }
    
    func selectedSegment(_ index: Int, at indexPath: IndexPath) {
        usingBankAccount = index == 0
        
        let new = DataSource(type: .segment,
                             isHorizontal: true,
                             items: [Segment(title: "Bank account", isSelected: usingBankAccount),
                                     Segment(title: "Card number", isSelected: !usingBankAccount)])
        
        accountDataSource?.updateBankDataSource(at: indexPath.section, element: new)
        accountDataSource?.updateCardDataSource(at: indexPath.section, element: new)
        
        reloadDataSections = [1, 2]
        isValidParameters = validateParameters()
    }
    
    func showDropList(at indexPath: IndexPath) {
    }
    
    func switchValueChanged(_ isOn: Bool, indexPath: IndexPath) {
        shouldSaveBeneficiary = isOn
        
        guard var dataSource = currentDataSources[safe: indexPath.section],
              var item = dataSource.items?[safe: indexPath.item] as? Switch else {
            return
        }
        
        item.isOn = isOn
        dataSource.items?[indexPath.item] = item
        accountDataSource?.updateBankDataSource(at: indexPath.section, element: dataSource)
        accountDataSource?.updateCardDataSource(at: indexPath.section, element: dataSource)
        
        let config = TextFieldConfig(placeHolder: "Enter beneficiary name",
                                     tappable: true)
        
        let new = parseLikeStatus(with: config)
        accountDataSource?.updateBankDataSource(at: currentDataSources.count - 1, element: new)
        accountDataSource?.updateCardDataSource(at: currentDataSources.count - 1, element: new)
        
        reloadDataSections = [3]
        isValidParameters = validateParameters()
    }
    
    func didTapRightView(_ text: String?, at indexPath: IndexPath) {
        guard !(text?.isEmpty ?? true) else { return }
        
        guard let accountDataSource = accountDataSource,
              let dataSource = currentDataSources[safe: indexPath.section],
            let config = dataSource.items?[safe: indexPath.item] as? TextFieldConfig else { return }
        
        hasLikedBeneficiary = !hasLikedBeneficiary
        
        let new = parseLikeStatus(with: config)
        accountDataSource.updateBankDataSource(at: currentDataSources.count - 1, element: new)
        accountDataSource.updateCardDataSource(at: currentDataSources.count - 1, element: new)
        
        reloadDataSections = [4]
    }
}

// MARK: BankListNavigator

extension NewAccountViewModel: BankListNavigator {
    func dismissWithBankItem(_ bank: Bank) {
        
        container?.navigationController?.popViewController(animated: true)
        
        guard let accountDataSource = accountDataSource,
            let index = currentDataSources.firstIndex(where: { $0.type == .dropList }),
            var dataSource = currentDataSources[safe: index],
              let item = dataSource.items?.first as? DropItem else { return }
        
        let new = DropItem(text: bank.name,
                           image: UIImage(named: bank.logo),
                           placeHolder: item.placeHolder)
        
        dataSource.items?[0] = new
        accountDataSource.updateBankDataSource(at: index, element: dataSource)
        
        reloadDataSections = [index]
        isValidParameters = validateParameters()
    }
    
    func dismissPopup() {}
}

extension NewAccountViewModel {
    func searchBeneficiary(searchTerm: String, completion: @escaping TCBResponseCompletion<[Beneficiary]>) {
        userCase.lookupAccountInfo(name: searchTerm) { [weak self] (result) in
            switch result {
            case .success(let cards):
                guard let cards = cards else {
                    completion(.success([]))
                    return
                }
                let beneficiaries = cards.map({ (card) -> Beneficiary in
                    let receiver = Receiver(receiverName: card.name,
                                            receiverIdentification: "cefc18f0-c2c7-4b0f-b1fa-1382c820f013",
                                            receiverScheme: "ID",
                                            receiverContactId: "61425aed-5d5c-4292-8f60-e2f3efc9b66a",
                                            receiverId: "61425aed-5d5c-4292-8f60-e2f3efc9b66a",
                                            receiverBankCode: card.productId,
                                            receiverBankBIC: card.bic,
                                            receiverBankName: card.productKindName,
                                            receiverBankAddress: "FINANCIAL PLAZA BIJLMERDREEF 109 1102 BW AMSTERDAM",
                                            receiverBankCountry: "NL")
                    let beneficiary = Beneficiary(accountName: card.name,
                                                  bankName: "Techcombank",
                                                  accountId: card.iban,
                                                  isFavorited: false,
                                                  bankIcon: "ic_bank_tech",
                                                  receiver: receiver,
                                                  name: card.name,
                                                  contactId: nil)
                    return beneficiary
                })
                self?.beneficiaries = beneficiaries
                completion(.success(beneficiaries))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension NewAccountViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beneficiaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BeneficiaryTableViewCell
        
        let beneficiary = beneficiaries[indexPath.row]
        cell.beneficiary = beneficiary
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 24))
        view.textColor = UIColor.black.withAlphaComponent(0.6)
        view.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        view.backgroundColor = .clear
        guard let section = BeneficiarySection(rawValue: section) else { return nil }
        switch section {
        case .favorite:
            view.text = "Favorite lists"
        case .all:
            view.text = "Bank/ Card number accounts"
        }
        return view
    }
}

// MARK: - UITableViewDelegate

extension NewAccountViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let beneficiary = beneficiaries[safe: indexPath.row] else { return }
        fillBeneficiary(with: beneficiary)
    }
}
