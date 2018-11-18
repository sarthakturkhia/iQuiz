//
//  AnswerView.swift
//  iQuiz
//
//  Created by Sarthak Turkhia on 11/6/18.
//  Copyright © 2018 Sarthak Turkhia. All rights reserved.
//

import UIKit

class AnswerView: UIViewController {
    
    var correctAnswer: Bool! = false
    var answer: String?
    var i: Int = 1
    var score: Int = 0
    var questionCount: Int = 1
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var correctAnswerLAbel: UILabel!
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(correctAnswer){
            answerLabel.text = "Correct"
            answerLabel.textColor = UIColor.green
        }
        else{
            answerLabel.text = "Incorrect"
            answerLabel.textColor = UIColor.red
        }
        correctAnswerLAbel.text = self.answer!
        ScoreLabel.text?.append(String(self.score))
    }
    

    @IBAction func NextClick(_ sender: Any) {
        print(questionCount)
        print(i)
        if (i + 1) < questionCount{
             let questionVC = self.storyboard?.instantiateViewController(withIdentifier: "QuestionView") as! QuestionView
            questionVC.i = self.i + 1
            questionVC.score = self.score
            self.present(questionVC, animated: true, completion: nil)
            }
        else{
             let finishVC = self.storyboard?.instantiateViewController(withIdentifier: "finishView") as! FinsihView
            finishVC.score = self.score
            finishVC.questionCount = self.questionCount
            self.present(finishVC, animated: true, completion: nil)
        }
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
