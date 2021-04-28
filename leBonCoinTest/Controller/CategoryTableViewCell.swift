//
//  CategoryTableViewCell.swift
//  leBonCoinTest
//
//  Created by julien brandin on 26/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    var categorySearchProtocol: categorySearchProtocol? = nil
    var categorySelected: category?
    
    let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    public var categories: [category]? {
         didSet {
             self.configCell()
         }
     }
    
    var categoryCollectionView: UICollectionView!
    
    func configCell(){
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 50)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        
        categoryCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        
        self.categoryCollectionView.backgroundColor = .white
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self

        self.categoryCollectionView.register(categoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        categoryCollectionView.allowsSelection = true
        
        self.categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.categoryCollectionView.collectionViewLayout = flowLayout
        self.categoryCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        self.categoryCollectionView.showsHorizontalScrollIndicator = false
        
        setUpView()
    }
    
    func setUpView(){
        
        ///cellView constraint
        self.addSubview(cellView)
        self.cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        ///collectionView constraint
        self.addSubview(categoryCollectionView)
        self.categoryCollectionView.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 5).isActive = true
        self.categoryCollectionView.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 5).isActive = true
        self.categoryCollectionView.bottomAnchor.constraint(equalTo: self.cellView.bottomAnchor, constant: 5).isActive = true
        self.categoryCollectionView.rightAnchor.constraint(equalTo: self.cellView.rightAnchor, constant: 5).isActive = true

    }
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.categories?.count ?? 0
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            if let cell: categoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? categoryCollectionViewCell {
                    cell.category = self.categories?[indexPath.row]
                    return cell
            }
           
            return UICollectionViewCell()

        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let category = categories?[indexPath.row] else { return }
            self.categorySearchProtocol?.selectCategory(category: category)
            textLabel?.backgroundColor = .orange
                    
            if let categoryIdSelected = categorySelected?.id {
                if category.id == categoryIdSelected {
                    self.categorySelected = nil ///reset categorySelected
                    self.categoryCollectionView.deselectItem(at: indexPath, animated: true)
                    self.categorySearchProtocol?.deselectCategory(category: category)
                }else{
                    self.categorySelected = category ///set categorySelected with the category
                }
            }else{
                self.categorySelected = category ///set categorySelected with the category
            }
        }
}

