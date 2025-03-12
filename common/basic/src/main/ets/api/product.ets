import axios, { AxiosResponse } from "@ohos/axios"
import { BASE_URL } from "../constants"
import {  PmsPortalProductDetail, ResponseData, SmsCoupon } from "../models"
import { getToken } from "../utils"

// 获取商品详情
export const getProductDetail = async (ProductId:number) => {
  let res: AxiosResponse<ResponseData<PmsPortalProductDetail>> =
    await axios.get<string, AxiosResponse<ResponseData<PmsPortalProductDetail>>>(BASE_URL + "/product/detail/"+ProductId, {
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}
// 获取当前商品相关优惠券
export const getProductCoupons = async (id: number) => {
  let res: AxiosResponse<ResponseData<SmsCoupon[]>> =
    await axios.get<string, AxiosResponse<ResponseData<SmsCoupon[]>>>(BASE_URL + "/member/coupon/listByProduct/" + id, {
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}