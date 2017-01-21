import RealmSwift

class Project: Object {
   
    dynamic var title = ""
    dynamic var detail = ""
    let actions = List<Item>()
    
    static func create() -> Project {
        let project = Project()
        
        RLM.write {
            RLM.add(project)
        }
        return project
    }
    func delete() {
        RLM.write {
            RLM.delete(self)
        }
    }
    
}

class Item: Object {
    
    enum ItemType {
        case capture
        case nextAction
        case waitingFor
        case projectAction
        case somedayMaybe
        case reference
        
        init(int: Int) {
            switch int {
            case 0: self = .capture
            case 1: self = .nextAction
            case 2: self = .waitingFor
            case 3: self = .projectAction
            case 4: self = .somedayMaybe
            case 5: self = .reference
            default: fatalError()
            }
        }
        
        var int: Int {
            switch self {
            case .capture: return 0
            case .nextAction: return 1
            case .waitingFor: return 2
            case .projectAction: return 3
            case .somedayMaybe: return 4
            case .reference: return 5
            }
        }
    }
    
    dynamic var itemTypeInt: Int = 0
    var itemType: ItemType {
        get { return ItemType(int: itemTypeInt) }
        set {
            RLM.write {
                itemTypeInt = newValue.int
            }
        }
    }
    
    dynamic var detail = ""
    dynamic var link = ""
    dynamic var firstStep = ""
    dynamic var finishedCondition = ""
    dynamic var waitCondition = ""
    dynamic var reminderDate = Date()
    dynamic var information = ""
    
    static func create() -> Item {
        let item = Item()
        
        RLM.write {
            RLM.add(item)
        }
        return item
    }
    func delete() {
        RLM.write {
            RLM.delete(self)
        }
    }
//    override class func primaryKey() -> String? {
//        return "detail"
//    }
//    override class func indexedProperties() -> [String] {
//        return ["firstStep","finishedCondition"]
//    }
}
