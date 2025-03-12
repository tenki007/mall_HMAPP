import { getAddressList, HmNavBar ,Address, addressCard} from 'basic'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct address {
  @State items:Address[]=[]
 async onPageShow(){
   this.items = await getAddressList()
 }

  build() {
    Column(){
      HmNavBar({title:"收货地址"})
      Scroll() {
        Column(){
          ForEach(this.items,(fitem:Address)=>{
              addressCard({ item: fitem })
          })
        }
      }.layoutWeight(1)
      .align(Alignment.Top)
      Button("新增地址")
        .type(ButtonType.Normal)
        .width("90%")
        .height(36)
        .borderRadius(6)
        .backgroundColor($r('app.color.login_btn_red'))
        .onClick((event: ClickEvent) => {
          router.pushUrl({url:"pages/My/Details/addAddress"})
        })

    }.height('100%')
    .width('100%')
  }
}