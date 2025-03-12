import { router } from '@kit.ArkUI'
@Preview
@Component
struct HmNavBar {
  title: string = "测试个人中心"
  showBackIcon: boolean = true
  showtext:boolean = false
  righttext:string = "清空"
  build() {
    Stack({ alignContent:
    Alignment.TopStart }) {
      Row() {
        if (this.title) {
          Text(this.title).fontColor($r('app.color.black')).fontSize(18).fontWeight(600)
        }
      }.justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center).width('100%').height('100%')
      if (this.showBackIcon) {
        Row() {
          Image($r("app.media.icon_left2")).width(20).height(20).onClick(() => {
            router.back() // 回上一页
          })
        }.alignItems(VerticalAlign.Center).width(44)
      }
      if (this.showtext){
        Row() {
          Text(this.righttext).fontSize(15)
        }.alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.End).width("100%").height("100%")
        .margin({left:44})
        .padding({right:44})
      }
    }.backgroundColor($r('app.color.white')).height(50).width('100%').padding(10)
  }
}
export { HmNavBar }