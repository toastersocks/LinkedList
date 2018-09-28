import XCTest
@testable import LinkedList

final class LinkedListTests: XCTestCase {
    var sourceSequence = [0,1]
    
    func testNext() {
        let source = [0,1]
        let node1 = LinkedListNode(source)
        let node2 = node1.next
        XCTAssertEqual(node2,
                       LinkedListNode([source[source.startIndex.advanced(by: 1)]]),
                       "The next property should return the next node in the list")
        XCTAssertNotEqual(node2,
                          LinkedListNode([source[source.startIndex]]),
                          "The next property should return the next node in the list")
    }
    
    func testComparableIndex() {
        let smallerNode = LinkedListNode([0,1,2,3,4,5,6,7])
        let biggerNode = smallerNode.next.next.next
        XCTAssertLessThan(smallerNode, biggerNode, "LinkedListNode indexes should be comparable. A node is considered to be greater than a second node if it is contained within the first node's chain of nodes")
        XCTAssertTrue(smallerNode < biggerNode)
        
    }
    
    func testAppend() {

        var node = LinkedListNode(sourceSequence)
        let elementToAppend = 2
        node.append(2)
        sourceSequence.append(2)
        XCTAssertEqual(node, LinkedListNode(sourceSequence), "append() should append an element to the end of the LinkedListNode chain")
        var emptyNode: LinkedListNode<Int> = .empty
        emptyNode.append(elementToAppend)
        XCTAssertEqual(emptyNode, LinkedListNode([elementToAppend]), "Appending to an empty LinkedListNode should create a node with only the newly appended element")
    }
    
    
    func testCollectionConformance() {

        let node = LinkedListNode(sourceSequence)
        XCTAssertEqual(node.startIndex, node, "A LinkedListNode's startIndex should be equal to the node")
        XCTAssertEqual(node.endIndex, .empty, "A LinkedListNode's endIndex should be equal to the .empty")
        XCTAssertEqual(node[node.index(after: node.startIndex)], sourceSequence[sourceSequence.index(after: sourceSequence.startIndex)])
    }
    
    func testMutableCollectionConformance() {
        var node = LinkedListNode(sourceSequence)
        let elementToInsert = 2
        node[node.startIndex] = elementToInsert
        sourceSequence[sourceSequence.startIndex] = elementToInsert
        node[node.index(after: node.startIndex)] = elementToInsert
        sourceSequence[sourceSequence.index(after: sourceSequence.startIndex)] = elementToInsert
        XCTAssertEqual(node, LinkedListNode(sourceSequence))
        let emptyNode = LinkedListNode<Int>()
        XCTAssertTrue(emptyNode.isEmpty)
    }
 
    func testDefaultInit() {
        XCTAssertEqual(LinkedListNode<Int>(), .empty, "The default initializer should create an .empty LinkdedListNode")
    }
    
    func testIntegerSubscriptSet() {
        var node = LinkedListNode(sourceSequence)
        let elementToInsert = -1
        
        node[0] = elementToInsert
        node[1] = elementToInsert
        sourceSequence[0] = elementToInsert
        sourceSequence[1] = elementToInsert
        
        XCTAssertEqual(node, LinkedListNode(sourceSequence))
    }
    
    func testIntegerSubscript() {
        let node = LinkedListNode(sourceSequence)
        XCTAssertEqual(node[0], sourceSequence[0])
    }
    
    
    static var allTests = [
        ("testNext", testNext),
        ("testComparableIndex", testComparableIndex),
        ("testAppend", testAppend),
        ("testCollectionConformance", testCollectionConformance),
        ("testMutableCollectionConformance", testMutableCollectionConformance),
        ("testDefaultInit", testDefaultInit),
        ("testIntegerSubscript", testIntegerSubscript),
        ("testIntegerSubscriptSet", testIntegerSubscriptSet),
    ]
}
