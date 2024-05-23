//
//  SheetView2.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/14/24.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct ToastModifier: ViewModifier{
    @Binding var isBottomTost: Bool
    @Binding var notEnough: Bool
    func body(content: Content) -> some View {
        ZStack{
            content
            if isBottomTost{
                VStack{
                    Spacer()
                    Text("Please enter a valid amount")
                        .foregroundColor(.white)
                        .padding(.horizontal, 35)
                        .padding(.vertical, 30)
                        .background(Color.gray)
                        .clipShape(Capsule())
                }
                .padding(.bottom, 2)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.8){
                        withAnimation
                        {
                            isBottomTost=false
                        }
                    }
                }
            }
            
            if notEnough{
                VStack{
                    Spacer()
                    Text("Not Enough to Sell")
                        .foregroundColor(.white)
                        .padding(.horizontal, 60)
                        .padding(.vertical, 30)
                        .background(Color.gray)
                        .clipShape(Capsule())
                }
                .padding(.bottom, 2)
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now()+1.8){
                        withAnimation
                        {
                            notEnough=false
                        }
                    }
                }
            }
        
        }
    }
}

extension View{
    func toast(isBottomTost: Binding<Bool>, notEnough: Binding<Bool>, duration: TimeInterval = 1) -> some View{
        modifier(ToastModifier(isBottomTost: isBottomTost, notEnough: notEnough))
    }
}

struct SheetView2: View {
    
    
    @Environment(\.dismiss) var dismiss
    
    
    var Stockvalue = 0.00
    // make the below variables Binding
    @Binding var Shares: Int
    @State var pmoney: Float = 22450.63
    @State var name: String = ""
    @State var cticker: String = "AAPL"
    @State var cvalue: Float = 173.15
    
    @State private var cExistingStocks=4
    // make the above State variable Binding and use it for whole view
    @State private var stocks = ""
    @State private var isBottomTost=false
    @State private var notEnough=false
    @State private var isSheet3Visible = false
    @State private var isSheet4Visible = false
    
    func BuyStocks(_ amount: String){
        if amount==""{
            isBottomTost=true
        }
        else{
            isSheet4Visible=true
            
            if let a = Int(amount) {
                Shares += a
                let d=Float(a)*cvalue
                let parameters: [String: Any] = [
                        "ticker": cticker,
                        "name": name,
                        "c": cvalue,
                        "q": a,
                        "p": d
                    ]
                print(parameters)
                    
    //                AF.request("https://web3-571-ass3-darsh.uc.r.appspot.com/insert/portfolio", method: .post, parameters: parameters, encoding: JSONEncoding.default)
    //                    .responseJSON { response in
    //                        switch response.result {
    //                        case .success(let value):
    //                            print("Success: \(value)")
    //                        case .failure(let error):
    //                            print("Error: \(error)")
    //                        }
    //                    }
    //
               
                AF.request("https://web3-571-ass3-darsh.uc.r.appspot.com/insert/portfolio", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                    .responseJSON { response in
                        print(response)
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
         
           // Int(amount)
            // all the data with mongodb here  for buing
            
            // after mongodb async await make it dismiss
            //                    if !isSheet3Visible{
            //                        dismiss()
            //                    }
        }
        
    }
    
    func SellStocks(_ amount: String, _ maxstocks: Int){
        if amount==""{
            isBottomTost=true
        }
        else{
            if let stocksToSell = Int(amount) {
                if stocksToSell > Shares {
                    notEnough = true
                }
                else{
                    isSheet3Visible=true
                    if let d = Int(amount) {
                        let a = d * -1
                        Shares += a
                        let d = Float(a)*cvalue
                        let parameters: [String: Any] = [
                                "ticker": cticker,
                                "name": name,
                                "c": cvalue,
                                "q": a,
                                "p": d
                            ]
                       // print(parameters)
                            
              
                        AF.request("https://web3-571-ass3-darsh.uc.r.appspot.com/insert/portfolio", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                            .responseJSON { response in
                                print(response)
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
                    // all the data wiht mongodb here for selling
                    
                    
                    // after mongodb async await make it dismiss
                    //                    if !isSheet3Visible{
                    //                        dismiss()
                    //                    }
                }
            }
        }
        
      

        
    }
    
    var body: some View {

            VStack {
                
                VStack{
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                    }
                    .padding()
                    Text("Trade \(cticker) Inc shares")
                        .font(.system(size: 21).bold())
                    
                }
                Spacer()
            
             
                HStack {
                    TextField("0", text: $stocks)
                        .keyboardType(.numberPad)
                        .padding()
                        .font(.system(size: 103))
                        .frame(width: UIScreen.main.bounds.width * 0.4)
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Shares")
                            .font(.title)
                            .padding(.bottom, 12)
                        Text("x $\(String(format: "%.2f", cvalue))/share = $\(String(format: "%.2f", (Float(stocks) ?? 0) * cvalue))")
                          
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.6)
                }
                Spacer()
          
                VStack{
                    Text("$\(String(format: "%.2f", pmoney)) available to buy \(cticker)")
                        .foregroundColor(.secondary)
                    HStack{
                        Button(action: {
                            BuyStocks(stocks)
                        }) {
                            Text("Buy")
                                .foregroundColor(.white)
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                                .background(Color.green)
                                .clipShape(Capsule())
                                
                        }
                        // to change  buy one
//                        .sheet(isPresented: $isSheet4Visible) {
//                            SheetView4(cname: cticker, stocks: stocks)
//                                   }
             

                        .padding()
                        Button(action: {
                            SellStocks(stocks,cExistingStocks)
                        }) {
                            Text("Sell")
                                .foregroundColor(.white)
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                                .background(Color.green)
                                .clipShape(Capsule())
                        }
                        // to change  sell one
//                        .sheet(isPresented: $isSheet3Visible) {
//                            SheetView3(cname: cticker, stocks: stocks)
//                                   }
                    }
                    
                }
                
            }
            .toast(isBottomTost: $isBottomTost,  notEnough: $notEnough)
            .overlay(Buysheet)
            .overlay(Sellsheet)
        // 2 methods either the above one else the below one using .overlay, just remove content from the struct toaster view
//            .overlay(
//                        VStack {
//                            Spacer()
//                            Text("Please enter a valid amount")
//                                .foregroundColor(.white)
//                                .padding(.horizontal, 35)
//                                .padding(.vertical, 30)
//                                .background(Color.gray)
//                                .clipShape(Capsule())
//                                .toast(isBottomTost: $isBottomTost)
//                        }
////                        .padding(.bottom, 2)
////                        .opacity(isBottomTost ? 1 : 0) // Show or hide the toast based on isBottomTost
////                        .animation(.easeInOut(duration: 0.3)) // Optional animation for showing/hiding the toast
//                    )
            
    }
    @ViewBuilder private var Buysheet: some View {
        if isSheet4Visible {
            VStack{
                Spacer()
                Text("Congralutions!")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                    .bold()
                    .foregroundColor(Color.white)
                //                Text("You have successfully bought \(number) shares of \(choice)")
                //                    .font(.subheadline)
                //                    .foregroundColor(Color.white)
                
                if Int(stocks) ?? 0 > 1 {
                    Text("You have successfully bought \(stocks) shares of \(cticker)")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                }else{
                    Text("You have successfully bought \(stocks) share of \(cticker)")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                }
                Spacer()
                HStack{
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Done")
                            .padding(.horizontal, 120.0)
                            .padding(.vertical, 15.0)
                            .foregroundColor(.green)
                            .background(.white)
                            .cornerRadius(100)
                    }
                }
                //                .padding(.horizontal, 10.0)
            }
            .frame(minWidth:0, maxWidth: .infinity)
            .background(Color.green)
        }
    }
    
    @ViewBuilder private var Sellsheet: some View {
        if isSheet3Visible {
            VStack{
                Spacer()
                Text("Congralutions!")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                    .bold()
                    .foregroundColor(Color.white)
                //                Text("You have successfully bought \(number) shares of \(choice)")
                //                    .font(.subheadline)
                //                    .foregroundColor(Color.white)
                
                if Int(stocks) ?? 0 > 1 {
                    Text("You have successfully sold \(stocks) shares of \(cticker)")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                }else{
                    Text("You have successfully sold \(stocks) share of \(cticker)")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                }
                Spacer()
                HStack{
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Done")
                            .padding(.horizontal, 120.0)
                            .padding(.vertical, 15.0)
                            .foregroundColor(.green)
                            .background(.white)
                            .cornerRadius(100)
                    }
                }
                //                .padding(.horizontal, 10.0)
            }
            .frame(minWidth:0, maxWidth: .infinity)
            .background(Color.green)
        }
    }
}




#Preview {
    SheetView2(Shares: Binding.constant(2),pmoney: 25000.00, name: "Apple INC", cticker: "AAPL", cvalue: 123.45)
}
//struct SheetView2_Previews: PreviewProvider {
//    static var previews: some View {
//        // Define a constant Binding<Int>
//        let shares = Binding.constant(100)
//        
//        // Preview SheetView2 with the constant Binding<Int>
//        return SheetView2(Shares: shares, pmoney: 25000.00, name: "Apple INC", cticker: "AAPL", cvalue: 123.45)
//    }
//}
