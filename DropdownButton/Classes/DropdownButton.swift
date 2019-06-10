//
//  DropdownButton.swift
//  DropdownButton
//
//  Created by Alexander Korus on 29.11.18.
//

import Foundation
import SnapKit
import UIKit

open class DropdownButton: UIButton {
    
    var table : UITableView!
    var shadow : UIView!
    
    @IBInspectable
    public var selectedIndex: Int {
        get {
            return self._selectedIndex
        }
        set {
            self._selectedIndex = newValue
            self.setTitle(self.dataArray[_selectedIndex], for: .normal)
        }
    }
    
    
    //MARK: IBInspectable
    
    @IBInspectable public var rowHeight: CGFloat = 30
    @IBInspectable public var rowBackgroundColor: UIColor = .white
    @IBInspectable public var selectedRowColor: UIColor = .cyan
    @IBInspectable public var hideOptionsWhenSelect = true
    @IBInspectable public var cellFont: UIFont = UIFont.systemFont(ofSize: 15.0)
    @IBInspectable public var cellTextAlignment: NSTextAlignment = .center
    @IBInspectable public var selectedRowTextColor: UIColor = .black
    @IBInspectable public var cellTextColor: UIColor = .black
    @IBInspectable public var animationDuration: Double = 0.9
    @IBInspectable public var animationCloseDelay: Double = 0.4
    @IBInspectable public var springDamping: CGFloat = 0.4
    @IBInspectable public var initialSpringVelocity: CGFloat = 0.1
    @IBInspectable public var useShadow: Bool = true

    @IBInspectable public var borderColor: UIColor =  UIColor.lightGray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var listHeight: CGFloat = 150 {
        didSet {
            
        }
    }
    
    @IBInspectable public var maxListHeight: CGFloat = 300
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 5.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    public var scrollToBottomWhenShow: Bool = false
    
    // Variables
    fileprivate  var tableHeightX: CGFloat = 100
    
    fileprivate  var dataArray = [String]()
    
    fileprivate  var _selectedIndex = 0
    fileprivate  var _isListExpanded = false
    
    public var isListExpanded: Bool {
        get {
            return _isListExpanded
        }
    }
    
    public var optionArray = [String]() {
        didSet {
            self.dataArray = self.optionArray
        }
    }
    public var optionIds : [Int]?
    
    // Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    // MARK: Closures
    fileprivate var didSelectCompletion: (String, Int ,Int) -> () = { selectedText, index , id  in }
    fileprivate var TableWillAppearCompletion: () -> () = { }
    fileprivate var TableDidAppearCompletion: () -> () = { }
    fileprivate var TableWillDisappearCompletion: () -> () = { }
    fileprivate var TableDidDisappearCompletion: () -> () = { }
    
    func setup() {
        self.setTitleColor(self.titleColor(for: .normal), for: .selected)
        self.addTarget(self, action: #selector(touchAction), for: .touchUpInside)
    }
    
    private func showList() {
        
        TableWillAppearCompletion()
        let estimatedListHeight = rowHeight * CGFloat( dataArray.count)
        if listHeight > estimatedListHeight {
            self.tableHeightX = estimatedListHeight
        } else {
            self.tableHeightX = listHeight
        }
        table = UITableView(frame: CGRect(x: self.frame.minX,
                                          y: self.frame.minY,
                                          width: self.frame.width,
                                          height: self.frame.height))
        shadow = UIView(frame: CGRect(x: self.frame.minX,
                                      y: self.frame.minY,
                                      width: self.frame.width,
                                      height: self.frame.height))
        shadow.backgroundColor = .clear
        
        table.dataSource = self
        table.delegate = self
        table.alpha = 0
        table.separatorStyle = .none
        table.layer.cornerRadius = 3
        table.backgroundColor = rowBackgroundColor
        table.rowHeight = rowHeight
        
        
        self.superview?.insertSubview(shadow, belowSubview: self)
        self.superview?.insertSubview(table, belowSubview: self)
        self.isSelected = true
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       usingSpringWithDamping: springDamping,
                       initialSpringVelocity: initialSpringVelocity,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                        
                        self.table.frame = CGRect(x: self.frame.minX,
                                                  y: self.frame.maxY+5,
                                                  width: self.frame.width,
                                                  height: self.tableHeightX)
                        
                        self.table.alpha = 1
                        self.shadow.frame = self.table.frame
                        if self.useShadow {
                            self.shadow.dropShadow()
                        }
                        self._isListExpanded = true
        },
                       completion: { (finish) -> Void in
                        if self.listHeight < estimatedListHeight && self.scrollToBottomWhenShow {
                            self.table.scrollToRow(at: IndexPath(row: self.dataArray.count-1, section: 0), at: .bottom, animated: true)
                        }
        })
        
    }
    
    
    private func hideList() {
        
        TableWillDisappearCompletion()
        UIView.animate(withDuration: animationDuration,
                       delay: animationCloseDelay,
                       usingSpringWithDamping: springDamping,
                       initialSpringVelocity: initialSpringVelocity,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                        self.table.frame = CGRect(x: self.frame.minX,
                                                  y: self.frame.minY,
                                                  width: self.frame.width,
                                                  height: 0)
                        self.shadow.alpha = 0
                        self.shadow.frame = self.table.frame
        },
                       completion: { (didFinish) -> Void in
                        
                        self.shadow.removeFromSuperview()
                        self.table.removeFromSuperview()
                        self.isSelected = false
                        self.TableDidDisappearCompletion()
                        self._isListExpanded = false
        })
    }
    
    public func expandList() {
        if !isListExpanded {
            showList()
        }
    }
    
    public func collapseList() {
        if isListExpanded {
            hideList()
        }
    }
    
    public func setOptions(options: [String], optionIds: [Int]? = nil, selectedIndex: Int) {
        self.optionIds = optionIds
        self.optionArray = options
        self.selectedIndex = selectedIndex
    }
    
    private func reSizeTable() {
        
        if listHeight > rowHeight * CGFloat( dataArray.count) {
            self.tableHeightX = rowHeight * CGFloat(dataArray.count)
        } else{
            self.tableHeightX = listHeight
        }
        UIView.animate(withDuration: 0.2,
                       delay: 0.1,
                       usingSpringWithDamping: springDamping,
                       initialSpringVelocity: initialSpringVelocity,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                        self.table.frame = CGRect(x: self.frame.minX,
                                                  y: self.frame.maxY+5,
                                                  width: self.frame.width,
                                                  height: self.tableHeightX)
                        
                        
        },
                       completion: { (didFinish) -> Void in
                        self.shadow.layer.shadowPath = UIBezierPath(rect: self.table.bounds).cgPath
                        
        })
        
    }
    
    // MARK: Actions Methods
    public func didSelect(completion: @escaping (_ selectedText: String, _ index: Int , _ id:Int ) -> ()) {
        didSelectCompletion = completion
    }
    
    public func listWillAppear(completion: @escaping () -> ()) {
        TableWillAppearCompletion = completion
    }
    
    public func listDidAppear(completion: @escaping () -> ()) {
        TableDidAppearCompletion = completion
    }
    
    public func listWillDisappear(completion: @escaping () -> ()) {
        TableWillDisappearCompletion = completion
    }
    
    public func listDidDisappear(completion: @escaping () -> ()) {
        TableDidDisappearCompletion = completion
    }
    
    
    
}


// MARK: UITableViewDataSource
extension DropdownButton: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "DropDownCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        if indexPath.row != _selectedIndex {
            cell?.backgroundColor = rowBackgroundColor
            cell?.textLabel?.textColor = cellTextColor
        } else {
            cell?.backgroundColor = selectedRowColor
            cell?.textLabel?.textColor = selectedRowTextColor
        }
        
        cell?.textLabel?.text = "\(dataArray[indexPath.row])"
        cell?.selectionStyle = .none
        cell?.textLabel?.font = self.cellFont
        cell?.textLabel?.textAlignment = self.cellTextAlignment
        return cell!
    }
}

// MARK: Target Action Functions
extension DropdownButton {
    
    @objc public func touchAction() {
        
        isSelected ?  hideList() : showList()
        
    }
    
}



// MARK: UITableViewDelegate
extension DropdownButton: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _selectedIndex = indexPath.row
        let selectedText = self.dataArray[self._selectedIndex]
        tableView.cellForRow(at: indexPath)?.alpha = 0
        UIView.animate(withDuration: 0.5,
                       animations: { () -> Void in
                        tableView.cellForRow(at: indexPath)?.alpha = 1.0
                        tableView.cellForRow(at: indexPath)?.backgroundColor = self.selectedRowColor
        } ,
                       completion: { (didFinish) -> Void in
                        self.setTitle("\(selectedText)", for: .normal)
                        tableView.reloadData()
        })
        
        if hideOptionsWhenSelect {
            touchAction()
            self.endEditing(true)
        }
        
        if let selected = optionArray.index(where: { $0 == selectedText }) {
            if let id = optionIds?[selected] {
                didSelectCompletion(selectedText, selected , id)
            } else {
                didSelectCompletion(selectedText, selected , 0)
            }
        }
    }
}

extension UIView {
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 2
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    
}
