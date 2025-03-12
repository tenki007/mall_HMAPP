import { UserSettings } from ".";
import { router } from "@kit.ArkUI";
import { routerParams } from "../models";

export async function isLogin(){
  let token = await new UserSettings(getContext()).getUserToken();
  return !!token
}

export async function getToken(){
  let token = await new UserSettings(getContext()).getUserToken();
  return token
}

export async function authRouter(url: string, params?: routerParams){
  if (await isLogin()) {
    router.pushUrl({ url: url, params: params })
  } else {
    router.pushUrl({ url: 'pages/Login/Login' })
  }
}