//
//  FinsihView.swift
//  iQuiz
//
//  Created by Sarthak Turkhia on 11/17/18.
//  Copyright © 2018 Sarthak Turkhia. All rights reserved.
//

import UIKit

class FinsihView: UIViewController {

    @IBOutlet weak var finalMessage: UILabel!
    @IBOutlet weak var Score: UILabel!
    var score: Int = 0
    var questionCount: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(score == 0){
            finalMessage.text = "Maybe Next Time!"
            finalMessage.textColor = UIColor.red
        }
        else if(score == questionCount){
            finalMessage.text = "Congratulations"
            finalMessage.textColor = UIColor.green
        }
            
        else{
           finalMessage.text = "You did Well"
        }
        Score.text = String(score)
        Score.text?.append(" on ")
        Score.text?.append(String(questionCount))
    }
    
    @IBAction func finishAction(_ sender: Any) {
        let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "mainTable") as! TableViewController
        let nav = UINavigationController(rootViewController: tableVC)
        self.present(nav, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
