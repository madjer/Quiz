//
//  QuizModel.swift
//  Quiz
//
//  Created by madjer bezerra on 4/27/16.
//  Copyright © 2016 madjer bezerra. All rights reserved.
//

import Foundation
import UIKit

class Question{
    var strQuestion : String!
    var imgQuestion : UIImage!
    var answers : [Answer]!
    init(question:String, strImagemFileName: String, answers:[Answer]){
        self.strQuestion = question
        self.imgQuestion = UIImage(named: strImagemFileName)
        self.answers = answers
    }
}

class Answer {
    var strAnswer : String!
    var isCorrect : Bool!
    init(answer: String, isCorrect: Bool){
        self.strAnswer = answer
        self.isCorrect = isCorrect
    }
}