import UIKit
import Foundation
import RxSwift
import RxCocoa
import RxRelay
import HandyJSON

var components = URLComponents(url: URL(string: "http://www.baidu.com?key=1&serach=faff")!, resolvingAgainstBaseURL: true)!
print(components.queryItems as Any)
components.queryItems = [
   URLQueryItem(name: "api_key", value: "123"),
   URLQueryItem(name: "language", value: Locale.preferredLanguages[0])
]
components.queryItems?.append(URLQueryItem(name: "type", value: "1"))
print(components.url?.absoluteString as Any)
let arr = [[1, 2, 3], [4, 5]]

let newArr = arr.flatMap { $0 }
let languages = UserDefaults.standard.object(forKey: "AppleLanguages")
print(languages as Any)
var observable = BehaviorRelay(value: "12")

observable.subscribe(onNext: { str in
        print(str)
})

_ = Observable<Int>.timer(0, period: 1, scheduler: MainScheduler.instance)
    .take(5)
    .map({ 5 - $0 })
    .map(String.init)
    .map({ "\($0)s" })
    .do(onCompleted: {
        
    }).subscribe(onNext: {
        print($0)
    })

Observable<String>.create{ observable in
    print("AA")
    observable.onNext("A")
    observable.onNext("B")
    return Disposables.create()
}.subscribe { (str) in
    print(str)
}

let group = DispatchGroup()
group.enter()
//Dispatch.quen.MainScheduler
let arrayNested: Array<[Int]> = [[1,2,3,4,5],[6,7]]

let maped2 = arrayNested.map { $0 }
print(maped2) // [[1, 2, 3, 4, 5], [6, 7]]

let flaped2 = arrayNested.flatMap { $0 }
print(flaped2) // [1, 2, 3, 4, 5, 6, 7]


func add(_ num: Int) -> (Int) -> Int {
    return { ss in
        return ss * num
    }
}

print(add(3)(2))

protocol Vehicle
{
    var numberOfWheels: Int {get}
    var color: UIColor {get set}

    mutating func changeColor()
}

struct MyCar: Vehicle {
    let numberOfWheels = 4
    var color = UIColor.blue

    mutating func changeColor() {
        color = .red
    }
}

func testRxShare() -> (){
    let seq = PublishSubject<Int>()
    let a = seq.map { (i) -> Int in
        print("MAP---\(i)")
        return i * 2
        }
        .share(replay: 1, scope: .forever)
    
    let _ = a.subscribe(onNext: { (num) in
        print("--1--\(num)")
    }, onError: nil, onCompleted: nil, onDisposed: nil)
    
    //seq.onNext(1)
    //seq.onNext(2)
    
    let _ = a.subscribe(onNext: { (num) in
        print("--2--\(num)")
    }, onError: nil, onCompleted: nil, onDisposed: nil)
    
    seq.onNext(3)
    seq.onNext(4)
    
    let _ = a.subscribe(onNext: { (num) in
        print("--3--\(num)")
    }, onError: nil, onCompleted: nil, onDisposed: nil)
    
    seq.onCompleted()
}

testRxShare()

Observable<String>.create({ (observer) -> Disposable in
    observer.onNext("1")
    observer.onNext("?")
    observer.onCompleted()
    //        observer.onError(MyError.anError)
    return Disposables.create()
}).subscribe({ (event) in
    print(event.element ?? "")
}).disposed(by: DisposeBag())


Observable.of(1,2,3).subscribe { print($0) }

Observable.of(4,5,6).subscribe(onNext: { (i) in
    print(i)
}, onError: { err in
}, onCompleted: {
    
}, onDisposed: {}).disposed(by: DisposeBag())

//var ob = Observable.form([1,2,3,4,5,6,7,8])

Observable.of(1,2,3,4,5,6,7,8)
    .filter { $0 % 2 == 0 }
    .subscribe(
        onNext: { num in
            print(num)
    }
)

let subject1 = PublishSubject<String>()
let subject2 = PublishSubject<String>()
// merge subject1和subject2
Observable
    .merge(subject1,subject2)
    .subscribe(onNext: {
        print($0)
    })
    

subject1.onNext("C")
subject1.onNext("o")
subject2.onNext("o")
subject2.onNext("o")
subject1.onNext("c")
subject2.onNext("i")

var action = BehaviorSubject<String?>(value:"L")
var actionOne = BehaviorRelay<String>(value: "B")
var actionTwo = PublishSubject<String?>( )
actionOne.accept("Ann")
actionOne.accept("Lucy")
//action.onCompleted()

action.onNext("O")
action.onNext("V")
actionOne.subscribe(onNext: { (str) in
    print("actionOne->:\(str )")
})
actionOne.accept("Tim" + "-" + actionOne.value)
action.subscribe(onNext: {print($0 as Any)})
action.onNext("E")
action.subscribe(onNext: {(element) in
    print("action->:\(element ?? "")")
})
actionTwo.subscribe(onNext:{print("actionTwo->:\($0 ?? "")")})

Observable.combineLatest(action, actionTwo).map { (str1, str2) -> Void in
    print(str1 ?? "", str2 ?? "")
}

var actionThree = ReplaySubject<String?>.create(bufferSize: 2)
actionThree.subscribe(onNext: { (str) in
    print("Replay1-->: \(str ?? "")")
})

actionThree.onNext("T")
actionThree.onNext("H")
actionThree.onNext("R")
actionThree.subscribe(onNext: { (str) in
    print("Replay2-->: \(str ?? "")")
})

_ = actionOne.buffer(timeSpan: 10, count: 2, scheduler: MainScheduler.instance).subscribe(onNext: { (str) in
    print("actionOneB->:\(str )")
})
actionOne.accept("Ann")
actionOne.accept("Lucy")
actionOne.accept("Seven")
actionOne.accept("Mondy")

var lists = [Int]()
lists.append(1)
lists.append(2)
lists.append(3)
Observable.from(optional: Int(""))
Observable.from(lists).map { (ele) -> String in
    print(ele)
    return String(ele)
    }
    .filter{Int($0) ?? 0 > 2}
    .subscribe(
        onNext: { num in
            print(num)
    }
)

print(lists.map{$0*2}.filter({ (I) -> Bool in
    I > 5
}))

var ss = lists.reduce(14) { (I, f) -> Int in
    I + f
}

Observable.of(1,2,3,4)
Observable.from([1,2,3,4])
Observable.just(1)
var label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 30))
BehaviorSubject(value: "Test").bind(to: label.rx.text)
label.backgroundColor = .red
