//
//  ProfileViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 1/17/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    public var userId: String!
    private var currentUser: ContributorProfile!
    private var tableView = IntrinsicTableView()
    var tableViewData = [cellData]()
    private var cellId = "cellId"

    var profilePicture : UIImageView = {
        
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
      //  imageView.image = UIImage(named: "profile_picture")
        return imageView
        
    }()

    var scrollView: UIScrollView = {
        
        var scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    var nameLabel: UILabel = {
    
        var nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.textColor = UIColor.black
       // nameLabel.text = "رافت فياض"
        nameLabel.textAlignment = .center
        return nameLabel
        
    }()
    
    
    var twitterImage: UIButton = {
        
        var button = UIButton()
        button.setImage(UIImage(named: "twitter_icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onCLickTwitter), for: .touchUpInside)
        return button
    
    }()
    
    var facebookImage:UIButton = {
        
         var button = UIButton()
        button.setImage(UIImage(named: "facebook_icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onClickFacebook), for: .touchUpInside)
        return button
        
    }()
    
    
    var userDescription: UILabel = {
        
        var nameDesription = UILabel()
        nameDesription.translatesAutoresizingMaskIntoConstraints = false
        nameDesription.font = UIFont.systemFont(ofSize: 16)
        nameDesription.textColor = UIColor.gray
        nameDesription.textAlignment = .center
       // nameDesription.text = "مهندس مدني انشائي. اعشق الرياضيات ، الفلك. متطوع في فريق التحرير للمساهمة في تقديم العلوم بلغة عربية سليمة"
        return nameDesription
        
    }()
    
    
    var dateLabel: UILabel = {
        
        var label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
      //  label.text = "2017-07-01"
        return label
        
    }()
    
    var viewsLabel: UILabel = {
        
      var label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.text = "11,242"
        return label
    }()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        getUserData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        if tableViewData[section].opened == true{
            return tableViewData[section].sectionData.count + 1
            
        } else{
            
            return 1

        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return tableViewData.count
        
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
            var id = tableViewData[indexPath.section].sectionData[indexPath.row - 1].id
            var type = tableViewData[indexPath.section].sectionData[indexPath.row - 1].type
            
            if (type == "Video")
            {
                let videoViewController = VideoViewController()
                //articleViewController.articleId = id
                videoViewController.articleId = id
                self.navigationController?.pushViewController(videoViewController, animated: true)
                
            }
            
            else if (type == "Image")
            {
                let imageViewController = ImageArticleViewController()
                //articleViewController.articleId = id
                imageViewController.articleId = id
                self.navigationController?.pushViewController(imageViewController, animated: true)
            }
            
            else
            {
                
                let articleViewController = ArticleViewController()
                //articleViewController.articleId = id
                articleViewController.articleId = id
                self.navigationController?.pushViewController(articleViewController, animated: true)
                print(id)
                
            }
       
        
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
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row  - 1].headline
            cell.textLabel?.textColor = UIColor.gray
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            return cell
        }
    }
    
    @objc func onCLickTwitter()
    {
        var urlString = "https://twitter.com/" + currentUser.twitter
        var url = URL(string: urlString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func onClickFacebook()
    {
        var urlString   =  "https://www.facebook.com/" + currentUser.facebook
        var url = URL(string: urlString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
    private func populateData()
    {
        
        viewsLabel.text = currentUser.views
        userDescription.text = currentUser.bio
        nameLabel.text = currentUser.full_name
        
        let index = currentUser.reg_date.index(currentUser.reg_date.startIndex, offsetBy: 10)
        let mySubstring = currentUser.reg_date.prefix(upTo: index)
        dateLabel.text =   " . " + mySubstring
        
        if let url = URL(string: currentUser.image)
        {
            profilePicture.sd_setShowActivityIndicatorView(true)
            profilePicture.sd_setIndicatorStyle(.gray)
            profilePicture.sd_addActivityIndicator()
            profilePicture.sd_setImage(with: url,  placeholderImage: nil, completed:
                {  (image, error, cache, ref) in

                    self.profilePicture.sd_removeActivityIndicator()
                    //  self.loadedImages[indexPath.item] = image
            })
        }
        
        if (currentUser.twitter == "")
        {
            twitterImage.isHidden = true
            facebookImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            
        }
        
        if (currentUser.facebook == "")
        {
            facebookImage.isHidden = true
            twitterImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        }
        
        var contributionsDic = self.currentUser.contributions
        var contributionsKey = contributionsDic.keys
        
        for (key, value) in contributionsDic
        {
            var cell = cellData()
            cell.opened = false
           // var counter = 0
            cell.title = key
            
            for j in value
            {
                cell.sectionData.append(j!)
              //  counter = counter + 1
            }
            
            tableViewData.append(cell)
        }
        
        
        self.tableView.reloadData()
    }
    
    private func getUserData()
    {
        
        let urlString = "https://api.nasainarabic.net/user/" + userId
        
        guard let url = URL(string: urlString) else
        {
            return
        }
        
        URLSession.shared.dataTask(with: url){ (data, repnose, error) in
            DispatchQueue.main.async {
                
                guard let data = data else {return}
                do {
    
                    let decoder = JSONDecoder()
                    self.currentUser = try decoder.decode(ContributorProfileData.self, from: data).data
                    self.populateData()
                }
                    
                catch let jsonError {
                    
                    print("Failed to decode:", jsonError)
                }
            }
            }.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        setupComponents()
    }
    
    
    func setupComponents()
    {
        self.view.addSubview(scrollView)
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive =  true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo:  self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.scrollView.addSubview(profilePicture)
        profilePicture.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        profilePicture.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 20).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: 150).isActive = true
        profilePicture.layer.masksToBounds = true
        profilePicture.layer.cornerRadius = 15
        
        self.scrollView.addSubview(nameLabel)
        self.nameLabel.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 20).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 15).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -15).isActive = true
        
        self.scrollView.addSubview(userDescription)
        self.userDescription.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        userDescription.widthAnchor.constraint(equalToConstant: self.view.frame.width - 30).isActive = true
        userDescription.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        userDescription.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 15).isActive = true
        userDescription.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -15).isActive = true
      //  var height = heightForView(text: userDescription.text!, font: UIFont.systemFont(ofSize: 16), width: self.view.frame.width - 30)
        userDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
        userDescription.numberOfLines = 3
       // userDescription.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        self.scrollView.addSubview(facebookImage)
        facebookImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        facebookImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        facebookImage.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 30).isActive = true
        facebookImage.topAnchor.constraint(equalTo: self.userDescription.bottomAnchor, constant: 15).isActive = true
    
        
        self.scrollView.addSubview(twitterImage)
        twitterImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        twitterImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        twitterImage.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: -30).isActive = true
        twitterImage.topAnchor.constraint(equalTo: self.userDescription.bottomAnchor, constant: 15).isActive = true
        
        var calenderIcon = UIImageView(image: UIImage(named: "calender_icon"))
        calenderIcon.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(calenderIcon)
        calenderIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        calenderIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        calenderIcon.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: -90).isActive = true
        calenderIcon.topAnchor.constraint(equalTo: facebookImage.bottomAnchor, constant: 25).isActive = true
        
        var viewsIcon = UIImageView(image: UIImage(named: "eye_icon_gray"))
        viewsIcon.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewsIcon)
        viewsIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        viewsIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        viewsIcon.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 90).isActive = true
        viewsIcon.topAnchor.constraint(equalTo: facebookImage.bottomAnchor, constant: 25).isActive = true
    
        self.scrollView.addSubview(viewsLabel)
        viewsLabel.centerYAnchor.constraint(equalTo: viewsIcon.centerYAnchor).isActive = true
        viewsLabel.rightAnchor.constraint(equalTo: viewsIcon.leftAnchor, constant: -5).isActive = true
        
        self.scrollView.addSubview(dateLabel)
        dateLabel.centerYAnchor.constraint(equalTo: calenderIcon.centerYAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: calenderIcon.rightAnchor, constant: 5).isActive = true

        if ( self.navigationController?.viewControllers.count == 1)
        {
                    let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onClickClose))
                    self.navigationItem.leftBarButtonItem = closeButton
            
        }
        
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(onClickShare))
        self.navigationItem.rightBarButtonItem = shareButton
        
        self.scrollView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        tableView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        tableView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        //tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
    }
    
    
    @objc func onClickClose()
    {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func onClickShare()
    {
        currentUser.profile_url.share()
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
}


extension UILabel {
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}



public struct ContributorProfileData:Decodable
{
    public var data: ContributorProfile
}


public struct ContributorProfile:Decodable
{
    
    var full_name:String
    var bio:String
    var image: String
    var facebook: String
    var twitter:String
    var views:String
    var reg_date:String
    var profile_url:String
    var contributions: [String: [ContributionContent?]]
}


struct cellData{
    
    var opened = Bool()
    var title = String()
    var sectionData = [ContributionContent]()
    
}

 public struct Contributions:Decodable
{
   
}

public struct ContributionContent:Codable
{
    var type:String?
    var headline:String?
    var slug:String?
    var id:String?
    var site:String?
    var role:String?
    var date:String?
    var order:String?
}

extension UIApplication {
    
    class var topViewController: UIViewController? {
        return getTopViewController()
    }
    
    private class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

extension Equatable {
    func share() {
        let activity = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        UIApplication.topViewController?.present(activity, animated: true, completion: nil)
    }
}
