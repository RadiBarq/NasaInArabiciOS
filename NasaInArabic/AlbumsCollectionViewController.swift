//
//  AlbumsCollectionViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/11/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit
import Hero

class AlbumsCollectionViewController: UICollectionViewController {
    
    private let titleCellReuseIdentifier = "titleCell"
    private let normalCellReuseIdentifier = "normalCell"
    var articles = [Images]()
    var articlesImageViews = [UIImageView?]()
    var numberOfRows = 0
    var currentPageNumber = 1


    var noItemAvailableLabel: UILabel = {
        
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "لا تتوفر صور لهاذا الموقع!"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label

    }()
    
    var changeSiteButton:UIButton = {
        
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("غير الموقع", for: .normal)
        button.setTitleColor(UIColor.init(red:63/255, green: 128/255, blue: 251/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(onClickChangeLocation), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        if (Global.selectedSiteImagesChanged == true || Global.imagesTagSelected == true)
        {
            Global.selectedSiteImagesChanged = false
            Global.imagesTagSelected = false
            currentPageNumber = 1
            numberOfRows = 0
            articles = []
            self.noItemAvailableLabel.removeFromSuperview()
            self.changeSiteButton.removeFromSuperview()
            articlesImageViews = []
            self.collectionView.reloadData()
            getData(pageNumber: currentPageNumber)
        }
    }
    
    @objc
    func onClickChangeLocation()
    {
        self.tabBarController?.selectedIndex = 3
    }
    

    func showNoItemLabel()
    {
        
        self.view.addSubview(noItemAvailableLabel)
        noItemAvailableLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        noItemAvailableLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.view.addSubview(changeSiteButton)
        // changeSiteButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        changeSiteButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        changeSiteButton.topAnchor.constraint(equalTo: noItemAvailableLabel.bottomAnchor, constant: 10).isActive = true
        

    }
    
    
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
        return Int(floor(Double(rowNumber / 10)))
    }
    
    func rowPerPage(rowNumber: Int, pageNumber: Int) ->Int{
        
        return rowNumber - 10 * pageNumber
        
    }
    
    func getData(pageNumber: Int)
    {
        var urlString = ""
          if (Global.categoryId == nil && Global.imagesTagName == nil)
            {
                
                urlString = "https://api.nasainarabic.net/images/" + Global.selectedSiteSlug + "/" + String(pageNumber)
               
            }
        
            
          else if(Global.imagesTagName != nil)
          {
            var urlStringUnicode =  "https://api.nasainarabic.net/tagged_images/\(Global.imagesTagName! )/\(String(pageNumber))"
            //+ "/" + Global.articlesTagName! + "/" + "q" + String(pageNumber)
            urlString = urlStringUnicode
         }
        

            var url = URL(string: urlString)
        
        
            if (url == nil)
            {
        
            if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed){
                url = URL(string: encoded)
                if (url == nil)
                {
                    return
                }
               
            }
            }
        
        
        URLSession.shared.dataTask(with: url!){ (data, repnose, error) in
            DispatchQueue.main.async {
                
                var test =  data?.isEmpty
                guard let data = data else {
                    
                    if (self.numberOfRows == 0)
                    {
                        self.collectionView.reloadData()
                    }
                    
                     return
                    
                }
                
                do {

                    let decoder = JSONDecoder()
                    let onePageArticle = try decoder.decode(Images.self, from: data)
                    self.articles.append(onePageArticle)
                    
                    if (self.numberOfRows == 0)
                    {
                        self.numberOfRows =  self.numberOfRows + onePageArticle.data.count + 1
                    }
                        
                    else
                    {
                        self.numberOfRows = self.numberOfRows + onePageArticle.data.count
                    }
                    
                    self.collectionView.reloadData()
                }
                    
                catch let jsonError {
                    
                    if (self.numberOfRows == 0)
                    {
                        self.numberOfRows = 1
                        self.collectionView.reloadData()
                        self.showNoItemLabel()
                        print("Failed to decode:", jsonError)
                    }
                }
            }
            }.resume()
    }
    
    
    
      override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
            if (indexPath.row != 0)
            {
        
                let cell = collectionView.cellForItem(at: indexPath) as! ArticlesNormalCell
                
        
                let pageNumber = getPageNumber(rowNumber: indexPath.row - 1)
                let rowPerPage = self.rowPerPage(rowNumber: indexPath.row - 1, pageNumber: pageNumber)
        
                
                var article = articles[pageNumber].data[rowPerPage]
                
                cell.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
                cell.card.hero.id = article.id
    
                let imageArticleViewController = ImageArticleViewController()
                imageArticleViewController.article = article
                imageArticleViewController.hero.isEnabled = true
                imageArticleViewController.hero.modalAnimationType = .none
                imageArticleViewController.view.hero.id = article.id
                imageArticleViewController.imageView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 200, damping: 25)]
        //         articleViewController.articleTitle.hero.modifiers = [.source(heroID:  "title"), .spring(stiffness: 250, damping: 25)]
                imageArticleViewController.modalPresentationStyle = .fullScreen
                present(imageArticleViewController, animated: true, completion: nil)
                
    
            }
    }
    
    @objc
    func resetButtonClicked()
    {
        Global.categoryChanged = false
        Global.selectedSiteChanged = false
        Global.articlesTagSelected = false
        Global.imagesTagName = nil
        currentPageNumber = 1
        numberOfRows = 0
        articles = []
        articlesImageViews = []
        self.collectionView.reloadData()
        getData(pageNumber: currentPageNumber)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row == numberOfRows - 2)
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
            if (Global.imagesTagName == nil)
            {
                    cell.titleLabel.text = "الصور"
                    cell.categoryButton.isHidden = true
                    cell.resetButton.isHidden = true
            }
            
            else
            {
                cell.titleLabel.text = Global.imagesTagName
                cell.resetButton.isHidden = false
                cell.categoryButton.isHidden = true
                cell.resetButton.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
            }
            
            return cell
        }
            
        else
        {
            
            let pageNumber = getPageNumber(rowNumber: indexPath.row - 1)
            let rowPerPage = self.rowPerPage(rowNumber: indexPath.row - 1, pageNumber: pageNumber)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  normalCellReuseIdentifier, for: indexPath) as! ArticlesNormalCell
            cell.articleTitle.text = articles[pageNumber].data[rowPerPage].headline
            cell.articleDescription.text = articles[pageNumber].data[rowPerPage].excerpt.htmlToString + "..."
            
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
public struct Images: Decodable{
    
    public var data = [BrowsingImage]()
    
}


public struct BrowsingImage: Decodable {
    
    var id:String
    var headline:String
    var description:String
    var excerpt: String
    var image:String
    var thumbnail:String
    var infograph:String?
    var publish_date:String
    
}



