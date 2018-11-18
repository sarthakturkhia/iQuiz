//
//  QuestionView.swift
//  iQuiz
//
//  Created by Sarthak Turkhia on 11/5/18.
//  Copyright © 2018 Sarthak Turkhia. All rights reserved.
//

import UIKit

class QuestionView: UIViewController, UITableViewDelegate {
    var topic: String?
    
    let btn1 = UIButton(type: .roundedRect)
    let btn2 = UIButton(type: .roundedRect)
    let btn3 = UIButton(type: .roundedRect)
    let btn4 = UIButton(type: .roundedRect)
    var currentCategory: String = categories[currentIndex]
    var i : Int = 0
    var questions: [String]?
    var answers: [String]?
    var selected: String = "-1"
    var score = 0
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var btnStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCategory = categories[currentIndex]
        NavBar.title = currentCategory
        questions = questionBank[currentCategory]
//        print("check " + String(i))
//        print(questions)
        TestLabel.text = questions?[i]
        answers = (answerBank[currentCategory])![i]
        setupButtons()
        
        if(i != 0){
            backButton.isEnabled = false
        }
        
        btn1.addTarget(self, action: #selector(btn1Pressed), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(btn2Pressed), for: .touchUpInside)
        btn3.addTarget(self, action: #selector(btn3Pressed), for: .touchUpInside)
        btn4.addTarget(self, action: #selector(btn4Pressed), for: .touchUpInside)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        let tableVC = self.storyboard?.instantiateViewController(withIdentifier: "mainTable") as! TableViewController
        let nav = UINavigationController(rootViewController: tableVC)
        self.present(nav, animated: true, completion: nil)
        
       
    }
    
    func setupButtons(){
        let btns = [self.btn1, self.btn2, self.btn3, self.btn4]
        var n = 0
        for btn in btns as [UIButton] {
            btn.setTitleColor(UIColor.lightGray, for: .normal)
           btn.setTitle(answers![n], for: .normal)
            n = n + 1
            self.btnStack.addArrangedSubview(btn)
        }
        
    }
    
    @IBAction func nextClick(_ sender: Any) {
        if self.selected == "-1" {
            let error = UIAlertController(title: "No answer Selected", message: "Please Select an Answer before clicking next.", preferredStyle: .alert)
            error.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ))
            self.present(error, animated: true, completion: nil)
        }
        else{
            
            let answerVC = self.storyboard?.instantiateViewController(withIdentifier: "answer") as! AnswerView
            let tempAns = answer[currentCategory]![i]
            answerVC.answer = answers![(Int(tempAns)!) - 1]
            answerVC.questionCount = (questions?.count)!
            if(selected == answer[currentCategory]![i]){
                answerVC.correctAnswer = true
                answerVC.score = self.score + 1
            }
            else{
                answerVC.correctAnswer = false
                answerVC.score = self.score
            }
            answerVC.i = self.i 
            self.present(answerVC, animated: true, completion: nil)
        }
    }
    
   
    
    @objc func btn1Pressed() {
        self.selected = "1"
        self.setupButtons()
        self.btn1.setTitleColor(UIColor.black, for: .normal)
    }
    
    @objc func btn2Pressed() {
        self.selected = "2"
        self.setupButtons()
        self.btn2.setTitleColor(UIColor.black, for: .normal)
    }
    
    @objc func btn3Pressed() {
        self.selected = "3"
        self.setupButtons()
        self.btn3.setTitleColor(UIColor.black, for: .normal)
    }
    
    @objc func btn4Pressed() {
        self.selected = "4"
        self.setupButtons()
        self.btn4.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBOutlet weak var NavBar: UINavigationItem!
    
    @IBOutlet weak var TestLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
