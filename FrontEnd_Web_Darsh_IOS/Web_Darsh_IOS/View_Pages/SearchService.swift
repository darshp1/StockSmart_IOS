//
//  SearchService.swift
//  Web_Darsh_IOS
//
//  Created by Darsh Patel on 4/18/24.
//

import SwiftUI
//
//class SearchService {
//    private var currentTask: URLSessionDataTask?
//    
//    func fetchSearchResults(for searchText: String, completion: @escaping ((String, String)?) -> Void) {
//        // Cancel previous task if it exists
//        currentTask?.cancel()
//        
//        // Delay before making the request
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            guard let url = URL(string: baseURL + searchText) else { return }
//            
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error = error {
//                    print("Error: \(error)")
//                    completion(nil)
//                    return
//                }
//                
//                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                    print("Invalid response")
//                    completion(nil)
//                    return
//                }
//                
//                if let data = data {
//                    do {
//                        let decoder = JSONDecoder()
//                        let decodedData = try decoder.decode(SearchResponse.self, from: data)
//                        
//                        if decodedData.ok {
//                            // Successful response, extract the symbols from the result
//                            let results = decodedData.finnhubData.result
//                            if let lastResult = results.last,
//                               !lastResult.symbol.contains("."),
//                               !lastResult.description.contains("."),
//                               lastResult.description.rangeOfCharacter(from: .decimalDigits) == nil {
//                                completion((lastResult.symbol, lastResult.description))
//                            } else {
//                                completion(nil)
//                            }
//                        } else {
//                            // Handle error response
//                            print("Server returned error")
//                            completion(nil)
//                        }
//                    } catch {
//                        print("Decoding error: \(error)")
//                        completion(nil)
//                    }
//                }
//            }
//            
//            self.currentTask = task
//            task.resume()
//        }
//    }
//}
