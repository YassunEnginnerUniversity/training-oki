import { cookies } from "next/headers";

export const getUserBySession = async () => {
  const endpoint = process.env.NEXT_PUBLIC_API_ENDPOINT + "/api/check_session"
  const cookieStore = await cookies(); //サーバコンポーネントでcookieを取得

  const response = await fetch(endpoint, {
    headers: {
      Cookie: cookieStore.toString()
    },
    credentials: 'include',
  })

  if(!response.ok) {
    return null
  }

  const responseData = await response.json();
  return responseData
}