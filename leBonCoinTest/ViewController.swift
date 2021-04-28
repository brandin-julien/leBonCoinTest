//
//  ViewController.swift
//  leBonCoinTest
//
//  Created by julien brandin on 22/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var advertTableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    var advertSearchBar: UISearchBar = {
       let searchBar = UISearchBar()
        return searchBar
    }()
    
    var advertSearchControler: UISearchController = {
       let searchBar = UISearchController(searchResultsController: nil)
        return searchBar
    }()
    
    var categories: [category] = []
    var adverts: [advert] = []
    var filterAdverts: [advert] = []
    var selectedCategory: category?
    
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
                    print("number of adverts: \(result?.count)")
                    print(result![0])
                    //self.advertTableView.reloadData()
                }
                
            }
        }

        apiHelper.getCategories { (result, error) in
            
            if error != nil {
                print(error)
            }
            
            if result != nil {
                print("result for categories")
                DispatchQueue.main.async {
                    print("number of categories: \(result?.count)")
                    self.categories = result ?? []
                    self.advertTableView.reloadData()
                }
                
            }
        }
                
        // Do any additional setup after loading the view.
    }
    
    func shortByDate(adverts: [advert]){
     
//        if self.adverts
        
        ///filter urgent and not urgent
        print("=========")
        print(adverts.count)
        print("=========")
        var urgentItems = adverts.filter { $0.isUrgent == true }
        var notUrgentItems = adverts.filter { $0.isUrgent == false }

        ///filter by date
        urgentItems = urgentItems.sorted { $0.creationDate > $1.creationDate }
        notUrgentItems = notUrgentItems.sorted { $0.creationDate > $1.creationDate }
        
        self.filterAdverts = urgentItems + notUrgentItems
        self.adverts = filterAdverts
        self.advertTableView.reloadData()
        
    }
    
    func setUpValue(){
        shortByDate(adverts: adverts)
        self.advertTableView.reloadData()
    }
    
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = navigationController{
            navigationController.isNavigationBarHidden = false
        }
        
        ///Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds

        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        advertTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
        advertTableView.dataSource = self
        advertTableView.delegate = self
        
        advertSearchControler.searchResultsUpdater = self
        advertSearchControler.obscuresBackgroundDuringPresentation = false
        advertSearchControler.searchBar.placeholder = "Rechercher"
        navigationItem.searchController = advertSearchControler
        definesPresentationContext = true
            
        advertTableView.register(AdvertTableViewCell.self, forCellReuseIdentifier: "advertCell")
        advertTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")

        view.addSubview(advertTableView)
        advertTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        advertTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        advertTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        advertTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        }
    
    func advertsForCategorySelected(category: category){
        let advertsForCategory = self.adverts.filter( { $0.categoryId == category.id} )
        print(advertsForCategory.count)
        self.filterAdverts = advertsForCategory
        let section = IndexSet(integer: 1)
        self.advertTableView.reloadSections(section, with: .none)
//        self.advertTableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if section == 0{
                return 1
            }
            return filterAdverts.count
           }
           
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
           if indexPath.section == 0 {
                let cell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
                cell.categories = self.categories
                cell.categorySelected = selectedCategory
                cell.categorySearchProtocol = self
                return cell
            }else if indexPath.section == 1{
                let cell: AdvertTableViewCell = tableView.dequeueReusableCell(withIdentifier: "advertCell", for: indexPath) as! AdvertTableViewCell
                    cell.advert = self.filterAdverts[indexPath.row]
                return cell
            }
           return UITableViewCell()
    }
           
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("selected \(indexPath.row) item")
            guard let navigationController = self.navigationController else {return}
            
            print("guard let passed")
            print(filterAdverts[indexPath.row])
            
            let advertDetailViewController = AdvertDetailViewController()
            advertDetailViewController.advert = self.filterAdverts[indexPath.row]
            
            navigationController.pushViewController(advertDetailViewController, animated: true)
           }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 105
        }
        return 170
    }
}

extension ViewController: UISearchResultsUpdating, UISearchControllerDelegate{
    
    
    func updateSearchResults(for searchController: UISearchController) {
      // TODO
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    var isSearchBarEmpty: Bool {
        print("isSearchBarEmpty \(advertSearchControler.searchBar.text?.isEmpty ?? true)")
        return advertSearchControler.searchBar.text?.isEmpty ?? true
    }
    
    /*
     DEBUG THIS
     */
     
    func filterContentForSearchText(_ searchText: String) {
        print("searchTExt : \(searchText)")
        let searchAdvert = self.filterAdverts.filter { (advert: advert) -> Bool in
            return advert.title.lowercased().contains(searchText.lowercased())
        }
        //self.advertTableView.reloadData()
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        print("present")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        print("dismiss")
    }
    
}

extension ViewController: categorySearchProtocol {
    func selectCategory(category: category) {
        print("selected category : \(category.name)")
        self.advertsForCategorySelected(category: category)
    }
    
    func deselectCategory(category: category) {
        print("deselected category : \(category.name)")
        self.filterAdverts = self.adverts
        let section = IndexSet(integer: 1)
        self.advertTableView.reloadSections(section, with: .none)
//        self.advertTableView.reloadData()
    }
    
    
}
