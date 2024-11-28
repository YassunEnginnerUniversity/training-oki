import { getCookie } from '@/actions/cookies/getCookies';

export const getPostsAll = async (page: number, cookies: string) => {
  const perPage = 10;
  const endpoint =
    process.env.NEXT_PUBLIC_API_ENDPOINT +
    `/api/posts?per_page=${perPage.toString()}&page=${page.toString()}`;
  const response = await fetch(endpoint, {
    method: 'GET',
    headers: {
      Cookie: cookies,
    },
    credentials: 'include',
  });
  if (!response.ok) {
    return [];
  }

  const posts = await response.json();
  return posts;
};
