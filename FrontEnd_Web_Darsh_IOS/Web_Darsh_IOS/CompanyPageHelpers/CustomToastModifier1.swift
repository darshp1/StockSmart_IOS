//
//  CustomToastModifier1.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 5/1/24.
//

import SwiftUI
import SwiftUI

struct CustomToastModifier1: ViewModifier {
    @Binding var isShowingToast2: Bool
    @Binding var cticker: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isShowingToast2 {
                VStack {
                    Spacer()
                    Text("Removed \(cticker) to favourites")
                        .foregroundColor(.white)
                        .padding(.horizontal, 45)
                        .padding(.vertical, 30)
                        .background(Color.gray)
                        .clipShape(Capsule())
                }
                .padding(.bottom, 2)
                .onAppear {
                   //print("Toast appearing")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                        withAnimation {
                            isShowingToast2 = false
                        }
                    }
                }
            }
        }
    }
}

extension View {
    func customToast2(isShowingToast2: Binding<Bool>, cticker: Binding<String>, duration: TimeInterval = 1) -> some View {
        modifier(CustomToastModifier1(isShowingToast2: isShowingToast2, cticker: cticker))
        //.customToast(isShowingToast: $isShowingToast,  cticker: $cticker)
      
    }
}
