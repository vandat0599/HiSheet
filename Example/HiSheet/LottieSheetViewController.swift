//
//  LottieSheetViewController.swift
//  HiSheet_Example
//
//  Created by Dat Van on 2/25/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Lottie
import HiSheet

class LottieSheetViewController: BottomSheetViewController {
    // MARK: - UI components
    
    private var lottieView: AnimationView
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.text = popupTitle
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.text = popupDescription
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var leftActionButton: UIButton = {
        let view = UIButton()
        view.setTitle(leftActionTitle, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(.systemPink, for: .normal)
        view.clipsToBounds = true
        view.cornerRadius = 5
        view.backgroundColor = .white
        view.borderColor = .systemPink
        view.borderWidth = 1
        view.addTarget(self, action: #selector(leftActionTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rightActionButton: UIButton = {
        let view = UIButton()
        view.setTitle(rightActionTitle, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.setTitleColor(.white, for: .normal)
        view.clipsToBounds = true
        view.cornerRadius = 5
        view.backgroundColor = .systemPink
        view.addTarget(self, action: #selector(rightActionTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - data
    let popupTitle: String!
    let popupDescription: String!
    let leftActionTitle: String!
    let rightActionTitle: String!
    let leftAction: (() -> Void)?
    let rightAction: (() -> Void)?
    
    init(
        lottie: AnimationView,
        closeImage: UIImage,
        title: String,
        description: String,
        leftActionTitle: String,
        rightActionTitle: String,
        leftAction: (() -> Void)?,
        rightAction: (() -> Void)?) {
        self.lottieView = lottie
        self.popupTitle = title
        self.popupDescription = description
        self.leftActionTitle = leftActionTitle
        self.rightActionTitle = rightActionTitle
        self.leftAction = leftAction
        self.rightAction = rightAction
        super.init()
        closeButton.setImage(closeImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
    }
    
    private func setupViewAttribute() {
        lottieView.loopMode = .loop
        lottieView.animationSpeed = 2
        lottieView.backgroundBehavior = .pauseAndRestore
        lottieView.contentMode = .scaleAspectFit
        lottieView.play()
        lottieView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutViews() {
        super.layoutViews()
        setupViewAttribute()
        contentView.addSubview(closeButton)
        contentView.addSubview(lottieView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(leftActionButton)
        contentView.addSubview(rightActionButton)
        let centerXLine = UIView()
        centerXLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(centerXLine)
        NSLayoutConstraint.activate([

            lottieView.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            lottieView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lottieView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),

            titleLabel.topAnchor.constraint(equalTo: lottieView.bottomAnchor, constant: 44),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            centerXLine.widthAnchor.constraint(equalToConstant: 0),
            centerXLine.heightAnchor.constraint(equalToConstant: 0),
            centerXLine.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            leftActionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            leftActionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            leftActionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            leftActionButton.trailingAnchor.constraint(equalTo: centerXLine.leadingAnchor, constant: -10),
            leftActionButton.heightAnchor.constraint(equalToConstant: 44),

            rightActionButton.topAnchor.constraint(equalTo: leftActionButton.topAnchor),
            rightActionButton.leadingAnchor.constraint(equalTo: centerXLine.trailingAnchor, constant: 10),
            rightActionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            rightActionButton.bottomAnchor.constraint(equalTo: leftActionButton.bottomAnchor),
        ])
    }

    // MARK: - Actions
        
    func showPopup() {
        
    }
    
    func hidePopup() {
        
    }
    
    @objc private func leftActionTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func rightActionTapped() {
        dismiss(animated: true, completion: nil)
    }
}
