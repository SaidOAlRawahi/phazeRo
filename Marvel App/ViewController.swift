//
//  ViewController.swift
//  Marvel App
//
//  Created by Said Al Rawahi
//

import UIKit

//the view controller that would display the charecters, incliding the table view delegate and data source
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    //the url that will retrieve the .JSON file from Marvel Servers (API Call)
    let apiCall: String = "https://gateway.marvel.com/v1/public/characters?ts=1&apikey=b062c8055d46977cc4e8558e5c3d3469&hash=1fc9db70b9295c6c05e406e0173674c1"
    
    //a variable that would be used to determine the selected item within the table
    var selectionIndex: Int = 0
    //an array that will store the characters data
    var charactersDataArr: [CharacterData] = []
    // variable that will be used to recognize if the data fetched from the API call is loaded
    var dataLoaded: Bool = false
    
    //outlet for the charecters table
    @IBOutlet weak var characterTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the fetch function on the start of the view
        fetchCharacterData(url: apiCall)
        
        // a personal touch while loop to repeat the code once data is loaded. (not optimal, but to show how large issues can be solved by basic and solutions)
        while !dataLoaded{
            //setting the delegate and data source to the code within the class
            characterTableView.delegate = self
            characterTableView.dataSource = self
        }
    }
    
    // a function that will transfer the API call response to a swift recognized format
    func fetchCharacterData(url: String){
        
        //use a completion handler to optimize the app, determine respone, fetch data and get errors
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self] data, response, error in
            guard let data = data, error == nil else {
                print("An error occured and can't get data")
                return
            }
            
            // a variable to parse the JSON results into it
            var results: CharacterResponse
            do{
                //try to decode the JSON data
                results = try JSONDecoder().decode(CharacterResponse.self, from: data)
            }
            catch{//decoding failed
                print("Error: ",String(describing: error))
                return
            }
            
            print(results.code)//code 200 means successful response
            
            //attemp variable to store temporary data
            var temp: CharacterData = CharacterData(characterID: 0, characterName: "", characterImageRef: "", characterWikiRef: "")
            
            // for loop to go through the results array within the data in the API call Response
            for item in results.data.results{
                
                temp.characterName = item.name//get character name
                temp.characterID = item.id//get character ID
                
                //for loop to go through the array of urls
                for url in item.urls{
                    // if type is wiki get url and break the loop
                    if url.type == "wiki" {
                        /*
                         IMPORTANT REMARK:
                         XCODE JSON DECODER HAS AN ISSUE IN DECODING THE THE URLS RETRIEVED FROM THE API CALL.
                         THEREFORE, DECODED URLS WILL BE DIFFERENT FROM THE ACTUAL ONES IN THE API CALL.
                         PROGRAMMATICALLY EVERYTHING IS CORRECT, UNLESS THERE IS SOMETHING I AM MISSING.
                         */
                        temp.characterWikiRef = url.url
                        print(url.url)
                        break
                    }
                }
                //get url of image and formate it in an understandable way to Marvel Servers
                let imageURL: String = item.thumbnail.path+"/standard_medium."+item.thumbnail.extension
                temp.characterImageRef = imageURL
                
                self.charactersDataArr.append(temp)//append the attempt variable.
            }
            dataLoaded = true//data is loaded
            
        })
        task.resume()
        
    }
    
    
    
    
    //a function to return the number of rows within the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //returning array length
        return charactersDataArr.count
    }
    
    //a function that returns a cell for each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // a variable to hold a single row of the CharacterDataArr
        let dataRow = charactersDataArr[indexPath.row]
        
        //configure the cell as the cell with the specified id as an object of characters table view cell
        let cell = characterTableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharactersTableViewCell
        
        //set the cell attributes to the data retrieved from the array
        cell.charID.text = "ID: " + String(dataRow.characterID)//set the id
        cell.charName.text = dataRow.characterName//set the name
        cell.urlString = dataRow.characterWikiRef//set the url for the wiki button
        
        //set the data using a loadFrom function in the Extentions swift file.
        cell.charImage.loadFrom(URLAddress: dataRow.characterImageRef)
        
        return cell
    }
    
    //a function that would let us know which row had been tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //set the selection index to the row number
        self.selectionIndex = indexPath.row
        
        //activiate segue to the next view
        performSegue(withIdentifier: "charactersToDetailsSeg", sender: self)
    }
    
    //a function that would allow us to send details to the next view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //setting up the destination
        let destination = segue.destination as! DetailedViewController
        
        //save the character id, name and image
        destination.charID = String(charactersDataArr[selectionIndex].characterID)
        destination.charName = charactersDataArr[selectionIndex].characterName
        destination.charImgRef = charactersDataArr[selectionIndex].characterImageRef
        
    }
    
}


