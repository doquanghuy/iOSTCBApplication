//
//  CashflowViewController.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PromiseKit
import Domain

class CashflowViewController: UIViewController {
    
    var viewModel: CashflowViewModel!
    private let disposeBag = DisposeBag()
    @IBOutlet weak var barChartCollectionView: UICollectionView!
    @IBOutlet weak var noticeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configNoticeLabel()
        configView()
        bindViewModel()
    }
    
    func configView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 194)
        let left = (barChartCollectionView.frame.width - 248) / 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: 4)

        barChartCollectionView.collectionViewLayout = layout
        barChartCollectionView.register(UINib.init(nibName: "BarChartCell", bundle: nil), forCellWithReuseIdentifier: "BarChartCell")
    }

    func bindViewModel() {
        let input = CashflowViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input: input)
        
        output.cashflow
            .map({ cashflow -> [BarChart] in
                return cashflow?.barChart ?? []
            })
            .drive(barChartCollectionView.rx.items(cellIdentifier: "BarChartCell", cellType: BarChartCell.self)) { _, barchart, cell in
                cell.fillData(with: barchart)
            }.disposed(by: disposeBag)
    }
    
    func configNoticeLabel() {
        let attributedString = NSMutableAttributedString(string: "Your expense hits over 60% income in this month", attributes: [
          .font: UIFont(name: "HelveticaNeue", size: 17.0)!,
          .foregroundColor: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.85),
          .kern: -0.32
        ])
        attributedString.addAttributes([
          .font: UIFont(name: "HelveticaNeue-Bold", size: 17.0)!,
          .foregroundColor: UIColor.init(red: 237/255.0, green: 28/255.0, blue: 36/255.0, alpha: 1)
        ], range: NSRange(location: 18, length: 8))
        
        noticeLabel.attributedText = attributedString
    }

}

extension CashflowViewController: HomeScrollViewDelegate {
    func didScrollToCashFlowSection() {
        for cell in barChartCollectionView.visibleCells {
            (cell as? BarChartCell)?.animate()
        }
    }
}
