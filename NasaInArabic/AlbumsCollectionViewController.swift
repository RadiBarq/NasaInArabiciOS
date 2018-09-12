//
//  AlbumsCollectionViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/11/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit


class AlbumsCollectionViewController: UICollectionViewController {
    
    private let titleCellReuseIdentifier = "titleCell"
    private let normalCellReuseIdentifier = "normalCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = fals
        
        // Register cell classes

        self.collectionView!.register(ArticlesTitleCell.self, forCellWithReuseIdentifier: titleCellReuseIdentifier)
        self.collectionView!.register(ArticlesNormalCell.self, forCellWithReuseIdentifier: normalCellReuseIdentifier)
        
        
        if let tabBarController = tabBarController {
            
            self.collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom:
                tabBarController.tabBar.bounds.height - 35, right: 0.0);
            
        }

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

 
}


extension AlbumsCollectionViewController: UICollectionViewDelegateFlowLayout
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
