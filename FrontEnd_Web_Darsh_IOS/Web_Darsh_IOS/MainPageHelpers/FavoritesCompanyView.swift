//
//  FavoritesCompanyView.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/14/24.
//

import SwiftUI
import Alamofire

struct FavoritesCompanyView: View {
    
    @State private var company_favs: [LikedCompanies]
    @State var pdetails: [PortfolioDetails]
    @State private var netWorth: Float
    @State private var cashBalance: Float
        
        init(company_favs: [LikedCompanies], pdetails: [PortfolioDetails], netWorth: Float, cashBalance: Float) {
            self._company_favs = State(initialValue: company_favs)
            self._pdetails = State(initialValue: pdetails)
            self._netWorth = State(initialValue: netWorth)
            self._cashBalance = State(initialValue: cashBalance)
        }
   

    func move(from source: IndexSet, to destination: Int) {
        company_favs.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
                let deletedTicker = company_favs[index].cticker.uppercased()
               something(deletedTicker)
            }
        company_favs.remove(atOffsets: offsets)
    }

    
    func something(_ h: String){
        print("yes came")
        let parameters: [String: Any] = [
                "ticker": h,
                
            ]
       // print(parameters)
            

        AF.request("https://web3-571-ass3-darsh.uc.r.appspot.com/delete/watchlist", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
               // print(response)
            
                switch response.result {
                case .success(let value):
                    print("Success: \(value)")
                    if let message = value as? String {
                        print("Response message: \(message)")
                        // Handle the response message accordingly
                        // For example, show an alert with the message
                    }
                case .failure(let error):
                    if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("Error: \(errorMessage)")
                        // Handle the error message accordingly
                        // For example, show an alert with the error message
                    } else {
                        print("Error: \(error)")
                        // Handle other types of errors
                    }
                }
            }
    }
    var body: some View {
  
        VStack {
            
            
            List {
               // PortfolioSummary(netWorth: 25000.00, cashBalance: 25000.00)
                DateTimeViewr()
                PortfolioSummary(pdetails: pdetails, netWorth: netWorth, cashBalance: cashBalance)
            
                Section(header: Text("FAVORITES")) {
                    ForEach(company_favs, id: \.cticker) { likedCompany in
                        NavigationLink(destination: LikedCompanies(cname: likedCompany.cname, cticker: likedCompany.cticker, sprice: likedCompany.sprice, dchange: likedCompany.dchange, dpchange: likedCompany.dpchange)) {
                         
                            HStack {
                                VStack(alignment: .leading){
                                    Text(likedCompany.cticker)
                                        .bold()
                                        .font(.system(size: 22))
                                    Text(likedCompany.cname)
                                        .font(.system(size: 17))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                
                                VStack(alignment: .trailing){
                                    Text("$\(likedCompany.sprice, specifier: "%.2f")")
                                        .bold()
                                        .font(.system(size: 20))
                                    HStack{
                                        Image(systemName: likedCompany.dchange > 0 ? "arrow.up.forward" : (likedCompany.dchange < 0 ? "arrow.down.forward" : "minus"))
                                            .foregroundColor(likedCompany.dchange > 0 ? .green : (likedCompany.dchange < 0 ? .red : .gray))
                                        Text("$\(likedCompany.dchange, specifier: "%.2f") (\(likedCompany.dpchange, specifier: "%.2f")%)")
                                        
                                            .foregroundColor(likedCompany.dchange > 0 ? .green : (likedCompany.dchange < 0 ? .red : .gray))
                                            .font(.system(size: 17))
                                    }
                                }
                            }
                        }
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
               
                   
                }
                
                 finnnhubDiv()
            }
        }
    }
}


//#Preview {
//    FavoritesCompanyView(company_favs: [
//        LikedCompanies(cname: "Apple", cticker: "AAPL", sprice: 123.47, dchange: 2.8942, dpchange: 3.927373),
//        LikedCompanies(cname: "Malcolm", cticker: "NVDA", sprice: 4.0, dchange: -5.0, dpchange: 6.0),
//        LikedCompanies(cname: "Nicola", cticker: "SNAP", sprice: 7.0, dchange: 0.0, dpchange: 9.0),
//        LikedCompanies(cname: "Terri", cticker: "DELL", sprice: 10.0, dchange: 11.0, dpchange: 12.0),
//        LikedCompanies(cname: "Darsh", cticker: "Description 5", sprice: 13.0, dchange: 14.0, dpchange: 15.0)
//    ]
// )
//}
