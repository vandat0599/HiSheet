//
//  BottomSheetViewController.swift
//  HiSheet
//
//  Created by Dat Van on 2/25/21.
//

import UIKit

open class BottomSheetViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - UI components
    public lazy var contentView: UIControl = {
        let view = UIControl()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.cornerRadius = 15
        view.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction(sender:)))
        view.addGestureRecognizer(panGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public lazy var closeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "ic-close", in: nil, compatibleWith: nil), for: .normal)
        view.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - properties
    private var contentViewBottomConstraint: NSLayoutConstraint!
    private var contentViewSize: CGSize!
    private let baseAlphaBackground: CGFloat = 0.5
    
    open var canDismissOnTouchOutSide = true
    open var canDismissOnSwipeDown = true
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("bottom sheet deinit")
    }
    
    // MARK: - life cycles
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
        updateSize()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateShowPopup()
    }
    
    open func layoutViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        view.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        view.addSubview(contentView)
        contentView.addSubview(closeButton)
        contentViewBottomConstraint = contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentViewBottomConstraint,
            
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
    }
    
    private func updateSize() {
        view.layoutIfNeeded() // update frame & bounds of view
        contentViewBottomConstraint.constant = contentView.bounds.height
        contentViewSize = contentView.bounds.size
        view.layoutIfNeeded() // hide popup
    }

    // MARK: - Actions
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        animateHidePopup(withDuration: 0.2, completion: completion)
    }
    
    @objc private func closeButtonTapped() {
        animateHidePopup(withDuration: 0.2, completion: nil)
    }
    
    @objc private func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        guard translation.y >= 0 else {
            self.animateShowPopup()
            return
        }
        contentViewBottomConstraint.constant = translation.y
        contentView.layoutIfNeeded()
        let percentDismiss = translation.y/contentViewSize.height
        view.backgroundColor = UIColor.black.withAlphaComponent(baseAlphaBackground*(1-percentDismiss))
        if sender.state == .ended {
            if canDismissOnSwipeDown {
                let dragVelocity = sender.velocity(in: view)
                if dragVelocity.y >= 1300 {
                    animateHidePopup(withDuration: 0.1, completion: nil)
                } else {
                    if percentDismiss > 0.6 {
                        animateHidePopup(withDuration: 0.1, completion: nil)
                    } else {
                        self.animateShowPopup()
                    }
                }
            } else {
                self.animateShowPopup()
            }
        }
    }
    
    private func animateShowPopup() {
        contentViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(self.baseAlphaBackground)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func animateHidePopup(withDuration duration: CGFloat = 0.2,  completion: (() -> Void)? = nil) {
        contentViewBottomConstraint.constant = contentViewSize.height
        UIView.animate(withDuration: TimeInterval(duration), animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.view.layoutIfNeeded()
        }) { (_) in
            super.dismiss(animated: true, completion: completion)
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}
