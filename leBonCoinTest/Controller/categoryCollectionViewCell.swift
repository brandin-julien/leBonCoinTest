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
        view.backgroundColor = .systemPink
        return view
    }()
    
    
    func config(){
        setUpView()
    }
    
    func setUpView(){
        
        ///cellView constraint
        self.addSubview(cellView)
        self.cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        
    }
    
    
}
