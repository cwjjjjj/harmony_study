const storage = new LocalStorage();

@Entry
@Component
struct Dynamicwidget1Card {
  // 接收 EntryFormAbility 传递过来的数据
  @LocalStorageProp("poetId") poetId: string = '';
  @LocalStorageProp("content") content: string = ''
  @LocalStorageProp("author") author: string = ''

  /*
   * The title.
   */
  readonly TITLE: string = 'Hello';
  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';
  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'EntryAbility';
  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';
  /*
   * The width percentage setting.
   */
  readonly FULL_WIDTH_PERCENT: string = '100%';
  /*
   * The height percentage setting.
   */
  readonly FULL_HEIGHT_PERCENT: string = '100%';

  readonly DATA_URL:string = 'https://widget-box-api.codefuture.top/v1/widgets/hitokoto-dark/get'
  readonly IMG_SRC:string = "https://image-qiniu.jellow.site/FvwncpBP4u-UmgOU6mt_b5S5qkUg.png"


  getData(){

  }

  build() {
    Column() {
      // content
      Row() {
        Text(this.content)
        Image($r('app.media.refresh_icon'))
        .height('16vp')
        .width('16vp')
        .onClick(() => {
          console.log('@@ this is card',this.poetId,this.content)
          postCardAction(this, {
            action: 'message',
            abilityName: this.ABILITY_NAME,
            params: {
              message: this.MESSAGE
            }
          });
        })
      }
      .width('100%')
      .height('calc(100% - 20vp)')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

    //   author
      Row(){
        Text().height('18vp').width('2vp').backgroundColor('#BB1515').margin('8vp').borderRadius('8vp')
        Text(this.author).fontFamily('minFont')
      }.width('100%').justifyContent(FlexAlign.End)

    }
    .height('100%')
    .width('100%')
    .padding('20vp')
    .backgroundImage($r('app.media.poetry_white_bg'))
    .backgroundImageSize({width:'100%',height:'100%'})
    .onClick(async () => {
      console.log('@@ this is card',this.poetId,this.content,JSON.stringify(globalThis))
      globalThis.poetId = this.poetId
      console.log('new globalthis poetid',globalThis.poetId)
      await storage.set('poetId',this.poetId)

      postCardAction(this, {
        action: 'router',
        abilityName: this.ABILITY_NAME,
        params: {
          message: this.poetId,
        }
      });
    })
  }
}