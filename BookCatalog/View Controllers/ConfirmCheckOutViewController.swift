//
//  ConfirmCheckOutViewController.swift
//  BookCatalog
//
//  Created by Michael Ardizzone on 3/5/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit

class ConfirmCheckOutViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    var confirmCheckOutDelegate : CheckOutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.makeoverButton()
        checkOutButton.makeoverButton()
    }

    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkOutPressed(_ sender: Any) {
        confirmCheckOutDelegate?.confirmCheckOut(name: nameTextField.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nameTextField.text = ""
        nameTextField.textColor = UIColor.darkText
    }
}

protocol CheckOutDelegate {
    func confirmCheckOut(name: String)
}
