//
//  SendMoneyViewController.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/17/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@objc public protocol CircularCountdownDelegate: class {
    @objc optional func timerDidUpdateCounterValue(sender: CircularCountdownView, newValue: Int)
    @objc optional func timerDidStart(sender: CircularCountdownView)
    @objc optional func timerDidPause(sender: CircularCountdownView)
    @objc optional func timerDidResume(sender: CircularCountdownView)
    @objc optional func timerDidEnd(sender: CircularCountdownView, elapsedTime: TimeInterval)
}

public class CircularCountdownView: UIView {
    @IBInspectable public var lineWidth: CGFloat = 4.0
    @IBInspectable public var lineColor: UIColor = UIColor.init(red: 246/255.0, green: 164/255.0, blue: 167/255.0, alpha: 1)
    @IBInspectable public var trailLineColor: UIColor = UIColor.init(red: 228/255.0, green: 228/255.0, blue: 228/255.0, alpha: 1)
    
    @IBInspectable public var isLabelHidden: Bool = false
    public var labelFont: UIFont?
    public var labelTextColor: UIColor?
    public var timerFinishingText: String?

    public weak var delegate: CircularCountdownDelegate?
    
    // use minutes and seconds for presentation
    public var useMinutesAndSecondsRepresentation = false
    public var moveClockWise = true

    private var timer: Timer?
    private var beginingValue: Int = 1
    private var totalTime: TimeInterval = 1
    private var elapsedTime: TimeInterval = 0
    private var interval: TimeInterval = 1 // Interval which is set by a user
    private let fireInterval: TimeInterval = 0.01 // ~60 FPS

    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        self.addSubview(label)

        label.textAlignment = .center
        label.frame = self.bounds
        if let font = self.labelFont {
            label.font = font
        }
        if let color = self.labelTextColor {
            label.textColor = color
        }

        return label
    }()
    private var currentCounterValue: Int = 0 {
        didSet {
            if !isLabelHidden {
                if let text = timerFinishingText, currentCounterValue == 0 {
                    counterLabel.text = text
                } else {
                    if useMinutesAndSecondsRepresentation {
                        counterLabel.text = getMinutesAndSeconds(remainingSeconds: currentCounterValue)
                    } else {
                        counterLabel.text = "\(currentCounterValue)"
                    }
                }
            }

            delegate?.timerDidUpdateCounterValue?(sender: self, newValue: currentCounterValue)
        }
    }

    // MARK: Inits
    override public init(frame: CGRect) {
        if frame.width != frame.height {
            fatalError("Please use a rectangle frame for SRCountdownTimer")
        }

        super.init(frame: frame)

        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        let context = UIGraphicsGetCurrentContext()
        let radius = (rect.width - lineWidth) / 2
        
        var currentAngle: CGFloat!
        
        if moveClockWise {
            currentAngle = CGFloat((.pi * 2 * elapsedTime) / totalTime)
        } else {
            currentAngle = CGFloat(-(.pi * 2 * elapsedTime) / totalTime)
        }
    
        context?.setLineWidth(lineWidth)

        // Main line
        context?.beginPath()
        context?.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: currentAngle - .pi / 2,
            endAngle: .pi * 2 - .pi / 2,
            clockwise: false)
        context?.setStrokeColor(lineColor.cgColor)
        context?.strokePath()

        // Trail line
        context?.beginPath()
        context?.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius,
            startAngle: -.pi / 2,
            endAngle: currentAngle - .pi / 2,
            clockwise: false)
        context?.setStrokeColor(trailLineColor.cgColor)
        context?.strokePath()
    }

    // MARK: Public methods
    /**
     * Starts the timer and the animation. If timer was previously runned, it'll invalidate it.
     * - Parameters:
     *   - beginingValue: Value to start countdown from.
     *   - interval: Interval between reducing the counter(1 second by default)
     */
    public func start(beginingValue: Int, interval: TimeInterval = 1) {
        self.beginingValue = beginingValue
        self.interval = interval

        totalTime = TimeInterval(beginingValue) * interval
        elapsedTime = 0
        currentCounterValue = beginingValue

        timer?.invalidate()
        timer = Timer(timeInterval: fireInterval, target: self, selector: #selector(CircularCountdownView.timerFired(_:)), userInfo: nil, repeats: true)

        RunLoop.main.add(timer!, forMode: .common)

        delegate?.timerDidStart?(sender: self)
    }

    /**
     * Pauses the timer with saving the current state
     */
    public func pause() {
        timer?.fireDate = Date.distantFuture

        delegate?.timerDidPause?(sender: self)
    }

    /**
     * Resumes the timer from the current state
     */
    public func resume() {
        timer?.fireDate = Date()

        delegate?.timerDidResume?(sender: self)
    }

    /**
     * Reset the timer
     */
    public func reset() {
        self.currentCounterValue = 0
        timer?.invalidate()
        self.elapsedTime = 0
        setNeedsDisplay()
    }
    
    /**
     * End the timer
     */
    public func end() {
        self.currentCounterValue = 0
        timer?.invalidate()
        
        delegate?.timerDidEnd?(sender: self, elapsedTime: elapsedTime)
    }
    
    /**
     * Calculate value in minutes and seconds and return it as String
     */
    private func getMinutesAndSeconds(remainingSeconds: Int) -> (String) {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds - minutes * 60
        let secondString = seconds < 10 ? "0" + seconds.description : seconds.description
        return minutes.description + ":" + secondString
    }

    // MARK: Private methods
    @objc private func timerFired(_ timer: Timer) {
        elapsedTime += fireInterval

        if elapsedTime <= totalTime {
            setNeedsDisplay()

            let computedCounterValue = beginingValue - Int(elapsedTime / interval)
            if computedCounterValue != currentCounterValue {
                currentCounterValue = computedCounterValue
            }
        } else {
            end()
        }
    }
}

class SendMoneyViewController: BaseViewController {
    
    var viewModel: SendMoneyViewModel!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var circularCountdownView: CircularCountdownView!
    @IBOutlet weak var sendMoneyButton: UIButton!
    @IBOutlet weak var otpStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureNoticeLabel()
        configCircularCountdownView()
        bindViewModel()
    }
    
    override func addImageBackground() {
    }
    
    func bindViewModel() {
        let timerDidEnd = rx.sentMessage(#selector(timerDidEnd(sender:elapsedTime:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let input = SendMoneyViewModel.Input(loadTrigger: Driver.just(()), sendMoneyTrigger: sendMoneyButton.rx.tap.asDriver(), timerDidEndTrigger: timerDidEnd)
        let output = viewModel.transform(input: input)
        
        output.otp.do(onNext: changeOTP(_:)).drive().disposed(by: disposeBag)
        output.toSuccessfulTransactionScreen.drive().disposed(by: disposeBag)
        output.changeOTP.do(onNext: changeOTP(_:)).drive().disposed(by: disposeBag)
    }
    
    func configureNoticeLabel() {
        let attributedString = NSMutableAttributedString(string: "Your money will be transferred at this step", attributes: [
          .font: UIFont(name: "HelveticaNeue", size: 14.0)!,
          .foregroundColor: UIColor(red: 0.0, green: 122.0 / 255.0, blue: 1.0, alpha: 1.0),
          .kern: -0.1
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(white: 0.0, alpha: 0.5), range: NSRange(location: 0, length: 18))
        noticeLabel.attributedText = attributedString
    }
    
    func configCircularCountdownView() {
        circularCountdownView.delegate = self
        circularCountdownView.labelFont = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        circularCountdownView.labelTextColor = UIColor.init(red: 234/255.0, green: 25/255.0, blue: 33/255.0, alpha: 1)
        circularCountdownView.timerFinishingText = "0"
        circularCountdownView.start(beginingValue: 30, interval: 1)
    }
    
    func changeOTP(_ otp: String) {
        var otp = otp
        for view in otpStackView.arrangedSubviews {
            if let label = view as? UILabel, let firstCharacter = otp.first {
                label.text = String(firstCharacter)
                otp = String(otp.dropFirst())
            }
        }
        circularCountdownView.start(beginingValue: 30, interval: 1)
    }
}

extension SendMoneyViewController: CircularCountdownDelegate {
    
    func timerDidEnd(sender: CircularCountdownView, elapsedTime: TimeInterval) {
    }
}
