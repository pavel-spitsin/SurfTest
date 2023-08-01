//
//  ViewController.swift
//  SurfTest
//
//  Created by Павел on 01.08.2023.
//

import UIKit
import Combine

class ProfileScreenView: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel: ProfileScreenViewModel
    private var cancelBag = Set<AnyCancellable>()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    private lazy var mainInfoView: MainInfoView = {
        let view = MainInfoView()
        view.backgroundColor = .clear
        return view
    }()
    private lazy var mySkillView: MySkillView = {
        let view = MySkillView(action: presentAlert)
        view.backgroundColor = .clear
        return view
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    private lazy var aboutUserInfoView: AboutUserInfoView = {
        let view = AboutUserInfoView()
        view.backgroundColor = .clear
        return view
    }()
    private lazy var contentView: UIView = {
        let contView = UIView()
        contView.backgroundColor = .clear
        return contView
    }()
    private lazy var customHighConstraint: NSLayoutConstraint = {
        let constraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
        constraint.priority = .defaultHigh
        return constraint
    }()
    
    //MARK: - Init
    
    init(viewModel: ProfileScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupBindings()
        navigationItem.title = Constants.navBarTitle
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        customHighConstraint.constant = height
        scrollView.contentSize = CGSize(width: contentView.frame.width, height: contentView.frame.height + 500)
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainInfoView)
        contentView.addSubview(mySkillView)
        contentView.addSubview(collectionView)
        contentView.addSubview(aboutUserInfoView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        mainInfoView.translatesAutoresizingMaskIntoConstraints = false
        mySkillView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        aboutUserInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            mainInfoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            mySkillView.topAnchor.constraint(equalTo: mainInfoView.bottomAnchor, constant: 40),
            mySkillView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mySkillView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mySkillView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: mySkillView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: aboutUserInfoView.topAnchor),
            customHighConstraint,
            
            aboutUserInfoView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            aboutUserInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            aboutUserInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    //MARK: - Bindings
    
    private func setupBindings() {
        viewModel.$skills
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.collectionView.reloadData()
            }
            .store(in: &cancelBag)
        
        viewModel.$isEdit
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.collectionView.reloadData()
            }
            .store(in: &cancelBag)
    }
    
    // MARK: - Actions
    
    @objc private func presentAlert() {
        if viewModel.isEdit == false {
            var textField = UITextField()
            
            let alert = UIAlertController(title: Constants.alertTitle, message: Constants.alertMessage, preferredStyle: .alert)
            alert.addTextField { alertTextField in
                alertTextField.placeholder = Constants.alertTextFieldPlaceholder
                textField = alertTextField
            }
            
            let cancelAction = UIAlertAction(title: Constants.alertCancelButtonTitle, style: .cancel) { action in
                print(textField.text!)
            }
            
            let addAction = UIAlertAction(title: Constants.alertAddButtonTitle, style: .default) { action in
                guard let skill = textField.text else { return }
                self.viewModel.skills.append(skill)
            }
            
            alert.addAction(addAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
        
        viewModel.isEdit.toggle()
    }
}


//MARK: - UICollectionViewDataSource

extension ProfileScreenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier,
                                                            for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        cell.skillLabel.text = viewModel.skills[indexPath.row]
        cell.isEdit = viewModel.isEdit
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension ProfileScreenView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.isEdit {
            viewModel.skills.remove(at: indexPath.row)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileScreenView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = viewModel.skills[indexPath.row]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 20, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}
