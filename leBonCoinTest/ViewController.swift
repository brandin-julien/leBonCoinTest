//
//  ViewController.swift
//  leBonCoinTest
//
//  Created by julien brandin on 22/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var myTableView: UITableView  = UITableView()
    var filterAdverts: [advert] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiHelper = APIHelper.init()
        
        apiHelper.getAdverts { (result, error) in
            
            if error != nil {
                print(error)
            }
            
            if result != nil {
                DispatchQueue.main.async {
                    self.shortByDate(adverts: result!)
                    print(result![0])
                    self.myTableView.reloadData()
                }
                
            }
        }
        
        view.backgroundColor = .red
        
        // Do any additional setup after loading the view.
    }
    
    func shortByDate(adverts: [advert]){
     
        ///filter urgent and not urgent
        var urgentItems = adverts.filter { $0.isUrgent == true }
        var notUrgentItems = adverts.filter { $0.isUrgent == false }

        ///filter by date
        urgentItems = urgentItems.sorted { $0.creationDate > $1.creationDate }
        notUrgentItems = notUrgentItems.sorted { $0.creationDate > $1.creationDate }
        
        //display correctly date for label
//        let formatter3 = DateFormatter()
//        formatter3.dateFormat = "MMM d h:mm a"
//        print(formatter3.string(from: urgentItems[0].creationDate))
        
        self.filterAdverts = urgentItems + notUrgentItems
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
               super.viewWillAppear(animated)
               
///                Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds

               let screenWidth = screenSize.width
               let screenHeight = screenSize.height
        
            myTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
               myTableView.dataSource = self
               myTableView.delegate = self
                
            
        
        myTableView.register(AdvertTableViewCell.self, forCellReuseIdentifier: "advertCell")
               
        view.addSubview(myTableView)
        myTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        }
           
           
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
           {
            return filterAdverts.count
           }
           
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
           {
            
            let cell: AdvertTableViewCell = tableView.dequeueReusableCell(withIdentifier: "advertCell", for: indexPath) as! AdvertTableViewCell
            cell.advert = self.filterAdverts[indexPath.row]
               return cell
           }
           
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
           {
            
//               print("User selected table row \(indexPath.row) and item \(filterAdverts[indexPath.row])")
           }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 160
    }
           

        


}
