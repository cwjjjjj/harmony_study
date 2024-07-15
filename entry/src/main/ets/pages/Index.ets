class User {
  nickname?: string
  age?: number
}

@Styles function sameStyle() {
  .backgroundColor(Color.Green)
  .onClick(() => {
    this.count++
  })
}

@Entry
@Component
struct Index {
  @State
  message: string = 'Hello World对dqweqwewq 的'
  
  @State
  user?: User = undefined

  build() {
    Column({ space: 20 }) {
      if(this.user){
        Text(this.user?.nickname)
        Text(this.user?.age?.toString())
      }else{
        Text('no user')
      }

      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}