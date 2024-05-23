//
//  LikedCompanies.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/6/24.
//
import Alamofire
import SwiftUI
import SwiftyJSON

struct LikedCompanies: View {
    // calling all of it again to get new data and making it State to changeit
    @State var cname: String
    @State var cticker: String
    @State var sprice: Float
    @State var dchange: Float
    @State var dpchange: Float
  //  @State var Q: Float
    //  @State var dp: Float
    //  @State var d: Float
    //  @State var c: Float
    
    // make below true to get loading
    @State private var makeLoadcomp = true
    
    
    
    // Portfolio
    @State private var showingSheet = false
    
    // just to check json data
    @State private var jsonData: Any? = nil
    
    // get_data api for About section
    @State private var weburl: String?
    @State private var logo: String?
    @State private var ipo: String?
    @State private var industry: String?
    
    // To get peers Data
    @State private var peers: [String] = []

    
    // get_price_stock data for getting Stats section
    @State private var open: Any?
    @State private var high: Any?
    @State private var low: Any?
    @State private var prevClose: Any?
    
    // To get Historical charts data
    @State private var  surprise_a: [Double] = []
    @State private var  actual_a: [Double] = []
    @State private var  estimate_a: [Double] = []
    @State private var  period_a: [String] = []
    
    
    // Recmmendation data api second chart data
    @State private var Period: [String] = []
    @State private var Buy: [Int] = []
    @State private var Strong_buy: [Int] = []
    @State private var Hold: [Int] = []
    @State private var Sell: [Int] = []
    @State private var Strong_Sell: [Int] = []
    
    // ffor Insider sentin=ment table
    @State private var Tmsrp: Double = 0.0
       @State private var Pmsrp: Double = 0.0
       @State private var Nmsrp: Double = 0.0
    @State private var Tchange: Double = 0.0
       @State private var Pchange: Double = 0.0
       @State private var Nchange: Double = 0.0
       private var data: [[Any]] {
           return [
            [cname, "MSRP", "Change"],
                        ["Total", String(format: "%.2f", Tmsrp), String(format: "%.2f", Tchange)],
                        ["Positive", String(format: "%.2f", Pmsrp), String(format: "%.2f", Pchange)],
                        ["Negative", String(format: "%.2f", Nmsrp), String(format: "%.2f", Nchange)]           ]
       }
    
    
    // For News Display
    @State private var newsItems1: [NewsItem] = []
    
    // for tabs
    @State private var selectedTab = 0
 
    
    // for chart page
    @State private var pageContent: AnyView?
    
    // for liked one
    @State private var isLiked: Bool = false
    
    
    // for toast,sheet2,walletmoney
    @State private var isShowingToast=false
    @State private var isShowingToast2=false
    @State private var walletMoney: Float = 0.00
    
    // for Shares
    @State private var Shares:Int = 0
    @State private var old_c1: Float = 0.00


    
    var body: some View {
        if makeLoadcomp{
            ProgressView("Fetching Data...")
                .background(Color.white)
                .onAppear {
                    Task {
                        let loadedPageContent = Chart_main_wv(stringParameter: cticker)
                        await fetchData()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.pageContent = AnyView(loadedPageContent)
                            makeLoadcomp = false
                        }
                    }
                }
                .opacity(makeLoadcomp ? 1 : 0)
        }
        else{
           
            VStack {
               
                ScrollViewReader { proxy in
                    ScrollView{

                        VStack(alignment: .leading){
                            HStack{
                                Text(cname)
                             
                                    .font(.system(size: 17))
                                    .foregroundColor(.gray)
                                Spacer()
                                AsyncImage(url: URL(string: logo ?? "Error<import-schema>schema identifier</import-schema>")) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30, height: 30)
                                        } placeholder: {
                                            // Placeholder view while loadin
                                            ProgressView()
                                        }
                            }
                            .padding(EdgeInsets(top: 0, leading: 22, bottom: 4, trailing: 20))
                        
                            HStack{
                                Text("$\(sprice, specifier: "%.2f")")
                                    .bold()
                                    .font(.system(size: 35))
                                    .padding(.trailing, 10)
                                Image(systemName: dchange > 0 ? "arrow.up.forward" : (dchange < 0 ? "arrow.down.forward" : "minus"))
                                    .foregroundColor(dchange > 0 ? .green : (dchange < 0 ? .red : .gray))
                                Text("$\(dchange, specifier: "%.2f") (\(dpchange, specifier: "%.2f")%)")
                                
                                    .foregroundColor(dchange > 0 ? .green : (dchange < 0 ? .red : .gray))
                                    .font(.system(size: 24))
                                Spacer()
                            }
                            .padding([.leading,  .trailing], 22)
                            
                           

                            TabView(selection: $selectedTab) {
                                pageContent
                                    .tag(0)
                                    .tabItem {
                                            Label("Hourly", systemImage: "chart.xyaxis.line")
                                        }
                                   
                                Other_chart(stringParameter: cticker)
                                    .tag(1)
                                    .tabItem {
                                        Label("Historical", systemImage: "clock.fill")
                                        }
                            }
                            .padding(.horizontal, 0)
                            .frame(height: 450)
                       
                            
                            Text("Portfolio")
                                .font(.title)
                                .padding(EdgeInsets(top: 1, leading: 9, bottom: -10, trailing: 0))
                            
                            HStack{
                                if Shares == 0 {
                                    VStack {
                                        Text("You have 0 shares of \(cticker)")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("Start Trading!")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    } .font(.system(size: 14))
                                } else {
                                    VStack {
                                        HStack{
                                            Text("Shares Owned:")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .bold()
                                            Text("\(Shares)")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                                        HStack{
                                            Text("Avg. Cost/Share:")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .bold()
                                            //Text(String(format: "%.2f", old_c1))
                                                Text(String(format: "%.2f", (sprice * Float(Shares))))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                                        HStack{
                                            Text("Total Cost:")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .bold()
                                            //Text(String(format: "%.2f", (old_c1 * Float(Shares))))
                                                Text(String(format: "%.2f", (sprice * Float(Shares))))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                                        HStack{
                                            Text("Change:")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .bold()
                                            Text(String(format: "%.2f", (sprice * Float(Shares))-(sprice * Float(Shares))))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                                        HStack{
                                            Text("Market Value:")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .bold()
                                            Text(String(format: "%.2f", (sprice * Float(Shares))))
                                                
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                                      
                                       
                                       
                                    }  .font(.system(size: 14))
                                        
                                    
                                }
                                
                                
                                Spacer()
                                Button(action: {
                                    // Action to perform when the button is tapped
                                    showingSheet.toggle()
                                }) {
                                    Text("Trade")
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color.green)
                                        .clipShape(Capsule()) // Oval shape
                                }
                                .sheet(isPresented: $showingSheet) {
                                    SheetView2(Shares:$Shares,pmoney: walletMoney, name:cname, cticker:cticker.uppercased(), cvalue:sprice )
                                }
                            }
                            .padding()

                            
                            // the comment to comment
                            Text("Stats")
                                .font(.title)
                                .padding(EdgeInsets(top: 1, leading: 9, bottom: 6, trailing: 0))
                            LazyVGrid(columns: [
                                // Fixed width for the first column
                                GridItem(.fixed(75)),
                                // Flexible width for the second column
                                GridItem(.fixed(60)),
                                GridItem(.fixed(10)),
                                GridItem(.fixed(80)),
                                GridItem(.fixed(60)),
                                GridItem(.fixed(60))
                                
                            ], spacing: 0) {
                                
                                GridRow {
                                    HStack {
                                        Text("High Price:")
                                            .bold()
                                    }
                                    
                                    HStack {
                                        if let jsonData = high {
                                            let jsonString = String(describing: jsonData)
                                            let cleanedString = jsonString.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "")
                                            Text("$\(cleanedString)")
                                            
                                        }
                                        
                                    }
                                    HStack{}
                                    
                                    HStack {
                                        Text("Open Price:")
                                            .bold()
                                    }
                                    
                                    HStack {
                                        if let jsonData = open {
                                            let jsonString = String(describing: jsonData)
                                            let cleanedString = jsonString.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "")
                                            Text("$\(cleanedString)")// use other slace
                                        }
                                    }
                                    HStack{}
                                    
                                    
                                }
                                
                                GridRow {
                                    HStack {
                                        Text("Low Price:")
                                            .bold()
                                    }
                                    
                                    HStack {
                                        if let jsonData = low {
                                            let jsonString = String(describing: jsonData)
                                            let cleanedString = jsonString.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "")
                                            Text("$\(cleanedString)")
                                        }
                                    }
                                    
                                    HStack{}
                                    
                                    HStack {
                                        Text("Prev. Close:")
                                            .bold()
                                    }
                                    
                                    HStack {
                                        if let jsonData = prevClose {
                                            let jsonString = String(describing: jsonData)
                                            let cleanedString = jsonString.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "")
                                            Text("$\(cleanedString)")
                                        }
                                    }
                                    HStack{}
                                    
                                }
                                
                            }
                            .padding(.horizontal, 10)
                            .font(.system(size: 14))
                            // to comment
                            
                            Text("About")
                                .font(.title)
                                .padding(EdgeInsets(top: 6, leading: 9, bottom: 6, trailing: 0))
                            LazyVGrid(columns: [
                                // Fixed width for the first column
                                GridItem(.fixed(130)),
                                // Flexible width for the second column
                                GridItem(.flexible())
                            ], spacing: 0) {
                                if let weburl = weburl {
                                    GridRow {
                                        HStack {
                                            Text("Webpage:")
                                                .bold()
                                            Spacer()
                                        }
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                Link(destination: URL(string: weburl)!) {
                                                    Text(weburl)
                                                }
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                if let ipo = ipo {
                                    GridRow {
                                        HStack {
                                            Text("IPO Start Date:")
                                                .bold()
                                            Spacer()
                                        }
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack{
                                                Text(ipo)
                                                Spacer()
                                            }
                                        }
                                        
                                    }
                                }
                                if let industry = industry {
                                    GridRow {
                                        HStack {
                                            Text("Industry:")
                                                .bold()
                                            Spacer()
                                        }
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack{
                                                Text(industry)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                if !peers.isEmpty {
                                    GridRow {
                                        HStack {
                                            Text("Company Peers:")
                                                .bold()
                                            Spacer()
                                        }
                                    
                                            ScrollView(.horizontal, showsIndicators: true) {
                                                LazyHStack {
                                                    
                                                    ForEach(peers, id: \.self) { peer in
                                                        NavigationLink(destination: LikedCompanies(cname: peer, cticker: peer, sprice: sprice, dchange: dchange, dpchange: dpchange)) {
                                                            Text("\(peer),")
                                                        }
                                                    }
                                                }
                                            
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                            .font(.system(size: 14))
                            
                        
                        
                            Text("Insights")
                                .font(.title)
                                .padding(EdgeInsets(top: 1, leading: 9, bottom: 6, trailing: 0))
                            
                            HStack {
                                Spacer()
                                Text("Insider Sentiments")
                                    .font(.title)
                                Spacer()
                            }

                            
                            LazyVStack(spacing: 10) {
                                ForEach(data.indices, id: \.self) { row in
                                    HStack(spacing: 10) {
                                        ForEach(data[row].indices, id: \.self) { column in
                                            ZStack(alignment: .bottom) {
                                                Text("\(data[row][column])")
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                    .padding(.bottom, 3) // Adjust the value as needed
                                                    .font(column == 0 || row == 0 ? .headline : .body)
                                                Rectangle()
                                                    .frame(height: 1)
                                                    .foregroundColor(.gray)
                                                    .alignmentGuide(.bottom) { _ in 0 }
                                            }
                                        }
                                    }
                                }
                            }
                                  
                        
                            Text("")
                                .font(.title)
                                .padding(EdgeInsets(top: 1, leading: 9, bottom: 6, trailing: 0))
                            
                          
                            ChartViews(Buy: $Buy, Period: $Period, Hold: $Hold, Sell: $Sell, Strong_buy: $Strong_buy, Strong_Sell: $Strong_Sell, surprise_a: $surprise_a, actual_a: $actual_a, estimate_a: $estimate_a, period_a: $period_a)
                         
                            Text("News")
                                .font(.title)
                                .padding(EdgeInsets(top: 1, leading: 17, bottom: 6, trailing: 0))
                            
                            if !newsItems1.isEmpty {
                                NewsView(newsItems: newsItems1)
                            } else {
                                Text("No news available")
                            }

                        }
                
                    }
                    
                }
            }
            .customToast(isShowingToast: $isShowingToast,  cticker: $cticker)
            .customToast2(isShowingToast2: $isShowingToast2,  cticker: $cticker)
            .navigationTitle(cticker)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isLiked {
                        Button(action: {
                            remove()
                            isLiked=false
                            isShowingToast2=true
                            print("button clicked")
                            
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color(.blue))
                                    .frame(width: 22, height: 22)
                                
                                Image(systemName: "plus")
                                    .font(Font.system(size: 11))
                                    .foregroundColor(.white)
                            }
                            .padding([.trailing], 8)
                        }
                        
                    }
                    else{
                       
                        Button(action: {
                            isLiked=true
                            isShowingToast=true
                            something()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color(.white))
                                    .overlay(
                                        Circle()
                                            .stroke(Color.blue, lineWidth: 2)
                                    )
                                    .frame(width: 22, height: 22)
                                
                                Image(systemName: "plus")
                                    .font(Font.system(size: 11))
                                    .foregroundColor(.blue)
                            }
                            .padding([.trailing], 8)
                        }
                    }
                }
                    
            }
            
        }
    }
    
    func remove()
    {
        let parameters: [String: Any] = [
                "ticker": cticker,
                
            ]
        
        AF.request("https://web3-571-ass3-darsh.uc.r.appspot.com/delete/watchlist", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
               // print(response)
            
                switch response.result {
                case .success(let value):
                    print("Success: \(value)")
                    if let message = value as? String {
                        print("Response message: \(message)")
                        // Handle the response message accordingly
                        // For example, show an alert with the message
                    }
                case .failure(let error):
                    if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("Error: \(errorMessage)")
                        // Handle the error message accordingly
                        // For example, show an alert with the error message
                    } else {
                        print("Error: \(error)")
                        // Handle other types of errors
                    }
                }
            }
    }
    
    func something(){
        print("yes came")
        let parameters: [String: Any] = [
                "ticker": cticker,
                "name": cname,
                "c": sprice,
                "q": 0,
                "dp": 0
            ]
       // print(parameters)
            

        AF.request("https://web3-571-ass3-darsh.uc.r.appspot.com/insert/watchlist", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
               // print(response)
                switch response.result {
                case .success(let value):
                    print("Success: \(value)")
                    if let message = value as? String {
                        print("Response message: \(message)")
                        // Handle the response message accordingly
                        // For example, show an alert with the message
                    }
                case .failure(let error):
                    if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("Error: \(errorMessage)")
                        // Handle the error message accordingly
                        // For example, show an alert with the error message
                    } else {
                        print("Error: \(error)")
                        // Handle other types of errors
                    }
                }
            }
    }
       

    func fetchData() async {
        guard let url1 = URL(string: "https://web3-571-ass3-darsh.uc.r.appspot.com/get_data/\(cticker)") else { return }
        guard let url2 = URL(string: "https://web3-571-ass3-darsh.uc.r.appspot.com/peers/\(cticker)") else { return }
        guard let url3 = URL(string: "https://web3-571-ass3-darsh.uc.r.appspot.com/get_price_stock/\(cticker)") else { return }
        guard let url4 = URL(string: "https://web3-571-ass3-darsh.uc.r.appspot.com/earnings/\(cticker)") else { return }
//      
        guard let url6 = URL(string: "https://web3-571-ass3-darsh.uc.r.appspot.com/gd/watchlist") else { return }
        guard let url7 = URL(string: "https://web3-571-ass3-darsh.uc.r.appspot.com/company_news/\(cticker)") else { return }
        guard let url8 = URL(string: "https://web3-571-ass3-darsh.uc.r.appspot.com/Recommendation_Trends/\(cticker)") else { return }
//        guard let url9 = URL(string: "https://web3-571-ass3-darsh.uc.r.appspot.com/day_data\(cticker)") else { return }
//
        
        
        
        guard let url5 = URL(string: "https://web3-571-ass3-darsh.uc.r.appspot.com/Insider_Sentiment/\(cticker)") else {return}
        
       
        
        do {
       
            // Fetch data from both URLs concurrently
           
            async let (data1, _) = URLSession.shared.data(from: url1)
            async let (data2, _) = URLSession.shared.data(from: url2)
            async let (data3, _) = URLSession.shared.data(from: url3)
            async let (data4, _) = URLSession.shared.data(from: url4)
            async let (data5, _) = URLSession.shared.data(from: url5)
           async let (data6, _) = URLSession.shared.data(from: url6)
           
         //
            async let (data7, _) = URLSession.shared.data(from: url7)
            async let (data8, _) = URLSession.shared.data(from: url8)
            
           
            // Decode data from the first URL
            let decodedData1 = try await JSONDecoder().decode(CompanyInfo.self, from: data1)
          
            weburl = decodedData1.finnhubData.weburl
            ipo = decodedData1.finnhubData.ipo
            industry = decodedData1.finnhubData.finnhubIndustry
            logo = decodedData1.finnhubData.logo
            cname = decodedData1.finnhubData.name
            // Decode data from the second URL
            if let peerData = try await JSONSerialization.jsonObject(with: data2, options: []) as? [String: Any],
                           let peersArray = peerData["finnhubData"] as? [String] {
                            peers = peersArray
                    }
            
           

            
            if let priceData = try await JSONSerialization.jsonObject(with: data3, options: []) as? [String: Any],
                     let finnhubData = priceData["finnhubData"] as? [String: Any] {
                if let k=finnhubData["c"]{
                    sprice=(k as AnyObject).floatValue
                }
                if let k=finnhubData["d"]{
                    dchange=(k as AnyObject).floatValue
                }
                if let k=finnhubData["dp"]{
                    dpchange=(k as AnyObject).floatValue
                }
                if let highString = finnhubData["h"] {
                       high = highString
                        
                }
              
                if let low1 = finnhubData["l"] {
                          low = low1
                      }
              
                if let open1 = finnhubData["o"] {
                          open = open1
                      }
                if let close = finnhubData["pc"]{
                          prevClose = close
                      }
                  }
            

            if let earningsData = try await JSONSerialization.jsonObject(with: data4, options: []) as? [String: Any],
               let finnhubData = earningsData["finnhubData"] as? [[String: Any]] {
                // Store the finnhubData array in the variable
                var s: [Double] = []
                var actual: [Double] = []
                var estimate: [Double] = []
                var dates: [String] = []
                for item in finnhubData {
                    if let period = item["period"] as? String,
                       let surprise = item["surprise"] as? Double,
                       let actualValue = item["actual"] as? Double,
                       let estimateValue = item["estimate"] as? Double {
                        s.append(surprise)
                        actual.append(actualValue)
                        estimate.append(estimateValue)
                        dates.append(period)
                    }
                }
                
                surprise_a = s
                actual_a = actual
                estimate_a = estimate
                period_a = dates
               // print(surprise_a , actual_a,  estimate_a, period_a)
            }
            
     
         
//            if let responseData = try await JSONSerialization.jsonObject(with: data5, options: []) as? [String: Any],
//                let finnhubData = responseData["finnhubData"] as? [[String: Any]] {
//                   print(finnhubData)
//               }
//            else{
//                print("hey")
//            }
       
          
            if let InsiderJson = try await
                JSONSerialization.jsonObject(with: data5, options: []) as? [String: Any],
                  let ok = InsiderJson["ok"] as? Bool,
                  ok,
                  let finnhubData = InsiderJson["finnhubData"] as? [String: Any],
                  let data = finnhubData["data"] as? [[String: Any]] {
                
                var tmsrp = 0.0
                              var pmsrp = 0.0
                              var nmsrp = 0.0
                              var tchange = 0.0
                              var pchange = 0.0
                              var nchange = 0.0
                  
                  for item in data {
                      if let msrp = item["mspr"] as? Double,
                         let change = item["change"] as? Double {
                          // Process the data
                                                tmsrp += msrp
                                                tchange += change
                        
                                                if change > 0 {
                                                    pchange += change
                                                } else {
                                                    nchange += change
                                                }
                        
                                                if msrp > 0 {
                                                    pmsrp += msrp
                                                } else {
                                                    nmsrp += msrp
                                                }
                      }
                  }
                Tmsrp=tmsrp
                Pmsrp=pmsrp
                Nmsrp=nmsrp
                Tchange=tchange
                Pchange=pchange
                Nchange=nchange
                //print(tmsrp, pmsrp, nmsrp, tchange, pchange, nchange)
                  
              } else {
                  print("Unable to parse JSON")
              }
            
              
            
     
            
            if let newsData = try await JSONSerialization.jsonObject(with: data7, options: []) as? [String: Any],
                let finnhubData = newsData["finnhubData"] as? [[String: Any]] {
               
                var newsItems: [NewsItem] = []
                let currentTimestamp = Int(Date().timeIntervalSince1970)
                
                 for newsDict in finnhubData{
                     guard let image = newsDict["image"] as? String, !image.isEmpty,
                           let headline = newsDict["headline"] as? String,
                           let datetime = newsDict["datetime"] as? Int,
                           let source = newsDict["source"] as? String,
                           let url1 = newsDict["url"] as? String,
                           let summary = newsDict["summary"] as? String else {
                         // Skip this news item if any required field is missing or if image is empty
                         continue
                     }
                     
                  
                     
                     let date = Date(timeIntervalSince1970: TimeInterval(datetime))
                        let dateFormatter = DateFormatter()
                         dateFormatter.dateFormat = "MMMM d, yyyy"
                         let formattedDate = dateFormatter.string(from: date)
                       // print(formattedDate )
                     let timeDifference = currentTimestamp - datetime
                     let hours = timeDifference / 3600
                             let minutes = (timeDifference % 3600) / 60
                             let formattedDatetime = String(format: "%02d hr, %02d min", hours, minutes)
                     
                     
//                     let newsItem = NewsItem(image: image, headline: headline, datetime: formattedDatetime, source: source, summary: summary)
                     let newsItem = NewsItem(image: image, headline: headline, datetime: formattedDatetime, source: source, summary: summary, formattedDate: formattedDate, url: url1)
                     newsItems.append(newsItem)
                 }
                 
                 // Ensure there are exactly 20 news items
                 let finalNewsItems = Array(newsItems.prefix(20))
                newsItems1=finalNewsItems
               // print("Number of news items: \(newsItems.count)")

               // print(newsItems1[0])
               }
          
            if let responseData = try await JSONSerialization.jsonObject(with: data8, options: []) as? [String: Any],
                let finnhubData = responseData["finnhubData"] as? [[String: Any]] {
                var buy: [Int] = []
                var sell: [Int] = []
                var hold: [Int] = []
                var strong_buy: [Int] = []
                var strong_sell: [Int] = []
                var period: [String] = []
                for item in finnhubData {
                  
                    // Access individual items within each dictionary
                    if let period1 = item["period"] as? String,
                       let buy1 = item["buy"] as? Int,
                       let hold1 = item["hold"] as? Int,
                       let sell1 = item["sell"] as? Int,
                       let strongBuy1 = item["strongBuy"] as? Int,
                       let strongSell1 = item["strongSell"] as? Int{
                      //  print("hey")
                      
                        period.append(period1)
                               buy.append(buy1)
                               sell.append(sell1)
                               hold.append(hold1)
                               strong_buy.append(strongBuy1)
                               strong_sell.append(strongSell1)
                        
                    }
                }
                Period = period
                  Buy = buy
                  Hold=hold
                  Sell=sell
                  Strong_buy=strong_buy
                  Strong_Sell=strong_sell
             //  print(Buy, Period, Hold, Sell, Strong_buy, Strong_Sell)
           
          
                }
          

        } catch {
            print("Error fetching data: \(error)")
        }
        //if anything happens remove this part
        let urlno = "https://web3-571-ass3-darsh.uc.r.appspot.com/gd/watchlist"
           AF.request(urlno, method: .get)
               .responseJSON { response in
                   switch response.result {
                   case .success(let value):
                       let jsonArray = JSON(value).arrayValue
                       for jsonObject in jsonArray {
                           if let company_t = jsonObject["company_t"].string {
                               if (cticker.uppercased() == company_t.uppercased()){
                                  isLiked=true
                               }
                           }
                       }
                       // Handle the success response here
                   case .failure(let error):
                       print("Error: \(error)")
                       // Handle the error here
                   }
               }
        
        // till here
        
        
        let url13 = "https://web3-571-ass3-darsh.uc.r.appspot.com/gd/uwallet"
        var urlComponents3 = URLComponents(string: url13)!
        urlComponents3.queryItems = [
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
                        walletMoney=w
                        print(w)
                       // print(p1)
                        } else {
                            print("Error: Unable to extract value of w")
                        }

                case .failure(let error):
                    print("Error: \(error)")
                    // Handle the error here
                }
         
            }
        
        
        
        
        let url = "https://web3-571-ass3-darsh.uc.r.appspot.com/gd/portfolio"
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = [
    //        URLQueryItem(name: "key1", value: "value1"),
    //        URLQueryItem(name: "key2", value: "value2")
        ]
        AF.request(urlComponents.url!, method: .get)
            .responseJSON { response in
                print("hey")
                switch response.result {
                   
                case .success(let value):
                    let jsonArray = JSON(value).arrayValue
                    for jsonObject in jsonArray {
                        if let company_t = jsonObject["company_t"].string,
                           let old_c = jsonObject["old_c"].float,
                           let Quantity = jsonObject["Quantity"].int {
                          //  print(company_t, Quantity)
                            fetchData(from: "https://web3-571-ass3-darsh.uc.r.appspot.com/get_price_stock/\(cticker)") { additionalData in
                                if let finnhubData = additionalData["finnhubData"].dictionary {
                                    // Now finnhubData is a dictionary, you can access its keys and values
                                  //  print(finnhubData)
                                    if let c = finnhubData["c"]?.float,
                                    let d=finnhubData["d"]?.float,
                                    let dp=finnhubData["dp"]?.float{
                                        // Now you have access to individual values
                                      print(c,d,dp)
                                    sprice = c
                                    dchange = d
                                    dpchange = dp

                                    } else {
                                        print("Error: Missing or invalid data in finnhubData")
                                    }
                                }
                                else{
                                    print("error")
                                }
                            }
                            if (cticker.uppercased() == company_t.uppercased()){
                                Shares=Quantity
                                old_c1=old_c
                                print(company_t, Quantity)
                                
                            }
                           
                        }
                    }
                    
                    // Handle the success response here
                case .failure(let error):
                    print("Error: \(error)")
                    // Handle the error here
                }
               
            }
     
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
    LikedCompanies(cname: "aapl", cticker: "aapl", sprice: 123.47, dchange: 2.8942, dpchange: 3.927373)
}
