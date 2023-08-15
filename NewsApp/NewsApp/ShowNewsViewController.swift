//
//  ShowNewsViewController.swift
//  NewsApp
//
//  Created by Polina Tereshchenko on 15.08.2023.
//

import Foundation
import UIKit
import SnapKit

final class ShowNewsViewController: UIViewController {
    
    //MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        view.image = UIImage(named: "image set") ?? UIImage.add
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Trump and 18 others charged in Georgia election inquiry"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var descriptionLabel: UITextView = {
        let text = UITextView()
        
        text.text = "Former US President Donald Trump has been charged with attempting to overturn his 2020 election defeat in the state of Georgia. It is the fourth criminal case brought against him in five months. Mr Trump, who is the leading Republican candidate for president in 2024, was indicted along with 18 other allies. He denies all 13 charges against him, which include racketeering and election meddling. He has said they are politically motivated. Georgia prosecutor Fani Willis first launched an investigation in February 2021 into allegations of election meddling against Mr Trump and his associates. In a 98-page indictment made public late on Monday, prosecutors listed 41 charges against the 19 defendants. Ms Willis announced she was giving defendants the opportunity to voluntarily surrender no later than noon on Friday 25 August. She said she plans to try all 19 accused together."
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 17)
        text.backgroundColor = .systemGray5
        
        
        return text
    }()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        
        label.text = "14.08.2023"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(dataLabel)
        view.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(view.frame.height / 6)
        }
        
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.trailing.equalTo(-5)
            make.height.equalTo(view.frame.height / 18)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dataLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
}
