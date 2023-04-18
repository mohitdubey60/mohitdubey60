//
//  BarChartsView.swift
//  ProgressTrackerApp-iOS-UIKit
//
//  Created by mohit.dubey on 23/02/23.
//

import UIKit
import Charts

class BarChartsView: UIView {
    @IBOutlet weak var barChartView: BarChartView!
    
    let mockData = [
        "Sunday,    3",
        "Monday,    2",
        "Tuesday,   4",
        "Wednesday, 2",
        "Thursday,  3",
        "Friday,    4",
        "Saturday,  2",
    ]
    let colors: [CGColor] = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor, UIColor.yellow.cgColor]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        barChartView.delegate = self
        var entries: [BarChartDataEntry] = []
        for x in 0..<7 {
            entries.append(BarChartDataEntry(x: Double(x),
                                          y: Double.random(in: 0...30)))
        }
        
        let dataSet: BarChartDataSet = BarChartDataSet(entries: entries, label: "data entries")
        dataSet.colors = colors.map({ NSUIColor(cgColor: $0) })
        let data: BarChartData = BarChartData(dataSet: dataSet)
        barChartView.data = data
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: mockData.map({ String($0.split(separator: ",").first!) }))
        barChartView.xAxis.labelRotationAngle = -75.0
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.granularity = 1
    }
}

extension BarChartsView: ChartViewDelegate {
    
}
