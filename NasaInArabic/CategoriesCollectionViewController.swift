//
//  CategoriesCollectionViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/8/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoriesCollectionViewController: UICollectionViewController {

    
//var categoriesString = ["انفوغراف", "الارض", "الذاكرة", "الفضاء الخارجي", "تكنولوجيا", "رواد العمل العرب", "رواد العمل التطوعي", "طاقة وبيئة", "طب", "فيزياء", "منح دراسية", "مواضيع علمية متنوعة", "ناسا بالعربي على الارض"]
    
//var categoryImages = ["category-info-graph", "category-earth", "category-memory", "category-outer-space", "category-tech", "category-arab-payoneers", "category-volunteers", "category-nature", "category-medicine", "category-physics", "category-scholarship", "category-science-topic", "category-nasa-on-earth"]
    
    
var categoriesString = ["المركبة الفضائية نيو هورايزنز" ,"تلسكوب جيمس ويب الفضائي" ,"تلسكوب هابل الفضائي" ,"ناسا بالعربي"]
var sites = [Site]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
     //   self.navigationController?.title = "المواقع"
     
        self.collectionView!.delegate = self
        self.collectionView!.dataSource = self
        // Register cell classes
        self.collectionView!.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.collectionView!.showsVerticalScrollIndicator = false
        self.navigationController?.navigationBar.backIndicatorImage = UIImage()
        getData()
        
        // Do any additional setup after loading the view.
    }

    
    func unselectRowsInSection(rowsCount: Int, section: Int)
    {
        for row in 0 ..< rowsCount + 1
        {
            var indexPath  = NSIndexPath(row: row, section: section)
            var selectedCell = self.collectionView!.cellForItem(at: indexPath as IndexPath ) as? CategoriesCollectionViewCell
            
            if (selectedCell != nil)
            {
                selectedCell?.visualEffectView.isHidden = true
                //cell?.removeImageView()
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            unselectRowsInSection(rowsCount: categoriesString.count, section: indexPath.section)
            var selectedCell = self.collectionView!.cellForItem(at: indexPath) as? CategoriesCollectionViewCell
            selectedCell?.visualEffectView.isHidden = false
            var selectedSiteSlug = sites[indexPath.row].slug
            var selectedSiteId = sites[indexPath.row].id
            Global.selectedSiteSlug = selectedSiteSlug
            Global.selectedSiteId = selectedSiteId
            Global.selectedSiteChanged = true
            Global.selectedSiteImagesChanged = true
            Global.selectedSiteVideosChanged = true
            Global.categoryId = nil
            Global.articlesTagName = nil
            Global.videosTagName = nil
            Global.imagesTagName = nil
            self.tabBarController?.selectedIndex = 0
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "المواقع"
        
        
    }
    
    func getData()
    {
        let urlString = "https://api.nasainarabic.net/sites"
        
        guard let url = URL(string: urlString) else
        {
            return
        }
        
        URLSession.shared.dataTask(with: url){ (data, repnose, error) in
            DispatchQueue.main.async {
                
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                    self.sites = try decoder.decode(SiteData.self, from: data).data
                    self.sites.append(Site(id: "14", name: "المرصد الاوروبي الجنوبي", slug: "eso"))
                    //self.populateData()
                    self.collectionView!.reloadData()
                }
                    
                catch let jsonError {
                    
                    print("Failed to decode:", jsonError)
                }
            }
            }.resume()

    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sites.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoriesCollectionViewCell
        
        var site = sites[indexPath.row]
        cell.categoryLabel.text = site.name
        
        if (site.id == Global.selectedSiteId)
        {
            cell.visualEffectView.isHidden  = false
        }
        
        else{
            
            cell.visualEffectView.isHidden = true
        }
        
        var image = UIImage(named: site.slug)
        
        if let image = image{
            
             cell.imageView.image = UIImage(named: site.slug)
             return cell

        }
            
        else
        {
             cell.imageView.image = UIImage(named: "main_logo")
             cell.imageView.contentMode = .scaleToFill
        }
        
       
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

class CategoriesCollectionViewCell: UICollectionViewCell{
    
    var imageView:UIImageView = {
       
        var imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "test_image")
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 5
        return imgView
        
    }()
    
    var categoryLabel: UILabel = {
        
       var lbl = UILabel()
       lbl.textAlignment = .right
       lbl.textColor = UIColor.black
       lbl.font = UIFont.systemFont(ofSize: 15)
       return lbl
        
    }()
    
     var visualEffectView: UIVisualEffectView = {
        
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.alpha = 0.9
        visualEffectView.layer.masksToBounds = true
        visualEffectView.layer.cornerRadius = 5
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
        
    }()

    
    var tickImageView:UIImageView = {
        
        var imgView = UIImageView()
        imgView.image = UIImage(named: "tick_icon")
       // imgView.layer.cornerRadius = 5
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    
    

//    var tickImageView: UIImageView = {
//
//
//
//
//    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupComponents()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func selectImage(){
        
        
     ///   visualEffectView.translatesAutoresizingMaskIntoConstraints
        
    }
    
    func setupComponents()
    {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: self.bounds.height - 20).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        self.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 2).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
        categoryLabel.adjustsFontSizeToFitWidth = true
        categoryLabel.text = "الفضاء و الكواكب"
        
        self.addSubview(visualEffectView)
        visualEffectView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        visualEffectView.heightAnchor.constraint(equalToConstant: self.bounds.height - 20).isActive = true
        visualEffectView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        visualEffectView.isHidden = true
        
        visualEffectView.contentView.addSubview(tickImageView)
        tickImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        tickImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        tickImageView.centerXAnchor.constraint(equalTo: visualEffectView.centerXAnchor).isActive = true
        tickImageView.centerYAnchor.constraint(equalTo: visualEffectView.centerYAnchor).isActive = true
        selectImage()
        
    }
}


struct SiteData:Decodable
{
    var data:[Site]
}

struct Site:Decodable
{
    var id:String
    var name:String
    var slug:String
}


extension CategoriesCollectionViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            // should changed
            return CGSize(width: collectionView.bounds.size.width / 2 - 30 , height: collectionView.bounds.size.width / 2 - 10)
    
    }
    
}



