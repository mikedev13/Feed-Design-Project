//
//  HomeFeedViewController.swift
//  Feed Design Project
//
//  Created by Mike Forster on 6/12/18.
//

import UIKit
import SDWebImage

class HomeFeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionview: UICollectionView!
    var cellId = "Cell"
    
    let myTestPost = TestPost.getTestFeed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation bar setup
        self.navigationItem.title = "Explore"
        let button1 = UIBarButtonItem(image: UIImage(named: "avatarUserpicJinYang"), style: .plain, target: self, action: nil)
        let button2 = UIBarButtonItem(image: UIImage(named: "iconNavigationCreatePost"), style: .plain, target: self, action: nil)
        //MARK: TO DO Round image and adjust alignment 
        //self.navigationItem.rightBarButtonItem = button1
        self.navigationItem.leftBarButtonItem = button2
        
        //Configure CollectionView
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 17, right: 0)
        layout.itemSize = CGSize(width: view.frame.width-20, height: 470)
        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(CustomCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor.gray
        self.view.addSubview(collectionview)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myTestPost.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCell
        let cellData = myTestPost[indexPath.row]
        
        //Round corners
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 15
        
        //Action on profileImageButton tapped
        cell.profileImageButton.addTarget(self, action: #selector(profileImageButtonTapped), for: UIControlEvents.touchUpInside)
        
        let imageUrl = cellData.imageURL
        let profileImageUrl = cellData.profileImageURL
        
        //Use image caching library for cell images
        cell.showCaseImageView.sd_setImage(with: imageUrl)
        cell.profileImageButton.sd_setImage(with: profileImageUrl, for: .normal)
        cell.addressTextLabel.text = cellData.addressText
        cell.listingDetailsLabel.text = "$ \(cellData.price) - \(cellData.numberBedrooms) Bedrooms - \(cellData.numberBedrooms) Bath"
        cell.cityLabel.text = cellData.city
        
        return cell
    }
    
    @IBAction func profileImageButtonTapped() -> Void {
        print("profileImageButton Tapped")
    }
    
}



class CustomCell: UICollectionViewCell {
    
    let showCaseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileImageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let addressTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.alpha = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rentalIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rectangle_2")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let listingDetailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.alpha = 0.8
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.black
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    
    func addViews(){
        backgroundColor = UIColor.white
        addSubview(cityLabel)
        addSubview(profileImageButton)
        addSubview(addressTextLabel)
        addSubview(rentalIconImageView)
        addSubview(listingDetailsLabel)
        addSubview(showCaseImageView)

        showCaseImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        showCaseImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        showCaseImageView.heightAnchor.constraint(equalToConstant: 420).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: showCaseImageView.bottomAnchor, constant: 10).isActive = true
        //cityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 230).isActive = true
        //MARK: TO Do Fix top spacing
        cityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 250).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        cityLabel.widthAnchor.constraint(equalToConstant: 95).isActive = true
        
        profileImageButton.topAnchor.constraint(equalTo: showCaseImageView.bottomAnchor, constant: 10).isActive = true
        profileImageButton.leftAnchor.constraint(equalTo: showCaseImageView.leftAnchor, constant: 8).isActive = true
        profileImageButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        profileImageButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        addressTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 52).isActive = true
        addressTextLabel.topAnchor.constraint(equalTo: showCaseImageView.bottomAnchor, constant: 9).isActive = true
        
        rentalIconImageView.topAnchor.constraint(equalTo: showCaseImageView.bottomAnchor, constant: 30).isActive = true
        rentalIconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 55).isActive = true
        rentalIconImageView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        rentalIconImageView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        
        listingDetailsLabel.topAnchor.constraint(equalTo: showCaseImageView.bottomAnchor, constant: 27).isActive = true
        listingDetailsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 67).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



