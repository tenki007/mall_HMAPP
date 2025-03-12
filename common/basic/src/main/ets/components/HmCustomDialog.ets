// 自定义弹窗
@CustomDialog
@Component
export struct HmCustomDialog {
  controller?: CustomDialogController
  @State data: string = ""
  onMyClick: () => void = () => {
  }

  build() {
    Column() {
      if(this.data){
        Text("自定义弹窗")
        Button("点击").onClick((event: ClickEvent) => {
          this.onMyClick()
        })
      }else {
        Row().height(200)
      }
    }
    .width("100%")
    .margin({bottom: 24})
    .borderWidth(1)
    .backgroundColor($r('app.color.white'))
  }
}
