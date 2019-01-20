//
//  ArticleTableViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/21/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit
import Cards

class ArticleTableViewController: UITableViewController {

    
    private let titleCellReuseIdentifier = "titleCell"
    private let normalCellReuseIdentifier = "normalCell"
    var articles = [Articles]()
    var articlesImageViews = [UIImageView?]()
    var numberOfRows = 0
    var currentPageNumber = 1
    
    
    
    struct Articles: Decodable{
        
        public var data = [BrowsingArticle]()
        
    }
    
    struct BrowsingArticle: Decodable
    {
        var headline:String
        var excerpt:String
        var image: String
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(ArticlesNormalTableCell.self, forCellReuseIdentifier:normalCellReuseIdentifier)
        self.tableView.register(ArticlesTitleTableCell.self, forCellReuseIdentifier: titleCellReuseIdentifier)
        
        if let tabBarController = tabBarController {
            self.tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: tabBarController.tabBar.bounds.height, right: 0.0);
        }
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        getData(pageNumber: currentPageNumber)
        
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if (indexPath.row == numberOfRows - 1)
        {
            print("end of the list")
            currentPageNumber = currentPageNumber + 1
            getData(pageNumber: currentPageNumber)
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:  titleCellReuseIdentifier, for: indexPath) as! ArticlesTitleTableCell
            return cell
        }
            
        else
        {
            let pageNumber = getPageNumber(rowNumber: indexPath.row - 1)
            let rowPerPage = self.rowPerPage(rowNumber: indexPath.row - 1, pageNumber: pageNumber)
            
            let cell = tableView.dequeueReusableCell(withIdentifier:  normalCellReuseIdentifier, for: indexPath) as! ArticlesNormalTableCell
            
            cell.articleTitle.text = articles[pageNumber].data[rowPerPage].headline
            cell.articleDescription.text = articles[pageNumber].data[rowPerPage].excerpt + "..."
            cell.setSuperViewController(superViewController: self)
            
            if let url = URL(string: self.articles[pageNumber].data[rowPerPage].image)
            {
                cell.articleImageView.sd_setShowActivityIndicatorView(true)
                cell.articleImageView.sd_setIndicatorStyle(.gray)
                cell.articleImageView.sd_addActivityIndicator()
                cell.articleImageView.sd_setImage(with: url,  placeholderImage: nil, completed:
                    
                    {  (image, error, cache, ref) in
                        
                        cell.articleImageView.sd_removeActivityIndicator()
                        //  self.loadedImages[indexPath.item] = image
                })
            }
            
            return cell
        }
    }
    
    func getData(pageNumber: Int)
    {
        let urlString = "https://api.nasainarabic.net/articles/main/" + String(pageNumber)
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
                    self.tableView.reloadData()
                    
                }
                    
                catch let jsonError {
                    
                    print("Failed to decode:", jsonError)
                }
            }
            }.resume()
    }
    
    func getPageNumber(rowNumber: Int) -> Int
    {
        return Int(floor(Double(rowNumber / 9)))
    }
    
    func rowPerPage(rowNumber: Int, pageNumber: Int) ->Int{
        
        return rowNumber - 9 * pageNumber
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberOfRows
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.row == 0)
        {
            return CGFloat(100)
        }
        
        else
        {
            return CGFloat(500)
        }
        
    }
}

private class ArticlesNormalTableCell: UITableViewCell{
    
    var articleImageView: UIImageView = {
        
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
    
    var card = Card()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setSuperViewController(superViewController: UIViewController)
    {
        self.superViewController =  superViewController
        let mainStroyBoard = UIStoryboard(name: "Main", bundle: nil)
        let articleViewController = mainStroyBoard.instantiateViewController(withIdentifier: "articleViewController") as! ArticleViewController
        card.shouldPresent(articleViewController, from: superViewController, fullscreen: true)
    }
    
    func setupComponents()
    {
        addSubview(card)
        card.frame = CGRect(x: 10, y: 30, width: self.bounds.width - 20 , height: 500)
        card.addSubview(articleImageView)
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.centerXAnchor.constraint(equalTo: card.centerXAnchor).isActive = true
        articleImageView.heightAnchor.constraint(equalToConstant: card.bounds.width).isActive = true
        articleImageView.topAnchor.constraint(equalTo: card.topAnchor, constant: 0).isActive = true
        articleImageView.widthAnchor.constraint(equalToConstant: card.bounds.width).isActive = true
        
        card.textColor = UIColor.black
        card.shadowOpacity = 0.6
        card.shadowBlur = 15
        card.hasParallax = true
        
        card.addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        articleTitle.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -10).isActive = true
        articleTitle.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 10).isActive = true
        articleTitle.leftAnchor.constraint(equalTo: articleImageView.leftAnchor, constant: 10).isActive = true
        
        card.addSubview(articleDescription)
        articleDescription.translatesAutoresizingMaskIntoConstraints = false
        articleDescription.rightAnchor.constraint(equalTo: card.rightAnchor, constant: -10).isActive = true
        articleDescription.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 5).isActive = true
        articleDescription.leftAnchor.constraint(equalTo: card.leftAnchor, constant: 10).isActive = true
        articleDescription.numberOfLines = 4
    }
    
}

private class ArticlesTitleTableCell: UITableViewCell
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        
    }
}


