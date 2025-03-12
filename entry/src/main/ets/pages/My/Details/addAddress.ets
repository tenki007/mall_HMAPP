import { addAddress, Address, getAddressById, HmNavBar, routerParams, updateAddress } from 'basic';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct AddAddress {
  @State Address: Address = {}
  @State textWidth: number = 64
  @State title: string = "新增收货地址"
  async  aboutToAppear() {
    const params = router.getParams() as routerParams
    if (params.id) {
      this.Address = await getAddressById(params.id)
    }
    if (params.name) {
      this.title = params.name
    }
    if (this.Address.defaultStatus===1) {
      this.Address.default=true
    }
    this.Address.city=''
}
  @Styles
  itemBoxStyle(){
    .width("100%")
    .height(50)
    .padding({ left: 10, right: 10 })
    .borderWidth({ bottom: 0.5 })
    .borderColor($r('app.color.box_bottom_line'))
    .backgroundColor($r('app.color.white'))
  }
  build() {
    Column() {
      if (this.title) {
        HmNavBar({ title: this.title })
      }
      // 分割线
      Row().width("100%").height(8)

      // 姓名
      Row() {
        Text("姓名")
          .width(this.textWidth)
        TextInput({ placeholder: "收货人姓名", text: $$this.Address.name })
          .placeholderColor($r('app.color.text_placeholder'))
          .backgroundColor($r('app.color.transparent'))
          .placeholderFont({ size: 14 })
          .fontSize(14)
      }
      .itemBoxStyle()

      // 手机号码
      Row() {
        Text("手机号码")
          .width(this.textWidth)
        TextInput({ placeholder: "收货人手机号码", text: $$this.Address.phoneNumber })
          .placeholderColor($r('app.color.text_placeholder'))
          .backgroundColor($r('app.color.transparent'))
          .placeholderFont({ size: 14 })
          .fontSize(14)
      }
      .itemBoxStyle()

      // 邮政编号
      Row() {
        Text("邮政编号")
          .width(this.textWidth)
        TextInput({ placeholder: "收货人邮政编号", text: $$this.Address.postCode })
          .placeholderColor($r('app.color.text_placeholder'))
          .backgroundColor($r('app.color.transparent'))
          .placeholderFont({ size: 14 })
          .fontSize(14)
      }
      .itemBoxStyle()

      // 所在区域
      Row() {
        Text("所在区域")
          .width(this.textWidth)
        TextInput({ placeholder: "所在区域", text: $$this.Address.province })
          .placeholderColor($r('app.color.text_placeholder'))
          .backgroundColor($r('app.color.transparent'))
          .placeholderFont({ size: 14 })
          .fontSize(14)
      }
      .itemBoxStyle()

      // 详细地址
      Row() {
        Text("详细地址")
          .width(this.textWidth)
        TextInput({ placeholder: "详细地址", text: $$this.Address.detailAddress })
          .placeholderColor($r('app.color.text_placeholder'))
          .backgroundColor($r('app.color.transparent'))
          .placeholderFont({ size: 14 })
          .fontSize(14)
      }
      .itemBoxStyle()

      // 分割线
      Row().width("100%").height(8)

      Row() {
        Text("设为默认")
          .width(this.textWidth)
        Toggle({ type: ToggleType.Switch, isOn: $$this.Address.default })
          .height(26)
          .width(40)
          .selectedColor($r('app.color.login_btn_red'))
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ bottom: 30 })
      .itemBoxStyle()



      Button("提交")
        .type(ButtonType.Normal)
        .width("90%")
        .height(36)
        .borderRadius(6)
        .backgroundColor($r('app.color.login_btn_red'))
        .onClick(async (event: ClickEvent) => {
          if (this.title == "新增收货地址") {
            this.Address.default ? this.Address.defaultStatus = 1 : this.Address.defaultStatus = 0
            // 提交
            await addAddress(this.Address)
          } else {
            this.Address.default ? this.Address.defaultStatus = 1 : this.Address.defaultStatus = 0
            // 修改
            await updateAddress(this.Address)
          }
          // 返回
          router.back()
        })

    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.page_bcg'))
  }
}
