//
//  ArticlesCollectionViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/4/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit



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
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:
        IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleCellReuseIdentifier, for: indexPath)
        return cell
        
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
        titleLbl.font = UIFont.boldSystemFont(ofSize: 30)
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
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
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
            return CGSize(width: collectionView.bounds.size.width / 2 , height: 10)
            
        }
    
        
    }
    
}



