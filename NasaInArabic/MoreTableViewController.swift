//
//  MainTableViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/6/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit


class MoreTableViewController: UITableViewController {

    let normalCellReuseIdentifier = "normalCell"
    let titleCellReuseIdentifier = "titleCell"
    
    var titleText = ["من نحن", "المرصد الاوروبي الجتوبي", "تعليم", "تفاعلي", "الاخبار", "في مثل هاذا اليوم"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
            tableView.register(MoreTableViewCell.self, forCellReuseIdentifier: normalCellReuseIdentifier)
            tableView.register(MoreTableViewTitleCell.self, forCellReuseIdentifier: titleCellReuseIdentifier)
        
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.backIndicatorImage = UIImage()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0)
        {
            
            let mainStroyBoard = UIStoryboard(name: "Main", bundle: nil)
            let aboutUsViewController = mainStroyBoard.instantiateViewController(withIdentifier: "aboutUsViewController") as! AboutUsViewController
            self.navigationController?.pushViewController(aboutUsViewController, animated: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleText.count
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 50
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if (indexPath.row == 0)
//        {
//            let cell = tableView.dequeueReusableCell(withIdentifier: titleCellReuseIdentifier, for: indexPath) as! MoreTableViewTitleCell
//            cell.title.text = "المزيد"
//            // Configure the cell...
//            return cell
//
//        }
        
            let cell = tableView.dequeueReusableCell(withIdentifier: normalCellReuseIdentifier, for: indexPath) as! MoreTableViewCell
            cell.title.text = titleText[indexPath.row]
            // Configure the cell...
            return cell

    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

class MoreTableViewCell: UITableViewCell{
    
    var title: UILabel = {
        
        var title = UILabel()
        title.textAlignment = .right
        title.textColor = UIColor.black
        title.font = UIFont.boldSystemFont(ofSize: 19)
        return title
        
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
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
}


class MoreTableViewTitleCell: UITableViewCell
{
    var title: UILabel = {
    
    var title = UILabel()
    title.textAlignment = .right
    title.textColor = UIColor.black
    title.font = UIFont.boldSystemFont(ofSize: 30)
    return title
    
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
        
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}

