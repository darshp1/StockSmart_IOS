//
//  SearchBar.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/6/24.
//

import Foundation
import SwiftUI


struct SearchBar: View {
    @State private var searchText = ""
    @State private var canbtn = false
    
    @Binding var showNavigationBarItems: Bool
    var onTap: () -> Void
    
    var body: some View {
        VStack {
            HStack{
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(red: 55/255, green: 55/255, blue: 55/255).opacity(0.6))
                        .padding(.leading, 10)
                    
                    TextField("Search", text: $searchText)
                        .padding(10)
                        .foregroundColor(.black)
                        .accentColor(Color(red: 55/255, green: 55/255, blue: 55/255).opacity(0.6))
                        .autocapitalization(.allCharacters)
                       
                    if canbtn {
                        Button(action: {
                            searchText = ""
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 55/255, green: 55/255, blue: 55/255).opacity(0.6))
                                    .frame(width: 22, height: 22)
                                
                                Image(systemName: "xmark")
                                    .font(Font.system(size: 11))
                                    .foregroundColor(.white)
                            }
                            .padding([.trailing], 8)
                        }
                    }

                }
                .background(Color(.systemGray4))
                .cornerRadius(12)
                .padding([.leading], 13)
                .padding(!canbtn ? [.trailing] : [])
                .onTapGesture {
                    onTap()
                    canbtn=true
                    
                }
                if(canbtn){
                    Spacer()
                    Button(action: {
                                canbtn=false
                                showNavigationBarItems=true
                                }) {
                                    Text("Cancel")
                                        .foregroundColor(.blue) // Sets the text color
                                        .padding([.trailing], 5)
                                    .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                }
                               
                }
            }
        }
        .padding(1)
    }
}


//
//struct SearchBar: View {
//    // Implement search bar functionality here
//    @State private var searchText = ""
//    var body: some View {
//       
//        VStack {
//            HStack {
//                Image(systemName: "magnifyingglass")
//                    .foregroundColor(.gray)
//                    .padding(.leading, 10)
//                
//                TextField("Search", text: $searchText)
//                    .padding(10)
//                    .foregroundColor(.gray)
//            }
//                   .background(Color(.systemGray4))
//                   .cornerRadius(8)
//                   .padding([.leading, .trailing], 13)
//                  
//               }
//               .padding(1) // Add margins around the VStack
//           }
//}
