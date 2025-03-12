import { authRouter } from "../../../../Index"
import { Address } from "../models/address"

@Component
struct addressCard {
  defaulticon:ResourceStr = ''
  @Prop item:Address
  build() {
    Column(){
      Row(){
        Column({space:5}) {
          Row({ space: 5 }) {
            if (this.item.defaultStatus===1) {
              Image($r('app.media.icon_default')).size({ width: 28 })
            }
            Text(this.item.province + ' ' + this.item?.city + '  ' + this.item.detailAddress).fontSize(15)
              .fontColor($r("app.color.black"))
          }

          Text(this.item.name + "   " + this.item.phoneNumber)
            .fontSize(13)
            .fontColor($r('app.color.text_normal'))
        }.alignItems(HorizontalAlign.Start)
        Row({ space: 16 }) {
          // 编辑
          Image($r("app.media.icon_edit"))
            .width(18)
            .onClick(() => {
              authRouter("pages/My/Details/addAddress", { id: this.item.id as number, name: "编辑收获地址" })
            })
          // 删除
          Image($r("app.media.icon_delete"))
            .width(18)
            .onClick(() => {

            })
        }
      }.width('100%').padding(15)
      .justifyContent(FlexAlign.SpaceBetween)
      Divider()
    }

  }
}
export { addressCard }