//
//  ProfileScreenViewModel.swift
//  SurfTest
//
//  Created by Павел on 01.08.2023.
//

import Combine
import Foundation
import UIKit

final class ProfileScreenViewModel: ObservableObject {
    
    //MARK: - Properties
    
    //Subscribe in view
    @Published var skills = ["MVC", "MVVM", "SOLID", "KISS", "DRY", "YAGNI", "SSOT", "HIG", "COMBINE"]
    @Published var isEdit = false
    
    private var cancelBag = Set<AnyCancellable>()
}
