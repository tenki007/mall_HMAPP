export interface ResponseData<T> {
  /** code为200时, 代表业务成功响应 */
  code: number
  msg: string
  data: T
}