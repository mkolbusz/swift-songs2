//
//  SongViewController.swift
//  lab01
//
//  Created by Użytkownik Gość on 12.10.2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//
import Foundation;
import UIKit

class SongViewController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var song: Song?
    var deleteIndex: NSIndexPath?
    
    @IBOutlet weak var artisTxtField: UITextField!
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var genreTxtField: UITextField!
    @IBOutlet weak var yearTxtField: UITextField!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    // MARK: Properties


    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.maximumValue = 5
        
        if let song = song {
            artisTxtField.text = song.artist
            titleTxtField.text = song.title
            genreTxtField.text = song.genre
            yearTxtField.text = String(song.year)
            ratingLabel.text = String(song.rating)
            stepper.value = Double(song.rating)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func changeStepperValue(sender: UIStepper) {
        rateLabel.text = String(Int(sender.value));
    }
    
    @IBAction func cancel(sender: AnyObject) {
        let isPresentingInAddSongMode = presentingViewController is UINavigationController
        if isPresentingInAddSongMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let title = titleTxtField.text ?? ""
            let artist = artisTxtField.text ?? ""
            let genre = genreTxtField.text ?? ""
            let year = Int(yearTxtField.text ?? "0")
            let rating = Int(rateLabel.text ?? "0")

            song = Song(title: title, artist: artist, genre: genre, year: year!, rating: rating!)
        }
        if deleteButton === sender {
            let sourceViewController = segue.destinationViewController as! SongTableViewController
            deleteIndex = sourceViewController.tableView.indexPathForSelectedRow
        }
    }
    

}

