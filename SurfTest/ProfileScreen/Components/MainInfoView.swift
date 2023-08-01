//
//  MainInfoView.swift
//  SurfTest
//
//  Created by Павел on 01.08.2023.
//

import UIKit

class MainInfoView: UIView {
    
    //MARK: - Properties
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView(image: .init(named: Constants.userImage))
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = Constants.userImageHeightWidth / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .init(named: "textColor_0")
        label.textAlignment = .center
        label.text = Constants.userName
        return label
    }()
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .init(named: "textColor_1")
        label.textAlignment = .center
        label.text = Constants.positionTitle
        return label
    }()
    private lazy var locationInfoView: LocationInfoView = {
        LocationInfoView()
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout

    private func setupLayout() {
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        locationInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(userImageView)
        addSubview(userNameLabel)
        addSubview(positionLabel)
        addSubview(locationInfoView)
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: self.topAnchor),
            userImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: Constants.userImageHeightWidth),
            userImageView.heightAnchor.constraint(equalToConstant: Constants.userImageHeightWidth),
            
            userNameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            positionLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 4),
            positionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            positionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            locationInfoView.topAnchor.constraint(equalTo: positionLabel.bottomAnchor),
            locationInfoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            locationInfoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            locationInfoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            locationInfoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
