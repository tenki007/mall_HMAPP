import axios, { AxiosResponse } from "@ohos/axios"
import { BASE_URL } from "../constants"
import { CommonPagePmsProduct, PmsProductCategoryNode, ResponseData } from "../models"
import { getToken } from "../utils"


export const getAllCateList = async () => {
  let res: AxiosResponse<ResponseData<PmsProductCategoryNode[]>> =
    await axios.get<string, AxiosResponse<ResponseData<PmsProductCategoryNode[]>>>(BASE_URL + "/product/categoryTreeList", {
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}

export const searchProductList = async (pageNum:number,pageSize:number,productCategoryId:number,sort:number=0)=>{
  let res: AxiosResponse<ResponseData<CommonPagePmsProduct>> =
    await axios.get<string, AxiosResponse<ResponseData<CommonPagePmsProduct>>>(BASE_URL+"/product/search",{
      headers: {
        Authorization: await getToken()
      },
      params:{
        pageNum:pageNum,
        pageSize:pageSize,
        productCategoryId:productCategoryId,
        sort:sort
      }
  })
  return res.data.data
}