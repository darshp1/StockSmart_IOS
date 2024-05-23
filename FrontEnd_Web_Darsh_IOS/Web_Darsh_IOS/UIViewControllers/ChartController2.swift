//
//  ChartController2.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/12/24.
//

import SwiftUI

struct ChartController2: UIViewControllerRepresentable {
    // Buy, Period, Hold, Sell, Strong_buy, Strong_Sell
    
    let Buy: [Int]
    let Period: [String]
    let Hold: [Int]
    let Sell: [Int]
    let Strong_buy: [Int]
    let Strong_Sell: [Int]

    
    func makeUIViewController(context: Context) -> Chart1 {
           // Pass the data to the d view controller
        let viewController = Chart1(Buy: Buy, Period: Period, Hold:Hold, Sell: Sell, Strong_buy: Strong_buy,Strong_Sell: Strong_Sell)
//        let viewController = Chart1()
           return viewController
       }
    func updateUIViewController(_ uiViewController: Chart1, context: Context) {
        // Update the view controller if needed
    }
}
