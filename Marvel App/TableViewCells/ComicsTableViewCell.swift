//
//  ComicsTableViewCell.swift
//  Marvel App
//
//  Created by Said Al Rawahi
//

import UIKit
//class for modelling the cells of characters
class ComicsTableViewCell: UITableViewCell {
    
    //a string to save the link of the wiki of the comics
    var urlString: String = ""
    
    //outlets for the name and image of the comics
    @IBOutlet weak var comicPosterImage: UIImageView!
    @IBOutlet weak var comicName: UILabel!
    
    //action that will be performed by the button
    @IBAction func openURL(_ sender: Any) {
        //open the url
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}
