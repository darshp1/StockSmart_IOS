//
//  NewsItem .swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/13/24.
//

import SwiftUI


struct NewsItem: Identifiable {
    let id = UUID()
    let image: String
    let headline: String
    let datetime: String
    let source: String
    let summary: String
    let formattedDate: String
    let url: String 
}
