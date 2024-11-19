import { getCookie } from "@/actions/cookies/getCookies";

export const getMyPosts = async (userId:string) => {
  const endpoint = process.env.NEXT_PUBLIC_API_ENDPOINT + `/api/posts?user_id=${userId}`;
  const cookies = await getCookie();
  const response = await fetch(endpoint,{
      headers: {
        Cookie: cookies,
      },
      credentials: 'include',
    }
  );
  if(!response.ok) {
    return [];
  }

  const posts = await response.json();
  return posts
}