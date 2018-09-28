import Foundation

public enum LinkedListNode<Value: Equatable>: Equatable {
    indirect case value(Value, next: LinkedListNode)
    case empty
    
    public var count: Int {
        switch self {
        case .empty:
            return 0
        case .value(_, let next):
            return next.count + 1
        }
    }
    
    var value: Value? {
        if case .value(let element, _) = self {
            return element
        } else { return nil }
    }
    
    var next: LinkedListNode {
        get {
            switch self {
            case .value(_, next: let next):
                return next
            case .empty:
                return .empty
            }
        }
        set {
            switch self {
            case .value(let value, next: _):
                self = .value(value, next: newValue)
            case .empty:
                self = newValue
            }
        }
    }
    
    var last: LinkedListNode? {
        guard case .value = self else { return nil }
        var current = self
        while case .value = current.next {
            current = current.next
        }
        return current
    }
    
    var first: LinkedListNode? {
        switch self {
        case .value:
            return self
        case .empty:
            return nil
        }
    }
    
    public mutating func append(_ element: Value) {
        guard case .value = self else { self = .value(element, next: .empty); return }
        var keypath: WritableKeyPath<LinkedListNode, LinkedListNode> = \LinkedListNode.next
        var current = self
    
        while case .value = current.next {
            print("Checking node: \(current[keyPath: keypath])")
            current = current.next
            keypath = keypath.appending(path: \.next)
        }
        print("Trying to append to: \(self[keyPath: keypath])")
        self[keyPath: keypath] = .value(element, next: .empty)
    }
    
    
    private static func initNext<T: Sequence>(_ sequence: T?) -> LinkedListNode<Value> where T.Element == Value {
        guard let sequence = sequence,
            let element = sequence.first(where: { _ in true })
            else { return .empty }
        
        return .value(element, next: LinkedListNode(sequence.dropFirst(1)))
    }
    
    public init<T: Sequence>(_ sequence: T?) where T.Element == Value {
        self = LinkedListNode.initNext(sequence)
    }
    
    public init() {
     self = .empty
    }
    
    /*
    public init(value: Value, next: LinkedListNode) {
        self = .value(value, next: next)
    }
    */
}

extension LinkedListNode: Comparable {
    public static func < (lhs: LinkedListNode<Value>, rhs: LinkedListNode<Value>) -> Bool {
        var current = lhs
        while case .value = current.next {
            current = current.next
            if current == rhs {
                return true
            }
        }
        return false
    }
}

extension LinkedListNode {
    func joinedContents(separator: String = ",", beforeValue: String = "", afterValue: String = "", onEmpty: String = "") -> String {
        var description = ""
        var current = self
        while case .value(let value, let next) = current {
            description.append("\(beforeValue)\(value)\(afterValue)")
            if case .value = next {
                description.append(separator)
            }
            current = current.next
        }
        return description
    }
}

extension LinkedListNode: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        switch self {
        case .value:
            return joinedContents(separator: " -> ", beforeValue: "(", afterValue: ")")
        case .empty:
            return ".empty"
        }
    }
}

extension LinkedListNode: CustomStringConvertible {
    public var description: String {
        return "[\(joinedContents())]"
    }
}

extension LinkedListNode: MutableCollection {
    public typealias Element = Value
    public typealias Index = LinkedListNode<Value>
    private var invalidIndexErrorMessage: String { return "Invalid index" }
    public subscript(position: LinkedListNode<Value>) -> Element {

        get {
            guard case .value(let value, _) = position else { fatalError(invalidIndexErrorMessage) }
            return value
        }
        
        set {
            guard case .value = self else { fatalError(invalidIndexErrorMessage) }
            var positionNextKeypath: WritableKeyPath<LinkedListNode, LinkedListNode> = \LinkedListNode.next
            var beforeIndexKeypath:  WritableKeyPath<LinkedListNode, LinkedListNode>? = nil
            var current = self
            
            while current != position {
                current = current.next
                beforeIndexKeypath = positionNextKeypath
                positionNextKeypath = positionNextKeypath.appending(path: \.next)
            }
            
            let secondHalf = current.next
            let new = LinkedListNode.value(newValue, next: secondHalf)
            
            if let beforeIndexKeypath = beforeIndexKeypath {
                self[keyPath: beforeIndexKeypath] = new
            } else {
                self = new
            }
        }
    }
    
    public var startIndex: LinkedListNode { return self }
    public var endIndex: LinkedListNode { return .empty }
    
    public func index(after i: LinkedListNode) -> LinkedListNode {
        return i.next
    }
}

extension LinkedListNode { // Mark: Integer subscriptable

    public subscript(_ indexOffset: Int) -> Element {
        get {
            precondition(indexOffset < count && indexOffset >= 0, "Index out of bounds")
            return self[self.index(startIndex, offsetBy: indexOffset)]
        }
        set {
            precondition(indexOffset < count && indexOffset >= 0, "Index out of bounds")
            self[self.index(startIndex, offsetBy: indexOffset)] = newValue
        }
    }
    
}
