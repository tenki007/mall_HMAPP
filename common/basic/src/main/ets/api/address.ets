import axios, { AxiosResponse } from "@ohos/axios"
import { getToken } from "../../../../Index"
import { BASE_URL } from "../constants"
import { Address, ResponseData } from "../models"

export const getAddressList = async () => {
  let res: AxiosResponse<ResponseData<Address[]>> =
    await axios.get<string, AxiosResponse<ResponseData<Address[]>>>(BASE_URL + "/member/address/list", {
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}

export const getAddressById = async (id:number) =>{
  let res: AxiosResponse<ResponseData<Address>> =
    await axios.get<string,AxiosResponse<ResponseData<Address>>>(BASE_URL + "/member/address/"+id,{
      headers: {
      Authorization: await getToken()
      }
    })
  return res.data.data
}

export const addAddress = async (item:Address)=>{
  let res:AxiosResponse<ResponseData<Address>> =
    await axios.post<string,AxiosResponse<ResponseData<Address>>>(BASE_URL+"/member/address/add",item,{
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}

export const updateAddress = async (item:Address)=>{
  let res:AxiosResponse<ResponseData<Address>> =
    await axios.post<string,AxiosResponse<ResponseData<Address>>>(BASE_URL+"/member/address/update/"+item.id,item,{
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}