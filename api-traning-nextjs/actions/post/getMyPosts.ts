export const getMyPosts = async (
  userId: number,
  page: number,
  cookies: string,
) => {
  const perPage = 10;
  const endpoint =
    process.env.NEXT_PUBLIC_API_ENDPOINT +
    `/api/posts?user_id=${userId}&per_page=${perPage.toString()}&page=${page.toString()}`;
  const response = await fetch(endpoint, {
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
