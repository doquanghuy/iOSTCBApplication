//
//  HomeViewController.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/10/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Domain
import TCBComponents
import TCBService
import Nuke
import SWRevealViewController

extension Notification.Name {
    static let profileDidChange = Notification.Name("profileDidChange")
}

protocol HomeScrollViewDelegate: class {
    func didScrollToCashFlowSection()
}

class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var viewModel: HomeViewModeling = HomeViewModel()
    private weak var delegate: HomeScrollViewDelegate?
    @IBOutlet private weak var messageView: UIView!
    @IBOutlet private weak var closeMessageButton: UIButton!
    @IBOutlet weak var messageDisplayLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
//    @IBOutlet weak var loginButton: TCBButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var animatedCashflow = false
    var displayName: String? {
        return user.name
    }
    var user: User!
    var services: UseCasesProvider!
    lazy var profileViewModel: ProfileViewModel = {
        let viewModel = ProfileViewModel(user: user)
        return viewModel
    }()
    
    #if DEBUG
    var showLeftMenuImmediately: Bool = false
    #endif
    
    private var refreshControl: UIRefreshControl?
    
    private lazy var avatar: UIImageView = {
        
        let view = UIImageView(image: UIImage(named: "avatar"))
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapProfile))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        additionalSafeAreaInsets.top = 232 - 44 - 20
        view.backgroundColor = .clear
        extendedLayoutIncludesOpaqueBars = true
        
        closeMessageButton.rx.tap.bind { [weak self] in
            UIView.animate(withDuration: 0.25) {
                self?.messageView.isHidden = true
            }
        }.disposed(by: disposeBag)
        
        loadUserProfile()
        customNavigationBar()
        
        delegate = children.first { $0 is CashflowViewController } as? HomeScrollViewDelegate
        view.accessibilityIdentifier = "HomeViewController"
//        showPasscodeScreenIfNeeded()
        
        avatarImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapProfile))
        avatarImageView.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(profileDidChange(_:)), name: .profileDidChange, object: nil)
        
        //Hide all content views for the demo
//        if let scrollView = view.subviews.first as? UIScrollView {
//            scrollView.contentInsetAdjustmentBehavior = .always
//            if let stackBoundView = scrollView.subviews.first?.subviews.last {
//                stackBoundView.isHidden = true
//            }
//        }
        
        // login button
//        loginButton.layer.cornerRadius = 14.5
//        loginButton.isHidden = !(user.name?.isEmpty ?? true)
//        loginButton.rx.tap.bind(onNext: { [weak self] in
//            self?.showOnboardViewIfNeeded(actionAfterLogin: { [weak self] user in
//                guard let self = self else { return }
//                self.user = user
//                self.loginButton.isHidden = !(user.name?.isEmpty ?? true)
//                self.loadUserProfile()
//            })
//        }).disposed(by: disposeBag)
        
        refreshControl = UIRefreshControl()
        
        if let refreshControl = refreshControl {
            refreshControl.attributedTitle = NSAttributedString(string: "")
            refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
            scrollView.addSubview(refreshControl)
        }
    }
    
    @objc private func refresh(sender:AnyObject)
    {
        NotificationCenter.default.post(name: .refeshDataInHomeVC, object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl?.endRefreshing()
        }
        
    }
    
    @objc func profileDidChange(_ notification: Notification) {
        if let user = notification.object as? User {
            self.user = user
        }
    }
    
    @objc private func didTapProfile() {
        showOnboardViewIfNeeded { [weak self] user in
            guard let self = self else { return }
            
            self.user = user
//            self.loginButton.isHidden = !(user.name?.isEmpty ?? true)
            
            let profileVC = ProfileViewController()
            profileVC.viewModel = self.profileViewModel
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animatedCashflow = false
        
        #if DEBUG
        if showLeftMenuImmediately {
            revealViewController()?.revealToggle(animated: true)
        }
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.setValue(0, forKey: "Selected")
        messageDisplayLabel.text =  "Good morning,\n" + (user.firstName ?? "")

        title = "Good morning" + ", \(user.firstName ?? "")"
        
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 0
        }
    }
    
    private var balanceViewController: BalanceViewController?
    
    // swiftlint:disable:next cyclomatic_complexity
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "BalanceIdentifier":
            guard let balanceViewController = segue.destination as? BalanceViewController else { return }
            balanceViewController.viewModel = BalanceViewModel(productService: TCBServiceFactory.loadService(),
                                                               productUseCase: TCBUseCasesProvider().makeProductUseCase())
            self.balanceViewController = balanceViewController
//        case "MessagesIdentifier":
//            guard let messageViewController = segue.destination as? MessageViewController else { return }
//            messageViewController.viewModel = MessageViewModel(useCase: services.makeMessagesUseCase())
//        case "OfferingIdentifier":
//            guard let offeringViewController = segue.destination as? OfferingViewController else { return }
//            let useCase = OfferingUseCaseProvider()
//            offeringViewController.viewModel = OfferingViewModel(useCase: OfferingUseCaseProvider(), navigator: DefaultOfferingNavigator(services: useCase, navigationController: self.navigationController))
//        case "CashflowIdentifier":
//            guard let cashflowViewController = segue.destination as? CashflowViewController else { return }
//            let useCase = CashflowUseCaseProvider()
//            cashflowViewController.viewModel = CashflowViewModel(useCase: CashflowUseCaseProvider(), navigator: DefaultCashflowNavigator(services: useCase, navigationController: self.navigationController))
//        case "RecentActivityIdentifier":
//            guard let recentActivityViewController = segue.destination as? RecentActivityViewController else { return }
////            let useCase = services.makePaymentUseCase()
//            let useCase = services.makeRecentActivityUseCase()
//            recentActivityViewController.viewModel = RecentActivityViewModel(useCase: useCase,
//                                                                             navigator: DefaultRecentActivityNavigator(services: useCase,
//                                                                                                                       navigationController: self.navigationController))
//            balanceViewController?.currentAccount
//                .asDriver()
//                .drive(onNext: { account in
//                    recentActivityViewController.viewModel.currentAccount = account
//                }).disposed(by: disposeBag)
//        case "AuditIdentifier":
//            guard let auditViewController = segue.destination as? AuditViewController else { return }
//            guard let userName = user.email else { return }
//            let useCase = services.makeAuditUseCase()
//            auditViewController.viewModel = AuditViewModel(useCase: useCase,
//                                                           navigator: DefaultAuditNavigator(services: useCase,
//                                                                                            navigationController: self.navigationController),
//                                                           userName: userName)
        default:
            break
        }
    }
    
    // MARK: Private
//    private func showPasscodeScreenIfNeeded() {
//        if viewModel.shouldShowPasscodeScreen() {
//            TCBPasscodeViewController.showWith(type: .firstTimeInstall, in: self)
//        }
//    }
    
    private func customNavigationBar() {
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "menu"), for: .normal)
        leftButton.contentMode = .scaleAspectFit
        leftButton.addTarget(self, action: #selector(menuButtonDidTap(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItems = [UIBarButtonItem.init(customView: leftButton)]
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem.init(customView: avatar)]
    }
    
    private func configureSubviews() {
        messageDisplayLabel.text =  "Good morning,\n" + (user.firstName ?? "")
        title = "Good morning, " + (user.firstName ?? "")
        
        guard let avatarURL = URL(string: user.avatarURL ?? "") else {
            return
        }
        Nuke.loadImage(with: avatarURL, into: avatar)
    }
    
    @IBAction func menuButtonDidTap(_ sender: Any) {
        revealViewController()?.revealToggle(animated: true)
    }
    
    private func loadUserProfile() {
        viewModel.getUserProfile { [weak self] (profile) in
            self?.user.firstName = profile.givenName
            self?.user.lastName = profile.familyName
            self?.user.email = profile.email
            self?.user.userId = profile.userID
            DispatchQueue.main.async {
                self?.configureSubviews()
            }
        }
    }
    
    private func showOnboardViewIfNeeded(actionAfterLogin: ((User) -> Void)? = nil) {
        guard user.email?.isEmpty ?? true else {
            actionAfterLogin?(user)
            return
        }
        
        let nav = BaseNavigationViewController()

        // register VC
        let registerNavigator = CustomRegisterNavigator(navigationController: nav,
                                                        actionAfterLogin: actionAfterLogin)
        
        let registerViewModel = RegisterViewModel(registerUseCase: services.makeRegisterUseCase(),
                                                  loginUseCase: services.makeLoginUseCase(),
                                                  navigator: registerNavigator)
        
        let registerVC = RegisterViewController(viewModel: registerViewModel)
        
        // first step VC
        let firstStepNavigator = CustomFirstStepLogInNavigator(services: services,
                                                               navigationController: nav,
                                                               registerViewController: registerVC,
                                                               actionAfterLogin: actionAfterLogin)
        
        let firstStepViewModel = FirstStepLoginViewModel(navigator: firstStepNavigator,
                                                         services: services)
        
        let firstStepVC = FirstStepLogInViewController(viewModel: firstStepViewModel)

        // onboard VC
        let navigator = CustomOnboardNavigator(navigationController: nav,
                                                loginViewController: firstStepVC,
                                                registerViewController: registerVC)
        
        let viewModel = OnboardViewModel(navigator: navigator)
        let onboardVC = OnboardViewController(viewModel: viewModel)

        nav.viewControllers = [onboardVC]
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}

// MARK: - LeftMenuDelegate
extension HomeViewController: LeftMenuDelegate {
    
    func didTapLogout() {
        let alert = UIAlertController(title: "Log out",
                                      message: "Are you sure you want to log out ?",
                                      preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        alert.addAction(cancelButton)
        
        let confirmButton = UIAlertAction(title: "Log out", style: .default) {[weak self] (_) in
            self?.services.makeProfileUseCase().logOut()
            let services = TCBUseCasesProvider()
            let appDependencyContainer = AppDepedencyContainer(services: services)
            let mainVC = appDependencyContainer.makeMainViewController(shouldLoad: false)
            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
            appDelegate?.window?.rootViewController = mainVC
        }
        alert.addAction(confirmButton)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !animatedCashflow && scrollView.contentOffset.y >= 800 {
            animatedCashflow = true
            delegate?.didScrollToCashFlowSection()
        }
        
        if let nav = navigationController as? LargeBarNavigationViewController {
            nav.scrollViewDidScroll(scrollView)
        }
    }
}
