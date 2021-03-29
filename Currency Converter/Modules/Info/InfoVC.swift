//
//  InfoVC.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 27/03/2021.
//

import UIKit

class InfoVC: UIViewController {
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addSubviews()
        self.setTexts()
    }
    
    private func addSubviews() {
        self.view.addSubview(self.appNameLabel)
        self.appNameLabel
            .matchParentHorizontally(safeArea: true)
            .alignParentTop(constant: 24, safeArea: true)
        
        self.view.addSubview(self.descriptionLabel)
        self.descriptionLabel
            .matchParentHorizontally(constant: 24, safeArea: true)
            .alignBelow(to: self.appNameLabel, constant: 16)
        
        self.view.addSubview(self.authorLabel)
        self.authorLabel
            .matchParentHorizontally(safeArea: true)
            .alignParentBottom(constant: 24, safeArea: true)
    }
    
    private func setTexts() {
        self.appNameLabel.text = AppText.appName.rawValue.uppercased()
        self.descriptionLabel.text = AppText.appDescription.rawValue
        self.authorLabel.text = AppText.appAuthor.rawValue.uppercased()
    }
}
