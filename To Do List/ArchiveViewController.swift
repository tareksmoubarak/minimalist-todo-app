//
//  ArchiveViewController.swift
//  To Do List
//
//  Created by Tarek Moubarak on 9/27/18.
//  Copyright © 2018 Tarek Moubarak. All rights reserved.
//

import UIKit

class ArchiveViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    var items: [String] = ["Nothing in the archive?! :O"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let itemsObject = UserDefaults.standard.object(forKey: "archive")
        if let tempItems = itemsObject as? [String]{
            items = tempItems
        } else{
            items = ["Nothing in the archive?! :O"]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let itemsObject = UserDefaults.standard.object(forKey: "archive")
        if let tempItems = itemsObject as? [String]{
            items = tempItems
        } else{
            items = ["Nothing in the archive?! :O"]
        }
        table.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default
            , reuseIdentifier: "Cell")
        cell.textLabel?.text = items[indexPath.row]
//        cell.textLabel?.text = "test"
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath)
        -> [UITableViewRowAction]? {
            
            let deleteTitle = NSLocalizedString("Delete", comment: "Delete action")
            let deleteAction = UITableViewRowAction(style: .destructive,
                                                    title: deleteTitle) {_,_ in
                                                        self.items.remove(at: indexPath.row)
                                                        self.table.reloadData()
                                                        UserDefaults.standard.set(self.items, forKey: "items")
            }
            return [deleteAction]
    }
}
