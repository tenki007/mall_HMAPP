import { PmsProduct, PmsSkuStock, PmsPortalProductDetail, property, propertyArr } from "../models"

// 规格选择自定义弹窗
@CustomDialog
@Component
export struct SpecsDialog {
  controller?: CustomDialogController
  @Link item: PmsPortalProductDetail | null // 商品详情
  @Link itemProperty: property[] | null //  选中规格
  @Link AllProperty: propertyArr[] | null // 商品规格
  @Link itemSkuStock: PmsSkuStock | null // 商品规格相关参数
  @Link PropertyName: string // 商品规格名称

  build() {
    Column() {
      this.buildSpecsItem()

      ForEach(this.AllProperty, (v: propertyArr, i: number) => {
        this.buildSpecs(v)
      })

      Button("完成")
        .width("90%")
        .height(35)
        .fontSize(14)
        .padding({ top: 5, bottom: 5 })
        .margin({ top: 20, bottom: 40 })
        .fontColor($r("app.color.white"))
        .backgroundColor($r("app.color.btn_color_2"))
        .onClick((event: ClickEvent) => {
          this.controller?.close()
        })
    }
    .width("100%")
    .borderRadius({ topLeft: 6, topRight: 6 })
    .backgroundColor($r("app.color.white"))
  }

  // 当前规格信息
  @Builder
  buildSpecsItem() {
    Row() {
      // 图片
      Image(this.item?.product?.pic)
        .height("100%")
        .borderRadius(5)
        .offset({ y: -15 })
      Column() {
        // 金额
        Text() {
          Span("￥")
            .fontSize(13)
          Span(this.itemSkuStock?.price?.toString())
            .fontSize(14)
        }
        .fontColor($r("app.color.btn_color_2"))

        // 库存
        Text("库存: " + this.itemSkuStock?.stock?.toString())
          .fontSize(13)
          .lineHeight(25)
          .fontColor($r("app.color.text_normal_3"))
        // 已选
        Text("已选: " + this.PropertyName)
          .fontSize(13)
          .fontColor($r("app.color.text_normal_3"))
          .lineHeight(18)
      }
      .height("100%")
      .padding({ left: 15, top: 15 })
      .alignItems(HorizontalAlign.Start)
    }
    .width("100%")
    .height(100)
    .padding({ left: 15 })
  }

  // 规格选项
  @Builder
  buildSpecs(item: propertyArr) {
    Column() {
      Text(item.key)
        .fontColor($r("app.color.text_normal_3"))
        .margin({ top: 15, bottom: 8 })
      Row({ space: 10 }) {
        ForEach(item.value, (v: string, i: number) => {
          Text(v)
            .borderRadius("50%")
            .fontSize(14)
            .fontColor(this.itemProperty?.findIndex(e => e.value == v) == -1 ?
            $r("app.color.text_normal_3") : $r("app.color.btn_color_2"))
            .padding({
              left: 15,
              right: 15,
              top: 5,
              bottom: 5
            })
            .backgroundColor(this.itemProperty?.findIndex(e => e.value == v) == -1 ?
            $r("app.color.divider") : $r("app.color.btn_color_1"))
            .onClick((event) => {
              // 这里直接修改对象内部第单一属性值时不会触发UI刷新需要变更整体对象所以先克隆一份然后修改克隆对象修改好后直接覆盖原来对象
              let temp = this.itemProperty
              this.itemProperty = []
              let i = temp?.findIndex(v => v.key == item.key)
              if (i !== -1) {
                (temp as property[])[i as number].value = v
              }
              this.itemProperty = temp
            })
        })
      }
    }
    .width("100%")
    .padding({ left: 15 })
    .alignItems(HorizontalAlign.Start)
  }
}