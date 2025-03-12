import { HmNavBar, PmsProduct, routerParams, searchProductList } from 'basic'
import Productdetail from 'basic/src/main/ets/components/Productdetail'
import { router } from '@kit.ArkUI'

@Entry
@Component
struct CateDetail {

  @State ProductList:PmsProduct[]=[]
  @State pageNum: number = 1 // 当前页码
  @State pageSize: number = 6 // 每页显示数量
  @State productCategoryId:number = 19
  @State sort:number = 0
  @State finished:boolean = false
  @State init:boolean = false
  @State loading:boolean = false
  loadingText: string = "加载中.." // 加载中的文本
  finishText: string = "没有数据啦" // 所有数据加载完成的文本

  async getData() {
    let res = (await searchProductList(this.pageNum,this.pageSize,this.productCategoryId,this.sort)).list as PmsProduct[]
    this.ProductList.push(...res)
    if (res.length < 5 ) {
      this.finished = true
    }else {
      this.pageNum++
    }
  }

  async aboutToAppear() {
    const params: routerParams = router.getParams() as routerParams
    if (params.id) {
      this.productCategoryId=params.id
    }
    let res = (await searchProductList(this.pageNum,this.pageSize,this.productCategoryId)).list as PmsProduct[]
    this.ProductList=res
    if (res.length < 5 ) {
      this.finished = true
      this.init=true
    }else {
      this.pageNum++
      this.init=true
    }
  }

  @Builder
  topTab(){
    Row(){
      Column(){
        Text('综合排序').fontColor(this.sort===0?$r('app.color.login_btn_red'):$r('app.color.black'))
      }.width('30%')
      .onClick(()=>{
        if (this.sort!==0) {
          this.sort=0
          this.ProductList=[]
          this.pageNum = 1
          this.finished=false
          this.getData()
        }
      })
      Column(){
        Text('销量优先').fontColor(this.sort===2?$r('app.color.login_btn_red'):$r('app.color.black'))
      }.width('30%')
      .onClick(()=> {
        if (this.sort !== 2) {
          this.sort = 2
          this.ProductList = []
          this.pageNum = 1
          this.finished=false
          this.getData()
        }
      })
      Column({space:5}){
        Row(){
          Text('价格').fontColor(this.sort===4||this.sort===3?$r('app.color.login_btn_red'):$r('app.color.black'))
          Column(){
            Image(this.sort===3?$r('app.media.icon_up_current'):$r('app.media.icon_up'))
              .size({width:12})
            Image(this.sort===4?$r('app.media.icon_down_current'):$r('app.media.icon_down'))
              .size({width:12})
          }
        }

      }.width('30%')
      .onClick(()=> {
        if (this.sort !== 3&&this.sort!==4) {
          this.sort = 3
          this.ProductList = []
          this.pageNum = 1
          this.finished=false
          this.getData()
        }else if (this.sort===3){
          this.sort = 4
          this.ProductList = []
          this.pageNum = 1
          this.finished=false
          this.getData()
        }else if (this.sort===4){
          this.sort = 3
          this.ProductList = []
          this.pageNum = 1
          this.finished=false
          this.getData()
        }
      })
      Column(){
        Image($r('app.media.tab_cate')).size({width:20})
      }.width('10%')
    }.width('100%')
    .backgroundColor($r('app.color.white'))
  }

  build() {
      Column(){
        Row(){
          HmNavBar({title:"商品列表"})
        }
        Row(){
          this.topTab()
        }.height(50)
        .backgroundColor($r('app.color.white'))
        List(){
          ListItem(){
            Grid(){
              ForEach(this.ProductList,(item:PmsProduct)=>{
                GridItem(){
                  Productdetail({ImageStr:item.pic,name:item.name,detailtext:item.subTitle,price:item.price,sale:item.sale})
                }.width("50%")
                .onClick(()=>{
                  router.pushUrl({url:"pages/Home/Product/ProductDetail",params:{id:item.id}})
                })
              })
            }.backgroundColor($r('app.color.white'))
          }
          ListItem(){
            Text(this.finished?this.finishText:this.loadingText)
              .fontSize(14).fontColor($r('app.color.text_normal'))
              .width('100%').textAlign(TextAlign.Center)
              .height(50)
          }
        }.margin({bottom:50})
        .onReachEnd(()=>{
          if(!this.finished&&this.init&&!this.loading){
            this.loading = true // 关闭阀门
            this.getData()
            this.loading = false // 关闭阀门
          }
        })

      }.height('100%')
      .width('100%')
      .backgroundColor($r('app.color.page_bcg'))
    }
}