//
//  ViewController.swift
//  OnboradSet
//
//  Created by Hiroki Taniguchi on 2018/02/17.
//  Copyright © 2018年 Hiroki Taniguchi. All rights reserved.
//

import UIKit
import SwiftyOnboard
import TTTAttributedLabel


class ViewController: UIViewController {

    @IBOutlet weak var swiftyOnboard: SwiftyOnboard!
    override func viewDidLoad() {
        super.viewDidLoad()
        swiftyOnboard.style = .light
        swiftyOnboard.delegate = self
        swiftyOnboard.dataSource = self
        swiftyOnboard.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        //        swiftyOnboard.backgroundColor = UIColor(red: 46/256, green: 46/256, blue: 76/256, alpha: 1)
    }
    
    @objc func handleSkip() {
        swiftyOnboard?.goToPage(index: 2, animated: true)
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        swiftyOnboard?.goToPage(index: index + 1, animated: true)
    }
}

extension ViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 4
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = CustomPage.instanceFromNib() as? CustomPage
        //        let testImageView = UIImage(#imageLiteral(resourceName: "test1"))
        
        view?.image.image = UIImage(named: "t\(index)")
        if index == 0 {
            //On the first page, change the text in the labels to say the following:
            view?.titleLabel.text = "YOLO"
            view?.subTitleLabel.text = "人生は少し長めなストーリーです。\nYOLOはそんなあなただけの\n波乱万丈なストーリーを\n綴っていく場所です"
        } else if index == 1 {
            //On the second page, change the text in the labels to say the following:
            view?.titleLabel.text = "SNSを\nストーリーに"
            view?.subTitleLabel.text = "連携したSNSの投稿が\n自然に貯まっていきます。\nあなたのストーリーは\n自然に綴られていきます。"
        } else if index == 2 {
            //On the second page, change the text in the labels to say the following:
            view?.titleLabel.text = "一緒に\nストーリーに"
            view?.subTitleLabel.text = "同じ時間を共にした相手と\n思い出を共有できます。\nあなたのストーリにーは\nどんな登場人物が出てきますか？"
        } else {
            //On the thrid page, change the text in the labels to say the following:
            view?.titleLabel.text = "ここだけの\nストーリーに"
            view?.subTitleLabel.text = "ここから直接思い出を残せます。\n誰かではなく、あなただけの\nストーリーを残してください。"
        }
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = CustomOverlay.instanceFromNib() as? CustomOverlay
        overlay?.skip.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay?.buttonContinue.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let overlay = overlay as! CustomOverlay
        let currentPage = round(position)
        overlay.contentControl.currentPage = Int(currentPage)
        overlay.buttonContinue.tag = Int(position)
        if currentPage == 0.0 || currentPage == 1.0 || currentPage == 2.0 {
            overlay.buttonContinue.setTitle("Twitterで登録！", for: .normal)
            overlay.skip.setTitle("Skip", for: .normal)
            overlay.skip.isHidden = false
        } else {
            overlay.buttonContinue.setTitle("Twitterで登録！！！", for: .normal)
            overlay.skip.isHidden = true
        }
    }
}
