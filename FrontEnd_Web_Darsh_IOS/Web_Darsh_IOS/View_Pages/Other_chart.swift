//
//  Other_chart.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/30/24.
//

import SwiftUI
import WebKit

struct Other_chart: View {
    let stringParameter: String // Declare a property to hold the string parameter
        
        // Initialize the struct with the string parameter
        init(stringParameter: String) {
            self.stringParameter = stringParameter
        }
    var body: some View {
            VStack {
                let startY: CGFloat = 00
                let endY: CGFloat = 500
                if stringParameter.uppercased() == "AAPL" {
                    ClippedWebView2(url: URL(string: "file:///Users/darsh/Desktop/Docs/USC_Courses/Spring_2024/Web/My_WT/Assignments/Assignment_4/Code/d.html")!)
                        .frame(width: UIScreen.main.bounds.width, height: 750) // Set the desired frame size
                        .clipped()
                        .offset(y: calculateOffset(startY: startY, endY: endY)) // Offset to center the visible portion vertically
                }
                if stringParameter.uppercased() == "NVDA" {
                    ClippedWebView2(url: URL(string: "file:///Users/darsh/Desktop/Docs/USC_Courses/Spring_2024/Web/My_WT/Assignments/Assignment_4/Code/nvda.html")!)
                        .frame(width: UIScreen.main.bounds.width, height: 750) // Set the desired frame size
                        .clipped()
                        .offset(y: calculateOffset(startY: startY, endY: endY)) // Offset to center the visible portion vertically
                }
                if stringParameter.uppercased() == "QCOM" {
                    ClippedWebView2(url: URL(string: "file:///Users/darsh/Desktop/Docs/USC_Courses/Spring_2024/Web/My_WT/Assignments/Assignment_4/Code/qcom.html")!)
                        .frame(width: UIScreen.main.bounds.width, height: 750) // Set the desired frame size
                        .clipped()
                        .offset(y: calculateOffset(startY: startY, endY: endY)) // Offset to center the visible portion vertically
                }
            }
                
        }

        func calculateOffset(startY: CGFloat, endY: CGFloat) -> CGFloat {
            let screenHeight = UIScreen.main.bounds.height
            let visibleHeight = endY - startY
            let centerOffset = (screenHeight - CGFloat(visibleHeight)) / 2
            return centerOffset - startY
        }
}

struct ClippedWebView2: UIViewRepresentable {
    var url: URL
    let startY: CGFloat = 0
    let endY: CGFloat = 500

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false // Disable scrolling
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject {
        // No need for coordinator in this case
    }
}
#Preview {
    Other_chart(stringParameter: "AAPL")
}
