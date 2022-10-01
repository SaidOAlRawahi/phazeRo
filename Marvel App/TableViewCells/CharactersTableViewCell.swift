//
//  CharactersTableViewCell.swift
//  Marvel App
//
//  Created by Said Al Rawahi
//

import UIKit
//class for modelling the cells of characters
class CharactersTableViewCell: UITableViewCell {
    
    //a string to save the link of the wiki of the character
    var urlString: String = ""
    
    //outlets for the name, id and image of the character
    @IBOutlet weak var charImage: UIImageView!
    @IBOutlet weak var charName: UILabel!
    @IBOutlet weak var charID: UILabel!
    
    //action that will be performed by the button
    @IBAction func openURL(_ sender: Any) {
        //open the url
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
}
