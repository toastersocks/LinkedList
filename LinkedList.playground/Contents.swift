import Cocoa
@testable import LinkedList


var linkedList = LinkedListNode([0,1,2,3,4,-1,5,6,7,-1,8,9])
let linkedList2 = LinkedListNode([0,1,2,3,4,5,6,8])
let element = linkedList2.next.next.next
element > linkedList2
linkedList == linkedList2
linkedList.count

var node = LinkedListNode<Int>([0])
node.isEmpty
node.next = .value(1, next: .empty)
func getNext<Element>(_ ptr: UnsafeMutablePointer<LinkedListNode<Element>>) -> UnsafeMutablePointer<LinkedListNode<Element>> {
    return UnsafeMutablePointer(&ptr.pointee.next)
}
//var ptr = UnsafeMutablePointer<LinkedListNode>(&node)
//ptr = getNext(ptr)
//ptr = getNext(ptr)
//node.next.next = .value(2, next: .empty)
//ptr = UnsafeMutablePointer<LinkedListNode>(&ptr.pointee.next)
//ptr.pointee.next = .value(2, next: .empty)
/*
 ptr = withUnsafeMutablePointer(to: &ptr.pointee.next) { (ptr) -> UnsafeMutablePointer<LinkedListNode> in
 //    ptr.pointee.next = .value(2, next: .empty)
 return UnsafeMutablePointer(&ptr.pointee.next)
 }
 */


node.append(2)
node.append(3)
let indexOf2 = node.index(node.startIndex, offsetBy: 2)
node[indexOf2] = -1
node[node.startIndex] = 100
node[3]
node[0] = 0
node
/*
 print("Node is: \(ptr.pointee))")
 while case .value = ptr.pointee.next {
 ptr = UnsafeMutablePointer(&(ptr.pointee.next))
 print("Current val: \(ptr.pointee))")
 }
 ptr.pointee.next = .value(2, next: .empty)
 ptr.pointee
 */

/*
 withUnsafeMutablePointer(to: &node) { (ptr: UnsafeMutablePointer<LinkedListNode>) -> Void in
 //    var ptr = ptr
 var current = ptr
 while case LinkedListNode<Int>.value = current.pointee.next {
 current = UnsafeMutablePointer(&current.pointee.next)
 }
 current.pointee.next = .value(2, next: .empty)
 //    ptr.pointee.next = .value(2, next: .empty)
 }
 */

node

for element in linkedList {
    print(String(describing: element))
}
linkedList.contains(8)
linkedList.randomElement()
let thirdIndex = linkedList.index(after: linkedList.index(after: linkedList.startIndex))
linkedList[thirdIndex]
let split = linkedList.split(separator: -1)
print(split)

let doubled = LinkedListNode(linkedList.map { $0 * 2 })
doubled
print(doubled)


