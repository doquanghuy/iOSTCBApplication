//
//  BeneficiaryListViewModel.swift
//  FastMobile
//
//  Created by Dinh Duong on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import Domain
import TCBService

protocol BeneficiaryListViewModeling {
    var favoriteBeneficiaries: [Beneficiary] { get }
    var selectedBeneficiary: PublishSubject<Beneficiary> { get }
    
    var originBeneficiaries: [Beneficiary] { get }
    var searchedBeneficiaries: [Beneficiary] { get }
    
    var selectedBeneficiaryValue: Beneficiary? {get set}
    
    func didSelectBeneficiary(at indexPath: IndexPath)
    func searchBeneficiary(searchTerm: String, completion: @escaping TCBResponseCompletion<Bool>)
    func fetchBeneficiaries(completion: @escaping (Error?) -> Void)
    func deleteContactAt(_ index: Int, completion: ((Bool?, Error?) -> Void)?)
}

class BeneficiaryListViewModel: BeneficiaryListViewModeling {
    var originBeneficiaries: [Beneficiary] = []
    var searchedBeneficiaries: [Beneficiary] = []
    var favoriteBeneficiaries: [Beneficiary] = []
    var selectedBeneficiary = PublishSubject<Beneficiary>()
    
    var selectedBeneficiaryValue: Beneficiary? = nil
    
    let useCase = TCBAccountUseCase()
    let contactUseCase = TCBUseCasesProvider().makeContactUseCase()
    
    ///
    /// - Returns: if beneficiaries empty, will return array with one value is  selectedBeneficiaryValue.
    func fetchBeneficiaries(completion: @escaping (Error?) -> Void) {
        
        contactUseCase.fetchContactList { [weak self] (resutl) in
            switch resutl {
            case let .success(contacts):
                let beneficiaries = contacts?.compactMap({ contact -> Beneficiary? in
                    let account = contact.accounts.first
                    let beneficiary = Beneficiary(accountName: contact.name,
                                                  bankName: account?.bank?.name ?? "",
                                                  accountId: account?.accountNumber ?? "",
                                                  isFavorited: false,
                                                  bankIcon: account?.bank?.logo ?? "",
                                                  receiver: nil,
                                                  name: account?.name,
                                                  contactId: contact.id)
                    return beneficiary
                })
                self?.originBeneficiaries.append(contentsOf: beneficiaries ?? [])
                completion(nil)
            case let .error(err):
                completion(err)
            }
        }
    }
    
    func didSelectBeneficiary(at indexPath: IndexPath) {
        guard let section = BeneficiarySection(rawValue: indexPath.section) else { return }
        switch section {
        case .favorite:
            let beneficiary = favoriteBeneficiaries[indexPath.row]
            selectedBeneficiary.onNext(beneficiary)
            selectedBeneficiaryValue = beneficiary
        case .all:
            let beneficiary = searchedBeneficiaries[indexPath.row]
            let newBeneficiary = Beneficiary(accountName: beneficiary.name ?? beneficiary.accountName,
                                                  bankName: beneficiary.bankName,
                                                  accountId: beneficiary.accountId,
                                                  isFavorited: beneficiary.isFavorited,
                                                  bankIcon: beneficiary.bankIcon,
                                                  receiver: beneficiary.receiver,
                                                  name: beneficiary.name,
                                                  contactId: beneficiary.contactId)
            selectedBeneficiary.onNext(newBeneficiary)
            selectedBeneficiaryValue = newBeneficiary
        }
    }
    
    func fetchBeneficiaryList() {
        guard let url = Bundle.main.url(forResource: "Contacts", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let parsedBeneficiaryList = try decoder.decode([Beneficiary].self, from: data)
            originBeneficiaries = parsedBeneficiaryList
        } catch {
            print("error:\(error)")
        }
    }
    
    func searchBeneficiary(searchTerm: String, completion: @escaping TCBResponseCompletion<Bool>) {
        guard !searchTerm.isEmpty else {
            searchedBeneficiaries = originBeneficiaries
            completion(.success(true))
            return
        }
        
        searchedBeneficiaries = originBeneficiaries
            .filter({
                $0.accountName.lowercased().contains(searchTerm.lowercased())
            })
        completion(.success(true))
    }
    
    func deleteContactAt(_ index: Int, completion: ((Bool?, Error?) -> Void)?) {
        guard let beneficiary = searchedBeneficiaries[safe: index],
              let contactId = beneficiary.contactId else { return }
        
        contactUseCase.deleteContact(contactId) { [weak self] (_, error) in
            guard error == nil else {
                completion?(false, error)
                return
            }
            self?.searchedBeneficiaries.remove(at: index)
            completion?(true, nil)
        }
    }
}
