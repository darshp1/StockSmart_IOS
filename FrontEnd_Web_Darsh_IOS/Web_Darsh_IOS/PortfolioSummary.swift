//
//  PortfolioSummary.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/6/24.
//

import Foundation
import SwiftUI


struct PortfolioSummary: View {
    
//    @State private var pdetails: [PortfolioDetails]
//    init( pdetails: [PortfolioDetails]) {
//        self._pdetails = State(initialValue: pdetails)
//    }
    @State var pdetails: [PortfolioDetails] 
  

      
    @State var netWorth: Float
    @State var cashBalance: Float
 //   @State private var users = ["Paul", "Taylor", "Adele"]
    
    func move(from source: IndexSet, to destination: Int) {
        pdetails.move(fromOffsets: source, toOffset: destination)
    }
    var body: some View {
     
         // Text("hey")
        Section(header: Text("PORTFOLIO")){
                    VStack {
                        HStack {
                            Text("Net Worth")
                                .font(.system(size: 22))
                            Spacer()
                            Text("Cash Balance")
                                .font(.system(size: 22))
            
                        }
                        HStack {
                            Text("$\(netWorth, specifier: "%.2f")")
                                .bold()
                                .font(.system(size: 22))
                            Spacer()
                            Text("$\(cashBalance, specifier: "%.2f")")
                                .bold()
                                .font(.system(size: 22))
            
                        }
                    }
                    .padding(10)
                    .background(Color(.white))
                    .cornerRadius(8)
                    
           
//                    ForEach(users, id: \.self) { user in
//                        NavigationLink(destination:LikedCompanies(cname: "Apple", cticker: "AAPL", sprice: 123.47, dchange: 2.8942, dpchange: 3.927373)) {
//                            Text(user)
//                        }
//                    }
//                .onMove(perform: move)
                    ForEach(pdetails, id: \.cticker) { pd in
                        NavigationLink(destination:LikedCompanies(cname: "Apple", cticker: pd.cticker, sprice: 123.47, dchange: 2.8942, dpchange: 3.927373)) {
                                  //  Text(pd.cticker)
                            
                            HStack {
                                VStack(alignment: .leading){
                                    Text(pd.cticker)
                                        .bold()
                                        .font(.system(size: 22))
                                    Text("\(pd.shares) shares")
                                        .font(.system(size: 17))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                
                                VStack(alignment: .trailing){
                                    Text("$\(pd.bsprice*Float(pd.shares), specifier: "%.2f")")
                                        .bold()
                                        .font(.system(size: 20))
                                    HStack{
                                        Image(systemName: pd.bsprice > pd.sprice ? "arrow.up.forward" : (pd.bsprice < pd.sprice ? "arrow.down.forward" : "minus"))
                                            .foregroundColor(pd.bsprice > pd.sprice ? .green : (pd.bsprice < pd.sprice ? .red : .gray))
                                        Text("$\(pd.bsprice - pd.sprice, specifier: "%.2f") (\(pd.sprice != 0 ? ((pd.bsprice - pd.sprice) / pd.sprice)*100 : 0.00, specifier: "%.2f")%)")

                                        
                                            .foregroundColor(pd.bsprice > pd.sprice ? .green : (pd.bsprice < pd.sprice ? .red : .gray))
                                            .font(.system(size: 17))
                                    }
                                }
                            }
                                }
                            }
                            .onMove(perform: move)
            

        }
    
   
       
    }
}

#Preview {
//    PortfolioSummary(netWorth: 1.2, cashBalance: 2.4)
    PortfolioSummary(pdetails: [
        PortfolioDetails(cticker: "SNAP", shares: 3, sprice: 123.47, bsprice: 123.47),
        PortfolioDetails(cticker: "DELL", shares: 1, sprice: 723.47, bsprice: 821.21),
        PortfolioDetails(cticker: "SMCI", shares: 1, sprice: 923.47, bsprice: 821.21)
    ], netWorth: 1.2, cashBalance: 2.4)
}
