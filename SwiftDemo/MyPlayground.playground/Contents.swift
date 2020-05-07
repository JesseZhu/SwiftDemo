import UIKit
//import RxSwift
//import RxCocoa
//import RxRelay
import HandyJSON

//print(UIDevice.current.identifierForVendor?.uuidString)

func testURLComponents() {
    var components = URLComponents(url: URL(string: "http://www.baidu.com?key=1&serach=faff")!, resolvingAgainstBaseURL: true)!
    print(components.queryItems as Any)
    components.queryItems = [
       URLQueryItem(name: "api_key", value: "123"),
       URLQueryItem(name: "language", value: Locale.preferredLanguages[0])
    ]
    components.queryItems?.append(URLQueryItem(name: "type", value: "1"))
    print(components.url?.absoluteString as Any)
}

//testURLComponents()

let credit = 128060
let str = String(format: "%4d", credit)

func testArray() {
    struct Student {
        let name: String
        let score: Int = 80
        let age: Int
    }
    
    let student1 = Student(name: "张三", age: 23)
    let student2 = Student(name: "李四", age: 24)
    let student3 = Student(name: "王二", age: 25)
    
    let students = [student1, student2, student3]
    
    let names = students.compactMap {
        $0.name
    }
    print("所有学生的姓名：\(names)")
    
    let namess = students.flatMap({$0.name})
    print("所有学生的姓名：\(namess)")
    
    
    let numbers = [1, 2, 3, 4, 5]
    let doubled = numbers.map { $0 * 2 }
    
    let milesToPoint = ["point1":120.0,"point2":50.0,"point3":70.0]
    let kmToPoint = milesToPoint.map { (key,value)  in
        return key
    }
    let ff = milesToPoint.reduce("all") { (str, arg1)  in
        return arg1.key + str
    }
    print(kmToPoint)
}

testArray()

func testDict() {//字典排序
    let dict = ["2227":"w","2215":"bbt","36":"bba"]

    let keyss = dict.map { (key, value)  in
        return key
    }
    let keyssss = dict.filter { (key, value) in
        return key != "15"
    }

    print(keyss)
    print(keyssss)
    
    let keys = dict.sorted(by: {$0.0 < $1.0})
    let values = dict.sorted(by: {$0.1 < $1.1})

    print(keys)
    print(values)
}

//testDict()

let quote = "The revolution will be Swift"
let substring = quote.dropFirst(2)
let realString = String(substring)

let max = Int.max


var arr1 = [[1,2,nil,3],[4,5,6, nil]]
var arrr3 = arr1.flatMap { (sss) -> [Int?] in
    return sss
}
var fff = arrr3

public enum  Result<Suc, Fal>{
    case suces(Suc)
    case failur(Fal)
}

//柯里化
func add1(_ v3: Int) -> (Int) -> (Int) -> Int {
    return {  v2 in
        return { v1 in
            return v1 - v2 - v3
        }
    }
}

print(add1(3)(2)(1))

func add(_ v1: Int, _ v2: Int){ v1 + v2 }
func currying<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B) -> (A) -> C {
    return { b in
        return { a in
            fn(a, b)
        }
    }
}

print(currying(add)(4)(2))

var i = Optional<Int>.none
var ii = i ?? 3 + 5
print(i.flatMap { $0 + 7} ?? "" )
var j = i.map{ $0 + 7}

print(j ?? "" )


struct ZB<Base> {
    var base: Base
    init(_ bas: Base) {
        self.base = bas
    }
}

extension ZB where Base == String {
    var numberCount: Int {
        var count = 0
        for c in self.base where ("0"..."9") .contains(c) {
            count += 1
        }
        return count
    }
}

extension String {
    var zb: ZB<String> { return ZB(self) }
}
print("343fsf123".zb.numberCount)

let x: Int? = 3
let y: Int? = nil

let startIndex = str.index(str.startIndex, offsetBy: 1)
let endIndex = str.index(str.startIndex, offsetBy: 3)
var ff444 = str.replacingCharacters(in: startIndex...endIndex, with: "new")

//var arr1 = [1,2,3,4,5,6]
//var arr2 = [3,25,7,8,9,10]
//var arr3 = (arr1 + arr2)
//var arr4 = arr3.compactMap { (ss) -> Int? in
//    ss
//}
//print(arr4)

//let mm = arr1.enumerated().map { (offset: Int, element: Int) -> Int in
//    return offset * element
//}
//var ss1 = "fgakbfjhbj/jfshakf"
//let tt = ss1.split(separator: "/")
// let ss2 = "ffafa"

class Animal: NSObject {
    var age = 2.0
    var grade = 3.0
    subscript(index: Int) -> Double {
        set {
            if index == 1{
                age = newValue
            }
            if index == 2{
                grade = newValue
            }
        }
        get {
            if index == 1 {
                return age
            }
            if index == 2 {
                return grade
            }
            return 0
        }
    }
}

let dog = Animal()
dog[1] = 3.3
print(dog[1])
let desc = dog.description

protocol Student {
    //定义一个可读可写的 name 属性
    var name: String { get set }
    //定义一个可读的 birthPlace 属性
    var birthPlace: String { get }
    //定义一个类属性 record
    static var qualification: String {get}
}

struct Puple: Student {
    static var qualification: String = "小学"
    var name: String
    var birthPlace: String = "北京"
}
var p1 = Puple(name: "小明", birthPlace: "上海")
Puple.qualification = "fff"
p1.birthPlace = "dddd"

print(p1.name,p1.birthPlace)

var s1: Student = p1
s1.name = "广州"


class Box<T> {
    var listener: ( (T) -> Void)?
    var value: T {
        didSet{
            self.listener?(value)
        }
    }
    
    init (_ value: T){
        self.value  = value
    }
    
    
    func bind (_ listener: @escaping (T) -> ()) {
        self.listener = listener
        self.listener?(value)
    }
}
    var boxInt = Box(4)
    boxInt.value = 6
    boxInt.bind {
        print($0)
    }
    boxInt.value = 11


enum AFError: Swift.Error {
    case some(String)
    case only(Int, String)
}

func divdiv(_ num1: Float, _ num2: Float) throws -> Double {
    if num2 == 0 {
        throw AFError.only(123, "some thing wrong")
    }
    return  Double(num1 / num2)
}

do{
   try divdiv(0 , 0)
} catch let AFError.some(some) {
    print(some)
} catch let AFError.only(i, msg) {
    print(i,msg)
}

enum ffff: String, CodingKey {
    case ff = "dsds"
}

let dd = try? divdiv(2, 4)
//fatalError("do not implmention")

struct MM: Codable, CustomStringConvertible, HandyJSON {
    
    
    var name: String?
    var  points: Int?
    var descriptions: String?
    
    var description: String {
        return (name ?? "") + " " + ( descriptions ??  "")
    }
    
    init() {
        
    }
///
//    mutating func mapping(mapper: HelpingMapper) {
//        mapper <<<
//            self.descriptions <-- "description"
//    }
    
//    enum CodingKeys: String, CodingKey {
//        case descriptions = "description"
//        case name
//        case points
//    }
}

let jsonDecoder = JSONDecoder()

let jsonString = "{\"name\": \"Durian\",\"points\": 600,\"description\": \"A fruit with a distinctive scent.\"}"

let data: Data? = jsonString.data(using: String.Encoding.utf8)

let  jsonObjec = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)

let mmm = try? jsonDecoder.decode(MM.self, from: data!)

let nnn = MM.deserialize(from: jsonString)

print(nnn ?? "ffff")

func getRandom(maxInt: Int) -> Swift.Result<Int, AFError> {
    if maxInt < 0 {
        return .failure(.some(" not suppot"))
    }
    
    let number = Int.random(in: 0...maxInt)
    return .success(number)
}
 /// This is a test function
func calFactor(number: Int) -> Swift.Result<Int, AFError> {
    let factors = (1...number).filter { (num) -> Bool in
        return number % num == 0
    }
    if factors.count == 2 {
        return .failure(AFError.some("isPrime"))
    }else{
        return .success(factors.count)
    }
}

let resultS = getRandom(maxInt: 111)
print(resultS)
let mapResult = resultS.map { (number) -> String in
    return "the random is \(number)."
}

let calResult = resultS.map {
    return calFactor(number: $0)
}
print(calResult) // Result<Result<Int, Error>, Error>

let calFlatResult = resultS.flatMap { //展平
    return calFactor(number: $0)
}
print(calFlatResult)

let rand = Int.random(in: 1...10)

let stackView = UIStackView()
stackView.axis = .vertical
NSLayoutConstraint.activate([
    stackView.topAnchor.constraint(equalTo: stackView.topAnchor),
    stackView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
    stackView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
    stackView.rightAnchor.constraint(equalTo: stackView.rightAnchor)
    ])
//stackView.

let hexString = "0xD7DCE2"
let coloe: Int = Int(strtoul(hexString, nil, 16))

let scale = UIScreen.main.scale
let scstring =  String(Int(scale))

enum Gender: Int {
    case male = 0
    case female
}

class Person {
    var name: String
    var age: Int
    var score: Int
    var gender: Gender
    
    init(name: String, age: Int, score: Int, gender: Gender) {
        self.name = name
        self.age = age
        self.score = score
        self.gender = gender
    }
}

let tom = Person(name: "Tom", age: 12, score: 77, gender: .male)
let tim = Person(name: "Tim", age: 17, score: 82, gender: .male)
let jack = Person(name: "Jack", age: 18, score: 83, gender: .male)
let lucy = Person(name: "Lucy", age: 21, score: 85, gender: .male)
let ann = Person(name: "Ann", age: 30, score: 87, gender: .male)

//MARK: 面向协议编程
struct MJ<Base> {
    var base: Base
    
    init(_ base: Base){
        self.base = base
    }
}

extension MJ where Base == String {
    func numberIntCount() -> Int {
        var int = 0
        for s in self.base where ("0"..."9") .contains(s) {
            int += 1
        }
        return int
    }
   
    mutating func test(){
        
    }
}

extension MJ where Base: Person {
    func run(){
        print("run")
    }
    
    static func eat() {}
}

protocol MJCompable {}
extension MJCompable {
    var mj: MJ<Self> {
        set {}
        get {
            return MJ(self)
        }
    }
    
    static var mj: MJ<Self>.Type {
        return MJ.self
    }
}

extension String: MJCompable{}

extension Person : MJCompable{}

//extension String {
//    var mj: MJ<String> {
//        return MJ(self)
//    }
//}

//extension Person {
//    var mj: MJ<Person> {
//        return MJ(self)
//    }
//}


Person.mj.eat()
tom.mj.run()
var count = "12dffd75afsf2323".mj.numberIntCount()

var testStringMJ = "ssss"
testStringMJ.mj.test()
 
//: Heading 1
//MARK: KeyPath
extension Sequence {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return map {$0[keyPath: keyPath]}
    }
    
//    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
//        return sorted { a, b in
//            return a[keyPath: KeyPath] < b[keyPath: keyPath]
//        }
//    }
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
            return sorted { a, b in
                return a[keyPath: keyPath] < b[keyPath: keyPath]
            }
        }
}

func testKeyPath() {
    var persons = [tom, tim, jack, lucy, ann]
    
    let sortByname = persons.sorted{ $0.score > $1.score }
    let sortByname2 = persons.sorted(by: \.score)
    let allName = sortByname.map{ $0.name }
    let allName2 = sortByname2.map(\.score)
    
    print(allName2)
}

testKeyPath()
