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
    var articles = [Articles]()
    var articlesImageViews = [UIImageView?]()
    var numberOfRows = 0
    var currentPageNumber = 1
    
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
        
        getData(pageNumber: currentPageNumber)
        
    }
    
    func getPageNumber(rowNumber: Int) -> Int
    {
        
        return Int(floor(Double(rowNumber / 9)))
        
    }
    
    func rowPerPage(rowNumber: Int, pageNumber: Int) ->Int{
        
        return rowNumber - 9 * pageNumber
        
    }
    
    func getData(pageNumber: Int)
    {
        let urlString = "https://api.nasainarabic.net/images/main/" + String(pageNumber)
        guard let url = URL(string: urlString) else
        {
            return
        }
        
        URLSession.shared.dataTask(with: url){ (data, repnose, error) in
            DispatchQueue.main.async {
                
                guard let data = data else {return}
                
                do {
                    
                    let decoder = JSONDecoder()
                    let onePageArticle = try decoder.decode(Articles.self, from: data)
                    self.articles.append(onePageArticle)
                    self.numberOfRows = self.numberOfRows + onePageArticle.data.count - 1
                    self.collectionView.reloadData()
                    
                }
                    
                catch let jsonError {
                    
                    print("Failed to decode:", jsonError)
                }
            }
            }.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row == numberOfRows - 1)
        {
            print("end of the list")
            currentPageNumber = currentPageNumber + 1
            getData(pageNumber: currentPageNumber)
        }
        
    }
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
           return numberOfRows
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
            let pageNumber = getPageNumber(rowNumber: indexPath.row - 1)
            let rowPerPage = self.rowPerPage(rowNumber: indexPath.row - 1, pageNumber: pageNumber)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  normalCellReuseIdentifier, for: indexPath) as! ArticlesNormalCell
            cell.articleTitle.text = articles[pageNumber].data[rowPerPage].headline
            cell.articleDescription.text = articles[pageNumber].data[rowPerPage].excerpt + "..."
            
            
            if let url = URL(string: self.articles[pageNumber].data[rowPerPage].image)
            {
                cell.imageView.sd_setShowActivityIndicatorView(true)
                cell.imageView.sd_setIndicatorStyle(.gray)
                cell.imageView.sd_addActivityIndicator()
                cell.imageView.sd_setImage(with: url,  placeholderImage: nil, completed:
                    
                    {  (image, error, cache, ref) in
                        
                        cell.imageView.sd_removeActivityIndicator()
                        //  self.loadedImages[indexPath.item] = image
                })
                
            }
            
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
