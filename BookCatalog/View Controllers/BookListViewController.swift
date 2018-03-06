//
//  ViewController.swift
//  BookCatalog
//
//  Created by Michael Ardizzone on 3/3/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var deleteAllButton: UIButton!
    @IBOutlet weak var addBookButton: UIButton!
    @IBOutlet weak var bookListTableView: UITableView!
    var listOfBooks = [Book]()

    override func viewWillAppear(_ animated: Bool) {
        loadBooksIntoTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        loadBooksIntoTableView()
        addBookButton.makeoverButton()
        deleteAllButton.makeoverButton()
    }
    
    func loadBooksIntoTableView() {
        Networking.getBooks(completionHandler: { books in
            self.listOfBooks = books
            self.bookListTableView.reloadData()
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        })
    }
    
    @IBAction func deleteAllPressed(_ sender: Any) {
        Networking.deleteAllBooks(completionHandler: self.loadBooksIntoTableView)
    }
    
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfBooks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = listOfBooks[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! BookDetailViewController
        detailVC.book = book
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        let book = listOfBooks[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let bookID = self.listOfBooks[indexPath.row].id
        let startLoadingBooks = self.loadBooksIntoTableView
        let d = UIContextualAction(style: .destructive, title: "Delete") { (action, self , true) -> Void  in
            Networking.deleteBook(id: bookID, completionHandler: startLoadingBooks)
        }
        let config = UISwipeActionsConfiguration(actions: [d])
        return config
    }

    
}

