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
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
 
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var descriptionLabel: UITextView = {
        let text = UITextView()
        
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 17)
        text.backgroundColor = .systemGray5
        text.isEditable = false
        
        return text
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        return label
    }()
    
    private let viewModel: ShowNewsViewModelProtocol
    
    //MARK: - Life Cycle
    init(viewModel: ShowNewsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .systemGray5
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(dateLabel)
        view.addSubview(descriptionLabel)
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        dateLabel.text = String(viewModel.date.prefix(10))
        
        if let data = viewModel.imageData,
           let image = UIImage(data: data) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "image set")
        }
        
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
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.trailing.equalTo(-5)
            make.height.equalTo(view.frame.height / 18)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
}
