import { CartItem } from '../models/CartItem'

@Preview
@Component
struct HmCartItem {
  @State item: CartItem = {}
  onDelete: (id: CartItem) => void = (id: CartItem) => {
  }
  onQuantityChange: (item: CartItem) => void = (item: CartItem) => {
  }

  build() {
    Row() {
      Image(this.item.productPic)
        .width(110)
        .padding({ right: 10 })

      Stack({ alignContent: Alignment.TopEnd }) {
        Column() {
          // 名称
          Text(this.item.productName)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
            .fontSize(15)
          // 属性
          Text() {
            ForEach(JSON.parse(this.item.productAttr as string), (v: object, i: number) => {
              Span(JSON.parse(this.item.productAttr as string)[i].key + ":")
                .fontSize(13)
                .fontColor($r('app.color.text_normal'))
              Span(JSON.parse(this.item.productAttr as string)[i].value + ";")
                .fontSize(13)
                .fontColor($r('app.color.text_normal'))
            })
          }
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .lineHeight(20)

          Text("￥" + this.item.price)
            .fontSize(14)
            .lineHeight(24)
            .baselineOffset(12)
          Row() {
            Button("-")
              .type(ButtonType.Normal)
              .height(30)
              .width(30)
              .borderWidth(0)
              .padding(0)
              .fontSize(20)
              .fontColor($r('app.color.text_normal'))
              .backgroundColor($r('app.color.page_bcg'))
              .enabled((this.item.quantity as number) > 1)
              .onClick((event: ClickEvent) => {
                (this.item.quantity as number)--
                this.onQuantityChange(this.item)
              })
            TextInput({ text: this.item.quantity?.toString() })
              .type(InputType.Number)
              .width(40)
              .height(30)
              .padding(0)
              .borderRadius(0)
              .fontSize(14)
              .textAlign(TextAlign.Center)
              .backgroundColor($r('app.color.page_bcg'))
              .onChange((e) => {
                if (parseInt(e) !== this.item.quantity) {
                  this.item.quantity = parseInt(e)
                  this.onQuantityChange(this.item)
                }
              })
            Button("+")
              .type(ButtonType.Normal)
              .height(30)
              .width(30)
              .borderWidth(0)
              .padding(0)
              .fontSize(20)
              .fontColor($r('app.color.text_normal'))
              .backgroundColor($r('app.color.page_bcg'))
              .onClick((event: ClickEvent) => {
                (this.item.quantity as number)++
                this.onQuantityChange(this.item)
              })
          }

        }
        // .layoutWeight(1)
        .width("63%")
        .alignItems(HorizontalAlign.Start)


        // 删除按钮
        Text("×")
          .fontSize(30)
          .fontWeight(FontWeight.Lighter)
          .fontColor($r('app.color.text_normal'))
          .offset({ x: 0, y: -8 })
          .onClick((event) => {
            this.onDelete(this.item)
          })
      }
    }
    .width("100%")
    .padding(10)

  }
}

export { HmCartItem }