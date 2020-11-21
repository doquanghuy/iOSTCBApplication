//
//  PinView.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/18/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit

public enum PinViewDeleteButtonAction: Int {
    /// Deletes the contents of the current field and moves the cursor to the previous field.
    case deleteCurrentAndMoveToPrevious = 0
    
    /// Simply deletes the content of the current field without moving the cursor.
    /// If there is no value in the field, the cursor moves to the previous field.
    case deleteCurrent
    
    /// Moves the cursor to the previous field and delets the contents.
    /// When any field is focused, its contents are deleted.
    case moveToPreviousAndDelete
    
}

private class PinViewFlowLayout: UICollectionViewFlowLayout {
    override var developmentLayoutDirection: UIUserInterfaceLayoutDirection { return .leftToRight }
    override var flipsHorizontallyInOppositeLayoutDirection: Bool { return true }
}

@objc
public class PinView: UIView {
    
    // MARK: - Private Properties -
    @IBOutlet fileprivate var collectionView: UICollectionView!
    
    fileprivate var flowLayout: UICollectionViewFlowLayout {
        self.collectionView.collectionViewLayout = PinViewFlowLayout()
        return self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
    }
    
    fileprivate var view: UIView!
    fileprivate var reuseIdentifier = "PinCell"
    fileprivate var isLoading = true
    var password = [String]()
    
    // MARK: - Public Properties -
    @IBInspectable public var pinLength: Int = 5
    @IBInspectable public var secureCharacter: String = "\u{25CF}"
    @IBInspectable public var interSpace: CGFloat = 5
    @IBInspectable public var textColor: UIColor = UIColor.black
    @IBInspectable public var shouldSecureText: Bool = true
    @IBInspectable public var secureTextDelay: Int = 500
    @IBInspectable public var allowsWhitespaces: Bool = true
    @IBInspectable public var placeholder: String = "\u{25CF}"
    @IBInspectable public var placeholderColor: UIColor = UIColor.black
    
    @IBInspectable public var borderLineColor: UIColor = UIColor.black
    @IBInspectable public var activeBorderLineColor: UIColor = UIColor.black
    
    @IBInspectable public var borderLineThickness: CGFloat = 2
    @IBInspectable public var activeBorderLineThickness: CGFloat = 4
    
    @IBInspectable public var fieldBackgroundColor: UIColor = UIColor.clear
    @IBInspectable public var activeFieldBackgroundColor: UIColor = UIColor.clear
    
    @IBInspectable public var fieldCornerRadius: CGFloat = 0
    @IBInspectable public var activeFieldCornerRadius: CGFloat = 0
    
    public var deleteButtonAction: PinViewDeleteButtonAction = .deleteCurrentAndMoveToPrevious
    
    public var font: UIFont = UIFont.systemFont(ofSize: 15)
    public var keyboardType: UIKeyboardType = UIKeyboardType.phonePad
    public var keyboardAppearance: UIKeyboardAppearance = .default
    public var becomeFirstResponderAtIndex: Int?
    public var isContentTypeOneTimeCode: Bool = true
    public var shouldDismissKeyboardOnEmptyFirstField: Bool = false
    public var pinInputAccessoryView: UIView? {
        didSet { refreshPinView() }
    }
    
    public var didFinishCallback: ((String) -> Void)?
    public var didChangeCallback: ((String) -> Void)?
    
    // MARK: - Init methods -
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    private func loadView(completionHandler: (() -> Void)? = nil) {
        let podBundle = Bundle(for: PinView.self)
        let nib = UINib(nibName: "PinView", bundle: podBundle)
        view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        
        // for CollectionView
        let collectionViewNib = UINib(nibName: "PinCell", bundle: podBundle)
        collectionView.register(collectionViewNib, forCellWithReuseIdentifier: reuseIdentifier)
        flowLayout.scrollDirection = .vertical
        collectionView.isScrollEnabled = false
                
        self.addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            completionHandler?()
        }
    }
    
    // MARK: - Private methods -
    @objc fileprivate func textFieldDidChange(_ textField: UITextField) {
        var nextTag = textField.tag
        let index = nextTag - 100
        guard let placeholderLabel = textField.superview?.viewWithTag(400) as? UILabel else {
            return
        }
        
        // ensure single character in text box and trim spaces
        if textField.text?.count ?? 0 > 1 {
            textField.text?.removeFirst()
            textField.text = { () -> String in
                let text = textField.text ?? ""
                return String(text[..<text.index((text.startIndex), offsetBy: 1)])
            }()
        }
        
        let isBackSpace = { () -> Bool in
            guard let char = textField.text?.cString(using: String.Encoding.utf8) else { return false }
            return strcmp(char, "\\b") == -92
        }
        
        if !self.allowsWhitespaces && !isBackSpace() && textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            return
        }
        
        // if entered text is a backspace - do nothing; else - move to next field
        // backspace logic handled in SVPinField
        nextTag = isBackSpace() ? textField.tag : textField.tag + 1
        
        // Try to find next responder
        if let nextResponder = textField.superview?.superview?.superview?.superview?.viewWithTag(nextTag) as UIResponder? {
            // Found next responder, so set it.
            nextResponder.becomeFirstResponder()
        } else {
            // Not found, so dismiss keyboard
            if index == 1 && shouldDismissKeyboardOnEmptyFirstField {
                textField.resignFirstResponder()
            } else if index > 1 { textField.resignFirstResponder() }
        }
        
        // activate the placeholder if textField empty
        placeholderLabel.isHidden = !(textField.text?.isEmpty ?? true)
        
        // secure text after a bit
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(secureTextDelay), execute: {
            placeholderLabel.isHidden = false
            if !(textField.text?.isEmpty ?? true) {
                placeholderLabel.textColor = self.textColor
                if self.shouldSecureText { textField.text = self.secureCharacter }
            } else {
                placeholderLabel.textColor = self.placeholderColor
            }
        })
        
        // store text
        let text =  textField.text ?? ""
        let passwordIndex = index - 1
        if password.count > passwordIndex {
            // delete if space
            password[passwordIndex] = text
        } else {
            password.append(text)
        }
        validateAndSendCallback()
    }
    
    fileprivate func validateAndSendCallback() {
        didChangeCallback?(password.joined())
        
        let pin = getPin()
        guard !pin.isEmpty else { return }
        didFinishCallback?(pin)
    }
    
    fileprivate func setPlaceholder() {
        for (index, char) in placeholder.enumerated() {
            guard index < pinLength else { return }
            
            if let placeholderLabel = collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.viewWithTag(400) as? UILabel {
                placeholderLabel.text = String(char)
            }
        }
    }
    
    func stylePinField(containerView: UIView, underLine: UIView, isActive: Bool) {
        
        containerView.backgroundColor = isActive ? activeFieldBackgroundColor : fieldBackgroundColor
        containerView.layer.cornerRadius = isActive ? activeFieldCornerRadius : fieldCornerRadius
        
        func setupUnderline(color: UIColor, withThickness thickness: CGFloat) {
            underLine.backgroundColor = color
            underLine.constraints.filter { ($0.identifier == "underlineHeight") }.first?.constant = thickness
        }
        
        if isActive {
            setupUnderline(color: activeBorderLineColor, withThickness: activeBorderLineThickness)
        } else {
            setupUnderline(color: borderLineColor, withThickness: borderLineThickness)
        }
        containerView.layer.borderWidth = 0
        containerView.layer.borderColor = UIColor.clear.cgColor
     }
    
    @IBAction fileprivate func refreshPinView(completionHandler: (() -> Void)? = nil) {
        view.removeFromSuperview()
        view = nil
        isLoading = true
        loadView(completionHandler: completionHandler)
    }
    
    // MARK: - Public methods -
    
    /// Returns the entered PIN; returns empty string if incomplete
    /// - Returns: The entered PIN.
    @objc
    public func getPin() -> String {
        
        guard !isLoading else { return "" }
        guard password.count == pinLength && password.joined().trimmingCharacters(in: CharacterSet(charactersIn: " ")).count == pinLength else {
            return ""
        }
        return password.joined()
    }
        
    /// Clears the entered PIN and refreshes the view
    /// - Parameter completionHandler: Called after the pin is cleared the view is re-rendered.
    @objc
    public func clearPin(completionHandler: (() -> Void)? = nil) {
        
        guard !isLoading else { return }
        
        password.removeAll()
        refreshPinView(completionHandler: completionHandler)
    }
    
    /// Clears the entered PIN and refreshes the view.
    /// (internally calls the clearPin method; re-declared since the name is more intuitive)
    /// - Parameter completionHandler: Called after the pin is cleared the view is re-rendered.
    @objc
    public func refreshView(completionHandler: (() -> Void)? = nil) {
        clearPin(completionHandler: completionHandler)
    }
    
    /// Pastes the PIN onto the PinView
    /// - Parameter pin: The pin which is to be entered onto the PinView.
    @objc
    public func pastePin(pin: String) {
        
        password = []
        for (index, char) in pin.enumerated() {

            guard index < pinLength else { return }

            // Get the first textField
            guard let textField = collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.viewWithTag(101 + index) as? PinTextField,
                let placeholderLabel = collectionView.cellForItem(at: IndexPath(item: index, section: 0))?.viewWithTag(400) as? UILabel
            else {
                return
            }

            textField.text = String(char)
            placeholderLabel.isHidden = true

            //secure text after a bit
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(secureTextDelay), execute: {
                if textField.text != "" {
                    if self.shouldSecureText { textField.text = self.secureCharacter } else {}
                }
            })

            // store text
            password.append(String(char))
            validateAndSendCallback()
        }
    }
}

// MARK: - CollectionView methods -
extension PinView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pinLength
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        guard let textField = cell.viewWithTag(100) as? PinTextField,
            let containerView = cell.viewWithTag(51),
            let underLine = cell.viewWithTag(50),
            let placeholderLabel = cell.viewWithTag(400) as? UILabel
        else {
            return UICollectionViewCell()
        }
        
        // Setting up textField
        textField.tag = 101 + indexPath.row
        textField.isSecureTextEntry = false
        textField.textColor = self.textColor
        textField.tintColor = self.tintColor
        textField.font = self.font
//        textField.deleteButtonAction = self.deleteButtonAction
        if #available(iOS 12.0, *), indexPath.row == 0, isContentTypeOneTimeCode {
            textField.textContentType = .oneTimeCode
        }
        textField.keyboardType = self.keyboardType
        textField.keyboardAppearance = self.keyboardAppearance
        textField.inputAccessoryView = self.pinInputAccessoryView
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        placeholderLabel.text = "\u{25CF}"
        placeholderLabel.textColor = placeholderColor
        
        stylePinField(containerView: containerView, underLine: underLine, isActive: false)
        
        // Make the Pin field the first responder
        if let firstResponderIndex = becomeFirstResponderAtIndex, firstResponderIndex == indexPath.item {
            textField.becomeFirstResponder()
        }
        
        // Finished loading pinView
        if indexPath.row == pinLength - 1 && isLoading {
            isLoading = false
            DispatchQueue.main.async {
                if !self.placeholder.isEmpty { self.setPlaceholder() }
            }
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            let width = (collectionView.bounds.width - (interSpace * CGFloat(max(pinLength, 1) - 1)))/CGFloat(pinLength)
            return CGSize(width: width, height: collectionView.frame.height)
        }
        let width = (collectionView.bounds.width - (interSpace * CGFloat(max(pinLength, 1) - 1)))/CGFloat(pinLength)
        let height = collectionView.frame.height
        return CGSize(width: min(width, height), height: min(width, height))
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interSpace
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        let width = (collectionView.bounds.width - (interSpace * CGFloat(max(pinLength, 1) - 1)))/CGFloat(pinLength)
        let height = collectionView.frame.height
        let top = (collectionView.bounds.height - min(width, height)) / 2
        if height < width {
            // If width of field > height, size the fields to the pinView height and center them.
            let totalCellWidth = height * CGFloat(pinLength)
            let totalSpacingWidth = interSpace * CGFloat(max(pinLength, 1) - 1)
            let inset = (collectionView.frame.size.width - CGFloat(totalCellWidth + CGFloat(totalSpacingWidth))) / 2
            return UIEdgeInsets(top: top, left: inset, bottom: 0, right: inset)
        }
        return UIEdgeInsets(top: top, left: 0, bottom: 0, right: 0)
    }
    
    public override func layoutSubviews() {
        flowLayout.invalidateLayout()
    }
}
