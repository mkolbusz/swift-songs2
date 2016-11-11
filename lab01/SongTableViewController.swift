//
//  SongTableViewController.swift
//  lab01
//
//  Created by macdt on 07/11/2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSongs()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadSongs() {
        let plistPath = NSBundle.mainBundle().pathForResource("songs", ofType: "plist")
        let list:NSArray = NSArray(contentsOfFile: plistPath!)!
        
        for song:NSDictionary in (list as NSArray as! [NSDictionary]) {
            let newSong = Song(
                title: song.valueForKey("title") as! String,
                artist: song.valueForKey("artist") as! String,
                genre: song.valueForKey("genre") as! String,
                year: song.valueForKey("date") as! Int,
                rating: song.valueForKey("rating") as! Int
            )
            
            songs.append(newSong!)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songs.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "SongTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! SongTableViewCell
        let song = songs[indexPath.row]

        cell.artistLabel.text = song.artist
        cell.titleLabel.text = song.title

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetails" {
            
            let songDetailViewController = segue.destinationViewController as! SongViewController
            if let selectedSongCell = sender as? SongTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedSongCell)!
                let selectedSong = songs[indexPath.row]
                songDetailViewController.song = selectedSong
            }
        }
        else if segue.identifier == "AddItem" {
            print("Adding new song")
        }
    }
 
    
    @IBAction func unwindToSongList(sender: UIStoryboardSegue) {
        if let sourceController = sender.sourceViewController as? SongViewController, song = sourceController.song, deleteIndex:NSIndexPath? = sourceController.deleteIndex {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                if (deleteIndex != nil) {
                    songs.removeAtIndex((deleteIndex?.row)!)
                    tableView.deleteRowsAtIndexPaths([deleteIndex!], withRowAnimation: .Fade)
                    
                }
                else {
                    songs[selectedIndexPath.row] = song
                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                }
                
            }
            else {
                let newIndexPath = NSIndexPath(forRow: songs.count, inSection: 0)
                songs.append(song)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            saveSongs();
        }
    }
    
    
    func saveSongs() {
        print("Save songs")
        let plistPath = NSBundle.mainBundle().pathForResource("songs", ofType: "plist")!
        print(plistPath)
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let albumsDocPath = documentsPath.stringByAppendingString("/songs.plist")
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(albumsDocPath) {
            print("copy")
            try? fileManager.copyItemAtPath(plistPath, toPath: albumsDocPath)
        }
        
        let albums = Song.convertToNSMutableArray(songs)
        print(albumsDocPath)
        
        albums.writeToFile(plistPath, atomically: true)
    }

}
