//
//  BarChartCell.swift
//  FastMobile
//
//  Created by Huy TO. Nguyen Van on 9/11/20.
//  Copyright © 2020 Huy Van Nguyen. All rights reserved.
//

import UIKit
import PromiseKit
import Domain

class BarChartCell: UICollectionViewCell {
    
    @IBOutlet weak var textValueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var barChartHeightConstraint: NSLayoutConstraint!
    private var barHeight: CGFloat = 0.0
    private var objBarChart: BarChart?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.barChartHeightConstraint.constant = 0
        textValueLabel.text = ""
    }
    
    func fillData(with barChart: BarChart) {
        objBarChart = barChart
        titleLabel.text = barChart.title
        //textValueLabel.text = barChart.textValue
        if let color = barChart.color {
            barView.backgroundColor = UIColor(hexString: color)
            barView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        if self.barChartHeightConstraint.constant > 0 {
            self.barChartHeightConstraint.constant = barChart.height
        }
        
        layoutIfNeeded()
    }
    
    func animate() {
        guard self.barChartHeightConstraint.constant == 0 else { return }
        animateBarChart(0)
    }
    
    func animateBarChart(_ steps: Int) {
        guard let objBarChart = objBarChart else { return }
        if steps > Int(objBarChart.height) {
            return
        }
        var steps = steps
        UIView.animate(withDuration: 0.006, animations: {
            self.barChartHeightConstraint.constant = CGFloat(steps)
            let value = (CGFloat(steps) / objBarChart.height) * CGFloat(truncating: NumberFormatter().number(from: objBarChart.textValue ?? "0") ?? 0)
            self.textValueLabel.text = String(format: "%.1fM", value)
            self.layoutIfNeeded()
        }, completion: { _ in
            steps += 2
            self.animateBarChart(steps)
        })
    }
}
