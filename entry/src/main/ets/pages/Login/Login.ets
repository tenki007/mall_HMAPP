import { LoginFormModel, login, UserSettings, TOKEN_KEY, LoginRes, ResponseData} from 'basic'
import { promptAction, router } from '@kit.ArkUI'
import { AxiosResponse } from '@ohos/axios'

@Entry
@Component
struct Login {

  @State UserFrom:LoginFormModel =new LoginFormModel({
    username: 'username',
    password: 'password'
  })
  @State showLoading:boolean = false

  @Styles
  inputStyle(){
    .padding({ left: 8, right: 8, top: 8 })
    .borderRadius(5)
    .margin({ bottom: 20, left: 10, right: 10 })
    .backgroundColor("#F8F6FC")
  }

  build() {
    Column() {
      Column(){
        Text("欢迎回来！").width('100%')
          .fontSize(25)
          .margin({bottom:30})
        Column(){
          Text('用户名').width('100%').padding({left:15})
          TextInput({placeholder:'请输入用户名',text:this.UserFrom.username}).align(Alignment.Center)
            .fontSize('18')
            .onChange((value:string)=>{
              this.UserFrom.username = value
            })
            .backgroundColor("#F8F6FC")

        }.inputStyle()
        Column(){
          Text('密码').width('100%').padding({left:15})
          TextInput({placeholder:'请输入密码',text:this.UserFrom.password}).align(Alignment.Center)
            .fontSize('18')
            .type(InputType.Password)
            .showPasswordIcon(true)
            .onChange((value:string)=>{
              this.UserFrom.password = value
            })
            .onSubmit(()=>{
              if(this.isInput()){
                this.login()
              }
            })
            .backgroundColor("#F8F6FC")
        }.inputStyle()

        Button({ type: ButtonType.Capsule })
        {
          Row() {
            if(this.showLoading){
              LoadingProgress().width(20).height(20).margin({ right: 12 })
                .color($r('app.color.white'))
            }
            Text('登录').fontColor($r('app.color.white'))
          }
        }
        .backgroundColor($r('app.color.btn_red'))
        .width('100%')
        .height(50)
        .margin({ top: 50 })
        .enabled(this.isInput())
        .onClick(()=>{
          this.login()
        })
      }
      .padding({ left: 32, right: 32 })
      .margin({ top: 140 })
    }
    .height('100%')
    .width('100%')
  }

  isInput(){
    if (this.UserFrom.username && this.UserFrom.password) {
      return true
    }
    return false
  }

  async login(){
    try {
      this.showLoading = true
      const token :AxiosResponse<ResponseData<LoginRes>> = await login(this.UserFrom)
      AppStorage.setOrCreate(TOKEN_KEY, token.data.data.tokenHead+token.data.data.token)
      new UserSettings(getContext()).setUserToken(token.data.data.tokenHead+token.data.data.token)
      router.replaceUrl({
        url: 'pages/Index' // 跳转到登录页
      })
      promptAction.showToast({ message: '登录成功' })
      this.showLoading = false
    }catch (e){
      console.log(e)
    } finally {
      this.showLoading = false
    }
  }

}
