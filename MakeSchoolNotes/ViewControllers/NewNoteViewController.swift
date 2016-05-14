//
//  NewNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Parth Shah on 15/05/16.
//  Copyright © 2016 Chris Orcutt. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var currentNote: Note?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        currentNote = Note()
        currentNote!.title   = "Super Simple New Note"
        currentNote!.content = "Yet More Content"
        
    }
    

}
