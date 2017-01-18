import RealmSwift

class Item: Object {
    
    dynamic var detail: String = ""
    dynamic var firstStep: String = ""
    dynamic var finishedCondition: String = ""
    
//    override class func primaryKey() -> String? {
//        return "detail"
//    }
//    override class func indexedProperties() -> [String] {
//        return ["firstStep","finishedCondition"]
//    }
    
    static func create() -> Item {
        let item = Item()
        
        RLM.write {
            item.detail = "Insert detail here"
            item.firstStep = "Insert first step here"
            item.finishedCondition = "Insert finished condition here"
            RLM.add(item)
        }
        return item
    }
    func delete() {
        RLM.write {
            RLM.delete(self)
        }
    }
}

class CapturedNote: Object {
    
    dynamic var note: String = ""
    
    static func create() -> CapturedNote {
        let note = CapturedNote()
        
        RLM.write {
            note.note = "Hi"
            RLM.add(note)
        }
        
        return note
    }
    func delete() {
        RLM.write {
            RLM.delete(self)
        }
    }
}
