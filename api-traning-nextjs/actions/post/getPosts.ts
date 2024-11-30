type GetPostsConfig = {
  page: number;
  tab: string | string[] | undefined;
  userId: number;
  cookies: string;
};

export const getPosts = async (config: GetPostsConfig) => {
  const { page, tab, userId, cookies } = config;
  const perPage = 10;
  let endpoint = '';

  // Tabによって取得するデータが変わる
  switch (tab) {
    case 'all':
      endpoint =
        process.env.NEXT_PUBLIC_API_ENDPOINT +
        `/api/posts?per_page=${perPage.toString()}&page=${page.toString()}`;
      break;
    case 'mine':
      endpoint =
        process.env.NEXT_PUBLIC_API_ENDPOINT +
        `/api/posts?user_id=${userId}&per_page=${perPage.toString()}&page=${page.toString()}`;
      break;
    case 'following':
      endpoint =
        process.env.NEXT_PUBLIC_API_ENDPOINT +
        `/api/posts?user_id=${userId}&filter=followings&per_page=${perPage.toString()}&page=${page.toString()}`;
      break;
    default:
      endpoint =
        process.env.NEXT_PUBLIC_API_ENDPOINT +
        `/api/posts?per_page=${perPage.toString()}&page=${page.toString()}`;
      break;
  }

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
