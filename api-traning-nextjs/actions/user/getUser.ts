import { cookies } from 'next/headers';
import { redirect } from 'next/navigation';

export const getUser = async () => {
  const cookieStore = await cookies(); //サーバコンポーネントでcookieを取得
  const session = cookieStore.get('_api_and_rspec_training_session');
  if (!session) return null;

  const endpoint = process.env.NEXT_PUBLIC_API_ENDPOINT + '/api/users/me';
  const response = await fetch(endpoint, {
    headers: {
      Cookie: cookieStore.toString(),
    },
    credentials: 'include',
  });

  if (!response.ok) {
    return null;
  }

  const responseData = await response.json();
  return responseData;
};
