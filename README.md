# SaveUs


## 📝 꼭 읽어주세요.
**extension을 활용합시다.**     
해당 프로젝트는 MVC패턴을 사용하기에 ViewController에 모든 코드를 한번에 때려 넣으면 코드 읽기가 힘들어집니다.    
때문에 extension으로 코드를 분리해 주세요.    
```swift
//MARK: 오토레이아웃 영역
//오토레이아웃 부분을 extension으로 분리    
extension MainViewController{
    
    func setlayout(){
        view.addSubview(testStackVeiw)
        testStackVeiw.snp.makeConstraints{
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height / 3)
        }
    }
    
}
```
    
**컴포넌트 선언 방법**   
여러가지 방식으로 컴포넌트를 선언 할 수 있지만 아래와 같은 방식을 권장합니다.    
큰 이유는 없고 보통 코드베이스로 작성할때 많이 사용하는 방식이고, 코드 블럭으로 묶여져 있어 확인하기가 편합니다.
```swift
    private lazy var emergencyButton: UIButton = {
        let button = UIButton()
        button.setTitle("emergencyButton",for:.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(didTapEmergencyButton), for: .touchUpInside)
        return button
    }()
```

**SnapKit사용법**    
스냅킷을 사용할 경우 아래의 방식을 권장 합니다.    

```swift
extension MainViewController{
    //1. setlayout()안에 모든 오토레이 아웃 코드를 넣어 놓는다.
    func setlayout(){
    
    //2.아래의 코드와 같이 원하는 view안에 addSubview(view를 추가)한다.
        view.addSubview(testStackVeiw)
        
        //3. make in은 지우고 단축인자($0)로 코드를 작성
        testStackVeiw.snp.makeConstraints{
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.safeAreaLayoutGuide.layoutFrame.height / 3)
        }
        
    }
    
}
```







