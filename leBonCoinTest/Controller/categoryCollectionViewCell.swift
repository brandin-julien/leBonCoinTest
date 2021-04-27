//
//  categoryCollectionViewCell.swift
//  leBonCoinTest
//
//  Created by julien brandin on 26/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import UIKit

class categoryCollectionViewCell: UICollectionViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "category name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var category: category? {
         didSet {
             self.configCell()
         }
     }
    
    
    func configCell(){
        setUpValue()
        setUpView()
    }
    
    func setUpValue(){
        
        guard let category = self.category else { return }
        
        nameLabel.text = category.name
    }
    
    func setUpView(){
        
        ///cellView constraint
        self.addSubview(cellView)
        self.cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        self.addSubview(nameLabel)
        self.nameLabel.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 0).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 0).isActive = true
        self.nameLabel.bottomAnchor.constraint(equalTo: self.cellView.bottomAnchor, constant: 0).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.cellView.rightAnchor, constant: 0).isActive = true
        //self.testLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true

        
        
    }
    
    
}
