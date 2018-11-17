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
    var currentCategory = categories[currentIndex ?? 0]
    var i : Int = 0
    var questions: [String]?
    var answers: [String]?
    
    
    @IBOutlet weak var btnStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavBar.title = currentCategory
        questions = questionBank[currentCategory]
        TestLabel.text = questions?[i]
        answers = (answerBank[currentCategory])![i]
        
        
        
        // Do any additional setup after loading the view.
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
