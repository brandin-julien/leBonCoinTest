//
//  APIHelper.swift
//  leBonCoinTest
//
//  Created by julien brandin on 22/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import Foundation
import UIKit

typealias ApiCategoriesCompletion = (_ results : [category]?, _ errorStrig : String?) -> Void
typealias ApiAdvertsCompletion = (_ results : [advert]?, _ errorStrig : String?) -> Void

class APIHelper {
    
    private let _baseURL = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    
    var getCategoriesUrl: String {
        return _baseURL + "categories.json"
    }
    
    var getAdvertsUrl: String {
        return _baseURL + "listing.json"
    }
    
    
    func getCategories(completion: ApiCategoriesCompletion?) {
      let url = URL(string: getCategoriesUrl)!

      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
          print("Error with fetching categories: \(error)")
            completion?([], "Error with fetching categories")
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(response)")
            completion?([], "Error system")
          return
        }
    
        if let data = data {
            print(data)
            do {
                let result = try JSONDecoder().decode([category].self, from: data)
                print(result)
                completion?(result, "")

            }catch _ {
                print("errror during reading categories json")
                completion?([], "Error of application")
            }
        }
      })
      task.resume()
    }
    
    
    func getAdverts(completion: ApiAdvertsCompletion?) {
      let url = URL(string: getAdvertsUrl)!

      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
          print("Error with fetching adverts: \(error)")
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          print("Error with the response, unexpected status code: \(response)")
          return
        }
    
        if let data = data {
            //print(data)
            do {
                
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "MMM d h:mm a"
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                dateFormatter.locale = Locale(identifier: "fr_FR")
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let result = try decoder.decode([advert].self, from: data)
                //print(result[0])
                print("okkkk")
                completion?(result, "")

            }catch _ {
                print("errror during reading adverts json")
            }
        }
      })
      task.resume()
    }
    
    
}
