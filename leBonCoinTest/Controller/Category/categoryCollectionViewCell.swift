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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "category name"        
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .orange
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.orange.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var category: category? {
         didSet {
             self.configCell()
         }
     }
    
    override var isSelected: Bool {
        didSet {
            nameLabel.backgroundColor = isSelected ? .orange : .white
            nameLabel.textColor = isSelected ? .white : .orange
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
        
        ///nameLAbel constraint
        self.addSubview(nameLabel)
        self.nameLabel.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 5).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 5).isActive = true
        self.nameLabel.bottomAnchor.constraint(equalTo: self.cellView.bottomAnchor, constant: 0).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.cellView.rightAnchor, constant: 0).isActive = true
        
    }
    
}
