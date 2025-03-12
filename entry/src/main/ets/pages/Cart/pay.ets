import { getOrderDetail, HmNavBar, OrderDetail, paySuccess, payTypeEnum, routerParams } from 'basic';
import { promptAction, router } from '@kit.ArkUI';

@Entry
@Component
struct Pay {
  @State OrderDetail: OrderDetail = {} as OrderDetail

  async aboutToAppear(): Promise<void> {
    const params: routerParams = router.getParams() as routerParams
    if (params) {
      if (params.id) {
        this.OrderDetail = await getOrderDetail(params.id) as OrderDetail
        this.OrderDetail.payType = payTypeEnum.ALIPAY // 默认支付宝支付
      }
    } else {
      this.OrderDetail = await getOrderDetail(138) as OrderDetail
    }
  }

  build() {
    Column() {
      HmNavBar({ title: "支付" })
      Column() {
        Text("支付金额")
          .fontSize(13)
          .fontColor($r('app.color.text_normal_2'))
        Text("￥" + this.OrderDetail.payAmount) {
          Span("￥")
            .fontSize(16)
          Span("" + this.OrderDetail.payAmount)
            .fontSize(22)
        }
      }
      .margin({ top: 30, bottom: 40 })

      // 支付宝支付
      Row() {
        Image($r("app.media.Alipay_pay"))
          .width(30)

        Column() {
          Text("支付宝支付")
          Text("推荐使用支付宝支付")
            .fontSize(12)
            .fontColor($r('app.color.text_normal_2'))
        }
        .padding({ left: 20 })
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Radio({
          group: 'payType',
          value: payTypeEnum.ALIPAY + ""
        })
          .checked(true)
          .radioStyle({ checkedBackgroundColor: $r('app.color.btn_color_2') })
          .onChange((selected: boolean) => {
            if (selected) {
              this.OrderDetail.payType = payTypeEnum.ALIPAY
            }
          })
      }
      .margin({ left: 25 })
      .padding({ bottom: 10, top: 10, right: 25 })
      .borderWidth({ bottom: 1 })
      .borderColor($r('app.color.divider'))

      // 微信支付
      Row() {
        Image($r("app.media.WeChat_pay"))
          .width(30)
        Column() {
          Text("微信支付")
        }
        .padding({ left: 20 })
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)


        Radio({
          group: 'payType',
          value: payTypeEnum.WECHAT + ""
        })
          .radioStyle({ checkedBackgroundColor: $r('app.color.btn_color_2') })
          .onChange((selected: boolean) => {
            if (selected) {
              this.OrderDetail.payType = payTypeEnum.WECHAT
            }
          })
      }
      .margin({ left: 25, bottom: 40 })
      .padding({ bottom: 10, top: 10, right: 25 })
      .borderWidth({ bottom: 1 })
      .borderColor($r('app.color.divider'))

      Button("确认支付")
        .width("90%")
        .type(ButtonType.Normal)
        .borderRadius(6)
        .backgroundColor($r('app.color.btn_color_2'))
        .onClick((event: ClickEvent) => {
          paySuccess(this.OrderDetail).then((res: number) => {
            if (res === 1) {
              router.replaceUrl({ url: "pages/Cart/paySuccess" })
            } else {

            }
          }).catch(() => {
            promptAction.showToast({ message: "支付失败" })
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}