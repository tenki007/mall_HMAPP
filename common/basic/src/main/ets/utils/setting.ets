import preferences from '@ohos.data.preferences'
import { TOKEN_KEY,USER_SETTING } from '../constants'


export class UserSettings{
  context:Context
  constructor(context:Context){
    this.context = context
  }
  getStore(){
    return preferences.getPreferences(this.context,USER_SETTING)
  }
  //获取token
  async getUserToken():Promise<string> {
    const adStore = await this.getStore()
    return await adStore.get(TOKEN_KEY, "") as string
  }
  //设置token
  async setUserToken (token: string) {
    const adStore = await this.getStore()
    await adStore.put(TOKEN_KEY, token)
    // 写入磁盘
    await adStore.flush()
  }
}