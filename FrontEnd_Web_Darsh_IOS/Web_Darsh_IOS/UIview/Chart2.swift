//
//  Chart2.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/12/24.
//

import SwiftUI
import Highcharts
import UIKit


class Chart2: UIViewController{
    var surprise_a: [Double]
        var actual_a: [Double]
        var estimate_a: [Double]
        var period_a: [String]
        
        var combinedData: [String] = []
           // Initialize the view controller with the passed data
        init(surprise_a: [Double], actual_a: [Double], estimate_a: [Double], period_a: [String]) {
               self.surprise_a = surprise_a
               self.actual_a = actual_a
               self.estimate_a = estimate_a
               self.period_a = period_a
               super.init(nibName: nil, bundle: nil)
      
                    
                    // Initialize combinedData array here
            self.combinedData = zip(period_a, surprise_a).map { period, surprise in
                "<span>\(period)</span><br><span>Surprise: \(surprise)</span>"}
           }
           
           required init?(coder: NSCoder) {
               fatalError("init(coder:) has not been implemented")
           }
           
     

       
        override func viewDidLoad() {
          super.viewDidLoad()

          let chartView = HIChartView(frame: CGRect(x: view.bounds.origin.x  ,
                                                    y: view.bounds.origin.y ,
                                                    width: view.bounds.size.width ,
                                                    height: 400))

          chartView.plugins = ["series-label"]

          let options = HIOptions()

          let chart = HIChart()
          chart.type = "spline"
          options.chart = chart

          let title = HITitle()
          title.text = "Historical EPS Surprises"
          options.title = title

          let subtitle = HISubtitle()
          subtitle.text = "Source: WorldClimate.com"
          options.subtitle = subtitle
        
    // Making 2 x axis for the second horizontal line
          let xAxis1 = HIXAxis()
          xAxis1.categories = combinedData
            // Second x-axis
            let xAxis2 = HIXAxis()
            xAxis2.title = HITitle() // Set an empty title
            xAxis2.alignTicks = NSNumber(value: false)
            xAxis2.opposite = NSNumber(value: false)

        // Add both x-axes to the options
        options.xAxis = [xAxis1, xAxis2]

          let yAxis = HIYAxis()
          yAxis.title = HITitle()
          yAxis.title.text = "Quanterly EPS"
          yAxis.labels = HILabels()
          options.yAxis = [yAxis]

          let tooltip = HITooltip()
      //    tooltip.crosshairs = true
          tooltip.shared = true
          options.tooltip = tooltip

          let plotOptions = HIPlotOptions()
          plotOptions.spline = HISpline()
          plotOptions.spline.marker = HIMarker()
          plotOptions.spline.marker.radius = 4
         // plotOptions.spline.marker.lineColor = "green"
          plotOptions.spline.marker.lineWidth = 1
          options.plotOptions = plotOptions
            


          let tokyo = HISpline()
          tokyo.name = "Actual"
       
          tokyo.marker = HIMarker()
          tokyo.marker.symbol = "circle"
            
          let tokyoData = HIData()

          tokyoData.marker = HIMarker()
          tokyo.data = actual_a
            
          let london = HISpline()
            london.name = "Estimated"
       
          london.marker = HIMarker()
          london.marker.symbol = "diamond"

          let londonData = HIData()

          londonData.marker = HIMarker()
          
          london.data = estimate_a
       
            

          options.series = [tokyo, london]

          chartView.options = options

          self.view.addSubview(chartView)
        }
       
      }

#Preview {
    Chart2(surprise_a: [1.5,2.9], actual_a: [1.5,2.9], estimate_a: [1.9,7.9], period_a: ["darsh", "patel"] )
}
