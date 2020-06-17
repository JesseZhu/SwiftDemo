//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

//: **startWith** 在序列触发值之前插入一个或者多个元素
Observable.of("🐱", "🐖", "🐟", "🦍")
    .startWith("1")
    .startWith("2")
    .startWith("3", "4", "5")
    .subscribe(onNext: {
        print("startWith", $0)
    })
    .disposed(by: disposeBag)

//: **merge** 把多个序列合并成单个序列，并按照事件触发的先后顺序，依次发射值
let publishSubject1 = PublishSubject<Int>()
let publishSubject2 = PublishSubject<Int>()

//Observable.of(publishSubject1, publishSubject2)
//    .merge()
//    .subscribe(onNext: {print($0)
//    })
//    .disposed(by: disposeBag)

Observable.merge(
    publishSubject1,
    publishSubject2
)
    .subscribe(onNext: {
        print("merge:", $0)
    })
    .disposed(by: disposeBag)

publishSubject1.onNext(1)
publishSubject2.onNext(2)
publishSubject1.onNext(3)
publishSubject2.onNext(4)
publishSubject2.onNext(5)

//: **Zip** 把多个序列组合成到一起并触发一个值，但只有每一个序列都发射了一个值之后才会组合成一个新的值并发出来
let publishSubject3 = PublishSubject<String>()
let publishSubject4 = PublishSubject<Int>()
let latestFromSubject = PublishSubject<Int>()

Observable.zip(publishSubject3, publishSubject4){
    "\($0) \($1/2)"
}
.subscribe(onNext: {
    print("Zip:", $0)
})
    .disposed(by: disposeBag)

//: **combineLatest** 获取两个序列的最新值，并通过某个函数对其进行处理，处理完之后返回一个新的发射值
Observable.combineLatest(publishSubject3, publishSubject4){
    "\($0) \($1*2)"
}.map{
    $0 + " 转换操作"
}
.subscribe(onNext: {
    print("combineLatest:", $0)
})
    .disposed(by: disposeBag)

publishSubject3.onNext("7")
publishSubject4.onNext(8)//combineLatest: 7 16 转换操作
publishSubject3.onNext("9")//combineLatest: 9 16 转换操作
publishSubject4.onNext(8)//combineLatest: 9 16 转换操作

//: **withLatestFrom** 操作符将两个 Observables 中最新的元素通过一个函数组合起来，然后将这个组合的结果发出来。当第一个 Observable 发出一个元素时，就立即取出第二个 Observable 中最新的元素，通过一个组合函数将两个最新的元素合并后发送出去
latestFromSubject.withLatestFrom(publishSubject4).subscribe(onNext: {
    print("withLatestFrom: ", $0) //withLatestFrom:  6
    })
publishSubject4.onNext(6)
latestFromSubject.onNext(999)
//: **flatMap** 把当前序列的元素转换成一个新的序列，并把他们合并成一个序列，这个在我们的一个可被观察者序列本身又会触发一个序列的时候非常有用，比如发送一个新的网络请求
//: **flatMapLatest** 和faltMap不同的是，flatMapLatest在收到一个新的序列的时候，会丢弃原有的序列 , flatMapLatest相当于map和switchLatest操作的组合
struct Player {
    var score: BehaviorRelay<Int>
}

let 👦🏻 = Player(score: BehaviorRelay(value: 80))
let 👧🏼 = Player(score: BehaviorRelay(value: 90))

let player = BehaviorRelay(value: 👦🏻)

player.asObservable()
    .flatMapLatest { $0.score.asObservable() } // Change flatMap to flatMapLatest and observe change in printed output
    .subscribe(onNext: { print("flatMapLatest or flatMap:", $0) })
    .disposed(by: disposeBag)

player.asObservable()
.flatMapLatest { $0.score.asObservable() } // Change flatMap to flatMapLatest and observe change in printed output
.subscribe(onNext: { print("flatMapLatest1 or flatMap:", $0) })
.disposed(by: disposeBag)

👦🏻.score.accept(85)
player.accept(👧🏼)
👦🏻.score.accept(95)  // Will be printed when using flatMap, but will not be printed when using flatMapLatest
👧🏼.score.accept(100)

//: **scan** 和Swift里面的reduce类似，给予一个初始值，依次对每个元素进行操作，最后返回操作的结果
Observable.of(10, 100, 1000)
    .scan(1) { aggregateValue, newValue in
        aggregateValue + newValue
}
.subscribe(onNext: { print("scan:", $0) })
.disposed(by: disposeBag)



//: **filter**
Observable.of(10, 100, 1000)
    .filter {
        $0 > 10
}
.subscribe(onNext: { print("filter:", $0) })
.disposed(by: disposeBag)

Observable.of(true)
    .filter{ $0 }
    .subscribe(onNext: { print("filter:", $0) })
    .disposed(by: disposeBag)

let mm = Observable.of(false)

mm.filter{$0}
    .subscribe(onNext: { print("filter:", $0) })
    .disposed(by: disposeBag)

//: **distinctUntilChanged** 过滤掉连续发射的重复数据
Observable.of("A", "B", "C", "C", "D", "D", "E", "C", "F")
    .distinctUntilChanged()
    .subscribe(onNext: { print("distinctUntilChanged:", $0) })
    .disposed(by: disposeBag)

let behavior = BehaviorRelay(value: 1)
behavior.distinctUntilChanged()
    .subscribe(onNext: {
        print("behaviordistinctUntilChanged", $0)
    })

behavior.accept(2)
behavior.accept(3)
behavior.accept(3)
behavior.accept(4)

//: **elementAt** 只发送指定位置的元素
Observable.of("A", "B", "C", "C", "D", "D", "E", "C", "F")
    .elementAt(1)
    .subscribe(onNext: { print("elementAt:", $0) })
    .disposed(by: disposeBag)

//: **take** 获取序列前多少个值
Observable.of("A", "B", "C", "C", "D", "D", "E", "C", "F")
    .take(2)
    .subscribe(onNext: { print("take:", $0) })
    .disposed(by: disposeBag)


//: **takeLast** 获取序列后多少个值
Observable.of("A", "B", "C", "C", "D", "D", "E", "C", "F")
    .takeLast(3)
    .subscribe(onNext: { print("takeLast:", $0) })
    .disposed(by: disposeBag)

//: **takeWhile** 发射值值到条件变成false，变成false后，后面满足条件的值也不会发射
Observable.of(1, 2, 3, 4, 5, 6, 1, 3)
    .takeWhile { $0 < 4 }
    .subscribe(onNext: { print("takeWhile:", $0) })
    .disposed(by: disposeBag)

//: **takeUntil** 发射原序列，直到新的序列发射了一个值
let publishSubject5 = PublishSubject<String>()
let publishSubject6 = PublishSubject<String>()

publishSubject5.takeUntil(publishSubject6)
    .subscribe(onNext: {
        print("takeUntil:", $0)
    })
    .disposed(by: disposeBag)

publishSubject5.onNext("BB")
publishSubject5.onNext("CC")
publishSubject6.onNext("DD")
publishSubject5.onNext("EE")

//: **skip** 跳过开头指定个数的值
Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
    .skip(2)
    .subscribe(onNext: { print("skip: ", $0) })
    .disposed(by: disposeBag)

//: **skipWhile** 跳过满足条件的值到条件变成false，变成false后，后面满足条件的值也不会跳过。
Observable.of(1, 2, 3, 4, 5, 6)
    .skipWhile { $0 < 4 }
    .subscribe(onNext: { print("skipWhile:", $0) })
    .disposed(by: disposeBag)

//: **skipWhileWithIndex** 和skipWhile类似，只不过带上了index
Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
.skipWhileWithIndex { element, index in
    index < 3
}
.subscribe(onNext: { print("skipWhileWithIndex:", $0) })
.disposed(by: disposeBag)

//: **skipUntil** 和takeUntil相反，跳过原序列，直到新序列发射了一个值。

publishSubject5.skipUntil(publishSubject6)
.subscribe(onNext: {
    print("skipUntil:", $0)
})
.disposed(by: disposeBag)

publishSubject5.onNext("BB")
publishSubject5.onNext("CC")
publishSubject6.onNext("DD")
publishSubject5.onNext("EE")
publishSubject5.onNext("FF")

//: **timer**

Observable<Int>.timer(.seconds(1), period: .seconds(1), scheduler: MainScheduler.init())
    .take(5)
    .subscribe(onNext: {
        print("timer:", $0 + 1)
    })
    .disposed(by: disposeBag)

Observable<NSNumber>.of(123, 4, 56)
.map {
    NumberFormatter.string(from: $0) ?? ""
}
.subscribe(onNext: {
    print($0)
})
.disposed(by: disposeBag)

//: [Next](@next)
