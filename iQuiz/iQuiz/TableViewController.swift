//
//  TableViewController.swift
//  iQuiz
//
//  Created by Sarthak Turkhia on 10/29/18.
//  Copyright © 2018 Sarthak Turkhia. All rights reserved.
//

import UIKit

var currentIndex: Int = 0

var categories: [String] = ["Marvel", "DC", "Science"]
var questionBank : [String: [String]] = ["Marvel":["What is the name of the actor that plays Iron Man in the Avengers Movie?", "Which marvel superhero's skeleton is made out of ademantium?"],
                                         "DC":["What is the name of Batman's butler?", "What is superman's home planet called?"],
                                         "Science":["Which one of these is not a sub-atomic particle?", "The speed of sound is fastest in?"]]
var answerBank : [String: [[String]]] = [
    "Marvel":[["Chris Evans", "Chris Hemsworth", "Mark Ruffalo", "Robert Downey Jr"], ["Superman", "Iron Man", "Wolverine", "Thor"]],
    "DC":[["Alfred", "Algor", "Al pacino", "Allan"], ["Korton", "Krypton", "Kiltron", "Earth"]],
    "Science": [["Proton", "Electron", "Positron", "Hydron"], ["Liquid", "Gas", "Vaccum", "Solid"]]]

var answer: [String: [String]] = ["Marvel" : ["4", "3"],
                                  "DC" : ["1", "2"],
                                  "Science" : ["4", "4"]]




class TableViewController: UITableViewController {
    var images: [String] = ["Marvel", "DC", "Science"]
    var desc: [String] = ["Questions from the Marvel Universe", "Questions from the DC universe", "Science questions and Facts"]
    var url : String = ""
   // var defaultURL: String = "http://www.json-generator.com/api/json/get/cgenUKMUGG?indent=2"
    var defaultUrl : String = ""
    override func viewDidLoad() {
        defaultUrl = "http://tednewardsandbox.site44.com/questions.json"
        checkConnection()
        self.tableView.rowHeight = 100
        super.viewDidLoad()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(checkConnection), for: .valueChanged)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func checkConnection() {
        if Reachability.isConnectedToNetwork() == true{
            print("Internet is connected")
            if (UserDefaults.standard.string(forKey: "url") != "" || UserDefaults.standard.string(forKey: "url") != nil){
                if UserDefaults.standard.string(forKey: "url") != nil{
                      url = UserDefaults.standard.string(forKey: "url")!
                }
                getJson(url)
            }
            self.tableView.refreshControl?.endRefreshing()
        }
        else{
            print("Internet is NOT connected")
            let alertControl = UIAlertController(title: "Error", message: "Internet Connection Failed", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertControl.addAction(cancelAction)
            self.present(alertControl, animated: true)
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    func getJson(_ url: String) {
        guard let url = URL(string: url) else {
            print("bad URL")
            return
        }
        print("Searching: \(url)")
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "Download failed")
                return
            }
            do {
                let myjson = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonArray = myjson as? [[String: Any]]
                    else {
                    print("got nothing")
                    return
                    }
                
                var currentCat: String?
                categories.removeAll()
                self.desc.removeAll()
                questionBank.removeAll()
                answerBank.removeAll()
                answer.removeAll()
               // var questionDict: [String: [NSArray]] = [:]
                
                
                for json in jsonArray{
                    var questArray: [NSArray] = []
                    currentCat = json["title"] as? String
                    categories.append(currentCat!)
                    self.desc.append(json["desc"] as! String)
                    guard let question = json["questions"] as? NSArray else {
                        print("No questions in Category")
                        return
                    }
                    questArray.append(question)
                    for question in questArray{
                        var questText: [String] = []
                        var allAnswers: [[String]] = []
                        var correctAnswers: [String] = []
                        for elem in question{
                            let tempDict: [String: Any] = elem as! [String : Any]
                            let ans = tempDict["answers"]! as? [String]
                            let correctAnswer = tempDict["answer"] as? String
                            allAnswers.append(ans!)
                            let que = tempDict["text"] as? String
                            questText.append(que!)
                            correctAnswers.append(correctAnswer!)
                        }
                        // replace data models with exisisting data structures
                        questionBank[currentCat!] = questText
//                        print(questionBank)
                        answerBank[currentCat!] = allAnswers
//                        print(answerBank)
                        answer[currentCat!] = correctAnswers
//                        print(answer)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch{
                print("Error: Download Failed")
                let alertControl = UIAlertController(title: "Error", message: "Download Failed", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertControl.addAction(cancelAction)
                self.present(alertControl, animated: true)
            }
        }
        task.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as! TableCellTableViewCell
        
        // Configure the cell...
        cell.title.text = categories[indexPath.row]
        cell.desc.text = self.desc[indexPath.row]
        cell.imageView?.image = UIImage(named: self.images[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        currentIndex = (tableView.indexPathForSelectedRow?.row)!
    }
    
    
 
    @IBAction func SettingsPressed(_ sender: UIBarButtonItem) {
        let alertControl = UIAlertController(title: "Settings", message: "Enter your custom data URL here", preferredStyle: .alert)
        var textField = UITextField()
        alertControl.addTextField(configurationHandler: {{ (theTextField : UITextField) in
            textField = theTextField
            textField.placeholder = "http://tednewardsandbox.site44.com/questions.json"
            }}())
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "Check Now", style: .default, handler: {
            (action : UIAlertAction) in
            if textField.text != "" && textField.text != nil {
                UserDefaults.standard.set(textField.text!, forKey: "url")
                self.checkConnection()
            }
        })
        alertControl.addAction(okAction)
        alertControl.addAction(cancelAction)
        self.present(alertControl, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
