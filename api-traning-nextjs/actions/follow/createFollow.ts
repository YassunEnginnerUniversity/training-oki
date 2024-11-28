'use server';

import { getCookie } from '@/actions/cookies/getCookies';

export const createFollow = async (userId: string) => {
  const endpoint =
    process.env.NEXT_PUBLIC_API_ENDPOINT + '/api/users/' + userId + '/follow';
  const cookies = await getCookie();
  const response = await fetch(endpoint, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Cookie: cookies,
    },
    credentials: 'include',
  });

  if (!response.ok) {
    return null;
  }

  const follow = response.json();
  return follow;
};
