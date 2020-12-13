//
//  ImageSheetViewController.swift
//  HiSheet
//
//  Created by Đạt on 12/14/20.
//

import UIKit
import Lottie

public class ImageSheetViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - UI components
    private lazy var viewHolder: UIControl = {
        let view = UIControl()
        view.backgroundColor = .white
        view.cornerRadius = 15
        view.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(sender:)))
        view.addGestureRecognizer(panGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "ic-close", in: Utils.resourcesBundle, compatibleWith: nil), for: .normal)
        view.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private lazy var viewTmp: UIView = {
        let view = UIView(frame: CGRect(x: viewHolder.frame.origin.x, y: viewHolder.frame.origin.y, width: 100, height: 100))
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - data
    let popupTitle: String!
    let popupDescription: String!
    let leftActionTitle: String!
    let rightActionTitle: String!
    let leftAction: (() -> Void)?
    let rightAction: (() -> Void)?
    private var viewHolderBottomConstraint: NSLayoutConstraint!
    private var popupSize: CGSize!
    private let baseAlphaBackground: CGFloat = 0.5
    
    public init(
        lottie: AnimationView,
        closeImage: UIImage? = nil,
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
        super.init(nibName: nil, bundle: nil)
        if closeImage != nil {
            closeButton.setImage(closeImage, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycles
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateShowPopup()
    }
    
    private func setupViewAttribute() {
        lottieView.loopMode = .loop
        lottieView.animationSpeed = 2
        lottieView.backgroundBehavior = .pauseAndRestore
        lottieView.contentMode = .scaleAspectFit
        lottieView.play()
        lottieView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutViews() {
        setupViewAttribute()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        view.addSubview(viewHolder)
        viewHolder.addSubview(closeButton)
        viewHolder.addSubview(lottieView)
        viewHolder.addSubview(titleLabel)
        viewHolder.addSubview(descriptionLabel)
        viewHolder.addSubview(leftActionButton)
        viewHolder.addSubview(rightActionButton)
        let centerXLine = UIView()
        centerXLine.translatesAutoresizingMaskIntoConstraints = false
        viewHolder.addSubview(centerXLine)
        viewHolderBottomConstraint = viewHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([
            viewHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewHolderBottomConstraint,
            
            closeButton.topAnchor.constraint(equalTo: viewHolder.topAnchor, constant: 5),
            closeButton.trailingAnchor.constraint(equalTo: viewHolder.trailingAnchor, constant: -5),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            
            lottieView.topAnchor.constraint(equalTo: closeButton.bottomAnchor),
            lottieView.centerXAnchor.constraint(equalTo: viewHolder.centerXAnchor),
            lottieView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            titleLabel.topAnchor.constraint(equalTo: lottieView.bottomAnchor, constant: 44),
            titleLabel.leadingAnchor.constraint(equalTo: viewHolder.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: viewHolder.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: viewHolder.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: viewHolder.trailingAnchor, constant: -20),
            
            centerXLine.widthAnchor.constraint(equalToConstant: 0),
            centerXLine.heightAnchor.constraint(equalToConstant: 0),
            centerXLine.centerXAnchor.constraint(equalTo: viewHolder.centerXAnchor),
            
            leftActionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            leftActionButton.leadingAnchor.constraint(equalTo: viewHolder.leadingAnchor, constant: 20),
            leftActionButton.bottomAnchor.constraint(equalTo: viewHolder.bottomAnchor, constant: -30),
            leftActionButton.trailingAnchor.constraint(equalTo: centerXLine.leadingAnchor, constant: -10),
            leftActionButton.heightAnchor.constraint(equalToConstant: 44),
            
            rightActionButton.topAnchor.constraint(equalTo: leftActionButton.topAnchor),
            rightActionButton.leadingAnchor.constraint(equalTo: centerXLine.trailingAnchor, constant: 10),
            rightActionButton.trailingAnchor.constraint(equalTo: viewHolder.trailingAnchor, constant: -20),
            rightActionButton.bottomAnchor.constraint(equalTo: leftActionButton.bottomAnchor),
        ])
        view.layoutIfNeeded() // update frame & bounds of view
        viewHolderBottomConstraint.constant = viewHolder.bounds.height
        popupSize = viewHolder.bounds.size
        view.layoutIfNeeded() // hide popup
    }

    // MARK: - Actions
        
    func showPopup() {
        
    }
    
    func hidePopup() {
        
    }
    
    @objc private func leftActionTapped() {
        animateHidePopup(withDuration: 0.2) {[weak self] in
            self?.leftAction?()
        }
    }
    
    @objc private func rightActionTapped() {
        animateHidePopup(withDuration: 0.2) {[weak self] in
            self?.rightAction?()
        }
    }
    
    @objc private func closeButtonTapped() {
        animateHidePopup(withDuration: 0.2, completion: nil)
    }
    
    @objc private func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        viewHolderBottomConstraint.constant = translation.y
        viewHolder.layoutIfNeeded()
        let percentDismiss = translation.y/popupSize.height
        view.backgroundColor = UIColor.black.withAlphaComponent(baseAlphaBackground*(1-percentDismiss))
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                animateHidePopup(withDuration: 0.1, completion: nil)
            } else {
                if percentDismiss > 0.6 {
                    animateHidePopup(withDuration: 0.1, completion: nil)
                } else {
                    viewHolderBottomConstraint.constant = 0
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: {
                        self.view.backgroundColor = UIColor.black.withAlphaComponent(self.baseAlphaBackground)
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
            }
        }
    }
    
    private func animateShowPopup() {
        viewHolderBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(self.baseAlphaBackground)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func animateHidePopup(withDuration duration: CGFloat = 0.2,  completion: (() -> Void)? = nil) {
        viewHolderBottomConstraint.constant = popupSize.height
        UIView.animate(withDuration: TimeInterval(duration), animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.view.layoutIfNeeded()
        }) { (isCompleted) in
            if isCompleted {
                self.dismiss(animated: true, completion: completion)
            }
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

