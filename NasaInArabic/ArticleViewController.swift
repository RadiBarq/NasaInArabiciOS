//
//  ArticleViewController.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/21/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit
import WebKit
import Hero
import WebKit
import SDWebImage
import AVFoundation
import MediaPlayer

class ArticleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WKNavigationDelegate, WKUIDelegate
{

    var cellId  = "articleCell"
    var sources: [ArticleSource]?
    var tags: [ArticleTag]?
    var contributors: [Translation]?
    var contributorsTitle: [String]?
    public var articleId: String?
    public var article: BrowsingArticle?
    var webViewTop : NSLayoutConstraint?
    var scrollViewBottom: NSLayoutConstraint?
    var webView:WKWebView!
    var playbackSlider:UISlider!
    var audioPlayerMainView = UIView()
    var repeatButton = UIButton()
    var bottomHeight: CGFloat = 50.0
    var numberOfRows = 0
    var numberOfSections = 0
    var audio:String?
    var observer: NSKeyValueObservation?
    
    
    var player:AVPlayer?
    var playerItem: AVPlayerItem!
    var playButton:UIButton?
    
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
                vc.modalPresentationStyle = .fullScreen
                profileViewController.userId = contributors![indexPath.row].user_id
                self.present(vc, animated: true, completion: nil)
            }
    
            else
            {
                 let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
                 vc.userId = contributors![indexPath.row].user_id
                 vc.modalPresentationStyle = .fullScreen
                 self.navigationController?.pushViewController(vc, animated: true)
            }
        }
            
        else if (indexPath.section == 0)
        {
            let sourceId = sources![indexPath.row].id
            var urlString   = "https://nasainarabic.net/r/s/" + sourceId
            var url = URL(string: urlString)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }


        else if (indexPath.section == 1)
        {
            let tagName = tags![indexPath.row].tag
            Global.articlesTagName = tagName
            Global.articlesTagSelected = true
            Global.tagTitle = tagName
            Global.categoryId = nil
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
//            guard let header = view as? UITableViewHeaderFooterView else { return }
//            header.textLabel?.textColor = UIColor.black
//            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//            header.textLabel?.frame = header.frame
//            header.backgroundColor = UIColor.white
//
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
        
        else if (section == 2 && contributors?.count != 0)
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
    
     var bottomView = UIView()
     var typeLableValue = UILabel()
     var viewsCountLabel = UILabel()
     var seperationBar = UIView()
  
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
       // label.text = "٣ دقيقة، ٧ ثانيه قراءة"
        return label
    }()
    
    var scrollView: UIScrollView = {
        
       var scrollView = UIScrollView()
       return scrollView
        
    }()
    
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
    
   
   public var descriptionLabel: UILabel = {
    
        var label = UILabel()
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = UIColor.black
        return label
    
    }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
          //  view.addSubview(visualEffec
            NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(willBeActive), name: UIApplication.willEnterForegroundNotification, object: nil)
    
//        let myURL = URL(string:"https://nasainarabic.net/main/articles/view/dino-chicken-gets-one-step-closer")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
            articleTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
            let webConfiguration = WKWebViewConfiguration()
            webView = WKWebView(frame: .zero, configuration: webConfiguration)
            webView.uiDelegate = self
            webView.navigationDelegate = self
        
            scrollView.bounces = false
      
            articleTableView.dataSource = self
            articleTableView.delegate = self
            articleTableView.bounces = false
        
            scrollView.contentInsetAdjustmentBehavior = .never
       
            view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:))))
            setupComponents()
        
            // if the article coming from contributor profile there will be no article, but article id.
            if (article != nil)
            {
                populateItems()
            }
        
           // webView.navigationDelegate = self
            getData()
        
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
//            print("Playback OK")
//            try AVAudioSession.sharedInstance().setActive(true)
//            print("Session is Active")
//        } catch {
//            print(error)
//        }
        
       // setupAVAudioSession()
    // // setupCommandCenter()
        
    }
    
    private func setupAVAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
            debugPrint("AVAudioSession is Active and Category Playback is set")
            UIApplication.shared.beginReceivingRemoteControlEvents()
            setupCommandCenter()
        } catch {
            debugPrint("Error: \(error)")
        }
    }
    
    @objc func willResignActive(_ notification: Notification) {
        // code to execute
        
//        if (self.player?.rate != 0)
//        {
//            self.player!.pause()
//            playButton!.setImage(UIImage(named: "start_button"), for: .normal)
//        }
    
    }
    

    
    @objc func willBeActive(_ notification: Notification) {
        // code to execute
//        self.player!.play()
//        playButton!.setImage(UIImage(named: "pause_button"), for: .normal)
    }
    
    
    private func setupCommandCenter() {
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: "ناسا بالعربي"]
        
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.player!.play()
            return .success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.player!.pause()
            return .success
        }
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    
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
    

//        self.webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
//                if complete != nil {
//                    self.webView.evaluateJavaScript("document.documentElement.offsetHeight", completionHandler: { (height, error) in
//                        print(height as! CGFloat)
//                        webView.heightAnchor.constraint(equalToConstant: height as! CGFloat).isActive = true
//                    })
//                }
//
//            })
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
    
    func getData()
    {
        
        var urlString = ""
        if (article != nil)
        {
            urlString = "https://api.nasainarabic.net/article/" + article!.id
            
        }
        
        else
        {
            urlString = "https://api.nasainarabic.net/article/" + articleId!
            
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
                    let onePageArticle = try decoder.decode(CurrentArticleData.self, from: data)
                    self.audio = onePageArticle.data?.audio
                    print(onePageArticle.data?.views)
                    self.viewsCountLabel.text = onePageArticle.data?.views
                    self.sources = onePageArticle.data?.sources
                    
                    if (self.sources?.count != 0)
                    {
                        self.numberOfSections = self.numberOfSections + 1
                        
                    }
                    
                    
                    self.tags = onePageArticle.data?.tags
                    
                    if (self.tags?.count != 0)
                    {
                        self.numberOfSections = self.numberOfSections + 1
                    }
                    
                    
                    
                    if (onePageArticle.data?.audio != nil)
                    {
                        self.addAudioPlayer()
                
                     }
            
                    self.contributors = []
                    self.contributorsTitle = []
                    var contributorsDic = onePageArticle.data?.contributors
                    
                    if (contributorsDic?.count != 0)
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
            

                    //if coming from user profile
                    if (self.article == nil)
                    {
                        
                        self.webView.loadHTMLString( "<html><body><p><font size=12>" + (onePageArticle.data?.description)! + "</font></p></body></html>", baseURL: nil)
                        let index = onePageArticle.data?.publish_date.index((onePageArticle.data?.publish_date.startIndex)!, offsetBy: 10)
                        let mySubstring = onePageArticle.data?.publish_date.prefix(upTo: index!)
                        self.dateLabel.text = " . " + mySubstring!
                        self.articleTitle.text = onePageArticle.data?.headline
                        self.typeLableValue.text = onePageArticle.data?.category
                        self.typeLableValue.text = onePageArticle.data?.category
                        
                        if let url = URL(string: (onePageArticle.data?.image)!)
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
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        let bounds = view.bounds
        visualEffectView.frame  = bounds
    }
    
    private func populateItems()
    {
        
       //descriptionLabel.text = article!.description.htmlToString
    
        let index = article!.publish_date.index(article!.publish_date.startIndex, offsetBy: 10)
        let mySubstring = article!.publish_date.prefix(upTo: index)
        dateLabel.text =   " . " + mySubstring
        articleTitle.text = article!.headline

        
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
        
//        var string = "<audio preload = 'none' controls> <source src =  'https://nasainarabic.net/uploads/audio_articles/d4e6f95f7f15bb87c0fd973a659d1983.mp3' type = 'audio/mp3'  Your browser does not support the audio element. </audio> "
//
//        webView.loadHTMLString("<html><body>" + "<div style='margin: 20px;'>" + string + "</div>" + "<p><font size=12>" + article!.description + "</font></p></body></html>", baseURL: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        //UIApplication.shared.isStatusBarHidden = false
        self.navigationController?.isNavigationBarHidden = false
        // articleTitle.text = ""
        // imageView.image = nil
        
        if (self.player != nil)
        {
            if (self.player?.rate != 0)
            {
                self.player!.pause()
                playButton!.setImage(UIImage(named: "start_button"), for: .normal)
            }
        }
        
    }
    
    
    func addAudioPlayer()
    {
        
        var test = 25.0
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                if (window.safeAreaInsets.bottom != 0)
                {
                    test = 30.0
                }
                

            //test =  test - Double(window.safeAreaInsets.bottom)
              
            }
        }
        
        
        self.view.addSubview(audioPlayerMainView)
        audioPlayerMainView.translatesAutoresizingMaskIntoConstraints = false
        audioPlayerMainView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        audioPlayerMainView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        audioPlayerMainView.heightAnchor.constraint(equalToConstant: CGFloat(test)).isActive = true
        audioPlayerMainView.backgroundColor = UIColor.white
        audioPlayerMainView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        audioPlayerMainView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor).isActive = true
    
        self.scrollViewBottom!.constant = CGFloat(test * -1 - 10)
        let url = URL(string: audio!)
        // Create asset to be played
        // Create a new AVPlayerItem with the asset and an
        // array of asset keys to be automatically loaded
         playerItem = AVPlayerItem(url: url!)
         player = AVPlayer(playerItem: playerItem)
         //player?.seek(to: .zero)
        
         NotificationCenter.default.addObserver(self, selector: #selector(onPlayerFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
//        let playerLayer=AVPlayerLayer(player: self.player!)
//        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
//        self.view.layer.addSublayer(playerLayer)
//
        

        self.playButton = UIButton()
        self.playButton?.translatesAutoresizingMaskIntoConstraints = false
            audioPlayerMainView.addSubview(self.playButton!)
        self.playButton?.leftAnchor.constraint(equalTo: audioPlayerMainView.leftAnchor, constant: 30).isActive = true
        self.playButton?.centerYAnchor.constraint(equalTo: audioPlayerMainView.centerYAnchor, constant: 0).isActive = true
            self.playButton?.setImage(UIImage(named: "start_button"), for: .normal)
        self.playButton?.addTarget(self, action: #selector(self.onClickPlay), for: .touchUpInside)
            self.playButton?.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.playButton?.heightAnchor.constraint(equalToConstant: 25).isActive = true
      //  playButton?.bottomAnchor.constraint(equalTo: audioPlayerMainView.bottomAnchor, constant: -10).isActive = true
        
        repeatButton.translatesAutoresizingMaskIntoConstraints = false
        repeatButton.setImage(UIImage(named: "repeat_icon"), for: .normal)
        self.audioPlayerMainView.addSubview(repeatButton)
        repeatButton.leftAnchor.constraint(equalTo: playButton!.rightAnchor, constant: 15).isActive = true
        repeatButton.centerYAnchor.constraint(equalTo: audioPlayerMainView.centerYAnchor, constant: 0).isActive = true
        //repeatButton.bottomAnchor.constraint(equalTo: audioPlayerMainView.bottomAnchor, constant: -10).isActive = true
        repeatButton.addTarget(self, action: #selector(onClickRepeat), for: .touchUpInside)
        repeatButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        repeatButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        var audioLabel = UILabel()
        audioLabel.text = "المقالة الصوتية"
        audioPlayerMainView.addSubview(audioLabel)
        audioLabel.textColor = UIColor.black
        audioLabel.font = UIFont.systemFont(ofSize: 20)
        audioLabel.translatesAutoresizingMaskIntoConstraints = false
        audioLabel.rightAnchor.constraint(equalTo: audioPlayerMainView.rightAnchor, constant:-30).isActive = true
        audioLabel.centerYAnchor.constraint(equalTo: audioPlayerMainView.centerYAnchor, constant: 0).isActive = true
        //audioLabel.bottomAnchor.constraint(equalTo: audioPlayerMainView.bottomAnchor, constant: -10).isActive = true
//
        // Create a new AVPlayerItem with the asset and an
        // array of asset keys to be automatically loaded
        // Register as an observer of the player item's status property
    
    }
    
    @objc func onClickRepeat()
    {
        let url = URL(string: audio!)
        // Create asset to be played
        // Create a new AVPlayerItem with the asset and an
        // array of asset keys to be automatically loaded
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        //player?.seek(to: .zero)
        player?.play()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onPlayerFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
       
    }

    
    @objc func onPlayerFinished()
    {
         playButton!.setImage(UIImage(named: "start_button"), for: .normal)
    }
    

    @objc
    func onClickPlay(_ sender:UIButton)
    {
        if player?.rate == 0
        {
            player!.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            playButton!.setImage(UIImage(named: "pause_button"), for: .normal)
        } else {
            
            player!.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            playButton!.setImage(UIImage(named: "start_button"), for: .normal)
        }
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
        scrollViewBottom = scrollView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor, constant:0)
        scrollViewBottom?.isActive = true
        scrollView.backgroundColor = UIColor.white
    
        self.scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 425).isActive = true
        
        self.scrollView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
       // dateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.scrollView.addSubview(readingTimeLabel)
        readingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        readingTimeLabel.rightAnchor.constraint(equalTo: self.dateLabel.leftAnchor, constant: -2).isActive = true
        readingTimeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        
        
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
        dismissButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
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
    
    func setupBottomView()
    {
        
        bottomView = UIView()
        self.view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 5).isActive = true
        bottomView.backgroundColor = UIColor.white
        bottomHeight = 50.0
        var centerConstant = -5
    
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                
             if (window.safeAreaInsets.bottom !=  0)
             {
                centerConstant = -10
                bottomHeight = window.safeAreaInsets.bottom + bottomHeight - 10
                
            }
            else
             {
                bottomHeight = 60.0
             }
            
            }
        }
        
        bottomView.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white
        bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: bottomHeight).isActive = true
        
        var typeLabel = UILabel()
        bottomView.addSubview(typeLabel)
        typeLabel.text = "التصنيف"
        typeLabel.textColor = UIColor.black
        typeLabel.font = UIFont.systemFont(ofSize: 18)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: CGFloat(centerConstant)).isActive = true
        typeLabel.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -30).isActive = true
    
        bottomView.addSubview(typeLableValue)
        typeLableValue.text = "طاقة وبيئة"
        typeLableValue.textColor = UIColor.gray
        typeLableValue.font = UIFont.systemFont(ofSize: 18)
        typeLableValue.translatesAutoresizingMaskIntoConstraints = false
        typeLableValue.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: CGFloat(centerConstant)).isActive = true
        typeLableValue.rightAnchor.constraint(equalTo: typeLabel.leftAnchor, constant: -5).isActive = true
        
        var shareImage = UIButton()
        bottomView.addSubview(shareImage)
        
        shareImage.translatesAutoresizingMaskIntoConstraints = false
        shareImage.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 30).isActive = true
        shareImage.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: CGFloat(centerConstant)).isActive = true
        shareImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        shareImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
        shareImage.setImage(UIImage(named: "share_icon"), for: .normal)
        shareImage.addTarget(self, action: #selector(onClickShare), for: .touchUpInside)
    
        bottomView.addSubview(viewsCountLabel)
       // viewsCountLabel.text = "100"
        viewsCountLabel.textColor = UIColor.gray
        viewsCountLabel.font = UIFont.systemFont(ofSize: 16)
        viewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsCountLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: CGFloat(centerConstant)).isActive = true
        viewsCountLabel.leftAnchor.constraint(equalTo: shareImage.rightAnchor, constant: 15).isActive = true
        
        //setup
        var viewsCountImageView = UIImageView()
        bottomView.addSubview(viewsCountImageView)
        viewsCountImageView.image = UIImage(named: "eye_icon")
        viewsCountImageView.translatesAutoresizingMaskIntoConstraints = false
        viewsCountImageView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: CGFloat(centerConstant)).isActive = true
        viewsCountImageView.leftAnchor.constraint(equalTo: viewsCountLabel.rightAnchor, constant: 7).isActive = true
        viewsCountImageView.widthAnchor.constraint(equalToConstant: 32.5).isActive = true
        viewsCountImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    @objc
    func onClickShare()
    {
        var articleUrl =  "https://nasainarabic.net/r/a/" + (article?.id)!
        articleUrl.share()
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
    
}

public struct CurrentArticleData:Decodable
{
    public var data: CurrentArticle?
}

public struct CurrentArticle: Decodable {
    
    var id: String
    var category: String
    var headline:String
    var slug: String
    var description: String
    var image: String
    var thumbnail: String
    var publish_date: String
    var views: String
    var sources: [ArticleSource]?
    var tags: [ArticleTag]
    var contributors: [String: [Translation]?]
    var audio:String?
}

public struct ArticleSource:Decodable
{
    var id:String
    var rel_id:String
    var title:String
}

public struct ArticleTag:Decodable
{
    var id:String
    var tag: String
    var article_id: String
    var url: String
}

public struct ArticleContributor:Decodable
{
    
    var ترجمة: [Translation]?
    var مُراجعة: [Translation]?
    var تحرير: [Translation]?
    var تصميم: [Translation]?
    var نشر: [Translation]?

}


public struct Translation:Decodable
{
    var full_name: String
    var user_id:String
    var image:String
    var rel_id:String
    var thumbnail:String
    
}




extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}


 public class IntrinsicTableView: UITableView {
    
    override public var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
    
}



