//
//  ApiAndDecoderTest.swift
//  leBonCoinTestTests
//
//  Created by julien brandin on 29/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import XCTest
@testable import leBonCoinTest

class ApiAndDecoderTest: XCTestCase {

    func categoriesTestDecoder(){
        
        ///json exemple
        let json = """
                  [
                   {
                      "id": 9,
                      "name": "Service"
                      },
                      {
                      "id": 10,
                      "name": "Animaux"
                      },
                      {
                      "id": 11,
                      "name": "Enfants"
                      }
                  ]
                  """
        
        ///trandform to data
        let data = json.data(using: .utf8)!
        
        ///get categories from json
        let result = try! JSONDecoder().decode([category].self, from: data)

        ///check if decoder is good
        XCTAssertEqual(result[0].id, 9)
        XCTAssertEqual(result[0].name, "Service")
        XCTAssertEqual(result[1].id, 10)
        XCTAssertEqual(result[1].name, "Animaux")
        XCTAssertEqual(result[2].id, 11)
        XCTAssertEqual(result[2].name, "Enfants")
    }
    
    func advertsTestDecoder(){
        
        ///json exemple
        let json = """
                  [
                      {
                      "id": 1643104674,
                      "category_id": 3,
                      "title": "Suzuki gn 125 - Parfait état",
                      "description": "Vends moto SUZUKI GN 125 Rouge Parfait état Véhicule soigné et faiblement kilométré Dort dans un parking fermé et chauffé Utilisée uniquement en ville Kilométrage : 33768 Régulièrement entretenue chez Actua Scoot (Bd Beaumarchais) depuis plus de 10 ans 1er contact par téléphone",
                      "price": 1550,
                      "images_url": {
                      "small": "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/f8d72ff2d2dfc0b9488bc20dbb0669eced1099ef.jpg",
                      "thumb": "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/f8d72ff2d2dfc0b9488bc20dbb0669eced1099ef.jpg"
                      },
                      "creation_date": "2019-11-05T15:55:23+0000",
                      "is_urgent": false
                      },
                      {
                      "id": 1701863243,
                      "category_id": 2,
                      "title": "Cintres qualité showroom",
                      "description": "Vend lot de 55 cintres métalliques d'occasion idéal pour showroom. Possibilité de vendre par lots : - lot de 20 cintres 10€ - lot de 20 cintres10€ - lot de 15 cintres 8€ N’hésitez pas à me contacter par sms pour toutes questions éventuelles",
                      "price": 30,
                      "images_url": {
                      "small": "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/374c6471b4a1718b6a4cc31f203df622431500c6.jpg",
                      "thumb": "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/374c6471b4a1718b6a4cc31f203df622431500c6.jpg"
                      },
                      "creation_date": "2019-11-05T15:55:16+0000",
                      "is_urgent": false
                      },
                      {
                      "id": 1701863257,
                      "category_id": 9,
                      "title": "Cours Particuliers Lycée :Maths, Physique ou Anglais",
                      "description": "Élève en mastère spécialisé à Télécom Paris (diplômé d'école d'ingénieur à Supoptique, IOGS), je souhaite donner des cours de maths, physique ou anglais pour des élèves, jusqu'à la Terminale.  J'ai donné des cours pendant deux ans à Bordeaux auparavant et j'apprécie réellement aider des élèves intéressés mais qui ont des difficultés, quelqu'elles soient.  Nous pourrons réviser le cours ou travailler des exercices selon les besoins de l'élève.  J'habite aux Gobelins avec possibilité de me déplacer Prix : 30€/h",
                      "price": 30,
                      "images_url": {
                      "small": "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/0e0daa0f32ab86fecc943b851ef88d3f45cffcfc.jpg",
                      "thumb": "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/0e0daa0f32ab86fecc943b851ef88d3f45cffcfc.jpg"
                      },
                      "creation_date": "2019-11-05T15:55:16+0000",
                      "is_urgent": false,
                      "siret": "435 456 993"
                      }
                  ]
                  """
        
        ///trandform to data
        let data = json.data(using: .utf8)!
        
        ///get categories from json
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
                   
        let result = try! decoder.decode([advert].self, from: data)

        ///check if decoder is good
        XCTAssertEqual(result[0].id, 1643104674)
        XCTAssertEqual(result[0].title, "Suzuki gn 125 - Parfait état")
        XCTAssertEqual(result[1].id, 1701863243)
        XCTAssertEqual(result[1].isUrgent, false)
        XCTAssertEqual(result[2].id, 1701863257)
        XCTAssertEqual(result[2].siret, "435 456 993")
    }
    
    func testValidApiCallGetsHTTPStatusCode200() throws {
      // given
      let urlString =
        "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"
      let url = URL(string: urlString)!
      // 1
      let promise = expectation(description: "Status code: 200")

      // when
      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        // then
        if let error = error {
          XCTFail("Error: \(error)")
//          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            // 2
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      })
      task.resume()
      // 3
      wait(for: [promise], timeout: 5)
    }
    
    override func setUp() {
        categoriesTestDecoder()
        advertsTestDecoder()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
