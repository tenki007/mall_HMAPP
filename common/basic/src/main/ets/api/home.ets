import axios, { AxiosResponse } from "@ohos/axios"
import { BASE_URL, CommonPagePmsProduct, getToken, HomeContentResult, PmsBrand,
  PmsProduct,
  ResponseData } from "../../../../Index"

export const getHomeContent = async () => {
  let res: AxiosResponse<ResponseData<HomeContentResult>> =
    await axios.get<string, AxiosResponse<ResponseData<HomeContentResult>>>(BASE_URL + "/home/content", {
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}
export const getBrandList = async (pageNum:number,pageSize:number) => {
  let res: AxiosResponse<ResponseData<PmsBrand[]>> =
    await axios.get<string, AxiosResponse<ResponseData<PmsBrand[]>>>(BASE_URL + "/brand/recommendList", {
      headers: {
        Authorization: await getToken()
      },params:{
        pageNum:pageNum,
        pageSize:pageSize
      }
    })
  return res.data.data
}
export const getHotProductList = async (pageNum:number,pageSize:number) => {
  let res: AxiosResponse<ResponseData<PmsProduct[]>> =
    await axios.get<string, AxiosResponse<ResponseData<PmsProduct[]>>>(BASE_URL + "/home/hotProductList", {
      headers: {
        Authorization: await getToken()
      },params:{
        pageNum:pageNum,
        pageSize:pageSize
      }
    })
  return res.data.data
}
export const getNewProductList = async (pageNum:number,pageSize:number) => {
  let res: AxiosResponse<ResponseData<PmsProduct[]>> =
    await axios.get<string, AxiosResponse<ResponseData<PmsProduct[]>>>(BASE_URL + "/home/newProductList", {
      headers: {
        Authorization: await getToken()
      },params:{
        pageNum:pageNum,
        pageSize:pageSize
      }
    })
  return res.data.data
}
export const getRecommendProductList = async (pageNum:number,pageSize:number) => {
  let res: AxiosResponse<ResponseData<PmsProduct[]>> =
    await axios.get<string, AxiosResponse<ResponseData<PmsProduct[]>>>(BASE_URL + "/home/recommendProductList", {
      headers: {
        Authorization: await getToken()
      },params:{
        pageNum:pageNum,
        pageSize:pageSize
      }
    })
  return res.data.data
}
export const getBrandDetail = async (brandId:number) => {
  let res: AxiosResponse<ResponseData<PmsBrand>> =
    await axios.get<string, AxiosResponse<ResponseData<PmsBrand>>>(BASE_URL + "/brand/detail/"+brandId, {
      headers: {
        Authorization: await getToken()
      }
    })
  return res.data.data
}
export const getProductByBrandId = async (brandId:number,pageNum:number,pageSize:number) => {
  let res: AxiosResponse<ResponseData<CommonPagePmsProduct>> =
    await axios.get<string, AxiosResponse<ResponseData<CommonPagePmsProduct>>>(BASE_URL + "/brand/productList", {
      headers: {
        Authorization: await getToken()
      },params:{
        brandId:brandId,
        pageNum:pageNum,
        pageSize:pageSize
      }
    })
  return res.data.data
}