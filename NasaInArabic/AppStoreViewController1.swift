//
//  AppStoreViewController1.swift
//  NasaInArabic
//
//  Created by Radi Barq on 9/23/18.
//  Copyright © 2018 RadiBarq. All rights reserved.
//

import UIKit
import Hero
import CollectionKit

class AppStoreViewController1: ExampleBaseViewController {

    let collectionView = CollectionView()
    let dataProvider = ArrayDataProvider<Int>(data: Array(0..<10))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.provider = CollectionProvider(
            dataProvider: dataProvider,
            viewUpdater: { (view: RoundedCardWrapperView, data: Int, index: Int) in
                view.cardView.titleLabel.text = "Hero"
                view.cardView.subtitleLabel.text = "App Store Card Transition"
                view.cardView.imageView.image = UIImage(named: "Unsplash\(data)")
        },
            layout: FlowLayout(spacing: 30).inset(by: UIEdgeInsets(top: 100, left: 20, bottom: 30, right: 20)),
            sizeProvider: { (index, data, collectionSize) in
                return CGSize(width: collectionSize.width, height: collectionSize.width + 20)
        },
            tapHandler: { [weak self] (view, index, dataProvider) in
                self?.cellTapped(cell: view, data: dataProvider.data(at: index))
            }
        )
        collectionView.delaysContentTouches = false
        view.insertSubview(collectionView, belowSubview: dismissButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func cellTapped(cell: RoundedCardWrapperView, data: Int) {
        // MARK: Hero configuration
        let cardHeroId = "card\(data)"
        cell.cardView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
        cell.cardView.hero.id = cardHeroId
        
        let vc = AppStoreViewController2()
        
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .none
        
        vc.cardView.hero.id = cardHeroId
        vc.cardView.hero.modifiers = [.useNoSnapshot, .spring(stiffness: 250, damping: 25)]
        vc.cardView.imageView.image = UIImage(named: "Unsplash\(data)")
        
        vc.contentCard.hero.modifiers = [.source(heroID: cardHeroId), .spring(stiffness: 250, damping: 25)]
        
        vc.contentView.hero.modifiers = [.useNoSnapshot, .forceAnimate, .spring(stiffness: 250, damping: 25)]
        
        vc.visualEffectView.hero.modifiers = [.fade, .useNoSnapshot]
        
        present(vc, animated: true, completion: nil)
    }
    
}

class ExampleBaseViewController: UIViewController {
    let dismissButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
        
        dismissButton.setTitle("Back", for: .normal)
        dismissButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        dismissButton.hero.id = "back button"
        view.addSubview(dismissButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dismissButton.sizeToFit()
        dismissButton.center = CGPoint(x: 30, y: 30)
    }
    
    @objc func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onTap() {
        back() // default action is back on tap
    }
}

class AppStoreViewController2: ExampleBaseViewController {
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    let contentCard = UIView()
    let cardView = CardView()
    let contentView = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(visualEffectView)
        
        cardView.titleLabel.text = "Hero 2"
        cardView.subtitleLabel.text = "App Store Card Transition"
        
        contentView.numberOfLines = 0
        contentView.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent neque est, hendrerit vitae nibh ultrices, accumsan elementum ante. Phasellus fringilla sapien non lorem consectetur, in ullamcorper tortor condimentum. Nulla tincidunt iaculis maximus. Sed ut urna urna. Nulla at sem vel neque scelerisque imperdiet. Donec ornare luctus dapibus. Donec aliquet ante augue, at pellentesque ipsum mollis eget. Cras vulputate mauris ac eleifend sollicitudin. Vivamus ut posuere odio. Suspendisse vulputate sem vel felis vehicula iaculis. Fusce sagittis, eros quis consequat tincidunt, arcu nunc ornare nulla, non egestas dolor ex at ipsum. Cras et massa sit amet quam imperdiet viverra. Mauris vitae finibus nibh, ac vulputate sapien.
        """
        
        contentCard.backgroundColor = .white
        contentCard.clipsToBounds = true
        
        contentCard.addSubview(contentView)
        contentCard.addSubview(cardView)
        view.addSubview(contentCard)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gr:))))
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let bounds = view.bounds
        visualEffectView.frame  = bounds
        contentCard.frame  = bounds
        cardView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.width)
        contentView.frame = CGRect(x: 20, y: bounds.width + 20, width: bounds.width - 40, height: bounds.height - bounds.width - 20)
    }
}

class CardView: UIView {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    var image = UIImage(named: "category-nature")
    var imageView = UIImageView()
    
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        subtitleLabel.font = UIFont.systemFont(ofSize: 17)
        imageView.contentMode = .scaleAspectFill
        
        addSubview(imageView)
        addSubview(visualEffectView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        visualEffectView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 90)
        titleLabel.frame = CGRect(x: 20, y: 20, width: bounds.width - 40, height: 30)
        subtitleLabel.frame = CGRect(x: 20, y: 50, width: bounds.width - 40, height: 30)
    }
}

class RoundedCardWrapperView: UIView {
    let cardView = CardView()
    
    var isTouched: Bool = false {
        didSet {
            var transform = CGAffineTransform.identity
            if isTouched { transform = transform.scaledBy(x: 0.96, y: 0.96) }
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                self.transform = transform
            }, completion: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    override init(frame: CGRect) {
        super.init(frame: frame)
        cardView.layer.cornerRadius = 16
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 12
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 8)
        addSubview(cardView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if cardView.superview == self {
            // this is necessary because we used `.useNoSnapshot` modifier on cardView.
            // we don't want cardView to be resized when Hero is using it for transition
            cardView.frame = bounds
        }
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isTouched = true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isTouched = false
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isTouched = false
    }
}


