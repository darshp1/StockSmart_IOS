//
//  NewsView.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/13/24.
//

import SwiftUI



struct SheetView: View {
    let news: NewsItem
    @Environment(\.dismiss) var dismiss
   
    @State private var open_B_safari = false
    
    var body: some View {
            VStack {
                HStack {
                        Spacer() // Pushes the button to the rightmost side
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                    }
                .padding()
                Text(news.source)
                    .font(.title)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(news.formattedDate)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
            
                Divider()
                
                Text(news.headline)
                    .font(.system(size: 21).bold())
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(news.summary.truncated(limit: 75))
                    .font(.system(size: 13))
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    if let url = URL(string: news.url) {//
        
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack(spacing: 0) {
                                Text("For more details click ")
                                    .font(.system(size: 13))
                                    .padding(.leading)
                                  
                                    .foregroundColor(.secondary)
                                    Text("here").underline()
                                    .font(.system(size: 13))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                               
                                }
                        }
                      
                
//                Text("For more details click here")
//                    .font(.system(size: 13))
//                    .padding(.leading)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .foregroundColor(.secondary)
                HStack(spacing: 0){
                   
                    Link(destination: URL(string: "https://twitter.com/intent/tweet?text=\(news.headline.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&url=\(news.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)" )!,
                                 label: {
                                    if let twitterImage = UIImage(named: "xt") {
                                        Image(uiImage: twitterImage)
                                            .resizable()
                                            .frame(width: 37, height: 37)
                                    } else {
                                        Text("Twitter") // Display text if image is not available
                                    }
                                })
                                .padding(.leading, 17)
                                
                    
                    Link(destination: URL(string: "https://www.facebook.com/sharer/sharer.php?u=\(news.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!,
                                 label: {
                                    if let image = UIImage(named: "fb") {
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                    } else {
                                        Text("Facebook")
                                    }
                                })
                    .padding(.leading, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
              
            }
        Spacer()
        }
    }


extension String {
    func truncated(limit: Int, trailing: String = "[...]") -> String {
        let words = self.components(separatedBy: .whitespacesAndNewlines)
        let truncatedWords = words.prefix(limit)
        let truncatedText = truncatedWords.joined(separator: " ")
        
        if words.count > limit {
            return truncatedText + trailing
        } else {
            return truncatedText
        }
    }
}


struct NewsView: View {
    @State private var showingSheet = false
    
    let newsItems: [NewsItem]
    @State private var selectedNewsItem: NewsItem?
    @State private var isPresentingUser: NewsItem? = nil

    var body: some View {
//                    VStack {
//                        ForEach(newsItems, id: \.headline) { newsItem in
//                            Text(newsItem.headline)
//                        }
//                    }
//        
//                    Button("Show Sheet") {
//                        showingSheet.toggle()
//                    }
//                    .sheet(isPresented: $showingSheet) {
//                        SheetView()
//                    }
        VStack {
            ForEach(Array(newsItems.enumerated()), id: \.element.id) { index, newsItem in
               
                    Button(action: {
                        selectedNewsItem = newsItem
                        showingSheet = true
                        isPresentingUser = newsItem
                    }) {
                        
                        if index==0{
                            VStack{
                                VStack(alignment: .trailing, spacing: 4) {

                                    if let imageUrl = URL(string: newsItem.image) {
                                        AsyncImage(url: imageUrl) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: UIScreen.main.bounds.width * 0.88, height: 215)
                                                    .cornerRadius(15)
                                            case .failure(_):
                                                Text("Failed to load image")
                                            case .empty:
                                                ProgressView() // Placeholder while loading
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                    }else {
                                        
                                        Text("Image not available")
                                    }
                                    
                                }
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        
                                        Text(newsItem.datetime)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                        
                                        Text(newsItem.headline)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.leading)
                                            
                                    }
                                }
                                .padding(.leading, 12)
                                .padding(.trailing, 5)
                          
                            }
                            .padding()
                        }
                        else{
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                
                                Text(newsItem.datetime)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text(newsItem.headline)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                
                            }
                            
                            .frame(width: UIScreen.main.bounds.width * 0.62)
                            
                            VStack(alignment: .trailing, spacing: 4) {
                                if let imageUrl = URL(string: newsItem.image) {
                                    AsyncImage(url: imageUrl) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 100, height: 105)
                                                .cornerRadius(15)
                                        case .failure(_):
                                            Text("Failed to load image")
                                        case .empty:
                                            ProgressView() // Placeholder while loading
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                }else {
                                    
                                    Text("Image not available")
                                }
                                
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.38)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(10)
                        
                    }
                    
                }
            }
                }
            .sheet(item: $isPresentingUser) { newsItem in
                SheetView(news: newsItem)
            }
        }
            
    }

#Preview {
    NewsView(newsItems: [NewsItem(image: "https://media.zenfs.com/en/reuters.com/b114924f19c4c7b9f6e500ef4b59c721", headline: "Apple denies violating US court order in Epic Games lawsuit", datetime: "08 hr, 16 min", source: "Yahoo", summary: "Apple denies violating US court order in Epic Games lawsuit", formattedDate: "22 July,24", url: "https://finnhub.io/api/news?id=27565c626253064f942996726a680865ba1ad7ddcb208906b01491f0d24db858"),   NewsItem(image: "https://media.zenfs.com/en/reuters.com/b114924f19c4c7b9f6e500ef4b59c721", headline: "Sample Headline", datetime: "1 hr", source: "Sample Source", summary: "Sample Summary", formattedDate: "22 July,24", url: "https://finnhub.io/api/news?id=27565c626253064f942996726a680865ba1ad7ddcb208906b01491f0d24db858"),NewsItem(image: "https://media.zenfs.com/en/reuters.com/b114924f19c4c7b9f6e500ef4b59c721", headline: "Another Headline", datetime: "2 hr", source: "Another Source", summary: "Another Summary", formattedDate: "22 July,24", url: "https://finnhub.io/api/news?id=27565c626253064f942996726a680865ba1ad7ddcb208906b01491f0d24db858")])
}
//
//ForEach(newsItems, id: \.headline) { newsItem in
//    Button(action: {
//        selectedNewsItem = newsItem
//        showingSheet = true
//    }) {
//        HStack {
//            VStack(spacing: 4) {
//                
//                Text(newsItem.datetime)
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    Text(newsItem.headline)
//                        .font(.headline)
//                        .foregroundColor(.primary)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//               
//            }
//         
//            VStack(alignment: .trailing, spacing: 4) {
//                if let imageUrl = URL(string: newsItem.image) {
//                                                AsyncImage(url: imageUrl) { phase in
//                                                    switch phase {
//                                                    case .success(let image):
//                                                        image
//                                                            .resizable()
//                                                            .aspectRatio(contentMode: .fill)
//                                                            .frame(width: 100, height: 115)
//                                                            .cornerRadius(5)
//                                                    case .failure(_):
//                                                        Text("Failed to load image")
//                                                    case .empty:
//                                                        ProgressView() // Placeholder while loading
//                                                    @unknown default:
//                                                        EmptyView()
//                                                    }
//                                                }
//                                            }else {
//                                                // Placeholder or error handling for invalid URL
//                                                Text("Image not available")
//                                            }
//            
//            }
//        }
//        .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color(UIColor.systemBackground))
//                            .cornerRadius(10)
//        
//    }
//    
//}
//}
//.sheet(isPresented: $showingSheet) {
//if let selectedNewsItem = selectedNewsItem {
//    SheetView(news: selectedNewsItem)
//}
