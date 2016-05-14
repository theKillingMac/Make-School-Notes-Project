//
//  NotesViewController.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Updated by Chris Orcutt on 09/07/2015.
//  Copyright © 2015 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class NotesViewController: UITableViewController {
 
    var notes: Results<Note>! {
        didSet {
            // Whenever notes update, update the table view
            tableView?.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        
        let myNote = Note()
        myNote.title   = "Super Simple Test Note"
        myNote.content = "A long piece of content"
        
        do {
            // Before you can add it to Realm you must first grab the default Realm.
            let realm = try Realm()
            
            // All changes to an object (addition, modification and deletion)
            // must be done within a write transaction/closure.
            try realm.write() {
                // Add your new note to Realm
                realm.add(myNote)
            }
            
            //update our notes variable to contain all of the same data as our Realm database.
            notes = realm.objects(Note)
            
        } catch {
            print("handle error")
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }

    }

extension NotesViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //This line makes a UITableViewCell with a unique identifier of "NoteCell".
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as! NoteTableViewCell
        
        let row = indexPath.row
        let note = notes[row] as Note
        cell.note = note
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if notes isn't empty, numberOfRowsInSection will return notes.count; otherwise it will return 0.
        return notes?.count ?? 0
        
        //The above line is the same as:
        // if let notes = notes {
        //     return Int(notes.count)
        // } else {
        //     return 0
        // }

    }
    
}