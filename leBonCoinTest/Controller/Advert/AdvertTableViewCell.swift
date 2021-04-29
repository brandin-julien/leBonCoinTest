//
//  AdvertTableViewCell.swift
//  leBonCoinTest
//
//  Created by julien brandin on 23/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import Foundation
import UIKit

class AdvertTableViewCell: UITableViewCell {
    
    static let imageSize : CGSize = CGSize(width: 150, height: 150)
    static let urgentLabelSize : CGSize = CGSize(width: 60, height: 30)
    static let basicLabelSize : CGSize = CGSize(width: 60, height: 20)
    static let titleLabelSize : CGSize = CGSize(width: 60, height: 40)

    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let descriptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let advertImageView: UIImageView = {
        var image = UIImage(named: "defaultImageCell")
        let imageView = UIImageView()
        imageView.image = image
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "TItle is missing" ///Set default value
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.text = "Price is missing" ///Set default value
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Date is missing" ///Set default value
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let urgentLabel: UILabel = {
        let label = UILabel()
        label.text = "URGENT"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .orange
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.orange.cgColor
        //label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var advert: advert? {
         didSet {
             self.configCell()
         }
     }
    
    func configCell(){
        setUpValue()
        setUpView()
    }
    
    func setUpValue(){
        
        guard let advert = self.advert else{return}
        
        if let url = advert.imagesUrl.small {
            load(url: url)
        }
        titleLabel.text = "\(advert.title)"
        priceLabel.text = "\(advert.price) €"

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d h:mm a"
        let dateFormated = formatter.string(from: advert.creationDate)
        dateLabel.text = "\(dateFormated)"
        
        urgentLabel.isHidden = !advert.isUrgent

    }
    
    func load(url: URL) {
         DispatchQueue.global().async { [weak self] in
             if let data = try? Data(contentsOf: url) {
                 if let image = UIImage(data: data) {
                     DispatchQueue.main.async {
                        self?.advertImageView.image = image
                     }
                 }
             }
         }
     }
    
    func setUpView(){
        
        self.selectionStyle = .none
        
        ///cellView constraint
        self.addSubview(cellView)
        self.cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
        self.cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5).isActive = true
        
        ///advertImageView constraint
        self.addSubview(advertImageView)
        self.advertImageView.heightAnchor.constraint(equalToConstant: AdvertTableViewCell.imageSize.height).isActive = true
        self.advertImageView.widthAnchor.constraint(equalToConstant: AdvertTableViewCell.imageSize.width).isActive = true
        self.advertImageView.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 0).isActive = true
        self.advertImageView.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 0).isActive = true
        
        ///descriptionView constraint
        self.addSubview(descriptionView)
        self.descriptionView.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 0).isActive = true
        self.descriptionView.leftAnchor.constraint(equalTo: self.advertImageView.rightAnchor, constant: 0).isActive = true
        self.descriptionView.bottomAnchor.constraint(equalTo: self.cellView.bottomAnchor, constant: 0).isActive = true
        self.descriptionView.rightAnchor.constraint(equalTo: self.cellView.rightAnchor, constant: 0).isActive = true
        
        ///titleLabel constraint
        self.addSubview(titleLabel)
        self.titleLabel.topAnchor.constraint(equalTo: self.descriptionView.topAnchor, constant: 5).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 5).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -15).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: AdvertTableViewCell.titleLabelSize.height).isActive = true

        ///priceLabel constraint
        self.addSubview(priceLabel)
        self.priceLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        self.priceLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 5).isActive = true
        self.priceLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: 5).isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant: AdvertTableViewCell.basicLabelSize.height).isActive = true
        
        
        ///dateLabel constraint
        self.addSubview(dateLabel)
        self.dateLabel.bottomAnchor.constraint(equalTo: self.descriptionView.bottomAnchor, constant: -10).isActive = true
        self.dateLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 5).isActive = true
        self.dateLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: 5).isActive = true
        self.dateLabel.heightAnchor.constraint(equalToConstant: AdvertTableViewCell.basicLabelSize.height).isActive = true
        
        ///urgentLabel
        
        self.addSubview(urgentLabel)
        self.urgentLabel.topAnchor.constraint(equalTo: self.cellView.topAnchor, constant: 10).isActive = true
        self.urgentLabel.leftAnchor.constraint(equalTo: self.cellView.leftAnchor, constant: 10).isActive = true
        self.urgentLabel.heightAnchor.constraint(equalToConstant: AdvertTableViewCell.urgentLabelSize.height).isActive = true
        self.urgentLabel.widthAnchor.constraint(equalToConstant: AdvertTableViewCell.urgentLabelSize.width).isActive = true
    }
 
}
