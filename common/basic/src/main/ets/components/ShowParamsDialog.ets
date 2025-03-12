import { PmsProductAttribute, PmsProductAttributeValue, PmsPortalProductDetail } from '../models'

// 查看商品参数弹窗
@CustomDialog
@Component
export struct ShowParamsDialog {
  controller: CustomDialogController
  @Link item: PmsPortalProductDetail | null

  build() {
    Column() {
      ForEach(this.item?.productAttributeList, (v: PmsProductAttribute, i: number) => {
        if (i > 1 && this.getValue(v.id as number) != "") {
          Row() {
            Text(v.name)
              .width('22%')
              .fontSize(14)
              .fontColor($r("app.color.text_normal_3"))
            Text(this.getValue(v.id as number))
              .fontSize(14)
          }
          .width('100%')
          .padding({top:8,bottom:8,left:10,right:10})
          .borderWidth({bottom:1})
          .borderColor($r("app.color.divider"))
        }
      })
    }
    .width('100%')
    .height('35%')
    .backgroundColor(Color.White)
  }

  getValue(id: number): string {
    let index = this.item?.productAttributeValueList?.findIndex(v => v.productAttributeId == id)
    if (index != -1) {
      return (this.item?.productAttributeValueList as PmsProductAttributeValue[])[index as number].value as string
    } else {
      return ""
    }
  }
}