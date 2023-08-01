//
//  CollectionCell.swift
//  SurfTest
//
//  Created by Павел on 01.08.2023.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    //MARK: - Properties
    
    static let identifier = String(describing: CollectionCell.self)
    var isEdit: Bool = false {
        didSet {
            isEdit ? addXmark() : removeXmark()
        }
    }

    lazy var skillLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        
        return label
    }()
    private lazy var removeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = .init(systemName: "xmark")
        imageView.tintColor = .init(named: "textColor_0")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = Constants.collectionCellCornerRadius
        configureComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        skillLabel.text = ""
        self.subviews.forEach {
            $0.isUserInteractionEnabled = false
        }
    }

    // MARK: - Layout
    
    func configureComponents() {
        backgroundColor = .clear
        setupLayout()
    }
    
    func setupLayout() {
        skillLabel.translatesAutoresizingMaskIntoConstraints = false
        removeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(skillLabel)
        contentView.addSubview(removeImageView)

        NSLayoutConstraint.activate([
            skillLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            skillLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            skillLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            skillLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            removeImageView.heightAnchor.constraint(equalToConstant: 24),
            removeImageView.widthAnchor.constraint(equalToConstant: 24),
            removeImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            removeImageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        ])
    }
    
    // MARK: - Actions
    
    func addXmark() {
        removeImageView.isHidden = false
    }
    
    func removeXmark() {
        removeImageView.isHidden = true
    }
}
