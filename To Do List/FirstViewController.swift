//
//  FirstViewController.swift
//  To Do List
//
//  Created by Tarek Moubarak on 9/27/18.
//  Copyright © 2018 Tarek Moubarak. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var items: [String] = ["Mmmmm.... are you okey?"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        if let tempItems = itemsObject as? [String]{
            items = tempItems
        } else{
            items = ["Mmmmm.... are you okey?"]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        if let tempItems = itemsObject as? [String]{
            items = tempItems
        } else{
            items = ["Mmmmm.... are you okey?"]
        }
        table.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//            items.remove(at: indexPath.row)
//            table.reloadData()
//            UserDefaults.standard.set(items, forKey: "items")
//        }
//    }
    
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
            
            let archiveTitle = NSLocalizedString("Archive", comment: "Archive Item")
            let archiveAction = UITableViewRowAction(style: .normal,
                                                     title: archiveTitle) {_,_ in
                                                        var archive: [String] = UserDefaults.standard.object(forKey: "archive") as? [String] ?? []
                                                        archive.append(self.items[indexPath.row])
                                                        self.items.remove(at: indexPath.row)
                                                        self.table.reloadData()
                                                        UserDefaults.standard.set(self.items, forKey: "items")
                                                        UserDefaults.standard.set(archive, forKey: "archive")
            }
//            favoriteAction.backgroundColor = .blue
            return [deleteAction, archiveAction]
    }
    
}

