//
//  MainTableViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/6/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit
import MessageUI

class MoreTableViewController: UITableViewController {

    let normalCellReuseIdentifier = "normalCell"
    let titleCellReuseIdentifier = "titleCell"
    
    var titleText = [ "من نحن", "تطوع في ناسا بالعربي", "تعليم", "تفاعلي", "الاخبار", "في مثل هاذا اليوم",  "تلفزيون ناسا بالعربي" , "تواصل معنا", "بلغ عن خطأ في التطبيق"]
    
    override func viewDidLoad() {
        
            super.viewDidLoad()
            tableView.register(MoreTableViewCell.self, forCellReuseIdentifier: normalCellReuseIdentifier)
            tableView.register(MoreTableViewTitleCell.self, forCellReuseIdentifier: titleCellReuseIdentifier)
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            tableView.showsVerticalScrollIndicator = true
            tableView.bounces = true
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.backIndicatorImage = UIImage()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0)
        {
            let webViewController = WebViewController()
            webViewController.url = "https://nasainarabic.net/main/portal/page/about"
            let navigationController = UINavigationController()
            navigationController.addChild(webViewController)
           // webViewController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        }
        
        if (indexPath.row == 1)
        {
            let webViewController = WebViewController()
            webViewController.url = "https://nasainarabic.net/main/portal/page/be-a-volunteer"
            let navigationController = UINavigationController()
            navigationController.addChild(webViewController)
           // navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        }
        
        if (indexPath.row == 2)
        {
            let webViewController = WebViewController()
            webViewController.url = "https://nasainarabic.net/education"
            let navigationController = UINavigationController()
            navigationController.addChild(webViewController)
            //navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        
        }
        
        if (indexPath.row == 3)
        {
            let webViewController = WebViewController()
            webViewController.url = "https://nasainarabic.net/main/interactive"
            let navigationController = UINavigationController()
            navigationController.addChild(webViewController)
           // navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationController, animated: true, completion: nil)
            
        }
        
        if (indexPath.row == 4)
        {
            
            let webViewController = WebViewController()
            webViewController.url = "https://nasainarabic.net/main/albums/view/news"
            let navigationController = UINavigationController()
            navigationController.addChild(webViewController)
           // navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        }
        
        if (indexPath.row == 5)
        {
            let webViewController = WebViewController()
            webViewController.url = "https://nasainarabic.net/main/events/"
            let navigationController = UINavigationController()
            navigationController.addChild(webViewController)
           // navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        }
        
        if (indexPath.row == 6)
        {
            
            let webViewController = WebViewController()
            webViewController.url = "https://nasainarabic.net/main/portal/tv"
            let navigationController = UINavigationController()
            navigationController.addChild(webViewController)
           // navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationController, animated: true, completion: nil)
            
        }
        
        if (indexPath.row == 7)
        {
            
            let webViewController = WebViewController()
            webViewController.url = "https://nasainarabic.net/main/portal/form/contact"
            let navigationController = UINavigationController()
            navigationController.addChild(webViewController)
          //  navigationController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        }
        
        if (indexPath.row == 8)
        {
            showMailComposer()
        }
    }
    
     @objc func onClickClose()
    {
    
    
    
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
    
    
    func showMailComposer()
    {
        guard MFMailComposeViewController.canSendMail() else
        {
            // Show alert informing the user
            print("cannot send an email")
            let alertEmailController = UIAlertController(title: "لا يمكنك ارسال الرسائل", message: "الرجاء تفعيل خدمة البريد الالكتروني خاصتك!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "موافق", style: .default, handler: nil)
            alertEmailController.addAction(defaultAction)
            // self.dismiss(animated: true, completion: nil)
            self.present(alertEmailController, animated: true, completion: nil)
            return
        }
    
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setSubject("NasaInArabic  iOS Issue")
        composer.setToRecipients(["radibaraq@gmail.com"])
        self.present(composer, animated: true)
        
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




extension MoreTableViewController: MFMailComposeViewControllerDelegate{

    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            
            let alertEmailController = UIAlertController(title: "حدث خطأ ما!", message: "لم نتمكن من ارسال الرسالة الرجاء المحاولة لاحقا", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "موافق", style: .default, handler: nil)
            alertEmailController.addAction(defaultAction)
            // self.dismiss(animated: true, completion: nil)
            self.navigationController?.present(alertEmailController, animated: true, completion: nil)
            controller.dismiss(animated: true)
            return
        }
        
        switch result{
            
        case .cancelled:
            print("Cancelled")
            
        case .failed:
            print("Failed to send")
            
        case .saved:
            print("Saved")
            
        case .sent:
            print("Email Sent")
            
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    


}
