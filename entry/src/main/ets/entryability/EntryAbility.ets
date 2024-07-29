import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

const storage = new LocalStorage();


export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    console.log('on Create testTag', '%{public}s', 'Ability onCreate launchParam',JSON.stringify(launchParam),JSON.stringify(want.parameters));
    storage.set('poetId',want.parameters?.message)
    const poetid:string|undefined = storage.get('poetId')
    globalThis.poetId = want.parameters?.message
    console.log('on create',JSON.stringify(want.parameters),poetid,JSON.stringify(poetid))
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam){
    console.log('on new want launchParam',want,JSON.stringify(launchParam),JSON.stringify(want.parameters),want.parameters?.message)
    storage.set('poetId',want.parameters?.message)
    globalThis.poetId = want.parameters?.message
    const poetid:string|undefined = storage.get('poetId')
    console.log('on new want',JSON.stringify(want.parameters),poetid,JSON.stringify(poetid))
  }

  onDestroy(): void {
    console.log('testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    console.log('testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
        console.log('testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
      // Main window is destroyed, release UI related resources
      console.log('testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
      // Ability has brought to foreground
      console.log('testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
      // Ability has back to background
      console.log('testTag', '%{public}s', 'Ability onBackground');
  }
}
