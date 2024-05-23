//
//  SheetView3.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/14/24.
//

import SwiftUI

struct SheetView3: View {
    @Environment(\.dismiss) var dismiss
    // need to get the below variable form parent
    @State  var cname: String
    @State  var stocks: String
    
    var body: some View {
        ZStack{
            Color.green.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Congratulations!")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                    .bold()
                Text("You have successfully sold \(stocks) shares of \(cname)")
                    .foregroundColor(.white)
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Text("Done")
                        .foregroundColor(.green)
                        .padding(.horizontal, 130)
                        .padding(.vertical, 15)
                        .background(Color.white)
                        .clipShape(Capsule())
                    
                }
                //                   Button("Press to dismiss") {
                //                       dismiss()
                //                   }
                //                   .font(.title)
                //                   .padding()
                //                   .background(Color.black)
            }
            
        }
    }
}


#Preview {
    SheetView3(cname: "AAPL", stocks: "4")
}
