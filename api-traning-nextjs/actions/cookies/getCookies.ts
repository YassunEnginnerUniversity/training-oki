import { cookies } from "next/headers";

export const getCookie = async() => {
  const cookieStore = await cookies(); //サーバコンポーネントでcookieを取得
  return cookieStore.toString();
}