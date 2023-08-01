//
//  MySkillView.swift
//  SurfTest
//
//  Created by Павел on 01.08.2023.
//

import UIKit

class MySkillView: UIView {
    
    //MARK: - Properties
    
    private var isEdit = false
    private var action: () -> Void
    
    private lazy var mySkillLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .init(named: "textColor_0")
        label.textAlignment = .left
        label.text = Constants.mySkilsTitle
        return label
    }()
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(.init(named: "Edit"), for: .normal)
        button.tintColor = .init(named: "textColor_0")
        button.addTarget(self, action: #selector(editAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    init(action: @escaping () -> Void) {
        self.action = action
        super.init(frame: .zero)
        backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout

    private func setupLayout() {
        mySkillLabel.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mySkillLabel)
        addSubview(editButton)
        
        NSLayoutConstraint.activate([
            mySkillLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mySkillLabel.trailingAnchor.constraint(equalTo: editButton.leadingAnchor),
            mySkillLabel.topAnchor.constraint(equalTo: self.topAnchor),
            mySkillLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            editButton.topAnchor.constraint(equalTo: self.topAnchor),
            editButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 24),
            editButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    // MARK: - Actions
    
    @objc private func editAction() {
        isEdit.toggle()
        editButton.setImage(.init(named: isEdit ? "Done" : "Edit"), for: .normal)
        action()
    }
}
