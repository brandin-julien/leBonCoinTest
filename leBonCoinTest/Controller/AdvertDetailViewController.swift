//
//  advertDetailViewController.swift
//  leBonCoinTest
//
//  Created by julien brandin on 24/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import UIKit

class AdvertDetailViewController: UIViewController {

    static let imageSize : CGSize = CGSize(width: 150, height: 500)

    let contantView: UIView = {
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
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Description is missing" ///Set default value
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        //label.lineBreakMode = .byTruncatingTail
        label.adjustsFontForContentSizeCategory = true
//        label.sizeToFit()
        return label
    }()
    
    let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Acheter", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var advert: advert? {
         didSet {
             self.config()
         }
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("change view controller")

        // Do any additional setup after loading the view.
    }
    
    func config(){
        print("==========")
        setUpView()
        setUpValue()
    }
    
    func setUpValue(){
        
        guard let advert = self.advert else{return}

        titleLabel.text = "\(advert.title)"
        priceLabel.text = "\(advert.price) €"
        descriptionLabel.text = "\(advert.description)"

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d h:mm a"
        let dateFormated = formatter.string(from: advert.creationDate)
        dateLabel.text = "\(dateFormated)"
        
    }
    
    func setUpView(){
        
        ///cellView constraint

        self.view.addSubview(contantView)
        self.contantView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.contantView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.contantView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.contantView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        
        ///advertImageView constraint
        self.view.addSubview(advertImageView)
        self.advertImageView.heightAnchor.constraint(equalToConstant: AdvertTableViewCell.imageSize.height).isActive = true
        //self.advertImageView.widthAnchor.constraint(equalToConstant: AdvertTableViewCell.imageSize.width).isActive = true
        self.advertImageView.topAnchor.constraint(equalTo: self.contantView.topAnchor, constant: 0).isActive = true
        self.advertImageView.rightAnchor.constraint(equalTo: self.contantView.rightAnchor, constant: 0).isActive = true
        self.advertImageView.leftAnchor.constraint(equalTo: self.contantView.leftAnchor, constant: 0).isActive = true
        
        ///descriptionView constraint
        self.view.addSubview(descriptionView)
        self.descriptionView.topAnchor.constraint(equalTo: self.advertImageView.bottomAnchor, constant: 0).isActive = true
        self.descriptionView.rightAnchor.constraint(equalTo: self.contantView.rightAnchor, constant: 0).isActive = true
        self.descriptionView.bottomAnchor.constraint(equalTo: self.contantView.bottomAnchor, constant: 0).isActive = true
        self.descriptionView.leftAnchor.constraint(equalTo: self.contantView.leftAnchor, constant: 0).isActive = true
        
        ///titleLabel constraint
        self.view.addSubview(titleLabel)
        self.titleLabel.topAnchor.constraint(equalTo: self.descriptionView.topAnchor, constant: 5).isActive = true
        self.titleLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 5).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -15).isActive = true
        self.titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        ///priceLabel constraint
        self.view.addSubview(priceLabel)
        self.priceLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        self.priceLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 5).isActive = true
        self.priceLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: 5).isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        ///dateLabel constraint
        self.view.addSubview(dateLabel)
        self.dateLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 5).isActive = true
        self.dateLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 5).isActive = true
        self.dateLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: 5).isActive = true
        self.dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
 
        
        ///buyButton constraint
        
        self.view.addSubview(buyButton)
        self.buyButton.bottomAnchor.constraint(equalTo: self.descriptionView.bottomAnchor, constant: -20).isActive = true
        self.buyButton.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -10).isActive = true
        self.buyButton.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 10).isActive = true
        self.buyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        ///descriptionLabel constraint
        self.view.addSubview(descriptionLabel)
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.buyButton.topAnchor, constant: 5).isActive = true
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 10).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -10).isActive = true
        self.descriptionLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 10).isActive = true
        //self.descriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
