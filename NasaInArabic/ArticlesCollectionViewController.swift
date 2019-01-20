//
//  ArticlesCollectionViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/4/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit
import Cards
import SDWebImage
import Hero

public struct Articles: Decodable{

     public var data = [BrowsingArticle]()
}

public struct BrowsingArticle: Decodable
{
    var id: String
   // var category_id: String
   // var category: String
    var headline:String
    var slug: String
    var description: String
    var excerpt:String
    var image: String
    var thumbnail: String
    var publish_date: String
    
}


//public struct CategoryArticles:Decodable{
//
//    public var data = [BrowsingCategoryArticle]
//}
//
//
//
//public struct BrowsingCategoryArticle:Decodable{
//
//    var id: String
//    var category_id: String
//    var category: String
//    var headline:String
//    var slug: String
//    var description: String
//    var excerpt:String
//    var image: String
//    var thumbnail: String
//    var publish_date: String
//
//}

class ArticlesCollectionViewController: UICollectionViewController  {

    
    private let titleCellReuseIdentifier = "titleCell"
    private let normalCellReuseIdentifier = "normalCell"
    var articles = [Articles]()
    var articlesImageViews = [UIImageView?]()
    var numberOfRows = 0
    var currentPageNumber = 1
    var علي = "ali mohammad"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.collectionView!.register(ArticlesTitleCell.self, forCellWithReuseIdentifier: titleCellReuseIdentifier)
        self.collectionView!.register(ArticlesNormalCell.self, forCellWithReuseIdentifier: normalCellReuseIdentifier)
        
        if let tabBarController = tabBarController {
            self.collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: tabBarController.tabBar.bounds.height, right: 0.0);
        }
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
       
        getData(pageNumber: currentPageNumber)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
  
        if (Global.categoryChanged == true)
        {
            
            Global.categoryChanged == false
            currentPageNumber = 1
            numberOfRows = 0
            articles = []
            articlesImageViews = []
            
            getData(pageNumber: currentPageNumber)
            
            
            
        }
        
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
        var urlString = ""
        
            if (Global.categoryId == nil)
            {
                 urlString = "https://api.nasainarabic.net/articles/main/" + String(pageNumber)
            }
        
         else
            {
                urlString = "https://api.nasainarabic.net/category/" + Global.categoryId! + "/" + String(pageNumber)
            }
        
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if (indexPath.row != 0)
        {
    
        let cell = collectionView.cellForItem(at: indexPath) as! ArticlesNormalCell
        cell.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
        cell.card.hero.id = "title"

        
        //
        //
//        let vc = AppStoreViewController2()
  //      vc.hero.isEnabled = true
//        vc.hero.modalAnimationType = .none
//        vc.cardView.hero.id = "title"
//        vc.cardView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
//        vc.cardView.imageView.image = UIImage(named: "test_image")
//        vc.contentCard.hero.modifiers = [.source(heroID:  "title"), .spring(stiffness: 250, damping: 25)]
//        vc.contentView.hero.modifiers = [.useNoSnapshot, .forceAnimate, .spring(stiffness: 250, damping: 25)]
//        vc.visualEffectView.hero.modifiers = [.fade, .useNoSnapshot]
//        present(vc, animated: true, completion: nil)
        
    
//       let articleViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "articleViewController") as? ArticleViewController
        
          let pageNumber = getPageNumber(rowNumber: indexPath.row - 1)
          let rowPerPage = self.rowPerPage(rowNumber: indexPath.row - 1, pageNumber: pageNumber)
          var article = articles[pageNumber].data[rowPerPage]
        
          let articleViewController = ArticleViewController()
         articleViewController.article = article
     //  articleViewController.articleId = article.data.
         articleViewController.hero.isEnabled = true
         articleViewController.hero.modalAnimationType = .none
         articleViewController.view.hero.id = "title"
        
          articleViewController.imageView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
//         articleViewController.articleTitle.hero.modifiers = [.source(heroID:  "title"), .spring(stiffness: 250, damping: 25)]
          articleViewController.articleTitle.hero.modifiers =  [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
         // articleViewController.visualEffectView.hero.modifiers = [.fade, .useNoSnapshot]
          present(articleViewController, animated: true, completion: nil)
        }
        
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    @objc
    func categoryButtonClicked()
    {
        var categoryVc = CategoriesViewController()
        
        let navController = UINavigationController(rootViewController: categoryVc)
        self.present(navController, animated: true, completion: nil)

    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if (indexPath.row == numberOfRows - 1)
        {
            print("end of the list")
            currentPageNumber = currentPageNumber + 1
            getData(pageNumber: currentPageNumber)
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath:
        IndexPath) -> UICollectionViewCell {
        
        
        if (indexPath.row == 0)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  titleCellReuseIdentifier, for: indexPath) as! ArticlesTitleCell
            cell.categoryButton.addTarget(self, action: #selector(categoryButtonClicked), for: .touchUpInside)
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

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return numberOfRows
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30
    }
}

class ArticlesNormalCell: UICollectionViewCell{
    
    var imageView: UIImageView = {
        
        var imgView = UIImageView()
        imgView.roundTop(radius: 20)
        imgView.image = UIImage(named: "category-earth")
        return imgView
        
    }()
    
  var superViewController: UIViewController?
    
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
    
    public var card = Card()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupComponents()
        
    }
    
//    func setSuperViewController(superViewController: UIViewController)
//    {
//        self.superViewController =  superViewController
//        let mainStroyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let articleViewController = mainStroyBoard.instantiateViewController(withIdentifier: "articleViewController") as! ArticleViewController
//        card.shouldPresent(articleViewController, from: superViewController, fullscreen: true)
//
//    }
    
    func setupComponents()
    {
        // Aspect Ratio of 5:6 is preferred
        addSubview(card)
        card.frame = CGRect(x: 10, y: 30, width: self.bounds.width - 20 , height: 500)
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
        card.isUserInteractionEnabled = false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        return titleImg

    }()
    
    
     public var categoryButton: UIButton = {
        
        var cateogryImage = UIButton()
        cateogryImage.setImage(UIImage(named: "categories_logo"), for: .normal)
        cateogryImage.translatesAutoresizingMaskIntoConstraints = false
        return cateogryImage
        
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
        self.addSubview(titleImage)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 5).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleImage.heightAnchor.constraint(equalToConstant: 43.52).isActive = true
        titleImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        titleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20).isActive = true
        
        self.addSubview(categoryButton)
        categoryButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        categoryButton.centerYAnchor.constraint(equalTo: titleImage.centerYAnchor).isActive = true
        categoryButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        categoryButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
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


// basically a view controller with a back button and a tap gesture configured


// basically a view controller with a back button and a tap gesture configured

