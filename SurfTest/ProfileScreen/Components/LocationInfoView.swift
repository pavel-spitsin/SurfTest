//
//  LocationInfoView.swift
//  SurfTest
//
//  Created by Павел on 01.08.2023.
//

import UIKit

class LocationInfoView: UIView {
    
    //MARK: - Properties
    
    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = .init(named: "Location")
        imageView.tintColor = .init(named: "textColor_1")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .init(named: "textColor_1")
        label.textAlignment = .left
        label.text = Constants.cityName
        return label
    }()
    private lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = .clear
        return content
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
        contentView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentView)
        contentView.addSubview(locationImageView)
        contentView.addSubview(cityNameLabel)
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).withPriority(999),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).withPriority(750),
            contentView.trailingAnchor.constraint(equalTo: self.leadingAnchor).withPriority(750),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            locationImageView.heightAnchor.constraint(equalToConstant: Constants.locationImageHeightWidth),
            locationImageView.widthAnchor.constraint(equalToConstant: Constants.locationImageHeightWidth),
            locationImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            cityNameLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor),
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            cityNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cityNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
