import { Request, UserSettings } from '../utils'
import { LoginForm, LoginFormModel, LoginRes, ResponseData } from '../models'
import axios, { AxiosResponse } from '@ohos/axios'
import { BASE_URL } from '../../../../Index'


// 登录接口实现

export const login = (data: LoginFormModel) => {
  return axios.post<ResponseData<LoginRes>,AxiosResponse<ResponseData<LoginRes>>, LoginForm>(
    BASE_URL+'/sso/login',data,{params:data});
}
export const info = async (token:string) => {
  return axios.post<ResponseData<object>,AxiosResponse<ResponseData<object>>>(BASE_URL+'/sso/login',{headers: {
    Authorization: token
  }});
}