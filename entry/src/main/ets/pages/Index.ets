import { window } from '@kit.ArkUI';
import { Context } from '@ohos.abilityAccessCtrl';
import { webview } from '@kit.ArkWeb';

@Entry
@Component
struct Index {
  context:Context = getContext(this)
  controller: webview.WebviewController = new webview.WebviewController();
  windowClass = window.getLastWindow(this.context)
  @State gaming:boolean = false
  @State uri:string = ''

  onBackPress(): boolean | void {
    if(!this.gaming){return false}
    this.controller.backward()
    return true
  }

  async aboutToAppear(): Promise<void> {
    await (await this.windowClass).setWindowLayoutFullScreen(true)
    await (await this.windowClass).setSpecificSystemBarEnabled('status', false)
    await (await this.windowClass).setSpecificSystemBarEnabled('navigationIndicator', false)
    await (await this.windowClass).setWindowKeepScreenOn(true)
  }

  build() {
    Stack() {

     List({space:50 }){
       ListItem().padding(15)
       ListItem(){
         Image($r('app.media.genshin')).width(160).height(160).borderRadius(30).clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.9 }).draggable(false)
           .onClick(() => {
             this.uri = 'https://ys.mihoyo.com/cloud/#/'
             this.gaming = true
           })
       }.padding(30)
       ListItem() {
         Image($r('app.media.starrail')).width(160).height(160).borderRadius(30).clickEffect({ level: ClickEffectLevel.LIGHT, scale: 0.9 }).draggable(false)
           .onClick(() => {
             this.uri = 'https://sr.mihoyo.com/cloud/#/'
             this.gaming = true
           })
       }.padding(30)
       ListItem().padding(15)
      }
      .height('100%')
     .chainAnimation(true)
      .scrollBar(BarState.Off)
      .alignListItem(ListItemAlign.Center)
     .listDirection(Axis.Horizontal)
    .visibility(this.gaming ? Visibility.Hidden : Visibility.Visible)
    .transition(TransitionEffect.OPACITY.animation({ duration:300}))


      if (this.gaming){
        Web({ src: this.uri, controller: this.controller })
          .height('100%')
          .height('100%')
          .javaScriptAccess(true)
          .cacheMode(CacheMode.Default)
          .allowWindowOpenMethod(true)
          .domStorageAccess(true)
          .databaseAccess(true)
          .fileAccess(true)
          .mixedMode(MixedMode.Compatible)
          .transition(TransitionEffect.OPACITY.animation({ duration:300}))
          .darkMode(WebDarkMode.Auto)
      }


    }
    .backgroundColor($r('app.color.start_window_background'))
    .height('100%')
    .width('100%')
  }
}