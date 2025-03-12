import { getHotProductList, HmNavBar, PmsProduct } from 'basic'
import Productdetail from 'basic/src/main/ets/components/Productdetail'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct HotProduct {
  @State productList:PmsProduct[]=[]
  @State pageNum: number = 1 // 当前页码
  @State pageSize: number = 6 // 每页显示数量
  @State finished:boolean=true
  loadingText: string = "加载中.." // 加载中的文本
  finishText: string = "没有数据啦" // 所有数据加载完成的文本

  aboutToAppear(): void {
    getHotProductList(this.pageNum,this.pageSize).then((res)=>{
      this.productList=res
      if (res.length < 6 ) {
        this.finished = true
      }else {
        this.finished = false
        this.pageNum++
      }
    })
  }

  getData() {
    getHotProductList(this.pageNum,this.pageSize).then((res)=>{
      this.productList.push(...res)
      if (res.length < 6 ) {
        this.finished = true
      }else {
        this.pageNum++
      }
    })

  }

  build() {
    Column() {
      HmNavBar({ title: '人气推荐' })
      List({ space: 10 }) {
        ListItem() {
          Image($r('app.media.hot_product_banner')).size({ width: '100%' })
        }
        ListItem(){
          Column({space:10}){
            Text('相关品牌').fontSize(18)
            Grid(){
              ForEach(this.productList,(item:PmsProduct)=>{
                GridItem(){
                  Productdetail({ImageStr:item.pic,name:item.name,detailtext:item.subTitle,price:item.price,sale:item.sale})
                }.onClick(()=>{
                  router.pushUrl({url:"pages/Home/Product/ProductDetail",params:{id:item.id}})
                })
                .width("50%")
              })
            }
          }.justifyContent(FlexAlign.Center)
          .padding({top:10})
          .backgroundColor($r('app.color.white'))
        }
        ListItem(){
          Text(this.finished?this.finishText:this.loadingText)
            .fontSize(14).fontColor($r('app.color.text_normal'))
            .width('100%').textAlign(TextAlign.Center)
            .height(50)
        }
      }
      .height('100%')
      .width('100%')
    }
  }
}