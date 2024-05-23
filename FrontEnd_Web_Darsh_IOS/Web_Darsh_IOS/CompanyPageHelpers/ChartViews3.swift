//
//  ChartViews3.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/13/24.
//

import SwiftUI

struct ChartViews: View {
    @Binding var Buy: [Int]
    @Binding var Period: [String]
    @Binding var Hold: [Int]
    @Binding var Sell: [Int]
    @Binding var Strong_buy: [Int]
    @Binding var Strong_Sell: [Int]
    
    @Binding var surprise_a: [Double]
    @Binding var actual_a: [Double]
    @Binding var estimate_a: [Double]
    @Binding var period_a: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            Color.clear.frame(height: 400)
                .overlay(
                    ChartController2(Buy: Buy, Period: Period, Hold: Hold, Sell: Sell, Strong_buy: Strong_buy, Strong_Sell: Strong_Sell)
                )
            Color.clear.frame(height: 400)
                .overlay(
                    ChartController(surprise_a: surprise_a, actual_a: actual_a, estimate_a: estimate_a, period_a: period_a)
                )
        }
    }
}
