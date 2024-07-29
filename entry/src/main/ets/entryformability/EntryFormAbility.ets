// import { formBindingData, FormExtensionAbility, formInfo } from '@kit.FormKit';
// import { Want } from '@kit.AbilityKit';
import { formBindingData, FormExtensionAbility, formInfo, formProvider } from '@kit.FormKit';
import { Configuration, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import http from '@ohos.net.http';
import { JSON } from '@kit.ArkTS';
import { PoetryDataResponseType } from '../types';
import font from '@ohos.font';


interface DataType {
  poetId: string;
  content: string;
  author:string;
}


let httpRequest: http.HttpRequest;

const DATA_URL = 'https://widget-box-api.codefuture.top/v1/widgets/hitokoto-dark/get?random=true'
const FONT_URL = 'https://other-qiniu.jellow.site/ljex8sviXGkZg2h25ITy-GuqJwKl.ttf'
let formData: DataType
const TAG: string = 'EntryFormAbility';
const DOMAIN_NUMBER: number = 0xFF00;

const countPunctuation = (str:string) => {
  const punct = "，。？！";
  let count = 0;
  for (let i = 0; i < str.length; i++) {
    if (!punct.includes(str[i])) {
      continue;
    };
    count++;
  };
  return count;
}
let content = ''

export default class EntryFormAbility extends FormExtensionAbility {
  // private httpRequest: http.HttpRequest;

  constructor() {
    super();
    font.registerFont({
      familyName:"minFont",
      // familySrc:"../font/minFont.ttf"
      familySrc:$rawfile('minFont.ttf')
    });
    // if(!this.httpRequest){
    //   this.httpRequest = http.createHttp();
    // }
  }

  onAddForm(want: Want) {
    font.registerFont({
      familyName:"minFont",
      // familySrc:"../font/minFont.ttf"
      familySrc:$rawfile('minFont.ttf')
    })
    // Called to return a FormBindingData object.
    let httpRequest = http.createHttp()
    httpRequest.request(DATA_URL,{
      header: {
        'Content-Type': 'application/json'
      },
      expectDataType: http.HttpDataType.OBJECT
    }).then(res=>{
      console.log('http get data res',res,JSON.stringify(res),'@@',JSON.stringify(res.result),JSON.stringify(want))
      formData = {
        poetId:'ttttest',
        content:JSON.stringify(res.result),
        author:'author'
      }
    }).catch((err:BusinessError)=>{
      console.log('get data err')
      formData = {
        poetId:'ttttest',
        content:'on add form error',
        author:'on add form error author'
      }
    })
    // let formData: DataType = {
    //   id: '鸿蒙雄起-刷新后',
    //   content: '鸿蒙千帆起，我要当舵手 - 刷新后'
    // };
    let id = want?.parameters?.[formInfo.FormParam.IDENTITY_KEY];
    console.log('my form id', id)
    // if(id){
    //   // 3. 更新数据到卡片上
    //   formProvider.updateForm(id.toString(),formData).then(res=>{
    //     console.log('mylog','更新成功',res);
    //   }).catch((err:Error)=>{
    //     console.log('mylog','更新失败');
    //   });
    // }


    return formBindingData.createFormBindingData(formData);
  }

  onCastToNormalForm(formId: string) {
    // Called when the form provider is notified that a temporary form is successfully
    // converted to a normal form.
    console.log('@@onCastToNormalForm',formId)
  }

  onUpdateForm(formId: string) {
    // Called to notify the form provider to update a specified form.
    console.log('@@onUpdateForm')
  }

  onFormEvent(formId: string, message: string) {
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
      if(countPunctuation(response.entry.quotes) >= 3){
        content = response.entry.quotes.replace(/[，。？！]/g, (m) => { return m + '\n' }).slice(0, -1)
      }else{
        content = response.entry.quotes
      }
      let formData:DataType = {
        poetId:response?.entry?.id ?? JSON.stringify(response?.entry),
        content:content ?? JSON.stringify(response?.entry),
        author:response?.entry?.author ?? JSON.stringify(response?.entry),
      }
      let formInfo = formBindingData.createFormBindingData(formData)
      formProvider.updateForm(formId, formInfo)
    }).catch((err:BusinessError)=>{
      console.log('@@get data err onFormEvent',JSON.stringify(err))
      let formData:DataType = {
        poetId:'ttttest',
        content:'error on form event' + JSON.stringify(err),
        author:'author error on form event' + JSON.stringify(err),
      }
      let formInfo = formBindingData.createFormBindingData(formData)
      formProvider.updateForm(formId, formInfo)
    })
    console.log('@@onFormEvent end',message)
  }

  onChangeFormVisibility() {
    // Called when the form provider receives form events from the system.
    // 需要配置formVisibleNotify为true，且为系统应用才会回调
    console.info('@@[EntryFormAbility] onChangeFormVisibility');
  }

  onRemoveForm(formId: string) {
    // Called to notify the form provider that a specified form has been destroyed.
    console.log('@@onRemoveForm')

  }

  onConfigurationUpdate() {
    // 当系统配置信息置更新时触发的回调
    console.info('@@[EntryFormAbility] configurationUpdate:');
  }


  onAcquireFormState(want: Want) {
    // Called to return a {@link FormState} object.
    console.log('@@onAcquireFormState')
    return formInfo.FormState.READY;
  }
};