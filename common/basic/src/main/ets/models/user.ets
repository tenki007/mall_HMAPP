export interface LoginForm{
  password:string,
  username:string
}
export class LoginFormModel implements LoginForm{
  username: string = '';
  password: string = '';

  constructor(model: LoginForm) {
    this.username = model.username;
    this.password = model.password;
  }
}
export interface LoginRes {
  tokenHead: string
  token: string
}
