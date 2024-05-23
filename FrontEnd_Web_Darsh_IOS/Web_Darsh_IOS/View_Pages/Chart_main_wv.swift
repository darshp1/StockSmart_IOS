//
//  Chart_main_wv.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/29/24.
//

import SwiftUI
import WebKit

struct Chart_main_wv: View {
    let stringParameter: String // Declare a property to hold the string parameter
        
        // Initialize the struct with the string parameter
        init(stringParameter: String) {
            self.stringParameter = stringParameter
        }
    //    @State var title: String = ""
    //    @State var error: Error? = nil
    //
    //    var body: some View {
    //        NavigationView {
    //            WebView(title: $title, url: URL(string: "https://web-frontend-for-a3.uc.r.appspot.com/search/AAPL")!)
    //                .onLoadStatusChanged { loading, error in
    //                    if loading {
    //                        print("Loading started")
    //                        self.title = "Loading…"
    //                    }
    //                    else {
    //                        print("Done loading.")
    //                        if let error = error {
    //                            self.error = error
    //                            if self.title.isEmpty {
    //                                self.title = "Error"
    //                            }
    //                        }
    //                        else if self.title.isEmpty {
    //                            self.title = "Some Place"
    //                        }
    //                    }
    //            }
    //
    //        }
    //    }
    
    //    var body: some View {
    //            VStack {
    //                ClippedWebView( url: URL(string: "https://web-frontend-for-a3.uc.r.appspot.com/search/AAPL")!)
    //                    .frame(width: 300, height: 2000)
    //            }
    //        }
    

 
//        var body: some View {
//                VStack {
//                    ClippedWebView(url: URL(string: "https://web-frontend-for-a3.uc.r.appspot.com/search/AAPL")!)
//                        .frame(width: 400, height: 2000) // Set the desired frame size
//                        .clipped()
//                        .offset(y: calculateOffset()) // Offset to center the visible portion vertically
//                }
//            }
//
//            func calculateOffset() -> CGFloat {
//                let screenHeight = UIScreen.main.bounds.height
//                let visibleHeight = 800 // height from startY to endY
//                let centerOffset = (screenHeight - CGFloat(visibleHeight)) / 2
//                return centerOffset - 500 // Offset to position startY at the center
//            }
    
    var body: some View {
            VStack {
                let startY: CGFloat = 460
                let endY: CGFloat = 1340
                ClippedWebView(url: URL(string: "https://web-frontend-for-a3.uc.r.appspot.com/search/\(stringParameter)")!)
                    .frame(width: UIScreen.main.bounds.width, height: 1400) // Set the desired frame size
                    .clipped()
                    .offset(y: calculateOffset(startY: startY, endY: endY)) // Offset to center the visible portion vertically
            }
        }

        func calculateOffset(startY: CGFloat, endY: CGFloat) -> CGFloat {
            let screenHeight = UIScreen.main.bounds.height
            let visibleHeight = endY - startY
            let centerOffset = (screenHeight - CGFloat(visibleHeight)) / 2
            return centerOffset - startY
        }
}

//
//struct WebView: UIViewRepresentable {
//    @Binding var title: String
//    var url: URL
//    var loadStatusChanged: ((Bool, Error?) -> Void)? = nil
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIView(context: Context) -> WKWebView {
//        let view = WKWebView()
//        view.navigationDelegate = context.coordinator
//        view.load(URLRequest(url: url))
//        return view
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        // you can access environment via context.environment here
//        // Note that this method will be called A LOT
//    }
//
//    func onLoadStatusChanged(perform: ((Bool, Error?) -> Void)?) -> some View {
//        var copy = self
//        copy.loadStatusChanged = perform
//        return copy
//    }
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        let parent: WebView
//
//        init(_ parent: WebView) {
//            self.parent = parent
//        }
//
//        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//            parent.loadStatusChanged?(true, nil)
//        }
//
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            parent.title = webView.title ?? ""
//            parent.loadStatusChanged?(false, nil)
//            
//            
//            let rect = CGRect(x: 0, y: 100, width: webView.bounds.width, height: 50) // Adjust the height as needed
//                webView.scrollView.scrollRectToVisible(rect, animated: false)
//
//            
////            // Adjust content offset for y-coordinate range
////               let xOffset = webView.scrollView.contentOffset.x // Keep the x-coordinate unchanged
////               let yOffset = CGFloat(80) // Start y-coordinate
////               let contentOffset = CGPoint(x: xOffset, y: yOffset)
////               webView.scrollView.setContentOffset(contentOffset, animated: false)
////               
////               // Adjust content size to limit the scrolling range
////               let contentSize = CGSize(width: webView.scrollView.contentSize.width, height: 150)
////               webView.scrollView.contentSize = contentSize
//            
//            
//            
//            
//            // Adjust content offset or size here if needed
//         //   webView.scrollView.setContentOffset(CGPoint(x: 80, y: 150), animated: false) // Adjust y offset as needed
//        }
//
//        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//            parent.loadStatusChanged?(false, error)
//        }
//    }
//}
//
//
//struct ClippedWebView: UIViewRepresentable {
//    var url: URL
//    let visibleRect = CGRect(x: 0, y: 1200, width: 400, height: 700) // Adjust these values as needed
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.load(URLRequest(url: url))
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        // Apply transformation to clip the web view
//        uiView.layer.masksToBounds = true
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = UIBezierPath(rect: visibleRect).cgPath
//        uiView.layer.mask = maskLayer
//    }
//}

//struct ClippedWebView: UIViewRepresentable {
//    var url: URL
//    let clippedSize = CGSize(width: 400, height: 700) // Set the desired size of the clipped area
//    let startY: CGFloat = 1200 // Set the desired Y coordinate to start clipping
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.load(URLRequest(url: url))
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        // Apply transformation to clip the web view
//        uiView.layer.masksToBounds = true
//        
//        // Calculate the vertical offset to start the clipped area
//        let yOffset = max(startY, uiView.scrollView.contentSize.height - clippedSize.height)
//        let visibleRect = CGRect(x: 0, y: yOffset, width: clippedSize.width, height: clippedSize.height)
//
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = UIBezierPath(rect: visibleRect).cgPath
//        uiView.layer.mask = maskLayer
//    }
//}
//struct ClippedWebView: UIViewRepresentable {
//    var url: URL
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.scrollView.isScrollEnabled = false // Disable scrolling
//        webView.load(URLRequest(url: url))
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        // No updates needed
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    class Coordinator: NSObject {
//        // No need for coordinator in this case
//    }
//}

//struct ClippedWebView: UIViewRepresentable {
//    var url: URL
//    let startY: CGFloat = 1200
//    let endY: CGFloat = 2000
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.scrollView.isScrollEnabled = false // Disable scrolling
//        webView.load(URLRequest(url: url))
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        // No updates needed
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    class Coordinator: NSObject {
//        // No need for coordinator in this case
//    }
//}


struct ClippedWebView: UIViewRepresentable {
    var url: URL
    let startY: CGFloat = 1200
    let endY: CGFloat = 1600

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
    Chart_main_wv(stringParameter: "AAPL")
}
