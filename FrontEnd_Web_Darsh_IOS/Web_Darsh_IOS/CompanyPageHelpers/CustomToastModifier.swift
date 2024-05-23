//
//  CustomToastModifier.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/30/24.
//

import SwiftUI

struct CustomToastModifier: ViewModifier {
    @Binding var isShowingToast: Bool
    @Binding var cticker: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isShowingToast {
                VStack {
                    Spacer()
                    Text("Adding \(cticker) to favourites")
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
                            isShowingToast = false
                        }
                    }
                }
            }
        }
    }
}

extension View {
    func customToast(isShowingToast: Binding<Bool>, cticker: Binding<String>, duration: TimeInterval = 1) -> some View {
        modifier(CustomToastModifier(isShowingToast: isShowingToast, cticker: cticker))
        //.customToast(isShowingToast: $isShowingToast,  cticker: $cticker)
      
    }
}



//#Preview {
//    CustomToastModifier(isShowingToast: true, cticker: "AAPL")
//}
