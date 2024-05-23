//
//  Chart3.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/12/24.
//

import SwiftUI
import Highcharts
import UIKit

class  Chart3: UIViewController {
    
    var chartView: HIChartView!

    override func viewDidLoad() {
      super.viewDidLoad()

      chartView = HIChartView(frame: CGRect(x: view.bounds.origin.x,
                                            y: view.bounds.origin.y ,
                                            width: view.bounds.size.width,
                                            height: 400))

        chartView.backgroundColor = .white
               view.addSubview(chartView)

        chartView.plugins = ["series-label"]

           let options = HIOptions()

           let title = HITitle()
           title.text = "Solar Employment Growth by Sector, 2010-2016"
           options.title = title

           let subtitle = HISubtitle()
           subtitle.text = "Source: thesolarfoundation.com"
           options.subtitle = subtitle

           let yAxis = HIYAxis()
           yAxis.title = HITitle()
           yAxis.title.text = "Number of Employees"
           options.yAxis = [yAxis]

           let xAxis = HIXAxis()
           xAxis.accessibility = HIAccessibility()
           xAxis.accessibility.rangeDescription = "Range: 2010 to 2017"
           options.xAxis = [xAxis]

           let legend = HILegend()
           legend.layout = "vertical"
           legend.align = "right"
           legend.verticalAlign = "middle"
           options.legend = legend

           let plotOptions = HIPlotOptions()
           plotOptions.series = HISeries()
           plotOptions.series.label = HILabel()
           plotOptions.series.label.connectorAllowed = false
           plotOptions.series.pointStart = 2010
           options.plotOptions = plotOptions

           let installation = HISeries()
           installation.name = "Installation"
           installation.data = [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]

     
           options.series = [installation]

           let responsive = HIResponsive()
           let rules = HIRules()
           rules.condition = HICondition()
           rules.condition.maxWidth = 500
           rules.chartOptions = [
             "legend": [
                "layout": "horizontal",
                "align": "center",
                "verticalAlign": "bottom"
             ]
           ]
           responsive.rules = [rules]
           options.responsive = responsive

           chartView.options = options

           self.view.addSubview(chartView)
         }

       }
#Preview {
    Chart3()
}
