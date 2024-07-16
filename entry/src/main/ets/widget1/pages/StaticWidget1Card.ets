@Entry
@Component
struct Widget1Card {
  /*
   * The title.
   */
  readonly TITLE: string = 'Hello World对对对ddd';
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

  build() {
    Row() {
      Column() {
        Image($r('app.media.god')).translate({x:'8%',y:'20%'})
      }
    }
    .height(this.FULL_HEIGHT_PERCENT)
    .width(this.FULL_WIDTH_PERCENT)
    .backgroundImage($r('app.media.bg'))
    .backgroundImageSize({width:'100%',height:'100%'})
    .onClick(() => {
      postCardAction(this, {
        action: this.ACTION_TYPE,
        abilityName: this.ABILITY_NAME,
        params: {
          message: this.MESSAGE
        }
      });
    })
  }
}