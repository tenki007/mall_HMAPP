import axios, { AxiosResponse } from "@ohos/axios"
import { BASE_URL } from "../constants"
import { addCartReqParams, CartItem, ResponseData } from "../models"
import { promptAction } from "@kit.ArkUI"
import { getToken } from "../utils"


// 获取用户购物车列表
export const getCartItemList = async () => {
  let res: AxiosResponse<ResponseData<CartItem[]>> =
    await axios.get<string, AxiosResponse<ResponseData<CartItem[]>>>(BASE_URL + "/cart/list", {
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}

// 修改购物车中指定商品的数量
export const upCartItemQuantity = async (item: CartItem) => {
  return await axios.get<string, AxiosResponse<ResponseData<number>>>(BASE_URL + "/cart/update/quantity", {
    headers: {
      Authorization: await getToken()
    },
    params: {
      id: item.id,
      quantity: item.quantity
    }
  })
}

// 删除指定购物车项目
export const deleteCartItem = async (id: number) => {
  return await axios.post<string, AxiosResponse<ResponseData<number>>>(BASE_URL + "/cart/delete", {}, {
    headers: {
      Authorization: await getToken()
    },
    params: {
      ids: id
    }
  })
}

// 清空购物车
export const clearCart = async () => {
  let res: AxiosResponse<ResponseData<number>> =
    await axios.post<string, AxiosResponse<ResponseData<number>>>(BASE_URL + "/cart/clear", {}, {
      headers: {
        Authorization: await getToken()
      }
    })
  promptAction.showToast({message: "清空购物车成功"})
  return res.data.data
}
// 添加商品到购物车
export const addCartItem = async (obj: addCartReqParams) => {
  let res: AxiosResponse<ResponseData<number>> =
    await axios.post<string, AxiosResponse<ResponseData<number>>>(BASE_URL + "/cart/add", obj, {
      headers: {
        Authorization: await getToken()
      }
    })
  promptAction.showToast({ message: "添加购物车成功" })
  return res.data.data
}