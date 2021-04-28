//
//  advertDetailViewController.swift
//  leBonCoinTest
//
//  Created by julien brandin on 24/04/2021.
//  Copyright © 2021 julien brandin. All rights reserved.
//

import UIKit

class AdvertDetailViewController: UIViewController {

    static let imageSize : CGSize = CGSize(width: 300, height: 300)
    static let urgenceImageSize : CGSize = CGSize(width: 20, height: 20)
    static let urgentLabelSize : CGSize = CGSize(width: 60, height: 30)
    static let basicLabelSize : CGSize = CGSize(width: 60, height: 20)
    static let titleLabelSize : CGSize = CGSize(width: 60, height: 60)
    static let backButtonSize : CGSize = CGSize(width: 30, height: 30)
    static let buyButtonSize : CGSize = CGSize(width: 30, height: 50)
    static let descriptionLabelSize : CGSize = CGSize(width: 30, height: 200)

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
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "TItle is missing" ///Set default value
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.sizeToFit()
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
        label.sizeToFit()
        return label
    }()
    
    let siretLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "" ///Set default value
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let line: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 1
        label.text = " "
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Description is missing" ///Set default value
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        label.sizeToFit()
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
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
    
    let urgenceImageView: UIImageView = {
        var image = UIImage(named: "urgenceStar")
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var advert: advert? {
         didSet {
             self.config()
         }
     }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// dismiss view detail
    @objc func backAction(){
       self.navigationController?.popViewController(animated: true)
    }
    
    func config(){
        setUpView()
        setUpValue()
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
    
    func setUpValue(){
        
        guard let advert = self.advert else{return}

        if let url = advert.imagesUrl.thumb {
                 load(url: url)
        }
        
        titleLabel.text = "\(advert.title)"
        priceLabel.text = "\(advert.price) €"
        descriptionLabel.text = "\(advert.description)"
                
        if let siret = advert.siret {
            siretLabel.text = "Siret : \(siret)"
        }else{
            siretLabel.isHidden = true
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d h:mm a"
        let dateFormated = formatter.string(from: advert.creationDate)
        dateLabel.text = "\(dateFormated)"
        
        urgenceImageView.isHidden = !advert.isUrgent
        
        
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
        self.advertImageView.heightAnchor.constraint(equalToConstant: AdvertDetailViewController.imageSize.height).isActive = true
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
        self.titleLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 20).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -20).isActive = true

        ///priceLabel constraint
        self.view.addSubview(priceLabel)
        self.priceLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
        self.priceLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 20).isActive = true
        self.priceLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -20).isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant: AdvertDetailViewController.basicLabelSize.height).isActive = true
        
        ///dateLabel constraint
        self.view.addSubview(dateLabel)
        self.dateLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 5).isActive = true
        self.dateLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 20).isActive = true
        self.dateLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -20).isActive = true
        self.dateLabel.heightAnchor.constraint(equalToConstant: AdvertDetailViewController.basicLabelSize.height).isActive = true
 
        ///line constant
        self.view.addSubview(line)
        self.line.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 10).isActive = true
        self.line.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -10).isActive = true
        self.line.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 10).isActive = true
        self.line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        ///descLabel constant
        self.view.addSubview(descLabel)
        self.descLabel.topAnchor.constraint(equalTo: self.line.bottomAnchor, constant: 10).isActive = true
        self.descLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -10).isActive = true
        self.descLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 10).isActive = true
        
        ///buyButton constraint
        self.view.addSubview(buyButton)
        self.buyButton.bottomAnchor.constraint(equalTo: self.descriptionView.bottomAnchor, constant: -20).isActive = true
        self.buyButton.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -10).isActive = true
        self.buyButton.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 10).isActive = true
        self.buyButton.heightAnchor.constraint(equalToConstant: AdvertDetailViewController.buyButtonSize.height).isActive = true

        ///descriptionLabel constraint
        self.view.addSubview(descriptionLabel)
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 20).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -20).isActive = true
        self.descriptionLabel.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 10).isActive = true
        
        ///siretLabel constraint
        self.view.addSubview(siretLabel)
        self.siretLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 15).isActive = true
        self.siretLabel.leftAnchor.constraint(equalTo: self.descriptionView.leftAnchor, constant: 20).isActive = true
        self.siretLabel.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -20).isActive = true
        self.siretLabel.heightAnchor.constraint(equalToConstant: AdvertDetailViewController.basicLabelSize.height).isActive = true

        ///backButton constraint
        self.view.addSubview(backButton)
        self.backButton.topAnchor.constraint(equalTo: self.contantView.topAnchor, constant: 35).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.contantView.leftAnchor, constant: 25).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: AdvertDetailViewController.backButtonSize.height).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: AdvertDetailViewController.backButtonSize.width).isActive = true
        
        ///urgenceImageView constant
        self.view.addSubview(urgenceImageView)
        self.urgenceImageView.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 0).isActive = true
        self.urgenceImageView.rightAnchor.constraint(equalTo: self.descriptionView.rightAnchor, constant: -25).isActive = true
        self.urgenceImageView.heightAnchor.constraint(equalToConstant: AdvertDetailViewController.urgenceImageSize.height).isActive = true
        self.urgenceImageView.widthAnchor.constraint(equalToConstant: AdvertDetailViewController.urgenceImageSize.width).isActive = true

    }
}
