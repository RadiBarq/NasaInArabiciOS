//
//  CategoriesViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 1/19/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var tableView = IntrinsicTableView()
    var cellId = "cellId"
    var tableViewData = [categoryCellData]()
    
    var categories: [Category]!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableViewData[section].opened == true{
            
            return tableViewData[section].sectionData.count + 1
            
        } else{
            
            return 1
            
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0
        {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else{return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            cell.textLabel?.textColor = UIColor.black
            cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
            return cell
        }
            
        else
        {
            // change that for different cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) else{return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row  - 1].title
            cell.textLabel?.textColor = UIColor.gray
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            return cell
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if (indexPath.row == 0)
        {
            
            if tableViewData[indexPath.section].opened == true{
                
                tableViewData[indexPath.section].opened = false
                
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                
            } else
            {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
            
    
        else
        {
            var categoryId = tableViewData[indexPath.section].sectionData[indexPath.row - 1].id
            Global.categoryId = categoryId
            Global.categoryChanged = true
            self.navigationController?.dismiss(animated: true, completion: nil)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black,
                                                                             NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)]
        self.navigationController?.title = "التصنيفات"
        self.navigationItem.title = "التصنيفات"
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onClickClose))
        self.navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc
    func onClickClose()
    {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return tableViewData.count
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        setupComponenets()
        
    
        self.tableView.reloadData()
        getData()
        
     
        
        // Do any additional setup after loading the view.
    }

    
    func getData()
    {
        
         let urlString = "https://api.nasainarabic.net/categories/" + Global.site
         guard let url = URL(string: urlString) else
         {
             return
         }
        
        
        URLSession.shared.dataTask(with: url){ (data, repnose, error) in
            DispatchQueue.main.async {
                
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                  
                    self.categories = try decoder.decode([Category].self, from: data)
                    self.populateData()
                    
                }
                    
                catch let jsonError {
                    
                    print("Failed to decode:", jsonError)
                }
            }
            }.resume()
    }
    
    
//    func populateChildren(title:String, counter:Int, childrens:[Category], currentObject: Category){
//
//
//            var currentChildrens = childrens +  categories[counter].children
//
//
//
//
//    }

    
    
    func getSubCategories(child: Category) -> [Category]
    {
        var subCategories = [Category]()

        if (child.children.count == 0)
        {
            return [child]
        }
        
        else
        {
            subCategories.append(child)
            
            for  i in child.children
            {
                subCategories = subCategories + getSubCategories(child: i)
            }
            
            return subCategories
        }
        
        
    }

    func populateData()
    {
        var subCategories = [Category]()
    
        for i in categories
        {
            var title = i.title
            
            if (i.children.count == 0)
            {
                   tableViewData.append(categoryCellData(opened: false, title: title, sectionData: [i]))
            }
    
                
            else
            {
                //populateChildren(title: title, counter: counter, childrens: [], currentObject: categories[counter].children[0])
                 subCategories.append(i)
                
                for j in i.children
                {
                   
                    subCategories = subCategories + getSubCategories(child: j)
                }
        
                tableViewData.append(categoryCellData(opened: false, title: title, sectionData: subCategories))
                subCategories = []
            }
    
        }
        
        self.tableView.reloadData()
    
    }
    
    
    func setupComponenets()
    {
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10).isActive = true
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
}


struct categoryCellData {
    
    var opened = Bool()
    var title = String()
    var sectionData = [Category]()
    
}


//public struct CategoryData:Decodable
//{
//    var data: [Category]
//
//}
//

public struct Category:Decodable
{
    
    var id: String
    var parent_id: String?
    var title:String
    var icon:String?
    var children: [Category]
    
    
}
