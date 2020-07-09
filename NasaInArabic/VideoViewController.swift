//
//  VideoViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 1/19/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import UIKit
import WebKit
import Hero
import SDWebImage
import YouTubePlayer
import YoutubeKit

class VideoViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, WKNavigationDelegate, WKUIDelegate  {
    
    
    var bottomView = UIView()
    var typeLableValue = UILabel()
    var viewsCountLabel = UILabel()
    var seperationBar = UIView()
    var videoWebView:WKWebView!
    
    var videoPlayer = YTSwiftyPlayer()
    var onePageArticle: CurrentVideoArticleData?
    var cellId  = "articleImageCell"
    var sources: [ArticleSource]?
    var tags: [VideoTag]?
    var contributors: [Translation]?
    var contributorsTitle: [String]?
    public var articleId: String?
    public var article: BrowsingVideo?
    var webViewTop : NSLayoutConstraint?
    var numberOfSections = 0
    var webView:WKWebView!
    var articleTableView:UITableView = IntrinsicTableView(frame: CGRect.zero)
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    public var articleTitle: UILabel = {
        
        var lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.textAlignment = .right
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont.boldSystemFont(ofSize: 21)
        //lbl.text = "تفريش الأسنان وحده غير قادر على حماية أسنان الأطفال من الوجبات الخفيفة السكرية"
        return lbl
        
    }()
    
    
    
    var dismissButton: UIView = {
        
        var view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 17.5
        return view
        
        
    }()
    
    
    public var descriptionLabel: UILabel = {
        
        var label = UILabel()
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = UIColor.black
        return label
        
    }()
    
    
    var imageView: UIImageView = {

        var imageView = UIImageView()
        //imageView.image = UIImage(named: "test_image")
      
        return imageView
    }()

    var dateLabel: UILabel = {
        
        var label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.darkGray
        //label.text = ". 2018-09-23"
        return label
        
    }()
    
    
    
    var readingTimeLabel: UILabel = {
        
        var label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.darkGray
        //label.text = "٣ دقيقة، ٧ ثانيه قراءة"
        return label
    }()
    
    
    
    var scrollView: UIScrollView = {
        
        var scrollView = UIScrollView()
        return scrollView
        
    }()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if (section == 0)
        {
            if let array = sources {
                
                return array.count
            }
            
            return 0
            
        }
            
        else if (section == 1)
        {
            
            if let array = tags {
                
                return array.count
            }
            
            return 0
            
        }
            
            
        else if (section == 2)
        {
            if let array = contributors
            {
                return contributors!.count
            }
            
            return 0
        }
            
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 2)
        {
            
            if (article != nil)
            {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "profileNavigationController") as! UINavigationController
                var profileViewController = vc.viewControllers[0] as! ProfileViewController
                profileViewController.userId = contributors![indexPath.row].user_id
                self.present(vc, animated: true, completion: nil)
            }
                
            else
            {
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
                vc.userId = contributors![indexPath.row].user_id
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
            
            
        else if (indexPath.section == 1)
        {
            let tagName = tags![indexPath.row].tag
            Global.videosTagName = tagName
            Global.videosTagSelected = true
            Global.tagTitle = tagName
            Global.categoryId = nil
            self.dismiss(animated: true, completion: nil)
        }
            
        else if (indexPath.section == 0)
        {
            let sourceId = sources![indexPath.row].id
            var urlString   = "https://nasainarabic.net/r/s/" + sourceId
            var url = URL(string: urlString)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier:cellId)
        

        var section = indexPath.section
        
        if (section == 0 && sources?.count != 0)
        {
            cell.textLabel?.text = sources![indexPath.row].title
        }
            
        else if (section == 1 && tags?.count != 0)
        {
            cell.textLabel?.text = "#" +  tags![indexPath.row].tag
        }
            
        else if (section == 2 && contributors!.count != 0)
        {
            cell.textLabel?.text = contributorsTitle![indexPath.row]
            cell.detailTextLabel!.text =  contributors![indexPath.row].full_name
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if (section == 0 && sources?.count != 0)
        {
            return "المصادر"
        }
            
        else if (section == 1 && tags?.count != 0)
        {
            return "وسوم المقال"
        }
            
        else if (section == 2 && contributors?.count != 0)
        {
            return "المساهمون"
        }
            
        else{
            
            return ""
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    @objc func handlePan(gr: UIPanGestureRecognizer) {
        
        let translation = gr.translation(in: view)
        switch gr.state {
        case .began:
            dismiss(animated: true, completion: nil)
        case .changed:
            Hero.shared.update(translation.y / view.bounds.height)
        default:
            let velocity = gr.velocity(in: view)
            if ((translation.y + velocity.y) / view.bounds.height) > 0.5 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        if (webView == self.webView)
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Change `2.0` to the desired number of seconds.
            // Code you want to be delayed
            webView.frame.size.height = 1
            //webView.frame.size = webView.sizeThatFits(.zero)
            webView.scrollView.isScrollEnabled=false
            var test = webView.scrollView.contentSize.height + 40
            self.webViewTop?.constant = test
            webView.updateConstraints()
            //print(test)
            
        }
    }
    
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
            articleTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            webView.navigationDelegate = self
            self.view.backgroundColor = UIColor.white
            self.scrollView.backgroundColor = UIColor.white
        
            videoWebView = WKWebView(frame:.zero, configuration: WKWebViewConfiguration())
            videoWebView.uiDelegate = self
            videoWebView.navigationDelegate = self
        
//            let myURL = URL(string:"https://nasainarabic.net/main/videos/view/minute-neuroscience-pain-and-the-anterolateral-system-2")
//            let myRequest = URLRequest(url: myURL!)
//            videoWebView.load(myRequest)
        
            scrollView.bounces = false
            articleTableView.dataSource = self
            articleTableView.delegate = self
            articleTableView.bounces = false
        
            scrollView.contentInsetAdjustmentBehavior = .never
            view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:))))
    
            if (article != nil)
            {
                //setupComponents()
                populateItems()
                getData()
            }
            
                
            else
            {
                getData()
            }
    
    }
  
    private func populateItems()
    {
        
        //descriptionLabel.text = article!.description.htmlToString
        let index = article!.publish_date.index(article!.publish_date.startIndex, offsetBy: 10)
        let mySubstring = article!.publish_date.prefix(upTo: index)
        dateLabel.text =   " . " + mySubstring
        articleTitle.text = article!.headline
        // typeLableValue.text = article!.category

        if let url = URL(string: article!.image)
        {
            
            imageView.sd_setShowActivityIndicatorView(true)
            imageView.sd_setIndicatorStyle(.gray)
            imageView.sd_addActivityIndicator()
            imageView.sd_setImage(with: url,  placeholderImage: nil, completed:

                {  (image, error, cache, ref) in

                    self.imageView.sd_removeActivityIndicator()
                    //  self.loadedImages[indexPath.item] = image
            })
        }
        
        webView.loadHTMLString( "<html><body><p><font size=12>" + article!.description + "</font></p></body></html>", baseURL: nil)
    }
    
    
    func getData()
    {
        
        var urlString = ""
        if (article != nil)
        {
            urlString = "https://api.nasainarabic.net/video/" + article!.id
        }
            
        else
        {
            urlString = "https://api.nasainarabic.net/video/" + articleId!
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
                    self.onePageArticle = try decoder.decode(CurrentVideoArticleData.self, from: data)
                    self.setupComponents()
                   // print(onePageArticle.data?.views)
                    self.viewsCountLabel.text = self.onePageArticle!.data?.views
                    self.sources = self.onePageArticle!.data?.sources
                    
                    
                    if (self.sources?.count != 0)
                    {
                        self.numberOfSections = self.numberOfSections + 1
                    }
                    
                    self.tags = self.onePageArticle!.data?.tags
                    
                    if (self.tags?.count != 0)
                    {
                        self.numberOfSections =  self.numberOfSections + 1
                    }
                    
                    //contributors = onePageArticle.data?.contributors
                    
                    //
                    //                    var ترجمة: [Translation]
                    //                    var مُراجعة: [Translation]
                    //                    var تحرير: [Translation]
                    //                    var تصميم: [Translation]
                    //                    var نشر: [Translation]
                    
                    //                    var translation = onePageArticle.data?.contributors.ترجمة
                    //                    var revision = onePageArticle.data?.contributors.مُراجعة
                    //                    var editing = onePageArticle.data?.contributors.تحرير
                    //                    var designing = onePageArticle.data?.contributors.تصميم
                    //                    var publishing = onePageArticle.data?.contributors.نشر
                    
                    self.contributors = []
                    self.contributorsTitle = []
                    var contributorsDic = self.onePageArticle!.data?.contributors
                    
                    if (contributorsDic!.count != 0)
                    {
                        self.numberOfSections = self.numberOfSections + 1
                        
                    }
                    
                    for (key, value) in contributorsDic!
                    {
                        for j in value!
                        {
                            
                            self.contributorsTitle?.append(key)
                            self.contributors?.append(j)
                
                        }
                    }
                
                    if (self.article == nil)
                    {
                        self.webView.loadHTMLString( "<html><body><p><font size=12>" + (self.onePageArticle!.data?.description)! + "</font></p></body></html>", baseURL: nil)
                        let index = self.onePageArticle!.data?.publish_date.index((self.onePageArticle!.data?.publish_date.startIndex)!, offsetBy: 10)
                        let mySubstring = self.onePageArticle!.data?.publish_date.prefix(upTo: index!)
                        self.dateLabel.text = " . " + mySubstring!
                        self.articleTitle.text = self.onePageArticle!.data?.headline
                        //self.typeLableValue.text = onePageArticle.data?.category
                        
        
                        
                        if let url = URL(string: (self.onePageArticle!.data?.image)!)
                        {
                            self.imageView.sd_setShowActivityIndicatorView(true)
                            self.imageView.sd_setIndicatorStyle(.gray)
                            self.imageView.sd_addActivityIndicator()
                            self.imageView.sd_setImage(with: url,  placeholderImage: nil, completed:

                                {  (image, error, cache, ref) in

                                    self.imageView.sd_removeActivityIndicator()
                                    //  self.loadedImages[indexPath.item] = image
                            })
                        }
                        
                    }
                    
                    self.articleTableView.reloadData()
                    // self.articles.append(onePageArticle)
                    //self.numberOfRows = self.numberOfRows + onePageArticle.data.count - 1
                    // self.collectionView.reloadData()
                }
                    
                    
                catch let jsonError {
                    
                    print("Failed to decode:", jsonError)
                }
            }
            }.resume()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
        // UIApplication.shared.isStatusBarHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    }
    
    
    func setupComponents()
    {
        
        setupBottomView()
        self.view.addSubview(scrollView)
        let safeViewMargins = self.view.safeAreaLayoutGuide
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive =  true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo:  self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 10).isActive = true
        scrollView.backgroundColor = UIColor.white
        
        
//        self.scrollView.addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
//        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
//        imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 425).isActive = true
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//        imageView.isUserInteractionEnabled = true
//        imageView.addGestureRecognizer(tapGestureRecognizer)
    
    
        self.scrollView.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white
        videoPlayer.backgroundColor = UIColor.white
      
        if (self.article != nil)
        {
                var videoId = article?.url.youtubeID
                videoPlayer = YTSwiftyPlayer(
                playerVars: [.videoID(videoId!)])
                videoPlayer.autoplay = true
                videoPlayer.loadPlayer()
        }
        
        else
        {
            var videoId = onePageArticle!.data?.url.youtubeID
            self.videoPlayer = YTSwiftyPlayer(
                playerVars: [.videoID(videoId!)])
            self.videoPlayer.autoplay = true
            self.videoPlayer.loadPlayer()
        }
        
         self.scrollView.addSubview(videoPlayer)
         videoPlayer.translatesAutoresizingMaskIntoConstraints = false
         videoPlayer.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
         videoPlayer.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
         videoPlayer.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
         videoPlayer.heightAnchor.constraint(equalToConstant: 425).isActive = true
    
        var translateButton = UIButton()
    
        

        translateButton.setTitle("الفيديو مترجم", for: .normal)
        //translateButton.titleLabel?.textColor = UIColor.blue
       // translateButton.tintColor = UIColor.blue
        translateButton.setTitleColor(UIColor.white, for: .normal)
        translateButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
     //   translateButton.setTitleColor(UIColor.white, for: .normal)
        self.videoPlayer.addSubview(translateButton)
        translateButton.translatesAutoresizingMaskIntoConstraints = false
        translateButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        translateButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        translateButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        translateButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        translateButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        translateButton.addTarget(self, action: #selector(onClickTranslateVideo), for: .touchUpInside)
        
        translateButton.layer.masksToBounds = true
        translateButton.layer.cornerRadius = 15
        
        
      //  let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
//    /    videoPlayer.isUserInteractionEnabled = true
//        videoPlayer.addGestureRecognizer(tapGestureRecognizer)
        //let myVideoURL = URL(string: )
        //videoPlayer.loadVideoURL(myVideoURL! as URL)
       
 
       // videoPlayer.load
       // videoPlayer.loadVideo(videoID: "xPVVcxSZPGI")
      
       // videoPlayer.playVideo()
//
//        self.scrollView.addSubview(videoWebView)
//        videoWebView.translatesAutoresizingMaskIntoConstraints = false
//        videoWebView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
//        videoWebView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
//        videoWebView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
//        videoWebView.heightAnchor.constraint(equalToConstant: 425).isActive = true
        
        
        self.scrollView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        dateLabel.topAnchor.constraint(equalTo: videoPlayer.bottomAnchor, constant: 20).isActive = true
        // dateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.scrollView.addSubview(readingTimeLabel)
        readingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        readingTimeLabel.rightAnchor.constraint(equalTo: self.dateLabel.leftAnchor, constant: -2).isActive = true
        readingTimeLabel.topAnchor.constraint(equalTo: videoPlayer.bottomAnchor, constant: 20).isActive = true
        
        
        self.scrollView.addSubview(articleTitle)
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        articleTitle.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        articleTitle.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 3).isActive = true
        //    articleTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        articleTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        
        
        //        self.scrollView.addSubview(descriptionLabel)
        //        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        //        descriptionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        //        descriptionLabel.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 20).isActive = true
        //        descriptionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        
        
        self.scrollView.addSubview(webView)
        self.scrollView.addSubview(seperationBar)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webViewTop =  webView.heightAnchor.constraint(equalToConstant: 300)
        webViewTop!.isActive = true
        webView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: -10).isActive = true
        webView.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 20).isActive = true
        webView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        //webView.bottomAnchor.constraint(equalTo: seperationBar.topAnchor).isActive = true
        webView.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 20).isActive = true
        
        //webView.scrollView.layer.masksToBounds = false
        //webView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        //descriptionLabel.heightAnchor.constraint(equalToConstant: self.view.bounds.height).isActive = true
        //webView.heightAnchor.constraint(equalToConstant: self.view.bounds.height).isActive = true
        
        
        self.view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        dismissButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = dismissButton.bounds
        blurEffectView.layer.cornerRadius = 17.5
        blurEffectView.layer.masksToBounds = true
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dismissButton.addSubview(blurEffectView)
        
        var closeImageView = UIImageView()
        closeImageView.image = UIImage(named: "close-image")
        closeImageView.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addSubview(closeImageView)
        closeImageView.centerXAnchor.constraint(equalTo: dismissButton.centerXAnchor).isActive = true
        closeImageView.centerYAnchor.constraint(equalTo: dismissButton.centerYAnchor).isActive = true
        closeImageView.widthAnchor.constraint(equalToConstant: 12.5).isActive = true
        closeImageView.heightAnchor.constraint(equalToConstant: 12.5).isActive = true
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        seperationBar.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(seperationBar)
        self.scrollView.addSubview(articleTableView)
        seperationBar.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 0).isActive = true
        seperationBar.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor, constant: 0).isActive = true
        seperationBar.heightAnchor.constraint(equalToConstant: 3).isActive = true
        seperationBar.backgroundColor = UIColor(red: 225/255, green:225/255 , blue: 225/255, alpha: 1)
        seperationBar.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 0).isActive = true
        //seperationBar.bottomAnchor.constraint(equalTo: self.articleTableView.topAnchor).isActive = true
        //        seperationBar.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -20).isActive = true
        seperationBar.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        seperationBar.layer.masksToBounds = true
        seperationBar.layer.cornerRadius = 2.5
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.onCloseClicked(sender:)))
        dismissButton.addGestureRecognizer(gesture)
        setupBottomView()
        initializeTableView()

        //descriptionLabel.bottomAnchor.constraint(equalTo: seperationBar.topAnchor, constant: -10).isActive = true
        //  descriptionLabel.bottomAnchor.constraint(equalTo: , constant: -5).isActive = true
    }
    
    
    @objc func onClickTranslateVideo()
    {
        if (self.article != nil)
        {
            var webViewController = WebViewController()
            webViewController.url = "https://nasainarabic.net/r/v/" + (article?.id)!
            var navigationController = UINavigationController()
            navigationController.addChild(webViewController)
            self.present(navigationController, animated: true, completion: nil)
        
        }
        
        else
        {
            var webViewController = WebViewController()
            webViewController.url = "https://nasainarabic.net/r/v/" + (onePageArticle?.data!.id)!
            var navigationController = UINavigationController()
            navigationController.addChild(webViewController)
            self.present(navigationController, animated: true, completion: nil)
        }
        
    }
    

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
    
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        var urlString   = "https://nasainarabic.net/r/v/" + (article?.id)!
        var url = URL(string: urlString)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    
    // Your action
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //UIApplication.shared.isStatusBarHidden = false
        self.navigationController?.isNavigationBarHidden = false
        // articleTitle.text = ""
        // imageView.image = nil
    }
    
    func initializeTableView()
    {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        
        articleTableView.translatesAutoresizingMaskIntoConstraints = false
        // self.scrollView.addSubview(articleTableView)
        self.articleTableView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        self.articleTableView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        self.articleTableView.topAnchor.constraint(equalTo: seperationBar.bottomAnchor , constant: 10).isActive = true
        self.articleTableView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -10).isActive = true
        // self.articleTableView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        self.articleTableView.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        
    }
    
    
    func setupBottomView()
    {
        
        bottomView = UIView()
        self.view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 5).isActive = true
        
        var height: CGFloat = 50.0
        
        
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                
                height = window.safeAreaInsets.bottom + height - 10
                
            }
        }
        
        bottomView.backgroundColor = UIColor.white
        bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        var typeLabel = UILabel()
        bottomView.addSubview(typeLabel)
        typeLabel.text = "التصنيف"
        typeLabel.textColor = UIColor.black
        typeLabel.font = UIFont.systemFont(ofSize: 18)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: -5).isActive = true
        typeLabel.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -30).isActive = true
        
        bottomView.addSubview(typeLableValue)
        typeLableValue.text = "طاقة وبيئة"
        typeLableValue.textColor = UIColor.gray
        typeLableValue.font = UIFont.systemFont(ofSize: 18)
        typeLableValue.translatesAutoresizingMaskIntoConstraints = false
        typeLableValue.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: -5).isActive = true
        typeLableValue.rightAnchor.constraint(equalTo: typeLabel.leftAnchor, constant: -5).isActive = true
        
        var shareImage = UIButton()
        bottomView.addSubview(shareImage)
        
        shareImage.translatesAutoresizingMaskIntoConstraints = false
        shareImage.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 30).isActive = true
        shareImage.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: -5).isActive = true
        shareImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        shareImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        shareImage.setImage(UIImage(named: "share_icon"), for: .normal)
        shareImage.addTarget(self, action: #selector(onClickShare), for: .touchUpInside)
        
        
        bottomView.addSubview(viewsCountLabel)
        // viewsCountLabel.text = "100"
        viewsCountLabel.textColor = UIColor.gray
        viewsCountLabel.font = UIFont.systemFont(ofSize: 16)
        viewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsCountLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: -5).isActive = true
        viewsCountLabel.leftAnchor.constraint(equalTo: shareImage.rightAnchor, constant: 15).isActive = true
        
        //setup
        var viewsCountImageView = UIImageView()
        bottomView.addSubview(viewsCountImageView)
        viewsCountImageView.image = UIImage(named: "eye_icon")
        viewsCountImageView.translatesAutoresizingMaskIntoConstraints = false
        viewsCountImageView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: -5).isActive = true
        viewsCountImageView.leftAnchor.constraint(equalTo: viewsCountLabel.rightAnchor, constant: 7).isActive = true
        viewsCountImageView.widthAnchor.constraint(equalToConstant: 32.5).isActive = true
        viewsCountImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    @objc func onCloseClicked(sender : UITapGestureRecognizer) {
        

        if (article == nil)
        {
            self.navigationController?.popViewController(animated: true)
        }
            
        else
        {
            dismiss(animated: true, completion: nil)
        }

        // Do what you want
    }

    @objc
    func onClickShare()
    {
        var articleUrl =  "https://nasainarabic.net/r/v/" + (article?.id)!
        articleUrl.share()
        
    }
    
}


extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
}




public struct CurrentVideoArticleData: Decodable
{
    public var data: CurrentVideoArticle?
    
}


public struct CurrentVideoArticle:Decodable{
    
    var id:String
    var headline:String
    var description: String
    var excerpt: String
    var url:String
    var image:String
    var thumbnail:String
    var caption:String?
    var publish_date:String
    var views:String
    var tags:[VideoTag]
    var sources:[ArticleSource]
    var contributors: [String: [Translation]?]
    
}

public struct VideoTag: Decodable{
    
    var id:String
    var tag:String
    var video_id:String
    var url:String
    
}


