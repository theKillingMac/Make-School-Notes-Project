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
        tableView.dataSource = self
        tableView.delegate = self
        
        do {
            let realm = try Realm()
            notes = realm.objects(Note).sorted("modificationDate", ascending: false)
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
    
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        
        if let identifier = segue.identifier {
            do {
                let realm = try Realm()
                
                switch identifier {
                    
                    case "Save":
                        // Grab a copy of NewNoteViewController to access the varibale currentNote
                        let source = segue.sourceViewController as! NewNoteViewController
                        
                        try realm.write() {
                            realm.add(source.currentNote!)
                        }
                        
                    default:
                        print("No one loves \(identifier)")
                    
                }
                
                // Realm allows for advanced sorting and query functionality for its stored objects. 
                notes = realm.objects(Note).sorted("modificationDate", ascending: false)
            } catch {
                print("handle error")
              }
        }
        
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //1
        let selectedNote = notes[indexPath.row]
        
        // 2
        //self.performSegueWithIdentifier("ShowExistingNote", sender: self)
    }
    
    // 3
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Swipe left to delete, then deleting the note from realm too
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let note = notes[indexPath.row] as Object
            
            do {
                let realm = try Realm()
                try realm.write() {
                    realm.delete(note)
                }
                
                notes = realm.objects(Note).sorted("modificationDate", ascending: false)
            } catch {
                print("handle error")
            }
        }
    }
    
}
    
