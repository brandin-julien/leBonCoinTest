//
//  CategoryTableViewCell.swift
//  leBonCoinTest
//
//  Created by julien brandin on 26/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    let cellView: UIView = {
        let view = UIView()
        //view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    let testLabel: UILabel = {
//        let label = UILabel()
//        label.text = "TEST"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
//    public var categoryCollectionView: UICollectionView = {
//        let collectionView = UICollectionView()
//        collectionView.backgroundColor = .purple
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()

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
        
        let frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        categoryCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        
//        self.categoryCollectionView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height);
//        self.categoryCollectionView.frame = self.frame
        self.categoryCollectionView.backgroundColor = .white
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self

//        self.categoryCollectionView.register(categoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        self.categoryCollectionView.register(categoryCollectionViewCell.self, forCellWithReuseIdentifier: "categoryCell")
        
        
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
        self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        
//        self.addSubview(testLabel)
//        self.testLabel.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 5).isActive = true
//        self.testLabel.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 5).isActive = true
////        self.testLabel.bottomAnchor.constraint(equalTo: self.cellView.bottomAnchor, constant: 5).isActive = true
//        self.testLabel.rightAnchor.constraint(equalTo: self.cellView.rightAnchor, constant: 5).isActive = true
//        //self.testLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
//
        ///collectionView constraint
        self.addSubview(categoryCollectionView)
        self.categoryCollectionView.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 5).isActive = true
        self.categoryCollectionView.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 5).isActive = true
        self.categoryCollectionView.bottomAnchor.constraint(equalTo: self.cellView.bottomAnchor, constant: 5).isActive = true
        self.categoryCollectionView.rightAnchor.constraint(equalTo: self.cellView.rightAnchor, constant: 5).isActive = true

    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

//        let cell: categoryCollectionViewCell = collectionView.cellForItem(at: indexPath) as! categoryCollectionViewCell
        let cell: categoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCollectionViewCell
        cell.config()
        return cell

//        let cell = UICollectionViewCell()
//        cell.backgroundColor = .black
//        return cell
        
//        if let cell: categoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? categoryCollectionViewCell {
//            cell.config()
//            return cell
//        }
        return UICollectionViewCell()

    }
    
}


/*
extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //let cell: categoryCollectionViewCell = collectionView.cellForItem(at: indexPath) as! categoryCollectionViewCell
        
        if let cell: categoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? categoryCollectionViewCell {
            cell.config()
            return cell
        }
        return UICollectionViewCell()
    }
 
}
*/
