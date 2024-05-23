//
//  ChartController.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/12/24.
//

import SwiftUI

struct ChartController: UIViewControllerRepresentable {
    
    let surprise_a: [Double]
    let actual_a: [Double]
    let estimate_a: [Double]
    let period_a: [String]

    
    func makeUIViewController(context: Context) -> Chart2 {
           // Pass the data to the d view controller
           let viewController = Chart2(surprise_a: surprise_a, actual_a: actual_a, estimate_a:estimate_a, period_a: period_a)
           return viewController
       }
    func updateUIViewController(_ uiViewController: Chart2, context: Context) {
        // Update the view controller if needed
    }
}


