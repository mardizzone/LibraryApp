//
//  BookDetailViewController.swift
//  BookCatalog
//
//  Created by Michael Ardizzone on 3/5/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController, CheckOutDelegate {
    var book : Book?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var checkedOutLabel: UILabel!
    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        checkOutButton.makeoverButton()
        shareButton.makeoverButton()
    }    

    func setLabels() {
        if let unwrappedBook = book {
            titleLabel.text = unwrappedBook.title
            authorLabel.text = unwrappedBook.author
            publisherLabel.text = unwrappedBook.publisher
            tagsLabel.text = unwrappedBook.categories
            guard let name = unwrappedBook.lastCheckedOutBy, let date = unwrappedBook.lastCheckedOut else {return}
            checkedOutLabel.text = "\(name) @ \(date)"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConfirmSegue" {
            let confirmVC = segue.destination as! ConfirmCheckOutViewController
            confirmVC.confirmCheckOutDelegate = self
        }
    }
    
    func confirmCheckOut(name: String) {
        guard let bookID = book?.id else {return}
        Networking.checkOutBook(name: name, id: bookID, completionHandler: { returnedBook in
            self.book = returnedBook
            //Update our labels to show the time of the most recent checkout and by whom
            self.setLabels()
        })
    }
        
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareIconPressed(_ sender: Any) {
        let items = ["\(titleLabel.text!) by \(authorLabel.text!)"]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.show(activityVC, sender: nil)
    }
}
