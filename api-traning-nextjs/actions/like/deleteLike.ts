"use server"

import { getCookie } from "@/actions/cookies/getCookies";

export const deleteLike = async (postId: string) => {
  const endpoint = process.env.NEXT_PUBLIC_API_ENDPOINT + "/api/posts/" + postId + "/like";
  const cookies = await getCookie();
  const response = await fetch(endpoint, {
    method: "DELETE",
    headers: {
      'Content-Type': 'application/json',
      Cookie: cookies,
    },
    credentials: 'include'
  })
  

  if(!response.ok) {
    return null
  }

  const like = response.json();
  return like
}