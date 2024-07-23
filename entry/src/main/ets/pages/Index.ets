import prompt from '@ohos.prompt';
import http from '@ohos.net.http';
import { BusinessError } from '@kit.BasicServicesKit';
import { PoetryDataResponseType } from '../types';

class User {
  nickname?: string
  age?: number
}
const DATA_URL = 'https://widget-box-api-beta.codefuture.top/v1/widgets/hitokoto-dark/get'

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

      Text('http get')
        .id('http')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        }).sameStyle().onClick(()=>{
        let httpRequest = http.createHttp()
        httpRequest.request(DATA_URL,{
          header: {
            'Content-Type': 'application/json'
          },
          expectDataType: http.HttpDataType.OBJECT
        }).then((res:http.HttpResponse)=>{
          if(!res.result){
            return
          }
          const response = res.result as PoetryDataResponseType
          this.message = JSON.stringify(response.entry.title)
          // this.message = response.entry.id
          console.log('@@response',JSON.stringify(response),JSON.stringify(response.id),JSON.stringify(response.entry))
        }).catch((err:BusinessError)=>{
          console.log('@@get data err onFormEvent',JSON.stringify(err))
          this.message = JSON.stringify(JSON.stringify(err))
        })
      })
      Text(this.message)

      Button('button').onClick(()=>{
        this.message = this.message + '!'
        console.log('message',this.message)
      }).fontColor('red').backgroundColor('green').bindContextMenu(this.MenuBuilder, ResponseType.LongPress)

      Image("https://image-qiniu.jellow.site/FvwncpBP4u-UmgOU6mt_b5S5qkUg.png")
        .width(160)
        .height(160)

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