//
//  ViewController.swift
//  Quiz
//
//  Created by madjer bezerra on 4/27/16.
//  Copyright © 2016 madjer bezerra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quizQuestion: UILabel!
    @IBOutlet weak var quizImagem: UIImageView!
    @IBOutlet weak var quizBtn1: UIButton!
    @IBOutlet weak var quizBtn2: UIButton!
    @IBOutlet weak var quizBtn3: UIButton!
    @IBOutlet weak var quizBtn4: UIButton!
    
    
    @IBOutlet weak var viewFeedback: UIView!
    @IBOutlet weak var labelFeedback: UILabel!
    @IBOutlet weak var btnFeedback: UIButton!
    
    var questions : [Question]!
    var currentQuestion = 0
    var grade = 0.0
    var quizEnded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let q0answer0 = Answer(answer:"Alemã", isCorrect:false)
        let q0answer1 = Answer(answer:"Austríaca", isCorrect:true)
        let q0answer2 = Answer(answer:"Francesa", isCorrect:false)
        let q0answer3 = Answer(answer:"Brasileira", isCorrect:false)
        let question0 = Question(question: "Qual a nacionalidade do Hitler?", strImagemFileName: "hitler", answers: [q0answer0,q0answer1,q0answer2,q0answer3])
        
        let q1answer0 = Answer(answer:"Eva Braun", isCorrect:true)
        let q1answer1 = Answer(answer:"Ines Brasil", isCorrect:false)
        let q1answer2 = Answer(answer:"Alois", isCorrect:false)
        let q1answer3 = Answer(answer:"Klara", isCorrect:false)
        let question1 = Question(question: "Qual o nome da esposa do Hitler?", strImagemFileName: "esposa_hitler", answers: [q1answer0,q1answer1,q1answer2,q1answer3])
        
        let q2answer0 = Answer(answer:"No primeira guerra", isCorrect:false)
        let q2answer1 = Answer(answer:"Na cadeia", isCorrect:true)
        let q2answer2 = Answer(answer:"Em casa antes da guerra", isCorrect:false)
        let q2answer3 = Answer(answer:"Em caucaia", isCorrect:false)
        let question2 = Question(question: "Onde hitler escreveu o livro Mein Kampf?", strImagemFileName: "Se", answers: [q2answer0,q2answer1,q2answer2,q2answer3])
        
        let q3answer0 = Answer(answer:"1912", isCorrect:false)
        let q3answer1 = Answer(answer:"1913", isCorrect:false)
        let q3answer2 = Answer(answer:"1899", isCorrect:false)
        let q3answer3 = Answer(answer:"1889", isCorrect:true)
        let question3 = Question(question: "Em que ano nasceu Hitler?", strImagemFileName: "Eu", answers: [q3answer0,q3answer1,q3answer2,q3answer3])

        questions = [question0, question1, question2, question3]
        startQuiz()
        
    }
    
    func startQuiz() {
        questions.shuffle()
        for(var i = 0; i < questions.count; i++) {
            questions[i].answers.shuffle()
        }
        quizEnded = false
        grade = 0.0
        currentQuestion = 0
        showQuestion(0)
    }
    
    func showQuestion(questionId : Int) {
        quizBtn1.enabled = true
        quizBtn2.enabled = true
        quizBtn3.enabled = true
        quizBtn4.enabled = true
        quizQuestion.text = questions[questionId].strQuestion
        quizImagem.image = questions[questionId].imgQuestion
        quizBtn1.setTitle(questions[questionId].answers[0].strAnswer, forState: UIControlState.Normal)
        quizBtn2.setTitle(questions[questionId].answers[1].strAnswer, forState: UIControlState.Normal)
        quizBtn3.setTitle(questions[questionId].answers[2].strAnswer, forState: UIControlState.Normal)
        quizBtn4.setTitle(questions[questionId].answers[3].strAnswer, forState: UIControlState.Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chooseAnswer1(sender: AnyObject) {
        selectAnswer(0)
    }
    @IBAction func chooseAnswer2(sender: AnyObject) {
        selectAnswer(1)
    }
    @IBAction func chooseAnswer3(sender: AnyObject) {
        selectAnswer(2)
    }
    @IBAction func chooseAnswer4(sender: AnyObject) {
        selectAnswer(3)
    }
    
    func selectAnswer (answerId: Int) {
        quizBtn1.enabled = false
        quizBtn2.enabled = false
        quizBtn3.enabled = false
        quizBtn4.enabled = false
        
        viewFeedback.hidden = false
        var answer : Answer = questions[currentQuestion].answers[answerId]
        if(answer.isCorrect == true) {
            grade = grade + 1.0
            labelFeedback.text = "Correto!"
        } else {
            labelFeedback.text = "Errado!"
        }
        if (currentQuestion < questions.count-1) {
            btnFeedback.setTitle("Proxima", forState: UIControlState.Normal)
        } else {
            btnFeedback.setTitle("Ver nota", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func feedbackBtnAction(sender: AnyObject) {
        viewFeedback.hidden = true
        if (quizEnded) {
            startQuiz()
        } else {
            nextQuestion();
        }
    }
    func nextQuestion (){
        currentQuestion++
        if(currentQuestion < questions.count) {
            showQuestion(currentQuestion)
        } else {
            endQuiz()
        }
    }
    func endQuiz(){
        grade = grade/Double(questions.count)*100.0
        quizEnded = true
        viewFeedback.hidden = false;
        labelFeedback.text = "Sua nota: \(grade)"
        btnFeedback.setTitle("Refazer", forState: UIControlState.Normal)
    }
}

