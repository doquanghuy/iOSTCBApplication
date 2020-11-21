//
//  EditEnvironmentViewController.swift
//  FastMobile
//
//  Created by Huy Van Nguyen on 11/4/20.
//  Copyright © 2020 Techcombank. All rights reserved.
//

import UIKit
import TCBComponents
import RxSwift
import RxCocoa
import Domain

class EditEnvironmentViewController: UIViewController {

    var viewModel: EditEnvironmentViewModel!
    private let disposeBag = DisposeBag()
    
    @IBOutlet private var baseURLTextField: TCBTextField!
    @IBOutlet private var realmTextField: TCBTextField!
    @IBOutlet private var clientIdTextField: TCBTextField!
    @IBOutlet private var saveButton: UIButton!
    @IBOutlet private var dbsBaseURLTextField: TCBTextField!
    @IBOutlet private var dbsGatewayTextField: TCBTextField!
    @IBOutlet private var dbsLegalEntityInternalIdTextField: TCBTextField!
    @IBOutlet private var dbsServiceAgreementIdTextField: TCBTextField!
    @IBOutlet private var dbsExternalServiceAgreementIdTextField: TCBTextField!
    @IBOutlet private var dbsSearchIBANTextField: TCBTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        bindViewModel()
    }
    
    func bindViewModel() {
        let input = EditEnvironmentViewModel.Input(loadTrigger: Driver.just(()), saveTrigger: saveButton.rx.tap.asDriver(), baseURLTrigger: baseURLTextField.rx.text.orEmpty.asDriver(), realmTrigger: realmTextField.rx.text.orEmpty.asDriver(), clientIdTrigger: clientIdTextField.rx.text.orEmpty.asDriver(), dbsBaseURLTrigger: dbsBaseURLTextField.rx.text.orEmpty.asDriver(), dbsGatewayTrigger: dbsGatewayTextField.rx.text.orEmpty.asDriver(), dbsLegalEntityInternalIdTrigger: dbsLegalEntityInternalIdTextField.rx.text.orEmpty.asDriver(), dbsServiceAgreementIdTrigger: dbsServiceAgreementIdTextField.rx.text.orEmpty.asDriver(), dbsExternalServiceAgreementIdTrigger: dbsExternalServiceAgreementIdTextField.rx.text.orEmpty.asDriver(), dbsSearchIBANTrigger: dbsSearchIBANTextField.rx.text.orEmpty.asDriver())
        let output = viewModel.transform(input: input)

        output.configuration.drive { [weak self]  configuration in
            self?.fillData(configuration)
        }.disposed(by: disposeBag)
        
        output.saveSuccess.drive { [weak self] (result, environment) in
            if result ?? false {
                self?.navigationController?.dismiss(animated: true, completion: {
                    TCBEnvironmentManager.shared.switchEnviroment(into: environment)
                })
            }
        }.disposed(by: disposeBag)
    }
    
    func configureView() {
        self.title = "Edit"
        configureTextField(baseURLTextField, placeholder: "BaseURL")
        configureTextField(realmTextField, placeholder: "Realm")
        configureTextField(clientIdTextField, placeholder: "ClientId")
        
        configureTextField(dbsBaseURLTextField, placeholder: "BaseURL")
        configureTextField(dbsGatewayTextField, placeholder: "Gateway")
        configureTextField(dbsLegalEntityInternalIdTextField, placeholder: "LegalEntityInternalId")
        configureTextField(dbsServiceAgreementIdTextField, placeholder: "ServiceAgreementId")
        configureTextField(dbsExternalServiceAgreementIdTextField, placeholder: "ExternalServiceAgreementId")
        configureTextField(dbsSearchIBANTextField, placeholder: "SearchIBAN")
    }
    
    func configureTextField(_ textField: TCBTextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.inactiveLineColor = UIColor.init(hexString: "cbd9e1") // 203 217 225
        textField.activeLineColor = UIColor.init(hexString: "cbd9e1") // 203 217 225
        textField.activePlaceholderTextColor = UIColor.init(hexString: "7b7b7b") // 123 123 123
        textField.inactivePlaceholderTextColor = UIColor.init(hexString: "7b7b7b") // 123 123 123
        textField.errorLineColor = UIColor.init(hexString: "ed1c23") // 237 28 35
        textField.autocapitalizationType = .none
        textField.font = UIFont.boldFont(18)
        textField.textColor = UIColor.init(hexString: "334955")
        textField.placeholderFontActive = UIFont.mediumFont(12)
        textField.placeholderFontInactive = UIFont.mediumFont(16)
    }
    
    private func fillData(_ configuration: Configuration) {
        baseURLTextField.text = configuration.backbase?.identity?.baseURL
        realmTextField.text = configuration.backbase?.identity?.realm
        clientIdTextField.text = configuration.backbase?.identity?.clientId
        
        dbsBaseURLTextField.text = configuration.custom?.dbs?.baseURL
        dbsGatewayTextField.text = configuration.custom?.dbs?.gateway
        dbsLegalEntityInternalIdTextField.text = configuration.custom?.dbs?.legalEntityInternalId
        dbsServiceAgreementIdTextField.text = configuration.custom?.dbs?.serviceAgreementId
        dbsExternalServiceAgreementIdTextField.text = configuration.custom?.dbs?.externalServiceAgreementId
        dbsSearchIBANTextField.text = configuration.custom?.dbs?.searchIBANURL
    }

}
