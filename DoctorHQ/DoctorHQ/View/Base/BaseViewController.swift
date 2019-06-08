//
//  BaseViewController.swift
//  DoctorHQ
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

import Localize_Swift
import SnapKit
import UIKit

class BaseViewController: UIViewController {

    // MARK: - Properties
    
    let reachability = Reachability()!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.startAnimating()
        return activity
    }()
    
    lazy var button_Back: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_back"), for: .normal)
        button.addTarget(self, action: #selector(self.back), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .interactive
        return tableView
    }()
    
    private lazy var view_InternetObserverToast: UIView = {
        let view = UIView.new(backgroundColor: UIColor.colorWithRGBHex(0xc0392b))
        view.tag = 9911
        return view
    }()
    
    private lazy var imageView_SadFace: UIImageView = {
        return UIImageView.new(withImageName: "ic_sad")
    }()
    
    private lazy var label_NoInternetTitle: UILabel = {
        return UILabel.new(withText: "No internet connection.".localized(), fontSize: 14.0, textColor: .white)
    }()
    
    private lazy var stackView_ToastContents: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.imageView_SadFace,
            self.label_NoInternetTitle
            ])
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    // MARK: - Functions
    
    /**
     Presents an alertController with completion.
     - parameter message: The body of the alert, nullable, since we can just sometimes use the title parameter.
     - parameter okButtonTitle: the title of the okay button.
     */
    func alert(message: String? = nil, okayButtonTitle: String) {
        
        let alertController = UIAlertController(title: "DoctorHQ", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okayButtonTitle, style: .default) { _ in }
        alertController.addAction(okAction)
        
        alertController.view.tintColor = .black
        present(alertController, animated: true, completion: nil)
    }

    
    func layoutInternetConnectionObserverToast() {
        if let keyWindow = UIApplication.shared.keyWindow {
            if keyWindow.subviews.filter({ $0.tag == 9911 }).count == 0 {
                keyWindow.addSubview(self.view_InternetObserverToast)
                self.view_InternetObserverToast.alpha = 0
                self.view_InternetObserverToast.snp.makeConstraints {
                    $0.height.equalTo(44.0)
                    $0.leading.trailing.equalToSuperview()
                    _ = $0.constraintToTop(keyWindow)
                }
                
                // The contents of the container toast.
                self.view_InternetObserverToast.addSubview(self.stackView_ToastContents)
                self.stackView_ToastContents.snp.makeConstraints {
                    $0.center.equalToSuperview()
                }
                
                self.imageView_SadFace.snp.makeConstraints {
                    $0.width.height.equalTo(30.0)
                }
                
                // The top extra view for iPhone X and similar phones.
                let topView = UIView()
                topView.backgroundColor = UIColor.colorWithRGBHex(0xc0392b)
                self.view_InternetObserverToast.addSubview(topView)
                topView.snp.makeConstraints {
                    $0.leading.trailing.equalToSuperview()
                    $0.height.equalTo(60.0)
                    $0.bottom.equalTo(self.view_InternetObserverToast.snp.top)
                }
            }
            
            return
        }
    }
    
    func toggleInternetToastVisibility(toastIsHidden: Bool) {
        if let keyWindow = UIApplication.shared.keyWindow,
            let toast = keyWindow.subviews.filter({ $0.tag == 9911 }).first {
            UIView.animate(withDuration: 0.5) {
                toast.alpha = toastIsHidden ? 0 : 1.0
            }
        }
    }
    
    private func observeInternetConnection() {
        self.reachability.whenReachable = { [weak self] _ in
            print("Reachable 🌍")
            self?.toggleInternetToastVisibility(toastIsHidden: true)
        }
        
        self.reachability.whenUnreachable = { [weak self] _ in
            print("Not reachable 🌍")
            self?.toggleInternetToastVisibility(toastIsHidden: false)
        }
        
        do {
            try self.reachability.startNotifier()
        } catch {
            print("Unable to start notifier 🌍")
        }
    }
    
    /// Overridable.
    @objc public func back() {
        if let navCon = self.navigationController {
            DispatchQueue.main.async {
                navCon.popViewController(animated: true)
            }
        }
    }
    
    deinit {
        print("🐽 Deinit \(self) 🐽")
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.layoutInternetConnectionObserverToast()
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        // Register cells
        self.tableView.register(BaseTableViewCell.self, forCellReuseIdentifier: BaseTableViewCell.identifier)
        self.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        self.tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
        
        let transluscentView = UIView()
        transluscentView.backgroundColor = .clear
        
        self.tableView.tableHeaderView = transluscentView
        self.tableView.tableFooterView = transluscentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.observeInternetConnection()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.reachability.stopNotifier()
    }
}

// MARK: - UIGestureRecognizerDelegate

extension BaseViewController: UIGestureRecognizerDelegate {
    
}
