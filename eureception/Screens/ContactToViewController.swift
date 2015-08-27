//
//  ContactToViewController.swift
//  Reception
//
//  Created by Muukii on 8/23/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import UIKit
import CoreStore

class ContactToViewController: BaseTransactionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.iconImageView.tintColor = UIColor.eureColor
        self.tableView.rowHeight = 116
        self.tableView.tableFooterView = UIView()
        
        self.textField.attributedPlaceholder = NSAttributedString.eureAttributedString(
            "CONTACT TO...",
            color: UIColor.eureLightGrayTextColor,
            size: 55
        )
        
        self.textField.tintColor = UIColor.eureColor
        
        // Do any additional setup after loading the view.
        self.textField
            .rac_signalForControlEvents(UIControlEvents.EditingChanged)
            .toSignalProducer()
            .map { ($0 as! UITextField).text ?? "" }
            .startWithSignal { (signal, disposable) -> () in
                
                signal.observe { [weak self] event in
                    
                    guard let value = event.value else {
                        return
                    }
                    
                    self?.results = self?.usersListMonitor.objectsInAllSections().filter { $0.compare(value) == true } ?? []
                }
        }
        
        self.textField
            .rac_signalForControlEvents(UIControlEvents.EditingChanged)
            .toSignalProducer()
            .map { ($0 as! UITextField).text ?? "" }
            .filter { $0.characters.count > 0}
            .startWithSignal { (signal, disposable) -> () in
                
                signal.observe { [weak self] event in
                    
                    guard !(self?.textFieldTop.constant == 30) else {
                        return
                    }
                    
                    UIView.animateWithDuration(0.3, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                        
                        self?.textFieldTop.constant = 30
                        self?.view.layoutIfNeeded()
                        }, completion: { (finish) -> Void in
                    })
                }
        }
        
        self.textField
            .rac_signalForControlEvents(UIControlEvents.EditingChanged)
            .toSignalProducer()
            .map { ($0 as! UITextField).text ?? "" }
            .filter { $0.characters.count == 0}
            .startWithSignal { (signal, disposable) -> () in
                
                signal.observe { [weak self] event in
                    
                    guard !(self?.textFieldTop.constant == 100) else {
                        return
                    }
                    
                    UIView.animateWithDuration(0.3, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
                        
                        self?.textFieldTop.constant = 200
                        self?.view.layoutIfNeeded()
                        }, completion: { (finish) -> Void in
                    })
                }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.textField.becomeFirstResponder()
    }
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    @IBOutlet dynamic weak var inputFieldView: UIView!
    @IBOutlet dynamic weak var tableView: UITableView!
    
    // MARK: Private
    @IBOutlet private dynamic weak var textFieldTop: NSLayoutConstraint!
    @IBOutlet private dynamic weak var iconImageView: UIImageView!
    @IBOutlet private dynamic weak var textField: UITextField!
  
    private var results: [User] = [] {
        didSet {
            
            self.tableView?.reloadData()
        }
    }
    
    private let usersListMonitor = CoreStore.monitorList(From(User), OrderBy(.Ascending("id")))
}

extension ContactToViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithClass(ContactToSuggestCell.self, forIndexPath: indexPath)
        cell.user = self.results[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let user = self.results[indexPath.row]
        
        let controller = YourNameViewController.viewControllerFromStoryboard()

        let transaction = AppointTransaction(user: user)
        controller.transaction = transaction
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 90, bottom: 0, right: 0)
    }
}
