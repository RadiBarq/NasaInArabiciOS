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


class ArticleViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    
     let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
     public var articleTitle: UILabel = {
        
        var lbl = UILabel()
        lbl.textColor = UIColor.black
       
        lbl.textAlignment = .right
        lbl.numberOfLines = 2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = UIFont.boldSystemFont(ofSize: 21)
        lbl.text = "تفريش الأسنان وحده غير قادر على حماية أسنان الأطفال من الوجبات الخفيفة السكرية"
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
       imageView.image = UIImage(named: "test_image")
       return imageView
        

    }()
    
    
    var dateLabel: UILabel = {
        
        var label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.darkGray
        label.text = ". 2018-09-23"
        return label
        
    }()
    
    var readingTimeLabel: UILabel = {
        
        var label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.darkGray
        label.text = "٣ دقيقة، ٧ ثانيه قراءة"
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
        label.text = "‏النفسي والاجتماعي والصحة ‏العامة والنشاطات اللامنهجية الثقافية والاجتماعية والرياضية والفنية ‏والشؤون المالية كالأقساط والقروض والمنح والمساعدات ‏المالية والمنح والبعثات الدراسية ‏والتدريب والتطوع والقضايا الأكاديمية والسلوكية والاقتراحات والشكاوى. ‏ تسهل الجامعة عمل النوادي والجمعيات الطلابية وبعضها فروع لجمعيات عالمية والتي تنظم ‏نشاطات وفعاليات ذات طابع ‏علمي واكاديمي ولا منهجي. هذا بالاضافة إلى المراكز العلمية التي ‏تقدم الاستشارات والخدمات وريادة الاعمال وتطوير ‏المهارات والخبرات والشراكات.‏‎ ‎أما المكتبة ‏فتحتوي على أكثر من 435,488 كتابا، 70,000 منها إلكترونية وأكثر من 28,000 ‏مجلات  ‏النفسي والاجتماعي والصحة ‏العامة والنشاطات اللامنهجية الثقافية والاجتماعية والرياضية والفنية ‏والشؤون المالية كالأقساط والقروض والمنح والمساعدات ‏المالية والمنح والبعثات الدراسية ‏والتدريب والتطوع والقضايا الأكاديمية والسلوكية والاقتراحات والشكاوى. ‏ تسهل الجامعة عمل النوادي والجمعيات الطلابية وبعضها فروع لجمعيات عالمية والتي تنظم ‏نشاطات وفعاليات ذات طابع ‏علمي واكاديمي ولا منهجي. هذا بالاضافة إلى المراكز العلمية التي ‏تقدم الاستشارات والخدمات وريادة الاعمال وتطوير ‏المهارات والخبرات والشراكات.‏‎ ‎أما المكتبة ‏فتحتوي على أكثر من 435,488 كتابا، 70,000 منها إلكترونية وأكثر من 28,000 ‏مجلات  ‏النفسي والاجتماعي والصحة ‏العامة والنشاطات اللامنهجية الثقافية والاجتماعية والرياضية والفنية ‏والشؤون المالية كالأقساط والقروض والمنح والمساعدات ‏المالية والمنح والبعثات الدراسية ‏والتدريب والتطوع والقضايا الأكاديمية والسلوكية والاقتراحات والشكاوى. ‏ تسهل الجامعة عمل النوادي والجمعيات الطلابية وبعضها فروع لجمعيات عالمية والتي تنظم ‏نشاطات وفعاليات ذات طابع ‏علمي واكاديمي ولا منهجي. هذا بالاضافة إلى المراكز العلمية التي ‏تقدم الاستشارات والخدمات وريادة الاعمال وتطوير ‏المهارات والخبرات والشراكات.‏‎ ‎أما المكتبة ‏فتحتوي على أكثر من 435,488 كتابا، 70,000 منها إلكترونية وأكثر من 28,000 ‏مجلات  ‏النفسي والاجتماعي والصحة ‏العامة والنشاطات اللامنهجية الثقافية والاجتماعية والرياضية والفنية ‏والشؤون المالية كالأقساط والقروض والمنح والمساعدات ‏المالية والمنح والبعثات الدراسية ‏والتدريب والتطوع والقضايا الأكاديمية والسلوكية والاقتراحات والشكاوى. ‏ تسهل الجامعة عمل النوادي والجمعيات الطلابية وبعضها فروع لجمعيات عالمية والتي تنظم ‏نشاطات وفعاليات ذات طابع ‏علمي واكاديمي ولا منهجي. هذا بالاضافة إلى المراكز العلمية التي ‏تقدم الاستشارات والخدمات وريادة الاعمال وتطوير ‏المهارات والخبرات والشراكات.‏‎ ‎أما المكتبة ‏فتحتوي على أكثر من 435,488 كتابا، 70,000 منها إلكترونية وأكثر من 28,000 ‏مجلات  ‏النفسي والاجتماعي والصحة ‏العامة والنشاطات اللامنهجية الثقافية والاجتماعية والرياضية والفنية ‏والشؤون المالية كالأقساط والقروض والمنح والمساعدات ‏المالية والمنح والبعثات الدراسية ‏والتدريب والتطوع والقضايا الأكاديمية والسلوكية والاقتراحات والشكاوى. ‏ تسهل الجامعة عمل النوادي والجمعيات الطلابية وبعضها فروع لجمعيات عالمية والتي تنظم ‏نشاطات وفعاليات ذات طابع ‏علمي واكاديمي ولا منهجي. هذا بالاضافة إلى المراكز العلمية التي ‏تقدم الاستشارات والخدمات وريادة الاعمال وتطوير ‏المهارات والخبرات والشراكات.‏‎ ‎أما المكتبة ‏فتحتوي على أكثر من 435,488 كتابا، 70,000 منها إلكترونية وأكثر من 28,000 ‏مجلات  ‏النفسي والاجتماعي والصحة ‏العامة والنشاطات اللامنهجية الثقافية والاجتماعية والرياضية والفنية ‏والشؤون المالية كالأقساط والقروض والمنح والمساعدات ‏المالية والمنح والبعثات الدراسية ‏والتدريب والتطوع والقضايا الأكاديمية والسلوكية والاقتراحات والشكاوى. ‏ تسهل الجامعة عمل النوادي والجمعيات الطلابية وبعضها فروع لجمعيات عالمية والتي تنظم ‏نشاطات وفعاليات ذات طابع ‏علمي واكاديمي ولا منهجي. هذا بالاضافة إلى المراكز العلمية التي ‏تقدم الاستشارات والخدمات وريادة الاعمال وتطوير ‏المهارات والخبرات والشراكات.‏‎ ‎أما المكتبة ‏فتحتوي على أكثر من 435,488 كتابا، 70,000 منها إلكترونية وأكثر من 28,000 ‏مجلات  ‏النفسي والاجتماعي والصحة ‏العامة والنشاطات اللامنهجية الثقافية والاجتماعية والرياضية والفنية ‏والشؤون المالية كالأقساط والقروض والمنح والمساعدات ‏المالية والمنح والبعثات الدراسية ‏والتدريب والتطوع والقضايا الأكاديمية والسلوكية والاقتراحات والشكاوى. ‏ تسهل الجامعة عمل النوادي والجمعيات الطلابية وبعضها فروع لجمعيات عالمية والتي تنظم ‏نشاطات وفعاليات ذات طابع ‏علمي واكاديمي ولا منهجي. هذا بالاضافة إلى المراكز العلمية التي ‏تقدم الاستشارات والخدمات وريادة الاعمال وتطوير ‏المهارات والخبرات والشراكات.‏‎ ‎أما المكتبة ‏فتحتوي على أكثر من 435,488 كتابا، 70,000 منها إلكترونية وأكثر من 28,000 ‏مجلات "
        return label
        
    }()
    
    
    override func viewDidLoad() {
        
            super.viewDidLoad()
            view.addSubview(visualEffectView)
//        let myURL = URL(string:"https://nasainarabic.net/main/articles/view/dino-chicken-gets-one-step-closer")
//        let myRequest = URLRequest(url: myURL!)
//        webView.load(myRequest)
        

            view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:))))
            setupComponents()
    }
    
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        let bounds = view.bounds
        visualEffectView.frame  = bounds
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        

        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    
    func setupComponents()
    {
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive =  true
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    
        
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
        
        self.scrollView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -5).isActive = true
      //  descriptionLabel.heightAnchor.constraint(equalToConstant: self.view.bounds.height).isActive = true
        
        
        self.view.addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
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
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.onCloseClicked(sender:)))
        dismissButton.addGestureRecognizer(gesture)
        setupBottomView()
        
    }
    
    func setupBottomView()
    {
        
       let bottomView = UIView()
        self.view.addSubview(bottomView)
       bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        let guide = view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
         var bottomAreaHeight = height + 50
        
        bottomView.backgroundColor = UIColor.white
        bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: bottomAreaHeight).isActive = true
        
    }
    
    
    @objc func onCloseClicked(sender : UITapGestureRecognizer) {
        
        
          dismiss(animated: true, completion: nil)
        // Do what you want
        
    }
    
    override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        
    }
    
  
    
}
