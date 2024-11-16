'user server'
import { LoginResponse } from "@/types/api/response/types";
import { redirect } from "next/navigation";

//メモ zodでフロントエンド側のバリデーションをつける（余計なPOSTを送らせないようにする）

export const login = async (prevState: LoginResponse, formData: FormData): Promise<LoginResponse> => {
  const username = formData.get("username");
  const password = formData.get("password");
  const data = { username, password }
  const endpoint = process.env.NEXT_PUBLIC_API_ENDPOINT + "/api/login"

  // /api/login にPOSTでデータを送る
  const response = await fetch(endpoint, {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    credentials: 'include',
    body: JSON.stringify(data),
  })

  // ログインに失敗し、エラーが発生したとき
  if(!response.ok) {
    const jsonResponse = await response.json();
    return jsonResponse;
  }

  redirect("/")
};

