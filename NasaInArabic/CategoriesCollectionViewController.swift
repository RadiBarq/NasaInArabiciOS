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

    
var categoriesString = ["انفوغراف", "الارض", "الذاكرة", "الفضاء الخارجي", "تكنولوجيا", "رواد العمل العرب", "رواد العمل التطوعي", "طاقة وبيئة", "طب", "فيزياء", "منح دراسية", "مواضيع علمية متنوعة", "ناسا بالعربي على الارض"]
    
    
var categoryImages = ["category-info-graph", "category-earth", "category-memory", "category-outer-space", "category-tech", "category-arab-payoneers", "category-volunteers", "category-nature", "category-medicine", "category-physics", "category-scholarship", "category-science-topic", "category-nasa-on-earth"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
     

        // Do any additional setup after loading the view.
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
        return categoriesString.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoriesCollectionViewCell
        
        cell.categoryLabel.text = categoriesString[indexPath.row]
        cell.imageView.image = UIImage(named: categoryImages[indexPath.row])
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

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupComponents()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
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
        categoryLabel.text = "الفضاء و الكواكب"
        
    }

}


extension CategoriesCollectionViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            // should changed
            return CGSize(width: collectionView.bounds.size.width / 2 - 30 , height: collectionView.bounds.size.width / 2 - 10)
    
    }
    
}
