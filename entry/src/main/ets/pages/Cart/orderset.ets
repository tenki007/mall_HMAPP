import {
  Address,
  authRouter,
  CartItem,
  generateConfirmOrder,
  generateOrder,
  HmCustomDialog,
  HmNavBar,
  OrderResult,
  routerParams
} from 'basic'
import { promptAction, router } from '@kit.ArkUI'

@Entry
@Component
struct Order {
  @State orderInformation: OrderResult = {} // 订单信息
  @State ids: number[] = []
  @State currentAddress: Address = {} // 当前收货地址
  @State orderId:number=0
  // 自定义弹窗控制器
  dialogController: CustomDialogController = new CustomDialogController({
    builder: HmCustomDialog(),
    customStyle: true, // 启用自定义布局样式
    alignment: DialogAlignment.Bottom // 底部对齐
  })

  // 初始化页面数据
  async onPageShow(): Promise<void> {
    const params: routerParams = router.getParams() as routerParams
    if (params) {
      if (params.ids) {
        // 获取生成订单数据
        this.orderInformation = await generateConfirmOrder(params.ids as number[])
        this.ids = params.ids as number[]
        // 从订单数据中获取默认地址
        let i = this.orderInformation.memberReceiveAddressList?.findIndex((v: Address) => v.defaultStatus == 1)
        if (i != -1) {
          this.currentAddress = (this.orderInformation.memberReceiveAddressList as Address[])[i as number]
        }
      }
      // 获取先择的地址
      if (params.address) {
        this.currentAddress = params.address as Address
      }
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          HmNavBar({ title: "创建订单" })
          // 地址
          this.getAddress()
          // 条纹分割线
          Image($r("app.media.dividingLine"))
            .width('100%')
            .margin({ bottom: 5 })

          Text("商品信息")
            .width("100%")
            .fontSize(13)
            .fontColor($r("app.color.text_normal_2"))
            .padding({ top: 10, bottom: 10, left: 20 })
            .backgroundColor($r("app.color.white"))

          Divider()
            .color($r("app.color.divider"))

          // 商品信息列表
          Column() {
            ForEach(this.orderInformation.cartPromotionItemList, (item: CartItem) => {
              this.getCartPromotionItem(item)
            })
          }
          .backgroundColor($r("app.color.white"))
          .padding({ bottom: 4 })
          .margin({ bottom: 8 })

          // 选择优惠券
          Row() {
            Text("券")
              .fontSize(11)
              .fontColor($r("app.color.white"))
              .padding(1)
              .borderRadius(2)
              .backgroundColor("#f85e52")
            Text(" 优惠券")
              .fontSize(13)
              .fontColor($r("app.color.text_normal_3"))
            Text("选择优惠券")
              .textAlign(TextAlign.End)
              .fontSize(13)
              .fontColor($r("app.color.btn_color_2"))
              .layoutWeight(1)
          }
          .padding({ left: 15, right: 10 })
          .height(36)
          .backgroundColor($r("app.color.white"))
          .onClick((event) => {
            this.dialogController.open()
          })

          Divider().color($r("app.color.divider"))
          // 积分抵扣
          Row() {
            Text("积")
              .fontSize(11)
              .fontColor($r("app.color.white"))
              .padding(1)
              .borderRadius(2)
              .backgroundColor("#ffaa0e")
            Text(" 积分抵扣")
              .fontSize(13)
              .fontColor($r("app.color.text_normal_3"))
            Text("0")
              .textAlign(TextAlign.End)
              .fontSize(13)
              .layoutWeight(1)
          }
          .padding({ left: 15, right: 10 })
          .height(36)
          .backgroundColor($r("app.color.white"))

          // 订单价格计算
          if (this.orderInformation.calcAmount) {
            Column() {
              this.getOrderInformation("商品合计", this.orderInformation.calcAmount.totalAmount as number)
              this.getOrderInformation("运费", 0)
              this.getOrderInformation("活动优惠", this.getReduceAmount(), true)
              this.getOrderInformation("优惠券", 0, true)
              this.getOrderInformation("积分抵扣", 0, true)
            }
            .margin({ top: 8 })
          }
          Row() {
            Text("备注")
              .fontSize(13)
              .fontColor($r("app.color.text_normal_3"))
            TextInput({ text: "", placeholder: "请填写备注信息" })
              .padding({ top: 0, bottom: 0, left: 25 })
              .placeholderFont({ size: 13 })
              .backgroundColor($r("app.color.white"))
          }
          .width("100%")
          .padding({
            left: 15,
            right: 10,
            bottom: 10,
            top: 10
          })
          .borderWidth({ bottom: 1 })
          .borderColor($r("app.color.divider"))
          .backgroundColor($r("app.color.white"))
          .justifyContent(FlexAlign.SpaceBetween)

        }

      }
      .width('100%')
      .padding({ bottom: 55 })
      .backgroundColor($r("app.color.page_bcg"))

      Row() {
        Text() {
          Span("实付款 ")
            .fontSize(14)
            .fontColor($r("app.color.text_normal_3"))
          Span("￥")
            .fontSize(14)
            .fontColor($r("app.color.btn_color_2"))
          Span(this.orderInformation.calcAmount?.payAmount + "")
            .fontSize(16)
            .fontColor($r("app.color.btn_color_2"))
        }

        Button("提交订单")
          .width(120)
          .type(ButtonType.Normal)
          .backgroundColor($r("app.color.btn_color_2"))
          .onClick((event: ClickEvent) => {
            this.submitOrder()
          })
      }
      .height(50)
      .width("100%")
      .backgroundColor($r("app.color.white"))
      .padding({ left: 10 })
      .justifyContent(FlexAlign.SpaceBetween)
    }

  }

  // 提交订单
  submitOrder() {
    generateOrder({
      cartIds: this.ids,
      memberReceiveAddressId: this.currentAddress.id,
      payType: 0,
      useIntegration: 0
    }).then((res) => {
      this.orderId=res.order?.id as number
      promptAction.showDialog({
        title: "提示",
        message: "订单创建成功，是否要立即支付？",
        buttons: [
          { text: "取消", color: "#FF000000" },
          { text: "去支付", color: "#FF007AFF" }
        ]
      }).then((result) => {
        if (result.index == 1) {
          router.replaceUrl({ url: "pages/Cart/pay",params:{id:this.orderId} })
        } else if (result.index == 0) {
          router.replaceUrl({ url: "pages/My/Details/order" })
        }
      })
    })
  }

  // 获取全部活动优惠
  getReduceAmount() {
    let reduceAmount = 0
    for (const element of this.orderInformation.cartPromotionItemList as CartItem[]) {
      reduceAmount += element.reduceAmount as number
    }
    return reduceAmount
  }

  // 封装订单信息
  @Builder
  getOrderInformation(str: string, num: number, isRed: boolean = false) {
    Row() {
      Text(str)
        .fontSize(13)
        .fontColor($r("app.color.text_normal_3"))
      Text((isRed ? "-￥" : "￥") + num)
        .fontSize(13)
        .fontColor(isRed ? $r("app.color.btn_color_2") : $r("app.color.black"))
    }
    .width("100%")
    .padding({
      left: 15,
      right: 10,
      bottom: 10,
      top: 10
    })
    .borderWidth({ bottom: 1 })
    .borderColor($r("app.color.divider"))
    .backgroundColor($r("app.color.white"))
    .justifyContent(FlexAlign.SpaceBetween)
  }

  // 封装订单商品项
  @Builder
  getCartPromotionItem(item: CartItem) {
    Row() {
      // 商品图片
      Image(item.productPic)
        .width(70)
        .padding(4)
        .margin({ right: 10 })
      Column() {
        // 商品名称
        Text(item.productName)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .fontSize(13)
        // 商品属性
        Text() {
          ForEach(JSON.parse(item.productAttr as string), (v: object, i: number) => {
            Span(JSON.parse(item.productAttr as string)[i].key + ":")
            Span(JSON.parse(item.productAttr as string)[i].value + ";")
          })
        }
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .fontSize(12)
        .fontColor($r('app.color.text_normal_3'))

        // 商品优惠
        Text(item.promotionMessage)
          .fontSize(11)
          .lineHeight(16)
          .fontColor($r('app.color.btn_color_2'))

        // 商品价格
        Text() {
          Span("￥" + item.price + "  ×" + item.quantity)
            .fontSize(13)
        }
        .lineHeight(18)

      }
      .layoutWeight(1)
      .padding({ right: 4 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(6)
  }

  // 封装地址UI
  @Builder
  getAddress() {
    Row() {
      Image($r("app.media.icon_gps2"))
        .width(20)
        .margin({ right: 10 })
      // 收货地址
      Column() {
        Text() {
          // 收货人姓名
          Span(this.currentAddress.name as string + "   ")
          Span(this.currentAddress.phoneNumber)
            .fontSize(12)
        }
        .margin({ bottom: 8 })

        // 收货地址
        Text(this.currentAddress.province)
          .width("80%")
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .fontSize(12)
          .fontColor($r("app.color.text_normal_2"))
        // 详细地址
        Text(this.currentAddress.detailAddress)
          .width("80%")
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .fontSize(12)
          .fontColor($r("app.color.text_normal_2"))
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r("app.media.icon_right_svg"))
        .fillColor($r("app.color.text_normal"))
        .width(12)
    }
    .width('100%')
    .padding(10)
    .onClick(() => {
      authRouter("pages/My/Details/AddressList", { name: "选择收货地址" })
    })
  }
}