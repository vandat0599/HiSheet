//
//  ViewController.swift
//  HiSheet
//
//  Created by vandat0599@gmail.com on 12/14/2020.
//  Copyright (c) 2020 vandat0599@gmail.com. All rights reserved.
//

import UIKit
import HiSheet

class ViewController: UIViewController {

    lazy var popupNetworkConnection: BottomSheetVC = {
        let view = BottomSheetVC(lottieFileName: "lottie-internet-connection", title: "You seem to be offline", description: "Check your Wi-Fi connection or cellular data and try again", leftActionTitle: "Retry", rightActionTitle: "Settings", leftAction: nil, rightAction: nil)
        view.modalPresentationStyle = .overFullScreen
        view.modalTransitionStyle = .crossDissolve
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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

