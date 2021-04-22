//
//  APIHelper.swift
//  leBonCoinTest
//
//  Created by julien brandin on 22/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import Foundation
import UIKit

//typealias ApiCategoriesCompletion = (_ results : [categoriesResult]?, _ errorStrig : String?) -> Void

class APIHelper {
    
    private let _baseURL = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    
    var getCategoriesUrl: String {
        return _baseURL + "categories.json"
    }
    
    var getAdvertsUrl: String {
        return _baseURL + "listing.json"
    }
    
    
    func getCategories() {
      let url = URL(string: getCategoriesUrl)!

      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
          print("Error with fetching categories: \(error)")
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          print("Error with the response, unexpected status code: \(response)")
          return
        }
    
        if let data = data {
            print(data)
            do {
                let result = try JSONDecoder().decode([category].self, from: data)
                print(result)

            }catch _ {
                print("errror during reading categories json")
            }
        }
      })
      task.resume()
    }
    
    
    func getAdverts() {
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
            print(data)
            do {
                let result = try JSONDecoder().decode([advert].self, from: data)
                print(result[0])

            }catch _ {
                print("errror during reading adverts json")
            }
        }
      })
      task.resume()
    }
    
    
}
