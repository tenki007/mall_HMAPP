import { HmNavBar, routerParams } from 'basic'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct PaySuccess {
  build() {
    Column() {
      HmNavBar({ title: "支付成功" })
      Image($r("app.media.icon_Success"))
        .width(80)
        .margin({ top: 40, bottom: 10 })
        .fillColor($r('app.color.btn_color_2'))
      Text("支付成功")
        .margin({ bottom: 60 })

      Button("查看订单")
        .width("90%")
        .type(ButtonType.Normal)
        .borderRadius(6)
        .margin({ bottom: 15 })
        .backgroundColor($r('app.color.btn_color_2'))
        .onClick((event: ClickEvent) => {
          router.replaceUrl({
            url: 'pages/My/My_Orders',
            params: { name: "pages/Index", id: 2 } as routerParams
          })
        })

      Button("返回首页")
        .width("90%")
        .type(ButtonType.Normal)
        .borderRadius(6)
        .fontColor($r('app.color.text_normal_3'))
        .backgroundColor($r('app.color.white'))
        .borderWidth(1)
        .borderColor($r('app.color.text_normal'))
        .onClick((event: ClickEvent) => {
          router.replaceUrl({ url: 'pages/Index' })
        })

    }
    .height('100%')
    .width('100%')
  }
}