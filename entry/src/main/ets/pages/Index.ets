import prompt from '@ohos.prompt';

class User {
  nickname?: string
  age?: number
}

@Styles function sameStyle() {
  .backgroundColor(Color.Green)
  .onClick(() => {
    console.log('123')
  })
}

@Entry
@Component
struct Index {
  @State
  message: string = 'Hello Wor22ld对dqweqwewq 的'
  
  @State
  user?: User = undefined

  @Builder MenuBuilder() {                                         // 自定义布局
    Column() {
      Text("菜单1")
        .width("100%")
        .height(40)
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          prompt.showToast({message: "菜单1"});
        })
      Divider()
        .width("100%")
        .height(1)
        .backgroundColor("#aabbcc")
      Text("菜单2")
        .width("100%")
        .height(40)
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          prompt.showToast({message: "菜单2"});
        })
      Divider()
        .width("100%")
        .height(1)
        .backgroundColor("#aabbcc")
      Text("菜单3")
        .width("100%")
        .height(40)
        .fontSize(20)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          prompt.showToast({message: "菜单3"});
        })
    }
    .backgroundColor(Color.Pink)
    .width(100)
  }

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
        }).sameStyle()

      Button('button').onClick(()=>{
        this.message = this.message + '!'
        console.log('message',this.message)
      }).fontColor('red').backgroundColor('green').bindContextMenu(this.MenuBuilder, ResponseType.LongPress)

      Image($r("app.media.startIcon"))
        .width(160)
        .height(160).bindMenu([
        {
          value: "菜单1",
          action: () => {
            prompt.showToast({message: "菜单1"})
          }
        },
        {
          value: "菜单2",
          action: () => {
            prompt.showToast({message: "菜单2"})
          }
        },
        {
          value: "菜单3",
          action: () => {
            prompt.showToast({message: "菜单3"})
          }
        }
      ])
    }
    .height('100%')
    .width('100%')
  }
}