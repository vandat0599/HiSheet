//
//  ViewController.swift
//  HiSheet
//
//  Created by vandat0599@gmail.com on 12/14/2020.
//  Copyright (c) 2020 vandat0599@gmail.com. All rights reserved.
//

import UIKit
import HiSheet
import Lottie

class ViewController: UIViewController {

    lazy var popupNetworkConnection: LottieSheetViewController = {
        let view = LottieSheetViewController(
            lottie: AnimationView.init(name: "lottie-internet-connection"),
            closeImage: UIImage(named: "ic-close"),
            title: "You seem to be offline",
            description: "Check your Wi-Fi connection or cellular data and try again",
            leftActionTitle: "Retry",
            rightActionTitle: "Settings",
            leftAction: nil,
            rightAction: nil)
        view.modalPresentationStyle = .overFullScreen
        view.modalTransitionStyle = .crossDissolve
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        present(popupNetworkConnection, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

