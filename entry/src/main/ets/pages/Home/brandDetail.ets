import {
  getBrandDetail, getProductByBrandId, HmNavBar, PmsBrand, PmsProduct, routerParams } from 'basic'
import { router } from '@kit.ArkUI'
import json from '@ohos.util.json'
import Productdetail from 'basic/src/main/ets/components/Productdetail'

@Entry
@Component
struct BrandDetail {
  @State brandId:number = -1
  @State brand:PmsBrand={}
  @State productList:PmsProduct[]=[]
  @State pageNum: number = 1 // 当前页码
  @State pageSize: number = 6 // 每页显示数量
  @State finished:boolean = true
  @State loading:boolean = false
  loadingText: string = "加载中.." // 加载中的文本
  finishText: string = "没有数据啦" // 所有数据加载完成的文本
  aboutToAppear(): void {
    const params: routerParams = router.getParams() as routerParams
    if (params.id) {
      this.brandId=params.id
    }
    getBrandDetail(this.brandId).then((res)=>{
      this.brand=res
    })
    getProductByBrandId(this.brandId,this.pageNum,this.pageSize).then((res)=>{
      this.productList=res.list as PmsProduct[]
      if ((res.list as PmsProduct[]).length < 5 ) {
        this.finished = true
      }else {
        this.pageNum++
        this.finished = false
      }
    })
  }
  getData(){
    getProductByBrandId(this.brandId,this.pageNum,this.pageSize).then((res)=>{
      this.productList.push(...res.list as PmsProduct[])
      if ((res.list as PmsProduct[]).length < 5 ) {
        this.finished = true
      }else {
        this.pageNum++
        this.finished = false
      }
    })
  }
  build() {
    Column({space:5}){
      HmNavBar({title:'品牌详情'})
      List({space:10}){
        ListItem(){
          Image(this.brand.bigPic).size({width:'100%'})
        }
        ListItem(){
          Row(){
            Row({space:5}){
              Column(){
                Image(this.brand.logo).size({width:120})
              }
              Column({space:5}){
                Text(this.brand.name).fontSize(18)
                Text('品牌首字母：'+this.brand.firstLetter).fontSize(13)
                  .fontColor($r('app.color.text_normal'))
              }.alignItems(HorizontalAlign.Start)
            }
            Column(){
              Image($r('app.media.love')).size({width:50,height:50})
            }
          }.height(100)
          .padding({left:30,right:30})
          .backgroundColor($r('app.color.white'))
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        ListItem(){
          Column({space:30}){
            Text('品牌故事').fontSize(18).width('100%').textAlign(TextAlign.Center)
            Text(this.brand.brandStory).fontSize(13).fontColor($r('app.color.text_normal'))
          }.justifyContent(FlexAlign.Start)
          .padding({top:20,left:8,right:8,bottom:20})
          .backgroundColor($r('app.color.white'))
        }
        ListItem(){
          Column({space:30}){
            Text('相关商品').fontSize(18).width('100%').textAlign(TextAlign.Center)
            Grid(){
              ForEach(this.productList,(item:PmsProduct)=>{
                GridItem(){
                  Productdetail({ImageStr:item.pic,name:item.name,detailtext:item.subTitle,price:item.price,sale:item.sale})
                }.width("50%")
                .onClick(()=>{
                  router.pushUrl({url:"pages/Home/Product/ProductDetail",params:{id:item.id}})
                })
              })
            }.backgroundColor($r('app.color.white'))
          }.justifyContent(FlexAlign.Start)
          .padding({top:20,left:8,right:8,bottom:20})
          .backgroundColor($r('app.color.white'))
        }
        ListItem(){
          Text(this.finished?this.finishText:this.loadingText)
            .fontSize(14).fontColor($r('app.color.text_normal'))
            .width('100%').textAlign(TextAlign.Center)
            .height(50)
        }
      }.onReachEnd(()=>{
        if (!this.finished&&!this.loading) {
          this.loading=true
          this.getData()
          this.loading=false
        }
      })
      .margin({bottom:50})
    }
    .backgroundColor($r('app.color.page_bcg'))
    .height('100%')
    .width('100%')
  }
}