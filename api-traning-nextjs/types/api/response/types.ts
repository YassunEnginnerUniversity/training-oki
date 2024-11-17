interface LoginSuccessResponse {
  message: string;
}
interface LoginErrorResponse {
  error: string;
}
export type LoginResponse = LoginSuccessResponse | LoginErrorResponse;
