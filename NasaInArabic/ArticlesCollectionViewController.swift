//
//  ArticlesCollectionViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/4/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit


import Cards


class ArticlesCollectionViewController: UICollectionViewController  {
    
    private let titleCellReuseIdentifier = "titleCell"
    private let normalCellReuseIdentifier = "normalCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(ArticlesTitleCell.self, forCellWithReuseIdentifier: titleCellReuseIdentifier)
        
        self.collectionView!.register(ArticlesNormalCell.self, forCellWithReuseIdentifier: normalCellReuseIdentifier)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:
        IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row == 0)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  titleCellReuseIdentifier, for: indexPath) as! ArticlesTitleCell
            return cell
            
        }
        
        else
        {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  normalCellReuseIdentifier, for: indexPath) as! ArticlesNormalCell
            return cell
            
            
        }
    }

 
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
    }
    */
    
}

class ArticlesTitleCell: UICollectionViewCell
{
    
    var titleLabel: UILabel = {
        
        var titleLbl = UILabel()
        titleLbl.text = "اخر المقالات"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 34)
        titleLbl.textAlignment = .right
        return titleLbl
        
    }()
    
    var titleImage: UIImageView = {
        
        var titleImg = UIImageView()
        titleImg.image = UIImage(named: "main_logo")
        return  titleImg
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents()
    {
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        
        self.addSubview(titleImage)
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleImage.heightAnchor.constraint(equalToConstant: 43.52).isActive = true
        titleImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        titleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
}

class ArticlesNormalCell: UICollectionViewCell{
    
    var imageView: UIImageView = {
        
        var imgView = UIImageView()
        imgView.roundTop(radius: 20)
        imgView.image = UIImage(named: "category-earth")
        return imgView
        
    }()
    
    var articleDescription: UILabel = {
        
        var desc = UILabel()
        desc.textColor = UIColor.darkGray
        desc.textAlignment = .right
        desc.font = UIFont.systemFont(ofSize: 15)
        desc.text = "الخلاصة: وجدت دراسة جديد رابطًا بين التشوهات العصبية الولادية لدى رُضّع النساء الحوامل المصابات بالسكري والعديد من الأمراض العصبية التنكسية مثل داء آلزهايمر Alzheimer's، داء باركنسون Parkinson's، وداء هنتنغتون Huntington's. وهذه أول مرة يحدّد فيها هذا الارتباط الذي قد يشير إلى طريقة جديدة لفهم وحتى علاج عيوب الأنبوب العصبي وهذه الأمراض أيضًا"
        return desc
        
    }()
    
    var articleTitle: UILabel = {
        
        var lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.textAlignment = .right
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont.boldSystemFont(ofSize: 21)
        lbl.text = "ظهور نجم نيوتروني وحيد بشكل خرافي في هاذه الصورة المقربة الجديدة "
        return lbl
        
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupComponents()
    }
    
    func setupComponents()
    {
        // Aspect Ratio of 5:6 is preferred
        let card = Card(frame: CGRect(x: 10, y: 30, width: self.bounds.width - 20 , height: 500))
        addSubview(card)
        
        card.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: card.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: card.bounds.width).isActive = true
        imageView.topAnchor.constraint(equalTo: card.topAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: card.bounds.width).isActive = true
        
        card.textColor = UIColor.black
        card.shadowOpacity = 0.6
        card.shadowBlur = 15
        card.hasParallax = true
        
        card.addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        articleTitle.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -10).isActive = true
        articleTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        articleTitle.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 10).isActive = true
        
        card.addSubview(articleDescription)
        articleDescription.translatesAutoresizingMaskIntoConstraints = false
        articleDescription.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -10).isActive = true
        articleDescription.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 5).isActive = true
        articleDescription.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 10).isActive = true
        articleDescription.numberOfLines = 4

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ArticlesCollectionViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (indexPath.row == 0)
        {
            let height = CGFloat(100)
            return CGSize(width: collectionView.bounds.size.width, height: height)
        }
        
            
        // should changed
        else
        {
            return CGSize(width: collectionView.bounds.size.width - 20 , height: 500)
            
        }
    
        
    }
    
}


extension UIView{
    
    func roundTop(radius:CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundBottom(radius:CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
}



