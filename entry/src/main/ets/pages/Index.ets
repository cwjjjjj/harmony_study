import prompt from '@ohos.prompt';
import http from '@ohos.net.http';
import { BusinessError } from '@kit.BasicServicesKit';
import { PoetryDataResponseType } from '../types';
// import { font } from '@kit.ArkUI'
import font from '@ohos.font';
import webview from '@ohos.web.webview';
import { promptAction } from '@kit.ArkUI';

const storage = new LocalStorage();

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

  private menuController: TabsController = new TabsController();
  private tabController: TabsController = new TabsController();
  private webController: WebviewController = new webview.WebviewController();

  @State
  message: string = 'Hello Wor22ld对dqweqwewq 的'
  @State @Watch('onPoetId')
  poetId : string = globalThis.poetId
  @State
  link ?: string = undefined

  onPoetId() {
    promptAction.showToast({ message: '监听变化' })
    console.log('onPoetId change',this.link,this.poetId,this.webController.getUrl())
    this.link = `https://h5.codefuture.top/widgetbox-h5/quickcard/poetry?id=${globalThis.poetId}`
    console.log('onPoetId link',this.link)
    this.webController.loadUrl(this.link)
  }

  // - aboutToAppear 函数在创建自定义组件的新实例后，在执行其 build 函数之前执行。
  // - 允许在 aboutToAppear 函数中改变状态变量，更改将在后续执行 build 函数中生效。
  aboutToAppear() {
    console.log('about to appear',this,globalThis.poetId,storage.get('poetId'))

    font.registerFont({
      familyName:"minFont",
      // familySrc:"../font/minFont.ttf"
      familySrc:$rawfile('minFont.ttf')
    })
  }

  // - aboutToDisappear 函数在自定义组件析构销毁之前执行。
  // - 不允许在 aboutToDisappear 函数中改变状态变量，特别是 @Link 变量的修改可能会导致应用程序行为不稳定。
  aboutToDisappear(){
    console.log('aboutToDisappear',this,globalThis.poetId,storage.get('poetId'))
  }

  onDidBuild(){
    console.log('onDidBuild',this.link,this,globalThis.poetId,storage.get('poetId'))
    // this.webController.loadUrl(this.link)

  }


  // 2）仅页面 `@Entry` 组件
  // - 页面每次显示时触发一次，包括路由过程、应用进入前后台等场景，仅 @Entry 修饰的自定义组件生效。
  onPageShow(){
    console.log('onpageshow',this,globalThis.poetId,storage.get('poetId'))
    this.poetId = globalThis.poetId
    this.link = !globalThis.poetId ? "https://h5.codefuture.top/widgetbox-h5/quickcard/poetry" : `https://h5.codefuture.top/widgetbox-h5/quickcard/poetry?id=${globalThis.poetId}`
    console.log('onpageshow link',this.link,this.poetId)

  }

  // - 页面每次隐藏时触发一次，包括路由过程、应用进入前后台等场景，仅 @Entry 修饰的自定义组件生效。
  onPageHide(){
    console.log('onpagehide',this,globalThis.poetId,storage.get('poetId'))
  }

  // - 当用户点击返回按钮时触发，仅 @Entry 修饰的自定义组件生效。
  onBackPress(){
    console.log('onbackpress',this,globalThis.poetId,storage.get('poetId'))
  }


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
      Tabs({// Tabs不设置vertical属性时，默认上下排版
        barPosition: BarPosition.End,
        controller: this.menuController
      }){
        TabContent() {
          Column(){
            Tabs({// Tabs不设置vertical属性时，默认上下排版
              barPosition: BarPosition.Start,
              controller: this.tabController
            }){
              TabContent() {
                Column(){
                  Text('查看信息').onClick(()=>{
                    console.log('page global this',this.webController.getUrl(),globalThis.poetId,this.poetId,JSON.stringify(globalThis),globalThis.poetId,this.poetId)
                    this.webController.getUrl()
                    this.webController.loadUrl(this.link)
                  })
                    Web({
                      // src: "https://www.arkui.club", // 默认加载 www.arkui.club 网址
                      // https://h5.codefuture.top/widgetbox-h5/quickcard/poetry?id=627ba9d11ab0047b8fc0cdcb
                      src:this.link,
                      controller: this.webController
                    }).onPageEnd(event=>{
                      console.log('onPageEnd',event?.url,this.link)
                    }).onAppear(()=>{
                      console.log('web onappear',this.webController.getUrl(),this.link)
                    })
                      .width("100%")
                      .height("100%")

                }
                .width('100%')
                .height('100%')
                .backgroundColor("orange")
              }.tabBar("消息tab" + this.poetId)
              TabContent() {
                Column()
                {
                  Text('456')
                }
                .width('100%')
                .height('100%')
                .backgroundColor("pink")
              }.tabBar("消息2tab")
            }
          }
            .width('100%')
            .height('100%')
            .backgroundColor("red")
        }.tabBar("消息")
        TabContent() {
          Column()
          {
            Text('456')
          }
            .width('100%')
            .height('100%')
            .backgroundColor("blue")
        }.tabBar("消息2")
      }


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
      Text(this.message + '你好')

      Button('button').onClick(()=>{
        this.message = this.message + '!'
        console.log('message',this.message)
      }).fontColor('red').backgroundColor('green').bindContextMenu(this.MenuBuilder, ResponseType.LongPress)

      Image("https://image-qiniu.jellow.site/FvwncpBP4u-UmgOU6mt_b5S5qkUg.png")
        .width(160)
        .height(160)

      Text("minFont Hello World 你好").fontFamily("minFont")

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