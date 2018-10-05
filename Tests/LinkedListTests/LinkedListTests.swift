import XCTest
@testable import LinkedList

final class LinkedListTests: XCTestCase {
    var sourceSequence = [0,1]
    
    func testNext() {
        let node = LinkedListNode(sourceSequence)
        XCTAssertEqual(node.next,
                       LinkedListNode([sourceSequence[sourceSequence.startIndex.advanced(by: 1)]]),
                       "The next property should return the next node in the list")
        XCTAssertNotEqual(node.next,
                          LinkedListNode([sourceSequence[sourceSequence.startIndex]]),
                          "The next property should return the next node in the list")
        XCTAssertEqual(node.next.next, .empty, "Beyond the last value node should be .empty")
        XCTAssertEqual(LinkedListNode<Int>().next, .empty, "The next property of an .empty node should also be .empty")
    }
    
    func testValue() {
        let node = LinkedListNode(sourceSequence)
        XCTAssertEqual(node.value, sourceSequence.first, "A LinkedListNode's `value` property should return its value and it should be Optional")
        let emptyNode = LinkedListNode<Int>()
        XCTAssertEqual(emptyNode.value, nil, "A LinkedListNode's `value` property should return nil if the node is .empty")
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
        XCTAssertEqual(node.startIndex, node, "A LinkedListNode's startIndex should be equal to the node itself")
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
    
    func testCustomCount() {
        let node = LinkedListNode(sourceSequence)
        XCTAssertEqual(node.count, sourceSequence.count)
    }
    
    func testCustomCountPerf() {
        let magicNumber = 11_634 // TODO: Trying to init with more elements than this causes a bad access. Probably because the init from sequence is recursive. FIX
        let node = LinkedListNode(Array<Int>(repeating: 0, count: magicNumber))
        measure {
            _ = node.count
        }
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
        ("testValue", testValue),
        ("testCustomCountPerf", testCustomCountPerf),
        ("testCustomCount", testCustomCount),
    ]
}
