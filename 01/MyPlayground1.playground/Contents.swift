//: Playground - noun: a place where people can play

import UIKit

class Vocabulary
{
    let date = NSDate()
    var name: String = ""
    var text: String = ""
    var tag : [String] = []
    var tagString : String = ""
    
    func fullDescription() -> String
    {
        if(!tag.isEmpty)
        {
            for tags in tag
            {
            tagString = tagString + "[" + tags + "]" + " "
            }
        }
        if(!name.isEmpty)
        {
            name = name + "\n"
        }
        if(!text.isEmpty)
        {
            text = text + "\n"
        }
        
        return String(date) + "\n" + name + text + tagString
    }
    
}


var v1 = Vocabulary()
v1.name = "Name one"
v1.text = "Text one"
v1.tag = ["first tag", "second tag", "third tag"]
v1.fullDescription()


var v2 = Vocabulary()
v2.name = "Name two"
v2.tag = ["first tag","second tag"]
v2.fullDescription()

var v3 = Vocabulary()
v3.fullDescription()

var v4 = Vocabulary()
v4.text = "Text four"
v4.fullDescription()

/********************************Додаткове завдання*********************************/
/***** 3 *****/
var entry = v1.fullDescription()
print(entry)
//////////////


/***** 2 ******/ //для днів на цьому тижні та наприклад за місяць аналогічний алгоритм
var dateToday = NSDate()
let TimeOfMsg = Int64(v1.date.timeIntervalSince1970)
let currentTime = Int64(dateToday.timeIntervalSince1970)
if(currentTime - TimeOfMsg > 86400)  //86400 - кількість секунд в 1 дні
{
    print("Yesterday!")
}
else
{
    print(NSDate()) //виведе 
}
///////////////

/****** 1 ******/ // буде виводити фолс тому що весь плейграунд компілюється одночасно і дати всі однакові/але алгоритм думаю що такий/
var array = [v1,v2,v3,v4]
array.sort({$0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970})
////////////////


