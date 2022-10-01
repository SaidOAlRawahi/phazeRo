//
//  DetailsViewController.swift
//  Marvel App
//
//  Created by Said Al Rawahiu
//

import UIKit

//the view controller that would display the the details and comics of the selected character, incliding the table view delegate and data source
class DetailedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // empty variables that would be set by the previous controller
    var charID: String = ""
    var charName: String = ""
    var charImgRef: String = ""
    
    var apiCall: String = ""// a variable that will be used for the api call
    
    //a variable that would be used to determine the selected item within the table
    var selectionIndex: Int = 0
    //an array that will store the characters data
    var comicsDataArr: [ComicsData] = []
    // variable that will be used to recognize if the data fetched from the API call is loaded
    var dataLoaded: Bool = false
    
    //outlets for the image and the title (character name)
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterIMG: UIImageView!
    //outlet for the comics table view
    @IBOutlet weak var comicsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiCall = "https://gateway.marvel.com/v1/public/characters/" + charID + "/comics?ts=1&apikey=b062c8055d46977cc4e8558e5c3d3469&hash=1fc9db70b9295c6c05e406e0173674c1"
        print(apiCall)
        
        //set the name and image to the label and image outlets
        characterName.text = charName
        characterIMG.loadFrom(URLAddress: charImgRef)
        
        // call the fetch function on the start of the view
        fetchCharacterData(url: apiCall)
        
        // a personal touch while loop to repeat the code once data is loaded. (not optimal, but to show how large issues can be solved by basic and solutions)
        while !dataLoaded{
            //setting the delegate and data source to the code within the class
            comicsTableView.delegate = self
            comicsTableView.dataSource = self
        }
    }
    
    func fetchCharacterData(url: String){
        
        //use a completion handler to optimize the app, determine respone, fetch data and get errors
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self] data, response, error in
            guard let data = data, error == nil else {
                print("An error occured and can't get data")
                return
            }
            
            // a variable to parse the JSON results into it
            var results: ComicsResponse
            do{
                //try to decode the JSON data
                results = try JSONDecoder().decode(ComicsResponse.self, from: data)
            }
            catch{//decoding failed
                print("Error: ",String(describing: error))
                return
            }
            
            print(results.code)//code 200 means successful response
            
            //attemp variable to store temporary data
            var temp: ComicsData = ComicsData(comicName: "", comicImageRef: "", comicWikiRef: "")
            
            // for loop to go through the results array within the data in the API call Response
            for item in results.data.results{
                
                temp.comicName = item.title//get comic name/title
                
                //for loop to go through the array of urls
                for url in item.urls{
                    // if type is wiki get url and break the loop
                    if url.type == "detail" {
                        /*
                         IMPORTANT REMARK:
                         XCODE JSON DECODER HAS AN ISSUE IN DECODING THE THE URLS RETRIEVED FROM THE API CALL.
                         THEREFORE, DECODED URLS WILL BE DIFFERENT FROM THE ACTUAL ONES IN THE API CALL.
                         PROGRAMMATICALLY EVERYTHING IS CORRECT, UNLESS THERE IS SOMETHING I AM MISSING.
                         */
                        temp.comicWikiRef = url.url
                        print(url.url)
                        break
                    }
                }
                
                //get url of image and formate it in an understandable way to Marvel Servers
                let imageURL: String = item.thumbnail.path+"/standard_medium."+item.thumbnail.extension
                temp.comicImageRef = imageURL
                
                self.comicsDataArr.append(temp)//append the attempt variable.
            }
            
            dataLoaded = true//data is loaded
            
        })
        task.resume()
        
    }
    
    //a function to return the number of rows within the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //returning array length
        return comicsDataArr.count
    }
    
    //a function that returns a cell for each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // a variable to hold a single row of the CharacterDataArr
        let dataRow = comicsDataArr[indexPath.row]
        
        //configure the cell as the cell with the specified id as an object of comics table view cell
        let cell = comicsTableView.dequeueReusableCell(withIdentifier: "comicsCell", for: indexPath) as! ComicsTableViewCell
        
        //set the cell attributes to the data retrieved from the array
        cell.comicName.text = dataRow.comicName
        cell.urlString = dataRow.comicWikiRef
        
        //set the data using a loadFrom function in the Extentions swift file.
        cell.comicPosterImage.loadFrom(URLAddress: dataRow.comicImageRef)
        
        
        return cell
    }
    
    
}
