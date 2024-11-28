import { getCookie } from '@/actions/cookies/getCookies';

export const getUser = async (userId: string) => {
  const cookie = await getCookie();
  if (!cookie) return null;

  const endpoint =
    process.env.NEXT_PUBLIC_API_ENDPOINT + `/api/users/${userId}`;
  const response = await fetch(endpoint, {
    headers: {
      Cookie: cookie,
    },
    credentials: 'include',
  });

  if (!response.ok) {
    return null;
  }

  const user = await response.json();
  return user;
};
