//
//  ViewController.swift
//  DropdownButton
//
//  Created by BigAlKo on 11/29/2018.
//  Copyright (c) 2018 BigAlKo. All rights reserved.
//

import UIKit
import SnapKit
import DropdownButton

class ViewController: UIViewController {
    // MARK: - Stored Properties
    
    
    // MARK: - Initializers
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // if you want to hide the dropdown, add a dismissDropdown function
        //self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissDropdown)))
        getOptions()
        
    }
    
    
    override func loadView() {
        self.view = View()
    }
    
    // MARK: - Instance Methods
    func getOptions() {
        
        let options = ["Option 1", "Option 2", "Option 3"]
        let ids = [0, 1, 2]
        
        self.dropDownButton.setOptions(options: options, optionIds: ids, selectedIndex: 0)
        
    }
}

// MARK: - Views
private extension ViewController {
    unowned var rootView: View { return self.view as! View }
    unowned var dropDownButton: DropdownButton { return self.rootView.dropDownButton }
}

// MARK: - Target Action Functions
extension ViewController {
    
    @objc func dismissDropdown() {
        self.dropDownButton.collapseList()
    }
    
}




