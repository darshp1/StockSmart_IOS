//
//  ContentView.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/2/24.
//

import SwiftUI
import Foundation
import Highcharts
import UIKit
import Alamofire
import SwiftyJSON


struct PortfolioDetails{
    @State var  cticker: String
    @State var  shares: Int
    @State var sprice: Float
    @State var  bsprice: Float

}


struct SearchResponse: Decodable {
    let ok: Bool
    let finnhubData: SearchData // Change the property name to match the key in JSON data
}

struct SearchData: Decodable {
    let count: Int
    let result: [SearchResult]
}

struct SearchResult: Decodable {
    let symbol: String
    let description: String
}

struct ContentView: View {
//    @State var portfoliodetAppend: [PortfolioDetails] = []
    //@State private var refreshID = UUID()
    @State private var showDetails = false
       @State private var showNavigationBarItems = true
   
       // make the below true for doing loading
       @State private var makeLoadhome = true
        @State private var p1: Float=0.00
        @State private var p2: Float = 0.00
   
     // for Favorites
       @State private var company_favs: [LikedCompanies] = [
//           LikedCompanies(cname: "Apple", cticker: "AAPL", sprice: 123.47, dchange: 2.8942, dpchange: 3.927373),
//           LikedCompanies(cname: "Malcolm", cticker: "NVDA", sprice: 4.0, dchange: -5.0, dpchange: 6.0),
//           LikedCompanies(cname: "Nicola", cticker: "SNAP", sprice: 7.0, dchange: 0.0, dpchange: 9.0),
//           LikedCompanies(cname: "Terri", cticker: "DELL", sprice: 10.0, dchange: 11.0, dpchange: 12.0),
//           LikedCompanies(cname: "Darsh", cticker: "Description 5", sprice: 13.0, dchange: 14.0, dpchange: 15.0)
       ]
   
       // for Portfolios
       @State private var pdetails: [PortfolioDetails] = [
//           PortfolioDetails(cticker: "AAPL", shares: 3, sprice: 123.47, bsprice: 123.47),
//           PortfolioDetails(cticker: "NVDA", shares: 5, sprice: 723.47, bsprice: 821.21)
           ]
   
   
   
       var chartView: HIChartView!
   
    
    
    @State private var searchText = ""
    //@State private var searchResults: [String] = []
    @State private var searchResults: [(String, String)] = []
    let baseURL = "https://web3-571-ass3-darsh.uc.r.appspot.com/auto_complete/"
    
    @State private var timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()

    var body: some View {
        if makeLoadhome{
            // ProgressView
                
                ProgressView("Fetching Data...")
                    .background(Color.white)
                    .onAppear {
                        getFirstPage {
                                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                                    print(p1, 25000)
                                    makeLoadhome = false
                                }
                        }
                        // make below true for every 15 seconds update
                        Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
                            print("it came here")
                            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                                            getFirstPage {
                                                   
                                                    print(p1, 25000)
                                                    makeLoadhome = false
                                                }
                                            }
                                        }
//                       
//                        
                        
                        
                        // the below
//                        getFirstPage { result in
//                                        DispatchQueue.main.async {
//                                          //  self.responseData = result
//                                        }
//                                        
//                                        // Introduce a delay before updating the UI again
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                            makeLoadhome = false
//                                            // Update UI again after 1 second
//                                            // This closure will be executed after 1 second
//                                        }
//                                    }
                    }
                    .opacity(makeLoadhome ? 1 : 0)
        }
                    else{
            NavigationView {
                VStack {
                    
                    if searchText.isEmpty{
                        if !company_favs.isEmpty{
                            FavoritesCompanyView(company_favs: company_favs, pdetails: pdetails, netWorth: 25000, cashBalance: p1)
                            
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        showNavigationBarItems ?        EditButton() : nil
                                    }
                                }
                            
                        }
                        else{
                            
                            List {
                                DateTimeViewr()
                                PortfolioSummary(pdetails: pdetails, netWorth: 25000, cashBalance: p1)
                                Section(header: Text("FAVORITES")) {
                                    // Add any placeholder content here
                                }
                                finnnhubDiv()
                            }
                            .environment(\.defaultMinListRowHeight, 0) // Set defaultMinListRowHeight to 0
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    if showNavigationBarItems {
                                        EditButton()
                                    }
                                }
                            }
                        }
                    }
                    else{
                        List {
                            ForEach(searchResults, id: \.0) { result in
                                let (symbol, description) = result
                                NavigationLink(destination: LikedCompanies(cname: symbol, cticker: symbol, sprice: 39.00, dchange: 39.00, dpchange: 39.00)) {
                                    VStack (alignment:. leading){
                                        
                                        Text(symbol)
                                            .font(.system(size: 22))
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        Text(description)
                                            .font(.system(size: 12))
                                            .foregroundColor(.gray)
                                        
                                    }
                                }
                            }
                            
                        }
                        .navigationTitle("Stocks")
                        
                    }
                    }
                }
                    .searchable(text: $searchText) {
                        //                ForEach(searchResults, id: \.self) { result in
                        //                    Text(result).searchCompletion(result)
                        //                }
                    }
                    

                    .onChange(of: searchText) { newText in
                        searchResults = []
                        if newText.isEmpty {
                            // Clear the search results and search text
                            searchResults = []
                            searchText = ""
                            
                        } else if newText.count >= 3 {
                            fetchSearchResults()
                        }
                    }
            }

    }
   
    
    func fetchSearchResults() {
        searchResults = []
        guard let url = URL(string: baseURL + searchText) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(SearchResponse.self, from: data)
                    
                    if decodedData.ok {
                        // Successful response, extract the symbols from the result
                        let results = decodedData.finnhubData.result
//                        let symbols = results.compactMap { result -> String? in
//                            guard !result.symbol.contains(".") else { return nil }
//                            return result.symbol
//                        }
//
//                        let des = results.compactMap { result -> String? in
//                            guard !result.description.contains(".") else { return nil }
//                            return result.description
//                        }
                        let resultsWithDescription = results.compactMap { result -> (String, String)? in
                            guard !result.symbol.contains("."),
                                  !result.description.contains("."),
                                  result.description.rangeOfCharacter(from: .decimalDigits) == nil else {
                                return nil
                            }
                            return (result.symbol, result.description)
                        }

                      //  let resultsWithDescription = Array(zip(symbols, des))

                        DispatchQueue.main.async {
                            searchResults = resultsWithDescription
                        }

//                        DispatchQueue.main.async {
//                            searchResults = symbols
//                        }
                    } else {
                        // Handle error response
                        print("Server returned error")
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }
           
        task.resume()
    }
    
    func getFirstPage(completion: @escaping () -> Void) {
        company_favs=[]
        pdetails=[]
        let group = DispatchGroup()

            // Request for portfolio data
            group.enter()
        let url = "https://web3-571-ass3-darsh.uc.r.appspot.com/gd/portfolio"
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = [
    //        URLQueryItem(name: "key1", value: "value1"),
    //        URLQueryItem(name: "key2", value: "value2")
        ]
        AF.request(urlComponents.url!, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let jsonArray = JSON(value).arrayValue
                    //print(jsonArray)
                        for jsonObject in jsonArray {
                            if let company_t = jsonObject["company_t"].string,
                               let old_c = jsonObject["old_c"].float,
                                let Quantity = jsonObject["Quantity"].int {
                                    print(company_t, Quantity)
                                fetchData(from: "https://web3-571-ass3-darsh.uc.r.appspot.com/get_price_stock/\(company_t)") { additionalData in
    //
                                    if let finnhubData = additionalData["finnhubData"].dictionary {
                                        // Now finnhubData is a dictionary, you can access its keys and values
                                        if let c = finnhubData["c"]?.float{
                                            // Now you have access to individual values
                                          
                         
                                           // print("Close: \(c)")
                                            let x=PortfolioDetails(cticker: company_t, shares: Quantity, sprice: old_c, bsprice: c);
                                            pdetails.append(x)
                                            let product = Float(Quantity) * c
                                            p2 += product

                                        } else {
                                            print("Error: Missing or invalid data in finnhubData")
                                        }
                                    }
                                    else{
                                        print("error")
                                    }
                                }
                                }
                            }
                    // Handle the success response here
                case .failure(let error):
                    print("Error: \(error)")
                    // Handle the error here
                }
                group.leave()
            }
     
        
        group.enter()
        let url2 = "https://web3-571-ass3-darsh.uc.r.appspot.com/gd/watchlist"
        var urlComponents2 = URLComponents(string: url2)!
        urlComponents2.queryItems = [
    //        URLQueryItem(name: "key1", value: "value1"),
    //        URLQueryItem(name: "key2", value: "value2")
        ]
        AF.request(urlComponents2.url!, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let jsonArray = JSON(value).arrayValue
                        for jsonObject in jsonArray {
                            if let company_t = jsonObject["company_t"].string,
                               let name = jsonObject["company_n"].string,
                                let s_price = jsonObject["s_price"].float {
                                    //print("\n\nfor watchlist",company_t, s_price,"\n\n")
                                    fetchData(from: "https://web3-571-ass3-darsh.uc.r.appspot.com/get_price_stock/\(company_t)") { additionalData in
                                        if let finnhubData = additionalData["finnhubData"].dictionary {
                                            
                                            // Now finnhubData is a dictionary, you can access its keys and values
                                            if let dp = finnhubData["dp"]?.float,
                                               let d = finnhubData["d"]?.float,
                                               let c = finnhubData["c"]?.float{
//                                                // Now you have access to individual values
//                                                print("for watchlit",company_t)
//                                                print("Day Percent Change: \(dp)")
//                                               
//                                                print("Day Change: \(d)")
//                             
//                                                print("Close: \(c)")
//                                            
                                     //           LikedCompanies(cname: "Apple", cticker: "AAPL", sprice: 123.47, dchange: 2.8942, dpchange: 3.927373),
                                                let x=LikedCompanies(cname: name, cticker: company_t, sprice: c, dchange: d, dpchange: dp);
                                                company_favs.append(x)
                                              
                                            } else {
                                                print("Error: Missing or invalid data in finnhubData")
                                            }
                                        }
                                       
                                        else{
                                            print("error")
                                        }
                                    }
                                }
                            }
                case .failure(let error):
                    print("Error: \(error)")
                    // Handle the error here
                }
                group.leave()
            }
        
        group.enter()
        let url3 = "https://web3-571-ass3-darsh.uc.r.appspot.com/gd/uwallet"
        var urlComponents3 = URLComponents(string: url3)!
        urlComponents2.queryItems = [
    //        URLQueryItem(name: "key1", value: "value1"),
    //        URLQueryItem(name: "key2", value: "value2")
        ]
        AF.request(urlComponents3.url!, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    if let w = json[0]["w"].float {
                       // print("Value of w:", w)
                        p1=w
                       // print(p1)
                        } else {
                            print("Error: Unable to extract value of w")
                        }

                case .failure(let error):
                    print("Error: \(error)")
                    // Handle the error here
                }
             group.leave()
            }
        group.notify(queue: .main) {
                print("All groups completed")
                 // Call the completion handler when all groups are completed
            }
        completion()
        
    }

    func fetchData(from url: String, completionHandler: @escaping (JSON) -> Void) {
        AF.request(url, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completionHandler(JSON(value))
                   // print(value)
                case .failure(let error):
                    print("Error: \(error)")
                    // Handle the error here
                }
            }
    }

}



#Preview {
    ContentView()
}

