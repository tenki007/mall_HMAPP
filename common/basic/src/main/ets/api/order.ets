import axios, { AxiosResponse } from "@ohos/axios"
import { getToken } from "../../../../Index"
import { BASE_URL } from "../constants"
import { Address, ResponseData } from "../models"
import { CommonPageOmsOrderDetail, OrderDetail, OrderParam, OrderRequest, OrderResponse } from "../models/order"
import { OrderResult } from "../models/OrderRes"

export const getAllOrderList = async (item:OrderRequest) => {
  let res: AxiosResponse<ResponseData<CommonPageOmsOrderDetail>> =
    await axios.get<string, AxiosResponse<ResponseData<CommonPageOmsOrderDetail>>>(BASE_URL + "/order/list",{
      headers: {
        Authorization: await getToken()
      },
      params:item
    })
  return res.data.data
}
// 根据购物车信息生成确认单
export const generateConfirmOrder = async (ids: number[]) => {
  let res: AxiosResponse<ResponseData<OrderResult>> =
    await axios.post<string, AxiosResponse<ResponseData<OrderResult>>>(BASE_URL + "/order/generateConfirmOrder", ids, {
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}
// 根据购物车信息生成订单
export const generateOrder = async (Param: OrderParam) => {
  let res: AxiosResponse<ResponseData<OrderResponse>> =
    await axios.post<string, AxiosResponse<ResponseData<OrderResponse>>>(BASE_URL + "/order/generateOrder", Param, {
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}

// 根据ID获取订单详情
export const getOrderDetail = async (id: number) => {
  let res: AxiosResponse<ResponseData<OrderDetail>> =
    await axios.get<string, AxiosResponse<ResponseData<OrderDetail>>>(BASE_URL + "/order/detail/" + id, {
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}


// 支付成功
export const paySuccess = async (data: OrderDetail) => {
  let res: AxiosResponse<ResponseData<number>> =
    await axios.post<string, AxiosResponse<ResponseData<number>>>(BASE_URL + "/order/paySuccess", {}, {
      headers: {
        Authorization: await getToken()
      },
      params: {
        orderId: data.id,
        payType: data.payType
      }
    })
  return res.data.data
}
