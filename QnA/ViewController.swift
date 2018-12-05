//
//  ViewController.swift
//  QnA
//
//  Created by CHEN WESLEY on 2018/11/15.
//  Copyright © 2018 CHEN WESLEY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var qImage: UIImageView!
    
    var item = 1
    var point = 0
    var qnAs = [Qna]()
    var choiceDict = [String:[String]]()
    var answerDict = [String:String]()
    var questionDict = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingQnA()
    }
    func loadingQnA(){
        item = 1
        point = 0
        qnAs = [Qna]()
        choiceDict = [String:[String]]()
        answerDict = [String:String]()
        questionDict = [String:String]()
        itemLbl.text = "題目 : \(String(item))"
        //Question
        questionDict["1"] = "世界上最冷的城市"
        questionDict["2"] = "世界上最熱的城市"
        questionDict["3"] = "世界上人口最多的城市"
        questionDict["4"] = "世界上近視率第一的國家"
        questionDict["5"] = "世界禿頭男哪邊最多"
        questionDict["6"] = "世界最多羊的國家"
        questionDict["7"] = "世界接待最多觀光客的國家"
        questionDict["8"] = "世界產最多椰子的國家"
        questionDict["9"] = "世界名字最長的首都"
        questionDict["10"] = "世界上唯一沒有流浪狗的國家"

        //choice
        choiceDict["1"] = ["俄羅斯-維爾霍揚斯克","加拿大-斯納格育空河","美國-阿拉斯加"]
        choiceDict["2"] = ["泰國-曼谷","美國-死亡谷","利比亞-阿濟濟耶"]
        choiceDict["3"] = ["印度-新德里","中國-上海","日本-東京"]
        choiceDict["4"] = ["中國","台灣","韓國"]
        choiceDict["5"] = ["西班牙","德國","捷克"]
        choiceDict["6"] = ["智利","澳洲","紐西蘭"]
        choiceDict["7"] = ["法國","泰國","日本"]
        choiceDict["8"] = ["緬甸","菲律賓","泰國"]
        choiceDict["9"] = ["曼谷","金邊","阿曼"]
        choiceDict["10"] = ["荷蘭","德國","加拿大"]

        //Answer
        answerDict["1"] = "俄羅斯-維爾霍揚斯克"
        answerDict["2"] = "利比亞-阿濟濟耶"
        answerDict["3"] = "日本-東京"
        answerDict["4"] = "台灣"
        answerDict["5"] = "捷克"
        answerDict["6"] = "澳洲"
        answerDict["7"] = "法國"
        answerDict["8"] = "菲律賓"
        answerDict["9"] = "曼谷"
        answerDict["10"] = "荷蘭"

        for (q,a) in answerDict{
            qnAs.append(Qna(question: questionDict[q]!, choice: choiceDict[q]!.shuffled(), answer: a,pic: q))
        }
        qnAs = qnAs.shuffled()
        showChoiceButtomText(index:item - 1)
        questionLbl.text  = qnAs[item - 1].question
        
        pointLbl.text = "\(String(point * 10))"
        
        self.qImage.image = UIImage(named:qnAs[item - 1].pic)!
       
    }
    
    @IBAction func reset(_ sender: UIButton) {
        loadingQnA()
    }
    
    @IBAction func answered(_ sender: UIButton) {
        var answer = "0000"
        let qns = 10
        let pressed  = sender.titleLabel?.text
        
        print("qnAs.count: \(qns)")
        print("item: \(item)")
    
        answer = qnAs[item - 1].answer
        print("pressed \(pressed ?? "") : 、\(answer)")

        if pressed == answer
        {
            point = point + 1
        }
    
        item = item + 1

        if qns >= item
        {
            let picName = qnAs[item - 1].pic
            print("picName: \(picName)")
            self.qImage.image = UIImage(named:picName)!

            questionLbl.text = qnAs[item - 1].question
            showChoiceButtomText(index:item - 1)

        }
        else
        {
            item = 10
            questionLbl.text = "答題完成"
            answerButtons[0].setTitle("", for: .normal)
            answerButtons[1].setTitle("", for: .normal)
            answerButtons[2].setTitle("", for: .normal)
            self.qImage.image = UIImage(named:"fin")!
            let score = String(point * 10)
            let msg = "恭喜你的對了 \(score)"
            // Create the alert controller
            let alertController = UIAlertController(title: "答題完成", message: msg , preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "再次挑戰", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                self.loadingQnA()
            }
          
            // Add the actions
            alertController.addAction(okAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }

        itemLbl.text = "題目 : \(String(item))"
        pointLbl.text = "\(String(point * 10))"


    }
    func showChoiceButtomText(index:Int){
        answerButtons[0].setTitle(qnAs[index].choice[0], for: .normal)
        answerButtons[1].setTitle(qnAs[index].choice[1], for: .normal)
        answerButtons[2].setTitle(qnAs[index].choice[2], for: .normal)
    }
    
}

