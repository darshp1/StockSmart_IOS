//
//  StockList.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/6/24.
//

import Foundation
import SwiftUI



struct StockList: View {
    @Binding var showDetails: Bool // Flag to control details view

    var body: some View {
        List {
            ForEach(stockData) { stock in
                NavigationLink(destination: Text("Stock Details")) {
                    StockRow(stock: stock, showDetails: $showDetails)
                }
            }
        }
        
    }
    
}


struct StockRow: View {
    let stock: Stock // Replace with your stock data model
    @Binding var showDetails: Bool

    var body: some View {
        HStack {
            VStack{
                Text(stock.symbol)
                    .bold()
                    .font(.system(size: 22))
                Text(stock.companyName)
                    .font(.footnote)
                    .foregroundColor(.gray)
           
            }
        
            Spacer(minLength: 100)

            VStack {
                Text("\(stock.price, specifier: "%.2f")")
                    .bold()
                    .font(.system(size: 18))
                HStack {
                    Text(stock.change)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
           
        }
    }
}

struct Stock: Identifiable { // Conforming to Identifiable
    let id = UUID() // Unique identifier
    let symbol: String
    let price: Double
    let companyName: String
    let change: String
}


let stockData = [ // Replace with actual stock data
    Stock(symbol: "AAPL", price: 171.23, companyName: "Apple Inc.", change: "-7.44 (-1.16%)"),
    Stock(symbol: "NVDA", price: 913.02, companyName: "NVIDIA Corp", change: "19.30 (1.00%)")
]
