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
    
    private lazy var button: UIButton = {
        let view = UIButton()
        view.setTitle("Show lottie popup", for: .normal)
        view.backgroundColor = .white
        view.setTitleColor(.systemBlue, for: .normal)
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func buttonTapped() {
        let vc = LottieSheetViewController(
            lottie: AnimationView.init(name: "lottie-internet-connection"),
            closeImage: UIImage(named: "ic-close")!,
            title: "You seem to be offline",
            description: "Check your Wi-Fi connection or cellular data and try again",
            leftActionTitle: "Retry",
            rightActionTitle: "Settings",
            leftAction: nil,
            rightAction: nil)
        present(vc, animated: true, completion: nil)
    }
}

