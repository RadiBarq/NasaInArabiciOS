//
//  VideosCollectionViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/11/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit
import SDWebImage


private let reuseIdentifier = "Cell"

class VideosCollectionViewController: UICollectionViewController {
    
    

    private let titleCellReuseIdentifier = "titleCell"
    private let normalCellReuseIdentifier = "normalCell"
    var articles = [Videos]()
    var articlesImageViews = [UIImageView?]()
    var numberOfRows = 0
    var currentPageNumber = 1
    var numberOfSections = 0

    
    var noItemAvailableLabel: UILabel = {
       
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "لا تتوفر فيديوهات لهاذا الموقع!"
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
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Register cell classes
        self.collectionView!.register(ArticlesTitleCell.self, forCellWithReuseIdentifier: titleCellReuseIdentifier)
        self.collectionView!.register(ArticlesNormalCell.self, forCellWithReuseIdentifier: normalCellReuseIdentifier)
        
        
        if let tabBarController = tabBarController {
            self.collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: tabBarController.tabBar.bounds.height - 35, right: 0.0);
        }

        
        getData(pageNumber: currentPageNumber)
        
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row == numberOfRows - 2)
        {
            print("end of the list")
            currentPageNumber = currentPageNumber + 1
            getData(pageNumber: currentPageNumber)
        }
        
    }
 
    func getPageNumber(rowNumber: Int) -> Int
    {
        
        return Int(floor(Double(rowNumber / 10)))
        
    }
    
    @objc
    func onClickChangeLocation()
    {
        self.tabBarController?.selectedIndex = 3
        
    }
    
    func rowPerPage(rowNumber: Int, pageNumber: Int) ->Int{
        
        return rowNumber - 10 * pageNumber
    }
    
    func getData(pageNumber: Int)
    {
        var urlString = ""
        
          if (Global.categoryId == nil && Global.videosTagName == nil)
          {
              urlString = "https://api.nasainarabic.net/videos/" + Global.selectedSiteSlug + "/" + String(pageNumber)
          }
    
          else if(Global.videosTagName != nil)
          {
            var urlStringUnicode =  "https://api.nasainarabic.net/tagged_videos/\(Global.videosTagName! )/\(String(pageNumber))"
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
                
                guard let data = data else {
                    if (self.numberOfRows == 0)
                    {
                        self.collectionView.reloadData()
                    }
                
                    return}
                
                do {
                    
                    let decoder = JSONDecoder()
                    let onePageArticle = try decoder.decode(Videos.self, from: data)
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
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if (Global.selectedSiteVideosChanged == true || Global.videosTagSelected == true)
        {
            Global.selectedSiteVideosChanged = false
            currentPageNumber = 1
            numberOfRows = 0
            articles = []
            articlesImageViews = []
            self.noItemAvailableLabel.removeFromSuperview()
            self.changeSiteButton.removeFromSuperview()
            self.collectionView.reloadData()
            getData(pageNumber: currentPageNumber)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
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
            
            let videoArticleViewController = VideoViewController()
            videoArticleViewController.article = article
            videoArticleViewController.hero.isEnabled = true
            videoArticleViewController.hero.modalAnimationType = .none
            videoArticleViewController.view.hero.id = article.id
            videoArticleViewController.videoWebView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
        //         articleViewController.articleTitle.hero.modifiers = [.source(heroID:  "title"), .spring(stiffness: 250, damping: 25)]
            videoArticleViewController.modalPresentationStyle = .fullScreen
            present(videoArticleViewController, animated: true, completion: nil)
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return numberOfRows
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30
    }
    
    
    @objc
    func resetButtonClicked()
    {
        Global.categoryChanged = false
        Global.selectedSiteChanged = false
        Global.articlesTagSelected = false
        Global.videosTagName = nil
        currentPageNumber = 1
        numberOfRows = 0
        articles = []
        articlesImageViews = []
        self.collectionView.reloadData()
        getData(pageNumber: currentPageNumber)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:
        IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row == 0)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  titleCellReuseIdentifier, for: indexPath) as! ArticlesTitleCell
            
              if (Global.videosTagName == nil)
              {
                  cell.titleLabel.text = "الفيديوهات"
                  cell.categoryButton.isHidden = true
                  cell.resetButton.isHidden = true
              }
            
            else
              {
                cell.titleLabel.text = Global.videosTagName
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

extension VideosCollectionViewController: UICollectionViewDelegateFlowLayout
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



public struct Videos: Decodable{
    
    public var data = [BrowsingVideo]()
}


public struct BrowsingVideo: Decodable {
    
    var id:String
    var headline:String
    var description:String
    var excerpt: String
    var url:String
    var image:String
    var thumbnail:String
    var publish_date:String
    
    
}



