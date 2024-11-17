export const logout = async () => {
  const endpoint = process.env.NEXT_PUBLIC_API_ENDPOINT + '/api/logout';

  const response = await fetch(endpoint, {
    method: 'DELETE',
    credentials: 'include',
  });

  if (!response.ok) {
    return null;
  }

  const responseData = await response.json();
  return responseData;
};
