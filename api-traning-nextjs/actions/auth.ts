'user server'
import { LoginResponse } from "@/types/api/response/types";

export const login = async (prevState: LoginResponse, formData: FormData): Promise<LoginResponse> => {
  const username = formData.get("username");
  const password = formData.get("password");

  const data = { username, password }
  const endpoint = process.env.NEXT_PUBLIC_API_ENDPOINT + "/api/login"

  // /api/login にPOSTでデータを送る
  const response = await fetch(endpoint, {
    method: "POST",
    body: JSON.stringify(data),
    headers: { "Content-Type": "application/json" }
  })

  const jsonResponse = await response.json();

  console.log(jsonResponse);

  return jsonResponse;
};

