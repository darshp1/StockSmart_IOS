//
//  Chart1.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/11/24.
//

import SwiftUI 
import Highcharts
import UIKit

    class Chart1: UIViewController {
        var Buy: [Int]
        var Period: [String]
        var Sell: [Int]
        var Hold: [Int]
        var Strong_Sell: [Int]
        var Strong_buy: [Int]
        
        
        init(Buy: [Int] ,Period: [String] , Hold: [Int], Sell: [Int],Strong_buy: [Int], Strong_Sell: [Int]) {
            // Buy: [2,3], Period: ["darsh,Patel"], Hold:[1,3], Strong_buy:[2,8],Strong_Sell: [1,5]
               self.Buy = Buy
               self.Hold = Hold
               self.Sell = Sell
               self.Period = Period
                self.Strong_Sell = Strong_Sell
            self.Strong_buy = Strong_buy
               super.init(nibName: nil, bundle: nil)
      
                    
           }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        var chartView: HIChartView!

        override func viewDidLoad() {
          super.viewDidLoad()

          chartView = HIChartView(frame: CGRect(x: view.bounds.origin.x,
                                                y: view.bounds.origin.y ,
                                                width: view.bounds.size.width,
                                                height: 400))

          let options = HIOptions()
            let chart = HIChart()
               chart.type = "column"
               options.chart = chart

               let title = HITitle()
               title.text = "Recommendation Trends"
               options.title = title

               let xAxis = HIXAxis()
               xAxis.categories = Period
               options.xAxis = [xAxis]

               let yAxis = HIYAxis()
               yAxis.min = 0
               yAxis.title = HITitle()
               yAxis.title.text = "#Analysis"
               yAxis.stackLabels = HIStackLabels()
              yAxis.stackLabels.enabled = false // this will remove the total count from the each labels
               options.yAxis = [yAxis]

               let legend = HILegend()
               legend.align = "right"
               legend.x = 10
               legend.verticalAlign = "bottom"
               legend.y = 0
               legend.floating = false
               legend.backgroundColor = HIColor(name: "white")
               legend.borderColor = HIColor(hexValue: "CCC")
               legend.borderWidth = 1
               legend.shadow = HICSSObject()
               legend.shadow.opacity = 0
               options.legend = legend

               let tooltip = HITooltip()
               tooltip.headerFormat = "<b>{point.x}</b><br/>"
               tooltip.pointFormat = "{series.name}: {point.y}<br/>Total: {point.stackTotal}"
               options.tooltip = tooltip

               let plotOptions = HIPlotOptions()
               plotOptions.series = HISeries()
               plotOptions.series.stacking = "normal"
               let dataLabels = HIDataLabels()
            //let dataLabels = HIDataLabels()
            dataLabels.enabled = NSNumber(value: true)
            dataLabels.formatter = HIFunction(jsFunction: "function() { return this.y !== 0 ? this.y : null; }")
         
            plotOptions.series.dataLabels = [dataLabels]
            options.plotOptions = plotOptions
            


               let john = HIColumn()
               john.name = "Strong buy"
               john.data = Strong_buy
              john.color = HIColor(hexValue: "1b7b42")
            
               let jane = HIColumn()
               jane.name = "Buy"
               jane.data = Buy
            jane.color = HIColor(hexValue: "21c15e")

               let joe = HIColumn()
               joe.name = "Hold"
               joe.data = Hold  
               joe.color = HIColor(hexValue: "c1952e")
            
            
            let sell = HIColumn()
            sell.name = "Sell"
            sell.data =  Sell
         sell.color = HIColor(hexValue: "f4696a")
            
            
            let strong_sell = HIColumn()
            strong_sell.name = "Strong Sell"
            strong_sell.data = Strong_Sell
            strong_sell.color = HIColor(hexValue: "8c2829")

               options.series = [john, jane, joe, sell, strong_sell]

               chartView.options = options

               self.view.addSubview(chartView)
             }

           }


#Preview {
    Chart1(Buy: [2,3], Period: ["Darsh","Patel"], Hold:[1,3], Sell: [10,0], Strong_buy:[2,8],Strong_Sell: [1,5])
  //  Chart1()
}
