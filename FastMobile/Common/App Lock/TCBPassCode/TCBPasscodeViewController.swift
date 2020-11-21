//
//  AppcodeViewController.swift
//  FastMobile
//
//  Created by Duong Dinh on 10/5/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import LocalAuthentication
import AudioToolbox
import PromiseKit

/// Translated code from Objective-C class so it's quite messy :)
class TCBPasscodeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var characterLabelsArray: [UIView]!
    @IBOutlet weak var charactersView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var touchIDButton: UIButton!
    
    let minimumSpace: CGFloat = 10
    // MARK: - Variables
    var passcodeType: TCBPasscodeType = .firstTimeInstall
    
    lazy var effectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: blur)
        return effectView
    }()
    
    lazy var blur: UIBlurEffect = {
        let blur = UIBlurEffect.init(style: .dark)
        
        return blur
    }()
    
    // Number of entered characters
    var countCharacters: Int = 0
    // Save current passcode
    var passcodeString = ""
    // Set up passcode
    var setupPasscodAttempt: TCBPasscodeSetupAttempt = .initial
    // New passcode
    var newPasscode: String = ""
    // New passcode confirm
    var confirmNewPasscode = ""
    private var viewModel: TCBPasscodeViewModeling = TCBPasscodeViewModel()
    
    static func showWith(type: TCBPasscodeType, in viewController: UIViewController) {
        let passcodeVC = TCBPasscodeViewController()
        passcodeVC.passcodeType = type
        passcodeVC.showInViewController(viewController)
    }
    
    func showInViewController(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromTop
        view.window?.layer.add(transition, forKey: nil)
        effectView.frame = viewController.view.frame
        view.frame = viewController.view.frame
        
        viewController.view.addSubview(effectView)
        viewController.view.addSubview(view)
        viewController.addChild(self)
        didMove(toParent: viewController)
        modalPresentationStyle = .fullScreen
    }
}

// MARK: - Setups
extension TCBPasscodeViewController {
    
    func initComponents() {
        view.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TCBPasscodeCollectionViewCell.self,
                                forCellWithReuseIdentifier: TCBPasscodeCollectionViewCell.cellIdentifier)
        
        // Set character views
        for characterView in characterLabelsArray {
            characterView.layer.cornerRadius = characterView.frame.width / 2
            characterView.layer.borderColor = UIColor.lightGray.cgColor
            characterView.layer.borderWidth = 0.4
            characterView.layer.masksToBounds = true
        }
        resetLabels()
        
        // Status bar
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func refresh() {
        setDotView(color: .white)
        resetValues()
        resetLabels()
    }
    
    func resetAfterFirstSetup() {
        setDotView(color: .white)
        countCharacters = 0
    }
    
    func resetLabels() {
        let isFirstTimeInstalled = passcodeType == .firstTimeInstall
        titleLabel.text = isFirstTimeInstalled ? "Set up new Appcode" : "Enter Appcode"
        cancelButton.isHidden = true
        cancelButton.setTitle(isFirstTimeInstalled ? "Reset" : "Cancel", for: .normal)
    }
    
    func resetValues() {
        setupPasscodAttempt = .initial
        countCharacters = 0
        passcodeString = ""
        newPasscode = ""
        confirmNewPasscode = ""
    }
}

// MARK: - Life Cycle
extension TCBPasscodeViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponents()
        refresh()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension TCBPasscodeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPads
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TCBPasscodeCollectionViewCell.cellIdentifier,
                                                      for: indexPath) as! TCBPasscodeCollectionViewCell
        
        cell.isHidden = viewModel.shouldHideCellAt(index: indexPath.row)
        let padNumber = viewModel.padTextAt(index: indexPath.row)
        cell.numberButton.setTitle(padNumber, for: .normal)
        cell.numberButton.tag = Int(padNumber) ?? 0
        cell.numberButton.addTarget(self,
                                    action: #selector(buttonClicked(button:)),
                                    for: .touchUpInside)
        cell.numberButton.indexPath = indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: minimumSpace, bottom: 0, right: minimumSpace)
    }
}

// MARK: - Navigation
extension TCBPasscodeViewController {
    
    func dismiss(shouldDelay: Bool = false) {
        let dismissBlock = {
            self.willMove(toParent: nil)
            self.effectView.removeFromSuperview()
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
        
        if shouldDelay {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                dismissBlock()
            }
        } else {
            dismissBlock()
        }
    }
}

// MARK: - Actions
extension TCBPasscodeViewController {
    
    // TODO: Refactor
    @objc func buttonClicked(button: TCBPasscodeButton) {
        AudioServicesPlaySystemSound(1104)
        guard let indexPath = button.indexPath else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) as? TCBPasscodeCollectionViewCell else { return }
        let number = cell.numberButton.titleLabel?.text ?? ""
        
        setDotView(countCharacters, color: .darkGray)
        countCharacters += 1
        
        if passcodeType == .firstTimeInstall {
            // Set up new passcode
            if setupPasscodAttempt == .initial {
                newPasscode += number
            } else if setupPasscodAttempt == .confirm {
                confirmNewPasscode += number
            }
        } else if passcodeType == .login {
            passcodeString += number
        }
        guard countCharacters == 4 else { return }
        passcodeDidCompleteTyping()
    }
    
    private func passcodeDidCompleteTyping() {
        switch passcodeType {
        case .firstTimeInstall:
            if setupPasscodAttempt == .initial {
                animateAfterFirstSetup()
            } else {
                if confirmNewPasscode == newPasscode {
                    // Save
                    viewModel.passCode = newPasscode
                    dismiss()
                } else {
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    ViewShaker(viewsArray: characterLabelsArray).shakeWithDuration(duration: 0.3) {
                        self.titleLabel.text = "Appcode did not match. Try again."
                        self.resetAfterFirstSetup()
                        self.confirmNewPasscode = ""
                        guard self.newPasscode.count > 4 else { return }
                        let length = self.newPasscode.count
                        self.newPasscode = (self.newPasscode as NSString).substring(to: length - 1)
                    }
                }
            }
        case .login:
            let passcode = viewModel.passCode
            if passcodeString == passcode {
                dismiss(shouldDelay: true)
            } else {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                ViewShaker(viewsArray: characterLabelsArray).shakeWithDuration(duration: 0.3) {
                    self.refresh()
                }
            }
        }
    }
}

// MARK: - Actions
extension TCBPasscodeViewController {
    
    @IBAction func cancelButtonClicked() {
        guard passcodeType == .firstTimeInstall else { return }
        guard newPasscode != "" else { return }
        
        let frame = charactersView.frame
        
        firstly {
            promise {
                self.cancelButton.isHidden = true
                self.charactersView.frame = CGRect(x: -500, y: frame.minY, width: frame.width, height: frame.height)
            }
        }.then {
            self.promise(task: {
                self.resetAfterFirstSetup()
                self.charactersView.frame = CGRect(x: 500, y: frame.minY, width: frame.width, height: frame.height)
            }, shouldAsync: false)
        }.then {
            self.promise {
                self.titleLabel.text = "Set up new Appcode"
                self.charactersView.frame = frame
            }
        }.then {
            self.promise(task: {
                self.setDotView(color: .white)
                self.resetValues()
            }, shouldAsync: false)
        }.catch { error in
            print(error)
        }
    }
    
    @IBAction func deleteButtonClicked() {
        guard countCharacters > 0 else { return }
        if passcodeType == .firstTimeInstall {
            for characterView in characterLabelsArray where characterView.tag == countCharacters - 1 {
                characterView.backgroundColor = .white
                
                let range = NSRange(location: countCharacters - 1, length: 1)
                countCharacters -= 1
                
                if setupPasscodAttempt == .initial {
                    newPasscode = countCharacters > 1 ? (newPasscode as NSString).replacingCharacters(in: range, with: "") : ""
                } else {
                    confirmNewPasscode = countCharacters > 1 ? (confirmNewPasscode as NSString).replacingCharacters(in: range, with: "") : ""
                }
                break
            }
        } else {
            for characterView in characterLabelsArray where characterView.tag == countCharacters - 1 {
                characterView.backgroundColor = .white
                if countCharacters > 1 {
                    let range = NSRange(location: countCharacters - 1, length: 1)
                    passcodeString = (passcodeString as NSString).replacingCharacters(in: range, with: "")
                } else {
                    passcodeString = ""
                }
                countCharacters -= 1
                break
            }
        }
    }
}

// MARK: - Utilities
extension TCBPasscodeViewController {
    
    func animateAfterFirstSetup() {
        let frame = charactersView.frame
        collectionView.isUserInteractionEnabled = false
        
        firstly {
            promise {
                self.charactersView.frame = CGRect(x: -500,
                                                   y: frame.minY,
                                                   width: frame.width,
                                                   height: frame.height)}
        }.then {
            self.promise(task: {
                self.resetAfterFirstSetup()
                self.charactersView.frame = CGRect(x: 500,
                                                   y: frame.minY,
                                                   width: frame.width,
                                                   height: frame.height)
            }, shouldAsync: false)
        }.then {
            self.promise {
                self.titleLabel.text = "Re-enter new Appcode"
                self.charactersView.frame = frame
            }
        }.then {
            self.promise(task: {
                self.setupPasscodAttempt = .confirm
                self.cancelButton.isHidden = false
                self.collectionView.isUserInteractionEnabled = true
            }, shouldAsync: false)
        }.catch { error in
            print(error)
        }
    }
    
    func setDotView(_ tag: Int? = nil, color: UIColor) {
        if let tag = tag {
            for characterView in characterLabelsArray where characterView.tag == tag {
                characterView.backgroundColor = color
            }
        } else {
            for characterView in characterLabelsArray {
                characterView.backgroundColor = color
            }
        }
    }
    
    func promise(task: @escaping () -> Void, shouldAsync: Bool = true) -> Promise<Void> {
        guard shouldAsync else {
            return Promise<Void> { seal in
                task()
                seal.fulfill_()
            }
        }
        
        return Promise<Void> { seal in
            UIView.animate(withDuration: 0.2, delay: 0.1, options: .transitionFlipFromRight, animations: {
                task()
                seal.fulfill_()
            }, completion: nil)
        }
    }
}
