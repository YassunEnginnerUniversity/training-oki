import { getCookie } from "@/actions/cookies/getCookies";

export const getPost = async (postId:string) => {
  const endpoint = process.env.NEXT_PUBLIC_API_ENDPOINT + `/api/posts/${postId}`;
  const cookies = await getCookie();
  const response = await fetch(endpoint, {
    headers: {
      'Content-Type': 'application/json',
      Cookie: cookies,
    },
    credentials: 'include'
  })

  if(!response.ok) {
    return null
  }

  const post = await response.json();
  return post
}