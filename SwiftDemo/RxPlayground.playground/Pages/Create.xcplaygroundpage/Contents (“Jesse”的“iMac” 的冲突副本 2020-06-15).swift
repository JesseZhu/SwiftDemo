//: [上一页](@previous)

import Foundation
import UIKit
import RxSwift
import RxCocoa
//: > 创建一个序列

enum TestError: Swift.Error {
    case test
}

let disposeBag = DisposeBag()
func testCreateObservable() {
    
    let button = UIButton()
    
    //: 常见的创建序列的方法
    let obsever = Observable<String>.create{ observable in
        print("AA")
        observable.onNext("A")
        observable.onNext("B")
        observable.onCompleted()
        return Disposables.create()
    }
    .subscribe { (str) in
        print(str)
    }
    .disposed(by: disposeBag)
    
//    obsever.do(on)
    
    //: Rx 对 Cocoa 的扩展
    let observabeTapped = button.rx.tap.asObservable()
    
    //: empty 创建一个空序列 只会发出一个完成事件
    _ = Observable<Int>.empty()
        .subscribe { event in
            print("空序列：\(event)")
    }
    .disposed(by: disposeBag)
    
    //: just 创建一个单个元素的序列
    let justObsevable = Observable.just("🔴")
    justObsevable.subscribe { event in
        print(event)
    }
    .disposed(by: disposeBag)
    
    //: of  使用固定数量的元素创建一个序列
    Observable.of("🐶", "🐱", "🐭", "🐹")
        .subscribe(onNext: { element in
            print(element)
        })
        .disposed(by: disposeBag)
    
    //: from 从一个序列创建一个可被观察的序列
    let fromObservable = Observable.from(["one", "two", "three", "four"])
    fromObservable.subscribe(onNext: {
        print("Observable.from", $0)
    })
    
    //: repeatElement 创建一个给予元素的无限序列
    Observable.repeatElement("🔴")
        .take(3)
        .subscribe(onNext: { print("repeatElement", $0) })
        .disposed(by: disposeBag)
    
    //: error 创建一个没有元素并以错误终止的序列
    Observable<Int>.error(TestError.test)
        .subscribe { print("错误序列：\($0)") }
        .disposed(by: disposeBag)
    
    //: never 创建一个序列，不会终止也不会发出任何事件
    let neverSequence = Observable<String>.never()
    let neverSequenceSubscription = neverSequence
        .subscribe { _ in
            print("This will never be printed")
    }
    .disposed(by: disposeBag)
}

testCreateObservable()

//: ###  Subject
//: ---
//: **Subject** 它既可以作为 **Observer** (订阅者/观察者)，也可以作为一个 **Observable** （观察序列）
//: * [AsyncSubject](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/rxswift_core/observable_and_observer/async_subject.html) 将在源 Observable 产生完成事件后，发出最后一个元素（仅仅只有最后一个元素），如果源 Observable 没有发出任何元素，只有一个完成事件。那 AsyncSubject 也只有一个完成事件
//: * [PublishSubject](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/rxswift_core/observable_and_observer/publish_subject.html) 只会发送给订阅者订阅之后的事件，之前发生的事件将不会发送
//: * [ReplaySubject](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/rxswift_core/observable_and_observer/replay_subject.html) 不管订阅者什么时候订阅的都可以把所有发生过的事件发送给订阅者
//: * [BehaviorSubject](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/rxswift_core/observable_and_observer/behavior_subject.html) 广播所有事件给订阅者，对于新的订阅者，广播最近的一个事件或者默认值
//: * [Variable-已废弃](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/rxswift_core/observable_and_observer/variable.html) 是BehaviorSubject的封装，它和BehaviorSubject不同之处在于，不能向Variable发送.Complete和.Error，它会在生命周期结束被释放的时候自动发送.Complete。
//: * [BehaviorRelay] 就是 BehaviorSubject 去掉终止事件 onError 或 onCompleted。取代 Variable
//: * [PublishRelay] 就是 PublishSubject 去掉终止事件 onError 或 onCompleted
//: * [ControlProperty](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/rxswift_core/observable_and_observer/control_property.html) 专门用于描述 UI 控件属性的，它具有以下特征：

//: * 不会产生 error 事件
//: * 一定在 MainScheduler 订阅（主线程订阅）
//: * 一定在 MainScheduler 监听（主线程监听）
//: * [共享附加作用](https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/recipes/share_side_effects.html)

func testSubject() {
    let asySubject = AsyncSubject<String>()
    asySubject.subscribe{
        print("asySubscription:", $0)
    }
    .disposed(by: disposeBag)
    
    asySubject.onNext("😿")
    asySubject.onNext("📚")
    asySubject.onNext("😒")
    asySubject.onCompleted()
    
    let publicSubject = PublishSubject<String>()
    publicSubject.onNext("🐍")
    publicSubject.subscribe{
        print("publicSubscription 1:", $0)
    }
    .disposed(by: disposeBag)
    
    publicSubject.onNext("🐱")
    publicSubject.onNext("🐖")
    
    publicSubject.subscribe{
        print("publicSubscription 2:", $0)
    }
    .disposed(by: disposeBag)
    
    publicSubject.onNext("A")
    publicSubject.onNext("B")
    
    
    let replaySubject = ReplaySubject<String>.create(bufferSize: 1)
    replaySubject
        .subscribe { print("RepalySubscription 1:", $0) }
        .disposed(by: disposeBag)
    replaySubject.onNext("🐶")
    replaySubject.onNext("🐱")
    
    replaySubject
        .subscribe { print("RepalySubscription 2:", $0) }
        .disposed(by: disposeBag)
    
    replaySubject.onNext("🅰️")
    replaySubject.onNext("🅱️")
    
    let behaviorSubject = BehaviorSubject<String>(value: "🎈")
    behaviorSubject.subscribe{ print("behaviorSubscription 1 :", $0) }
    .disposed(by: disposeBag)
    
    behaviorSubject.onNext("🍌")
    behaviorSubject.on(Event.next("🍇"))
//     behaviorSubject.onError(TestError.test)
    
    behaviorSubject.subscribe{ print("behaviorSubscription 2 :", $0) }
    .disposed(by: disposeBag)
    behaviorSubject.onNext("🍪")
    behaviorSubject.on(Event.next("🍫"))
    
    behaviorSubject.subscribe{ print("behaviorSubscription 3 :", $0) }
    .disposed(by: disposeBag)
    behaviorSubject.onNext("🏐")
    behaviorSubject.on(Event.next("🏀"))
}

testSubject()

let name: String? = nil
let nameBehavior = BehaviorRelay<String?>(value: name)
let mm = Observable.from(optional: nameBehavior.value)

Observable<Int>.create { observer -> Disposable in
    if let element = name {
        observer.onNext(element)
    }
    observer.onCompleted()
    return Disposables.create()
}

mm.subscribe(onNext: { (str) in
    print(str)
}, onError: { (err) in
    print("err")
}, onCompleted: {
    print("done")
}) {
    
}
//: [下一页](@next)

//: [主页](Untitled)
