import { getCookie } from '@/actions/cookies/getCookies';
import { getCurrentUser } from '@/actions/user/getCurrentUser';
import PostList from '@/components/post/PostList';
import PostModal from '@/components/post/PostModal';
import { Tabs, TabsContent } from '@/components/ui/tabs';

import { redirect } from 'next/navigation';
import React from 'react';
import TabPostList from '@/components/post/TabPostList';
import { getPosts } from '@/actions/post/getPosts';
import LoadMorePostList from '@/components/post/LoadMorePostList';

const HomePage = async ({
  searchParams,
}: {
  searchParams: Promise<{ [key: string]: string | string[] | undefined }>;
}) => {
  const currentUser = await getCurrentUser();
  const tab = (await searchParams).tab;
  let tabValue = '';

  if (!currentUser) {
    redirect('/login');
  }

  // パラメータによってタブ種類を変更
  switch (tab) {
    case 'mine':
      tabValue = 'mine';
      break;
    case 'following':
      tabValue = 'following';
      break;
    default:
      tabValue = 'all';
      break;
  }

  const cookies = await getCookie();
  const postsConfig = {
    page: 1,
    tab: tab,
    userId: currentUser.id,
    cookies: cookies,
  };
  const initialPosts = await getPosts(postsConfig);

  return (
    <div className="mt-10 max-w-[850px] mx-auto px-4 mb-[200px] w-full">
      <Tabs defaultValue={tabValue}>
        <div className="flex justify-between">
          <TabPostList />
          <PostModal />
        </div>
        <TabsContent value={tabValue}>
          <PostList posts={initialPosts.posts} />
          <LoadMorePostList tab={tabValue} userId={currentUser.id} />
        </TabsContent>
      </Tabs>
    </div>
  );
};

export default HomePage;
