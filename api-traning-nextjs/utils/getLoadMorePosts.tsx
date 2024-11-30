'use client';
import { getPosts } from '@/actions/post/getPosts';

export const getLoadMorePosts = async (
  tab: string,
  page: number,
  userId: number,
) => {
  const cookies = document.cookie;
  const postsConfig = {
    page: page,
    tab: tab,
    userId: userId,
    cookies: cookies,
  };
  const response = await getPosts(postsConfig);

  return response;
};
