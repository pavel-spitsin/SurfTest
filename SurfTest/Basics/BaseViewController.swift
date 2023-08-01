//
//  BaseViewController.swift
//  SurfTest
//
//  Created by Павел on 01.08.2023.
//

import Foundation

import UIKit

class BaseViewController: UINavigationController {
    
    //MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(named: "backgroundColor_0")
    }
}
