//
//  DateTimeViewr.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/6/24.
//

import Foundation
import SwiftUI

struct DateTimeViewr: View {
    var body: some View {
            let currentDate = Date()
            
            let fd = DateFormatter()
            fd.dateFormat = "MMMM dd, yyyy"
            
            return HStack{
                Text(fd.string(from: currentDate))
                    .bold()
                    .font(.system(size: 33))
//                    .padding(15)
                    .foregroundColor(.gray)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(8)
            .padding([.leading, .trailing], 15)
            .padding(8)
        }
        
}
