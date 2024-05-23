//
//   FavoritesCompanyView.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/8/24.
//

import Foundation
import SwiftUI
//
//
//
//struct FavoritesCompanyView: View {
//    
//    @State private var company_favs: [LikedCompanies] // Change the type to [LikedCompanies]
//        
//    init(company_favs: [LikedCompanies]) {
//        self._company_favs = State(initialValue: company_favs) // Initialize company_favs with the provided array
//    }
//
//    func move(from source: IndexSet, to destination: Int) {
//        company_favs.move(fromOffsets: source, toOffset: destination)
//    }
//    
//    func delete(at offsets: IndexSet) {
//        company_favs.remove(atOffsets: offsets)
//    }
//
//    
//    var body: some View {
//        VStack {
//            PortfolioSummary(netWorth: 25000.00, cashBalance: 25000.00)
//            
//            List {
//                Section(header: Text("FAVORITES")) {
//                    ForEach(company_favs, id: \.cticker) { likedCompany in
//                        NavigationLink(destination: LikedCompanies(cname: likedCompany.cname, cticker: likedCompany.cticker, sprice: likedCompany.sprice, dchange: likedCompany.dchange, dpchange: likedCompany.dpchange)) {
//                         
//                            HStack {
//                                VStack(alignment: .leading){
//                                    Text(likedCompany.cticker)
//                                        .bold()
//                                        .font(.system(size: 22))
//                                    Text(likedCompany.cname)
//                                        .font(.system(size: 17))
//                                        .foregroundColor(.gray)
//                                }
//                                Spacer()
//                                
//                                VStack(alignment: .trailing){
//                                    Text("$\(likedCompany.sprice, specifier: "%.2f")")
//                                        .bold()
//                                        .font(.system(size: 20))
//                                    HStack{
//                                        Image(systemName: likedCompany.dchange > 0 ? "arrow.up.forward" : (likedCompany.dchange < 0 ? "arrow.down.forward" : "minus"))
//                                            .foregroundColor(likedCompany.dchange > 0 ? .green : (likedCompany.dchange < 0 ? .red : .gray))
//                                        Text("$\(likedCompany.dchange, specifier: "%.2f") (\(likedCompany.dpchange, specifier: "%.2f")%)")
//                                        
//                                            .foregroundColor(likedCompany.dchange > 0 ? .green : (likedCompany.dchange < 0 ? .red : .gray))
//                                            .font(.system(size: 17))
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    .onMove(perform: move)
//                    .onDelete(perform: delete)
//                }
//            }
//        }
//    }
//}
//
//struct LikedCompanies: View {
//    var cname: String    // Change name to cname
//    var cticker: String  // Change description to cticker
//    var sprice: Float    // Change floatValue1 to sprice
//    var dchange: Float   // Change floatValue2 to dchange
//    var dpchange: Float
//    
//    var body: some View {
//        Text("User details for \(cticker)")
//            .navigationTitle(cticker)
//    }
//}
