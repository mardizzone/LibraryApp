//
//  AddBookViewController.swift
//  BookCatalog
//
//  Created by Michael Ardizzone on 3/4/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var categoriesTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.makeoverButton()
    }

    @IBAction func addBookButtonPressed(_ sender: Any) {
        //Ensure that the user has added a Title and Author before adding the book
        if (titleTextField.text == "Book Title" || titleTextField.text == "") && (authorTextField.text == "Author" || authorTextField.text == "") {
            let alert = setUpAddButtonAlert()
            self.show(alert, sender: nil)
            print("show unacceptable alert")
            return
        }
        addBookWithTextFieldParams()
        self.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let alert = setUpCancelButtonAlert()
        //Ensure that the user wants to leave screen when there is text on screen that has been altered
        if titleTextField.text != "" && titleTextField.text != "Book Title" {
            print("cancel confirmation")
            self.show(alert, sender: nil)
            return
        }
        if authorTextField.text != "" && authorTextField.text != "Author" {
            print("cancel confirmation")
            return
        }
        if publisherTextField.text != "" && publisherTextField.text != "Publisher" {
            print("cancel confirmation")
            return
        }
        if categoriesTextField.text != "" && categoriesTextField.text != "Categories" {
            print("cancel confirmation")
            return
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func addBookWithTextFieldParams() {
        var params = [String : String]()
        params["author"] = authorTextField.text ?? ""
        params["categories"] = categoriesTextField.text ?? ""
        params["title"] = titleTextField.text ?? ""
        params["publisher"] = publisherTextField.text ?? ""
        Networking.addBook(inputParams: params)
    }
    
    //MARK: - Set Up Alerts
    func setUpCancelButtonAlert() -> UIAlertController {
        let alert = UIAlertController(title: "You have made changes", message: "Are you sure you want to exit?", preferredStyle: UIAlertControllerStyle.alert)
        let dismissAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: { alerAction in
            self.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(dismissAction)
        alert.addAction(cancelAction)
        return alert
    }
    
    func setUpAddButtonAlert() -> UIAlertController {
        let alert = UIAlertController(title: "More Information Required", message: "Please add an Author and Title", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelAction)
        return alert
    }
}

extension AddBookViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.font = UIFont(name: "AovelSans-Black", size: 17)
    }
    
}
