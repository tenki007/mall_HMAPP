import { getBrandList, HmNavBar, PmsBrand } from 'basic';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct BrandDetail {
  @State BrandList:PmsBrand[]=[]
  @State pageNum: number = 1 // 当前页码
  @State pageSize: number = 6 // 每页显示数量
  @State finished:boolean=true
  loadingText: string = "加载中.." // 加载中的文本
  finishText: string = "没有数据啦" // 所有数据加载完成的文本
  async aboutToAppear() {
    this.BrandList = await getBrandList(1,6)
    if (this.BrandList.length < 5 ) {
      this.finished = true
    }else {
      this.finished = false
      this.pageNum++
    }
  }

  getData() {
    getBrandList(this.pageNum,this.pageSize).then((res)=>{
      this.BrandList.push(...res)
      if (res.length < 5 ) {
        this.finished = true
      }else {
        this.pageNum++
      }
    })

  }

  @Builder
  gridItem(item:PmsBrand){
    Column({space:5}){
      Image(item.logo).height(55)
      Text(item.name)
      Text('商品数量'+item.productCount).fontSize(13)
        .fontColor($r('app.color.text_normal'))
    }.height(180)
    .padding({top:10,left:8})
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.white'))
    .width('50%')
    .onClick(()=>{
      router.pushUrl({url:"pages/Home/brandDetail",params:{id:item.id}})
    })
  }
  build() {
    Column(){
      HmNavBar({title:"推荐品牌列表"})
      List({space:8}){
        ListItem(){
          Image($r('app.media.recommend_brand_banner')).size({width:"100%"})
        }
        ListItem(){
            Column({space:10}){
              Text('相关品牌').fontSize(18)
              Grid(){
                ForEach(this.BrandList,(item:PmsBrand)=>{
                  this.gridItem(item)
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
      }.onReachEnd(()=>{
        if(!this.finished){
          this.getData()
        }
      })
      .margin({bottom:40})
    }.backgroundColor($r('app.color.page_bcg'))
    .height('100%')
    .width('100%')
  }
}