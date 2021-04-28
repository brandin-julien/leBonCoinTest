//
//  ViewController.swift
//  leBonCoinTest
//
//  Created by julien brandin on 22/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var advertTableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
//    var advertSearchBar: UISearchBar = {
//       let searchBar = UISearchBar()
//        return searchBar
//    }()
    
    var advertSearchControler: UISearchController = {
       let searchBar = UISearchController(searchResultsController: nil)
        return searchBar
    }()
    
    var categories: [category] = []
    var adverts: [advert] = []
    var filterAdverts: [advert] = []
    var selectedCategory: category?
    
    enum advertTableViewSection: Int, CaseIterable {
        case categorySection = 0
        case advertSection = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func shortByDate(adverts: [advert]){
        
        ///filter urgent and not urgent
        print("total of adverts : \(adverts.count)")
        var urgentItems = adverts.filter { $0.isUrgent == true }
        var notUrgentItems = adverts.filter { $0.isUrgent == false }

        ///filter by date
        urgentItems = urgentItems.sorted { $0.creationDate > $1.creationDate }
        notUrgentItems = notUrgentItems.sorted { $0.creationDate > $1.creationDate }
        
        self.filterAdverts = urgentItems + notUrgentItems
        self.adverts = filterAdverts
        self.advertTableView.reloadData()
        
    }
    
    func getValue(){
        let apiHelper = APIHelper.init()
        
        apiHelper.getAdverts { (result, error) in
            
            if error != nil {
                print("error during load of adverts : \(error)")
            }
            
            if result != nil {
                DispatchQueue.main.async {
                    self.shortByDate(adverts: result!)
                    print("number of adverts: \(String(describing: result?.count))")
                }
                
            }
        }

        apiHelper.getCategories { (result, error) in
            
            if error != nil {
                print(error)
            }
            
            if result != nil {
                DispatchQueue.main.async {
                    print("number of categories: \(result?.count)")
                    self.categories = result ?? []
                    self.advertTableView.reloadData()
                }
                
            }
        }

    }
    
    func setUpValue(){
        shortByDate(adverts: adverts)
        self.advertTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getValue()
        setUpView()
    }
    
    func setUpView(){
        ///get navigationController
//         if let navigationController = navigationController{
//             navigationController.isNavigationBarHidden = false
//         }
        
        ///Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        advertTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
        advertTableView.register(AdvertTableViewCell.self, forCellReuseIdentifier: "advertCell")
        advertTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: "categoryCell")
         
         ///search controller
//         advertSearchControler.searchResultsUpdater = self
//         advertSearchControler.obscuresBackgroundDuringPresentation = false
//         advertSearchControler.searchBar.placeholder = "Rechercher"
//         navigationItem.searchController = advertSearchControler
//         definesPresentationContext = true
         
         ///config for tableView
         advertTableView.dataSource = self
         advertTableView.delegate = self
         view.addSubview(advertTableView)
         advertTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
         advertTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
         advertTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
         advertTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func advertsForCategorySelected(category: category){
        let advertsForCategory = self.adverts.filter( { $0.categoryId == category.id} )
        print("Number of adverts for selected category : \(advertsForCategory.count)")
        self.filterAdverts = advertsForCategory
        let section = IndexSet(integer: 1)
        self.advertTableView.reloadSections(section, with: .none) ///reload adverts sections
    }

}

///delegate and datesource for TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return advertTableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch advertTableViewSection(rawValue: section) {
        case .categorySection:
            return 1
        case .advertSection:
            return filterAdverts.count
        default:
            return 0
        }
    }
           
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        switch advertTableViewSection(rawValue: indexPath.section) {
        case .categorySection:
            let cell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryTableViewCell
            cell.categories = self.categories
            cell.categorySearchProtocol = self
            return cell
        case .advertSection:
            let cell: AdvertTableViewCell = tableView.dequeueReusableCell(withIdentifier: "advertCell", for: indexPath) as! AdvertTableViewCell
            cell.advert = self.filterAdverts[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
           
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let navigationController = self.navigationController else {return}
                        
            let advertDetailViewController = AdvertDetailViewController()
            advertDetailViewController.advert = self.filterAdverts[indexPath.row]
            
            navigationController.pushViewController(advertDetailViewController, animated: true)
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch advertTableViewSection(rawValue: indexPath.section) {
        case .categorySection:
            return 100
        case .advertSection:
            return 160
        default:
            return 200
        }
    }
    
}

/*
//Trying to add a searchBar
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
     
    func filterContentForSearchText(_ searchText: String) {
        print("searchTExt : \(searchText)")
        let searchAdvert = self.filterAdverts.filter { (advert: advert) -> Bool in
            return advert.title.lowercased().contains(searchText.lowercased())
        }
       // self.advertTableView.reloadData()
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        print("present")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        print("dismiss")
    }
}
*/

///protocoal for selectedCategory
extension ViewController: categorySearchProtocol {
    func selectCategory(category: category) {
        print("selected category : \(category.name)")
        self.advertsForCategorySelected(category: category)
    }
    
    func deselectCategory(category: category) {
        print("deselected category : \(category.name)")
        self.filterAdverts = self.adverts
        let section = IndexSet(integer: 1) /// select adverts section
        self.advertTableView.reloadSections(section, with: .none) ///reload only adverts section
    }
    
}
