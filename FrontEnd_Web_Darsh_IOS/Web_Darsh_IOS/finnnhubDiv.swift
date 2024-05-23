//
//  finnnhubDiv.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/6/24.
//

import Foundation
import SwiftUI

struct finnnhubDiv: View {
    var body: some View {
//        VStack{
//            Link("Powered by Finnhub.io", destination: URL(string: "https://www.finnhub.io")!)
//                .foregroundColor(.gray)
//                .font(.system(size: 15))
//                .padding(15)
//        }
//        .frame(maxWidth: .infinity)
//        .background(Color.white)
//        .cornerRadius(8)
//        .padding([.leading, .trailing], 15)
//        .padding(8)
        
        HStack {
            Spacer()
            Link("Powered by Finnhub.io", destination: URL(string: "https://www.finnhub.io")!)
                .foregroundColor(.gray)
                .font(.system(size: 15))
                .padding(12)
            Spacer()
        }
    }
}

#Preview {
    finnnhubDiv()
}
